# SSL证书部署or更新流程

## 申请或续费

访问[我的证书](https://console.cloud.tencent.com.cn/ssl)，然后点击续费，或者删了重新申请。

过不了两三分钟就申请成功了，下载 Nginx 版本（含 `pem` 和 `key` 文件）。

## 部署平台

### NextCloud

1. 进入 NextCloud 的 Docker 内，然后编辑 `/etc/apache2/cert/` 下的 `pem` 和 `key` 文件，将新的文件内容覆盖掉。

2. 退出 Docker，然后执行命令 `sudo docker restart nextcloud`，即可访问。

### TrueNAS

1. 进入 TrueNAS 界面后，在 `系统-证书` 下添加新的证书

2. 在 `系统-常规` 下，更换 `GUI SSL证书` 的选项为最新添加的证书，系统会重启服务，即可。

### PVE

1. 后台连接 PVE，更新 `/etc/pve/nodes/[Your_Host_Name]/` 下的 `pem` 和 `key` 文件，将新的文件内容覆盖掉。

2. 执行 `systemctl restart pveproxy`，等待更新完成即可。

---

> 20241224感想：第一次更新，有点手忙脚乱，赶紧记录下来，下次就好了。嘎嘎😋