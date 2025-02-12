# PVE-服务器部署

## PVE安装

略，有待补充

## PVE初始化

### 整合固态存储空间

> 删除 locall-lvm，合并存储空间到 local

1. 在 PVE 的命令行里执行以下命令：

```bash
lvremove pve/data
# 随后键入 y 以确定删除操作
lvextend -l +100%FREE -r pve/root # 将存储空间都合并到 local
```

2. 在 PVE 的操作界面点击 `数据中心 - 存储` ，选中  `local-vm` ，点击 `移除`；
3. 再双击打开 `local` ，将内容一栏追加勾选 “磁盘映像”，点击 `OK` 确定即可。

### AX210驱动更改

> （见此文章：[基于PVE与AX210无线网卡的NAS主机调试记录](https://www.bilibili.com/read/cv35005863)）

运行信息大概类似下面这样：

```bash
> dmesg|grep iwl
#略
iwlwifi 0000:aa:00.0: WRT: Invalid buffer destination
#略
iwlwifi 0000:aa:00.0: loaded firmware version 83.e8f84e98.0 ty-a0-gf-a0-83.ucode op_mode iwlmvm
iwlwifi 0000:aa:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420
```

即新版的PVE内核不兼容。这里引用一段原文，以防原文丢失：

> 似乎是读驱动时报了”Invalid buffer destination“，然后顺着这个错误信息，在archlinux论坛里翻到两个帖子：
>
> https://bbs.archlinux.org/viewtopic.php?id=288765
>
> https://bbs.archlinux.org/viewtopic.php?id=286305
>
> 提到了“AX210/211无线网卡在OS的某次6.X内核更新后无法使用”，报错和上面相同。看了下PVE 8.2的内核，发现用的是Kernel 6.5.11的Debian 12.5。

移动新的驱动：

```bash
mv /usr/lib/firmware/iwlwifi-ty-a0-gf-a0-86.ucode.xz ~/ # 我这里有86版本，依情况而定
mv /usr/lib/firmware/iwlwifi-ty-a0-gf-a0-83.ucode.xz ~/
# 直到降到尾号为72版本，就可以正常运行啦！
```

重启机子，再次查看运行信息，即正常：

```bash
root@haohaha:~# dmesg | grep -i iwl
[    3.878485] iwlwifi 0000:07:00.0: enabling device (0000 -> 0002)
[    3.880018] iwlwifi 0000:07:00.0: Detected crf-id 0x400410, cnv-id 0x400410 wfpm id 0x80000000
[    3.880029] iwlwifi 0000:07:00.0: PCI dev 2725/0024, rev=0x420, rfid=0x10d000
[    3.880303] iwlwifi 0000:07:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-86.ucode failed with error -2
[    3.880369] iwlwifi 0000:07:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-85.ucode failed with error -2
[    3.880430] iwlwifi 0000:07:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-84.ucode failed with error -2
[    3.880486] iwlwifi 0000:07:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-83.ucode failed with error -2
[    3.880547] iwlwifi 0000:07:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-82.ucode failed with error -2
[    3.880605] iwlwifi 0000:07:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-81.ucode failed with error -2
[    3.880662] iwlwifi 0000:07:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-80.ucode failed with error -2
[    3.880718] iwlwifi 0000:07:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-79.ucode failed with error -2
[    3.880788] iwlwifi 0000:07:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-78.ucode failed with error -2
[    3.880846] iwlwifi 0000:07:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-77.ucode failed with error -2
[    3.880901] iwlwifi 0000:07:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-76.ucode failed with error -2
[    3.880958] iwlwifi 0000:07:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-75.ucode failed with error -2
[    3.881014] iwlwifi 0000:07:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-74.ucode failed with error -2
[    3.881074] iwlwifi 0000:07:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-73.ucode failed with error -2
[    3.949885] iwlwifi 0000:07:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.36
[    3.950336] iwlwifi 0000:07:00.0: loaded firmware version 72.a764baac.0 ty-a0-gf-a0-72.ucode op_mode iwlmvm
[    4.461401] iwlwifi 0000:07:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420
[    4.634925] iwlwifi 0000:07:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x3f
[    4.634940] iwlwifi 0000:07:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    4.634952] iwlwifi 0000:07:00.0: WFPM_AUTH_KEY_0: 0x90
[    4.634964] iwlwifi 0000:07:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[    4.637355] iwlwifi 0000:07:00.0: loaded PNVM version e28bb9d7
[    4.652500] iwlwifi 0000:07:00.0: Detected RF GF, rfid=0x10d000
[    4.721469] iwlwifi 0000:07:00.0: base HW address: e8:bf:b8:9b:97:9a
[    4.818834] iwlwifi 0000:07:00.0 wlp7s0: renamed from wlan0
```

## 安装 iStoreOS (OpenWRT)

### 安装步骤

1. 使用 MobaXTerm 可更方便传输文件。

2. 向 PVE 内传入 `img2kvm` 和 下载好的 iStore镜像/OpenWRT镜像，版本要根据自己主机的指令集架构选择。

3. 赋予 `img2kvm` 执行权限： `chmod +x ./img2kvm`

4. 新建虚拟机，虚拟机 ID 为 `100` （参考）

    1. 添加 PCI 设备，直通 AX210

5. 在 PVE 命令行中执行命令

    格式： `./img2kvm <传入的镜像名称> <虚拟机号> <磁盘号> <放入的存储设备名>`

    我的命令为：

    ```bash
    ./img2kvm istore... 100 vm-100-disk-0 local
    ```

6. 在 PVE 的操作界面将新建硬盘正式添加到设备中，在启动项中打开此磁盘启动，并排至第一位。

7. 打开 iStoreOS 之后，编辑 `/etc/config/network` ，将其其中一段改为：

    ```bash
    config interface 'lan'
    option device 'br-lan'
    option proto 'static'
    option ipaddr 'xxx.xxx.xxx.xxx' # 这里填写安装 PVE 时所写的网关地址
    option netmask '255.255.255.0'
    option ip6assign '60'
    ```

8. 重启即可进入软路由设置界面，可连接 WiFi，并配置 IPv6。

### 配置 iStoreOS

1. 在主页选择更换软件源，更换为中科大源
2. 进入系统-软件包，点击更新列表
3. 进入iStore，安装 frpc。

### IPv6+DDNS-GO+Socat 部署服务器到公网

参考视频：[手把手教学！Openwrt IPV6 ddns解析，公网访问，远程开机，远程桌面 - Bilibili](https://www.bilibili.com/video/BV1NL411X7KA)

!!! note "DDNS-GO"
    
    1. 注意，腾讯的密钥和 DnsPod 搀在一个页面了，默认打开的是腾讯的，千万注意。
    2. DnsPod 那的白名单不用开，默认就是关着的，别开。开了反倒可能出现 DDNS-Go 的 “IP非法” 错误。

!!! note "备案"

    - 其实不用云服务器，只用域名的话，备案其实也不用备（毕竟备案需要有云资源）。

## PVE 配置

### 更新中科大源并更新软件

```bash
sed -i 's|^deb http://ftp.debian.org|deb https://mirrors.ustc.edu.cn|g' /etc/apt/sources.list
sed -i 's|^deb http://security.debian.org|deb https://mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list
rm /etc/apt/source.list.d/* # 删除其他源
apt update
apt upgrade
```

### 优化 PVE 界面

1. 将 pve_source.tar,gz 传入 PVE 中
2. 解压此包
3. 命令行中运行 `pve-source` 
4. 执行 6 选项，优化 PVE 界面；
5. 执行 7 选项，选 `o` 即可。

### 设置用户账号

    ```text
    cat /etc/passwd	# 查看所有用户的列表
    sudo useradd -m 用户名 -s /bin/bash	# 创建新用户，并使用/bin/bash 作为 shell
    sudo passwd 用户名	# 为新用户设置密码
    sudo adduser 用户名 sudo	# 为新用户添加管理员权限
    sudo userdel 用户名	# 删除用户
    ```

### 安装 KDE 图形界面

1. 运行如下命令

```bash
apt install kde-full -y
apt install lightdm -y
# 在随后的设置中选择 lightdm 即可
apt install chromium -y
```

2. 重启电脑，右上角左数第一个图标选择 Plasma(x11)，然后输入用户名密码即可进入图形界面。

### 图形界面配置

#### 安装 X11VNC-Server

#### 安装搜狗输入法

#### 安装 Zsh 并美化

……

## 安装 Ubuntu 22.04

### 设置网络配置

1. 编辑 `/etc/netplan/01-network-manager-all.yaml`

```bash
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:  # 替换为您的网络接口名称
      dhcp4: no
      addresses:
        - 192.168.3.50/24
      routes:
        - to: default
          via: 192.168.3.1
      nameservers:
        addresses: [223.6.6.6, 8.8.8.8]

```

2. 执行 `sudo netplan apply`

### 设置系统代理

### 更改启动界面

lightdm

### 安装 X11VNC-Server



### 配置 Docker

#### Docker换源

见 [2024 年 4 月可以用的 docker 国内源 - Josefa@知乎](https://zhuanlan.zhihu.com/p/690195557)

emmm，看起来换官方源开代理更靠谱。

官方源：`https://registry.docker-cn.com`

然后重启 Docker 服务 `sudo systemctl restart docker`

#### Docker配置代理

注意是 `172,.17.0.1:7890` ，因为 docker 用的是 docker 自己的网卡 `docker0` 。

### Docker 内 Nextcloud 配置代理

配置 `config/config.php` ：

```bash
	'proxy' => 'http://172.17.0.1:7890', # 因为是docker内，故docker网关为172.17.0.1
```

### WebDAV 挂载到 Ubuntu

见：[Linux 将 WebDAV 挂载为本地磁盘](https://blog.lincloud.pro/archives/36.html)

```bash
sudo apt install davfs2
mkdir osca
sudo mount -t davfs http://192.168.9.3:6293/osca/ ~/osca
```

后续还有重启自动挂载，看文章就是了。

如果Nextcloud无法读取信息，要检查：

1. 容器内 `data/` 目录的所有者，应该是 `www-data`
2. 挂载点权限是否改变
3. TrueNAS 的 `/mnt/oscaPool` 所有者是否为 osca，即 TrueNAS 的配置用户这一步是否做好！

### Nextcloud 部署 OnlyOffice

> 主要思路： [使用docker进行nextcloud+onlyoffice环境搭建 - CSDN](https://blog.csdn.net/houjiezhuang/article/details/134122734)
>
> 辅助文档：[NAS搭建NextCloud集成OnlyOffice - CSDN](https://blog.csdn.net/u011723630/article/details/135560531)

要点：

1. `config.php` 内要写：

   ```bash
   'proxy_exclude' => ['172.17.0.2'],
   'onlyoffice' => [
   	'verify_peer_off' => true,
       'DocumentServerUrl' => 'http://192.168.9.2:6290/', // 外部访问
       'DocumentServerInternalUrl' => 'http://172.17.0.2/', // 内部访问
   ],
   'allow_local_remote_servers' => true,
   ```

2. 改 OnlyOffice 容器内 `/etc/onlyoffice/documentserver/default.json` 里面的代码：

   ```bash
   "requestDefaults": {
                                   "headers": {
                                           "User-Agent": "Node.js/6.13",
                                           "Connection": "Keep-Alive"
                                   },
                                   "gzip": true,
                                   "rejectUnauthorized": false # 这里要把原来的 true 改成 false
                           }, 
   ```

3. 一定要去 OnlyOffice 的内部看好密钥的每个字母，这非常重要。

4. 更新字体参考：[ubuntu server 22.04 使用docker安装 onlyoffice 8.0同时添加中文字体、字号 - CSDN](https://blog.csdn.net/fire_in_java/article/details/138905726)

   `docker cp /path/to/fonts/. my_container:/usr/share/fonts/`

   要复制 `mini-fonts` 和 `fonts` 两个文件夹的.

   就是别忘了更新浏览器缓存。

## 安装 TrueNAS Core

### PVE-硬盘直通

见  [硬盘直通 - firemakergk@Github](https://github.com/firemakergk/aquar-build-helper/blob/master/details/pve%E7%A1%AC%E7%9B%98%E7%9B%B4%E9%80%9A.md)、

### 配置网络

```bash
ifconfig <网卡> inet <ip> netmask <子网掩码>
```

### 配置用户（必做！！）

见 [truenas下配置用户及权限 - firemakergk@Github](https://github.com/firemakergk/aquar-build-helper/blob/master/details/truenas%E4%B8%8B%E9%85%8D%E7%BD%AE%E7%94%A8%E6%88%B7%E5%8F%8A%E6%9D%83%E9%99%90.md)

### 配置池

见 [TrueNAS存储池配置 - firemakergk@Github](https://github.com/firemakergk/aquar-build-helper/blob/master/details/TrueNAS%E5%AD%98%E5%82%A8%E6%B1%A0%E9%85%8D%E7%BD%AE.md)

### 配置 WebDAV 服务

见 [TrueNAS下的WebDAV服务配置 - firemakergk@Github](https://github.com/firemakergk/aquar-build-helper/blob/master/details/TrueNAS%E4%B8%8B%E7%9A%84WebDAV%E6%9C%8D%E5%8A%A1%E9%85%8D%E7%BD%AE.md)
