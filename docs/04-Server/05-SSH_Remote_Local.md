# 本地服务器远程连接

!!! info ""

    author: Haorui Zhang (Haohahahaha)

    email: 1259203802@qq.com

    date: 2024-03-28

三台机器：

- 本地服务器 A （搭载实际业务）

- 云服务器 B （通过端口转发提供公网服务）

- 终端 C （连接 A 进行业务处理）


### 本地服务器 A 安装 SSH 服务与远程桌面

```bash
sudo apt install openssh-server
sudo systemctl start sshd
```

给主机安个向日葵远程桌面，登录上自己的账号，免得本地服务器（其实是虚拟机）挂掉无法修复

### 云服务器 B 设置 防火墙与域名

- 防火墙：添加规则，开放部分端口

- 域名解析：如果有域名的话，记得填写你想给这台云服务器的域名

    - 顺便：有域名的话也记得设置域名解析给云服务器 B 。

### 服务器 A&&B 设置 SSH 服务

然后打开 `/etc/ssh/sshd_config`，找到如下两行，改为：

```
// 非注释两边均建议开启
AllowTcpForwarding yes
GatewayPorts yes    // 在云服务器 B 上一定要打开，主要功能是退出后允许随时连接
TCPKeepAlive yes
ClientAliveInternal 60  // 在本地服务器 A 上一定要打开，主要功能是连接时保持连接状态，不会过一段时间就自动断开
ClientAliveCountMax 3   // 在本地服务器 A 上一定要打开，同上
```

设置好后在两个服务器上均要重启服务：

```bash 
sudo systemctl restart sshd
```

### 本地服务器 A 对云服务器 B 做端口映射

```bash
ssh -NfR <服务器IP>:<服务器Port>:<本地IP>:<本地Port> <服务器用户名>@<服务器IP>
```

其中：

- `<服务器IP>` 为你的云服务器的公网 IP

- `<服务器Port>` 为之前在防火墙中打开的端口，端口的范围为你刚才设置的防火墙规则

- `<本地IP>` 一般填写localhost

- `<本地Port>` 为启用远程桌面的高级设置中指定的端口，

    > ssh 为 22
    >
    > code-server为 8080
    >
    > Windows 远程桌面 为 3389

- `<服务器用户名>` 为你登陆云服务器的用户名

- `-R` 表示远程端口转发

- `-N` 表示不执行命令，只进行端口转发

- `-f` 表示将ssh放到后台执行

### 互相导入 id_rsa.pub，方便连接

!!! info "`A -> B`: 方便端口映射"

!!! info "`C -> B`: 方便调试云服务器的 SSH 服务"

!!! success "`C -> A`: 方便直连本地服务器 A ，打开即工作！"

具体步骤：

1. 在前者（指箭头左侧的机子）生成公钥:

    ```bash
    ssh-keygen -t rsa -C "你的邮箱" # 邮箱就是个标志，写别的也行，不过推荐邮箱
    # 然后一路回车
    ```

2. 然后用文本编辑器打开 `~/.ssh/id_rsa.pub` ，复制其中的内容

3. ~~远程连接到~~ 不管用什么方法 把内容传给后者（指箭头右侧的机子）

4. 将内容存到后者的 ~/.ssh/authorized_keys (没有就建一个) 保存

5. 最后重启 SSH 服务，别忘了重新做端口映射