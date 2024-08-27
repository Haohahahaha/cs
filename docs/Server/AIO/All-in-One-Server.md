# All in One 服务器配置流程

> author: Haohahahaha (Haorui Zhang) feat.[JesseHT](JesseHT@outlook.com)
> 
> mail: 1259203802@qq.com
>
> date: 2024-08-05

## 架构介绍

![临时架构]()

## Windows Server 2022 安装

1. 在安装时选择 Datacenter (Desktop Edition) 版本
2. 右键桌面-个性化-主题-桌面图标设置：勾选计算机-应用
3. 打开无线 LAN 服务：右键管理-添加角色和功能-一直下一步到功能-勾选“无线 LAN 服务”-勾选“如果需要，自动重新启动目标服务器”-确定-安装即可
4. 安装无线网卡驱动，自己下载。
5. 安装英伟达驱动，自行下载。
6. 安装必要软件，自行下载。

## PVE 安装

> 

1. 正常安装
2. 注意硬盘选择
3. 注意本机 ip 与网关的填写
4. 重启后BIOS设置为首选项
5. 连接网线到笔记本，进行操作
   1. 可以删掉 local-lvm
   2. 比如新挂载一块硬盘设置为容器功能
   3. 上传 ISO 文件

### Ubuntu-Router

> 用来给校园网认证，深澜现在还搞不明白

1. 无线驱动 - 只要认设备就不需要安装
2. 设置 iptables
   
    > 注意nat设置好！

    ```bash
    sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
    sudo iptables -A FORWARD -i wlan0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
    sudo iptables -A FORWARD -i eth0 -o wlan0 -j ACCEPT
    ```

    1. 其余看这个[内网路由器](https://blog.csdn.net/ljn1046016768/article/details/136812970)
    2. 这个应该不用改 
   
        ~~如果可能的话，记得改 `/etc/resolv.conf` 设置一下网关 `8.8.8.8` 和 `114.114.114.114`~~
   
3. docker
4. frpc
5. nextcloud

### TrueNAS 安装

1. 挂载存储池
2. 打开网络共享服务(SMB、NFS、WebDAV)

### Ubuntu 22.04 安装

1. apt 换源 / Clash / zsh+omz / 中文输入法等基础设施见：[Ubuntu 22.04 虚拟机搭建全流程](https://cs.haohaha.cn/greenhand/Ubuntu2204-greenhand/Ubuntu2204-greenhand)
2. 下载专业软件

### 需求类

1. Nextcloud
   1. 存储
   2. 通话
   3. 办公等套件
2. Git服务器？预留。
3. 写端口映射表
4. 看看v6？有线也许可以，但无线是真不行
5. 装向日葵和编程等所需组件。
