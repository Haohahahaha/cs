# SSL证书部署or更新流程

!!! tip "更新记录"

    20241224感想：第一次更新，有点手忙脚乱，赶紧记录下来，下次就好了。嘎嘎😋

    202502月部署更新：NextCloud 平台 第一次部署时要严格按照现在写好的做。

    20250322更新：PVE 部署简化了。

## 申请或续费

访问[我的证书](https://console.cloud.tencent.com.cn/ssl)，然后点击续费，或者删了重新申请。

过不了两三分钟就申请成功了，下载 Nginx 版本（含 `pem` 和 `key` 文件）。

## 部署平台

!!! success "NextCloud"

    1. 进入 NextCloud 的 Docker 内，然后编辑 `/etc/apache2/cert/` 下的 `pem` 和 `key` 文件，将新的文件内容覆盖掉。
        
        !!! note "初始没有这个目录，新建就可以了。"

    2. 退出 Docker，然后执行命令 `sudo docker restart nextcloud`，即可访问。

        !!! note "别忘了在 iStoreOS - Socat 端口映射那改成 https 的端口🤓"

!!! success "TrueNAS"

    1. 进入 TrueNAS 界面后，在 `系统-证书` 下添加新的证书

    2. 在 `系统-常规` 下，更换 `GUI SSL证书` 的选项为最新添加的证书，系统会重启服务，即可。

!!! success "PVE"

    打开 PVE 界面，在本机下面选择 `系统-凭证`，点击 `上传自定义凭证`，将下载好的 `pem` 和 `key` 文件导入即可，注意顺序哈（这里是 `key` 在前，`pem` 在后。
   

