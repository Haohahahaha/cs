# 在服务器内使用 Docker 建立 Nextcloud 私有云

> author: Haohahahaha (Haorui Zhang)
>
> mail: 1259203802@qq.com
>
> date: 2024-07-12

## 下载
???+ note "Nextcloud 兼容全平台"

    - 安卓下载地址：https://download.nextcloud.com/android/

    > 建议下载最新的 nightly 版本的 APP。

## 步骤


### 安装 docker
    sudo apt update
    sudo apt install docker.io -y
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo useradd -m -s /bin/bash docker_user
    sudo passwd docker_user	// 密码 OScar0926
    sudo usermod -aG docker docker_user
    sudo adduser docker_user sudo
    su - docker_user 

### docker 改代理
    sudo mkdir /etc/systemd/system/docker.service.d
    sudo touch/etc/systemd/system/docker.service.d/http_proxy.conf
    sudo vim /etc/systemd/system/docker.service.d/http_proxy.conf
    # 文件内容
    [Service]
    Environment="HTTP_PROXY=127.0.0.1:7890"
    Environment="HTTPS_PROXY=127.0.0.1:7890"
    # 重启 docker 并验证代理是否生效
    systemctl daemon-reload && systemctl restart docker
    systemctl show --property=Environment docker

### 采用 docker-compose 进行多 docker 部署

在这里先暂时贴一个 `docker-compose.yml` ，它需要放在你想要部署的文件夹内。

然后执行 `sudo docker-compose up -d` 即可。

关于 `docker-compose` 的命令，简约如下：

```bash
docker-compose up -d    # 创建所有容器并按顺序启动
docker-compose down     # 停止所有容器并删除
docker-compose stop     # 停止所有容器
docker-compose start    # 按顺序启动所有容器
docker-compose restart  # 停止所有容器并按顺序启动所有容器
```

`docker-compose.yml` 文件参考如下：

```yaml
version: '3'

services:
  mysql:
    image: mysql:8.0
    container_name: mysql
    restart: unless-stopped
    environment:
      - MYSQL_ROOT_PASSWORD=Hanzhe31415
      - MYSQL_DATABASE=nextcloud       # 自动创建 nextcloud 数据库
      - MYSQL_USER=hanzhe      # 为 nextcloud 创建新用户
      - MYSQL_PASSWORD=Hanzhe31415  # 为新用户设置密码
    ports:
      - "3307:3306"
    volumes:
      - ./mysql:/var/lib/mysql
    networks:
      - nextcloud-network

  cache:
    image: redis
    restart: unless-stopped
    expose:
     - "6379"
    volumes:
     - ./cache:/data
    command: redis-server --requirepass 'Hanzhe31415' # 这里的redis_password换成你要配置的redis密码
    # command指的是启动容器后代替默认启动指令来启动服务的指令
    networks:
      - nextcloud-network

  nextcloud:
    image: nextcloud:latest
    container_name: nextcloud
    restart: unless-stopped
    ports:
      - "7788:80"
      - "7789:443"
    volumes:
      - ./HaoPool:/var/www/html/data
    depends_on:
      - mysql
      - cache
    networks:
      - nextcloud-network

volumes:
  mysql_data:

networks:
  nextcloud-network:
```

??? note "此处为单条命令的 CLI 版本，后续有 docker-compose 版本，无须参考此处。"

    ### 配置mysql
        docker pull mysql:latest
        docker run -itd --name mysql -p 3307:3306 -e MYSQL_ROOT_PASSWORD=[YOUR_PASSWD] mysql
        docker exec -it mysql bash
        mysql -uroot -p
        create database nextcloud charset=utf8;
        exit
        exit
        docker ps

    ### 安装 docker-nextcloud
        ```bash
        docker search nextcloud
        docker pull nextcloud
        docker run --name nextcloud -p 6290:80 -v /home/oscar/nextcloud/data:/var/www/html/data -d nextcloud
        docker ps
        # 记录下屏幕显示的 CONTAINER ID，后面将会使用

### 安装 NextCloud 
    打开网页，主机:端口
    管理员账号：
    管理员密码：
    数据目录:默认
    数据库选择 mysql
    数据库名称 nextcloud
    主机名一定要填写ip:端口(如果是localhost+端口,会报错,原因未知,给权限也没用)
    关于查IP： sudo docker inspect mysql | grep "IPAddress"
    数据库账户一定要是root超级用户(如果是其他新创建用户,也会报错,给所有权限也没有用)

### 设置 nextcloud
    docker exec -it nextcloud /bin/bash
    sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources
    sed -i 's/security.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources
    apt-get update
    apt-get install vim -y
    cd config
    vim config.php
    # config.php 需要改动和添加的如下：
    //'memcache.local' => '\\OC\\Memcache\\APCu' // 用本地式缓存使用APCu // 注释这行 
    'memcache.local' => '\\OC\\Memcache\\Redis',
    'memcache.distributed' => '\\OC\\Memcache\\Redis', // 分布式缓存使用Redis
    'memcache.locking' => '\\OC\\Memcache\\Redis', // 启用Redis缓存的文件锁
    'redis' => array(
      'host' => 'cache', // 这里和mariadb的逻辑相同，填写容器links时映射的主机名
      'port' => 6379,
      'password' => 'redis_password' // 这是之前在配置docker-compose时配置的redis密码
    ),
    'filelocking.enabled' => 'true',
    array ( // 此处为示例
        0 => '192.168.1.123', 
        1 => 'nextcloudtest.hwb0307.com',
    ),
    'overwritehost' => 'nextcloudtest.hwb0307.com:4443',
    'overwriteprotocol' => 'https',
    'overwrite.cli.url' => 'http://nextcloudtest.hwb0307.com:4443',
    //
    exit
    docker restart nextcloud
    

### nextcloud-docker 离线安装app

1. 在网站 https://apps.nextcloud.com 中找到应用
2. 下载稳定版应用安装包（注意要和安装的 NextCloud 版本一致）
3. 解压 tar zxvf xxx.zip
4. 传入 docker 内：`sudo docker cp [localSource] [dockerName:/var/www/html/apps]`
5. 进入 docker 内
6. 更改其权限：`sudo chown -R www-data:www-data [directory]`
7. 去 NextCloud 界面打开应用，从 已禁用的应用 中 找到应用，启用即可。

### NextCloud 安装 Preview-Generator 后执行问题

1. 如果数据目录用的是 基于 PVE+TrueNAS 的方案来做的 nfs 挂载，那么就需要在 TrueNAS 的 CLI 中赋予其要 generate 的目录的权限，一般给 775 即可。

2. 需要先设置缩略图格式和质量

3. 在 `/var/www/html/config/config.php` 中设置生成缩略图的文件格式

4. 生成命令参考：`su - www-data -c 'php /var/www/html/occ peview:generate-all --path="/your/directory/here"'`
   其中这个目录是以 /var/www/html/data 为根目录来写的。
   整体命令如下：
   ```bash
   su - www-data -c 'php /var/www/html/occ config:app:set --value="256 1024" previewgenerator squareSizes'
   su - www-data -c 'php /var/www/html/occ config:app:set --value="256 1024" previewgenerator widthSizes'
   su - www-data -c 'php /var/www/html/occ config:app:set --value="256 1024" previewgenerator heightSizes'
   su - www-data -c 'php /var/www/html/occ config:app:set preview jpeg_quality --value="100"'
   # config.php 中
   'enable_previews' => true,
   'enabledPreviewProviders' =>
   array (
   0 => 'OC\\Preview\\TXT',
   1 => 'OC\\Preview\\MarkDown',
   2 => 'OC\\Preview\\Image',
   3 => 'OC\Preview\PNG',  // 比如，禁止png格式图片，请自行设置。
   ),
   # 结束
   su - www-data -c 'php /var/www/html/occ peview:generate-all --path="/your/directory/here"'
   ```
   
5. 执行命令时爆内存？
> 类似：
> 
> Fatal error: Allowed memory size of 2097152 bytes exhausted (tried to allocate 438272 bytes) in /var/www/html/3rdparty/composer/autoload_real.php on line 37
   1. 使用 `php -i | grep memory_limit` 查看为正常 512M
   2. 使用 `php --ini` 查到 `ini` 目录为 `/usr/local/etc/php`
   3. 直接把 `/usr/local/etc/php/conf.d/nextcloud.ini` 内的 `memory_limit=${PHP_MEMORY_LIMIT}` 改成 `memory_limit=512M` （我给了24GB）
   4. 解决。

### 批量传入数据

- 插上移动硬盘直接拷进去可能更合适。哦对挂载nfs我懒得写。

- 使用 `rsync` 即可搞定：
  ```bash
  sudo rsync -auvh --progress /SOURCE_DIR/* /TARGET_DIR
  ```
  - `rsync` 巨占内存。所以我们应该写个命令定时清缓存：
  ```bash
  crontab -e
  # 然后新增一行
  * * * * * sudo sync; echo 3 > /proc/sys/vm/drop_caches
  ```
  这样就不会爆内存了嘎嘎。

- 网页刷新无文件问题

  - 需要生成索引，命令行为：`su - www-data -c 'php /var/www/html/occ files:scan --all` （或者把 `--all` 改为 `username` 也可以。
  - 其实可以设置每天去扫描，不过我懒得弄了，贴个[链接](https://blog.csdn.net/u010457406/article/details/84335143)先。

  
## Alist

贴个 `docker-compose.yml` 以供参考

```yaml
version: "3"
 
services:
  app:
    image: xhofe/alist:latest
    container_name: alist
    volumes:
      - ./app:/opt/alist/data
    ports:
      - 5244:5244 # 按需修改
    restart: unless-stopped
```