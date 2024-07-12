# 在服务器内使用 Docker 建立 Nextcloud 私有云

> author: Haohahahaha (Haorui Zhang)
>
> mail: 1259203802@qq.com
>
> date: 2024-07-12

!!! note "目前简单记录所有命令及简单注释"

```bash
// 安装 docker
sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo useradd -m -s /bin/bash docker_user
sudo passwd docker_user	// 密码 OScar0926
sudo usermod -aG docker docker_user
sudo adduser docker_user sudo
su - docker_user 

// docker 改代理
sudo mkdir /etc/systemd/system/docker.service.d
sudo touch/etc/systemd/system/docker.service.d/http_proxy.conf
sudo vim /etc/systemd/system/docker.service.d/http_proxy.conf
// 文件内容
[Service]
Environment="HTTP_PROXY=127.0.0.1:7890"
Environment="HTTPS_PROXY=127.0.0.1:7890"
// 重启 docker 并验证代理是否生效
systemctl daemon-reload && systemctl restart docker
systemctl show --property=Environment docker

// 配置mysql
docker pull mysql:latest
docker run -itd --name mysql -p 3307:3306 -e MYSQL_ROOT_PASSWORD=[YOUR_PASSWD] mysql
docker exec -it mysql bash
mysql -uroot -p
create database nextcloud charset=utf8;
exit
exit
docker ps

// 安装 docker
docker search nextcloud
docker pull nextcloud
docker run --name nextcloud -p 6290:80 -v /home/oscar/nextcloud/data:/var/www/html/data -d nextcloud
docker ps
// 记录下屏幕显示的 CONTAINER ID，后面将会使用 

// 打开网页，主机:端口
管理员账号：
管理员密码：
数据目录:默认
数据库选择 mysql
数据库名称 nextcloud
主机名一定要填写ip:端口(如果是localhost+端口,会报错,原因未知,给权限也没用)
数据库账户一定要是root超级用户(如果是其他新创建用户,也会报错,给所有权限也没有用)

// 设置 nextcloud 允许外部设备访问
docker exec -it nextcloud /bin/bash
sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources
sed -i 's/security.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources
apt-get update
apt-get install vim -y
cd config
vim config.php
// 在array中添加1
array (
    0 => '10.70.165.115',
    1 => '*',
),
//
exit
docker restart nextcloud

// 设置内网穿透 ngrok
TODO

// 设置公网服务器提供重定向服务
// 大概需要本地服务器将动态域名更新上传到服务器上？
TODO
```