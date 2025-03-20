## PVE 中 local 盘空间不足的解决办法

!!! info ""
    
    author: Haohahahaha (Haorui Zhang)
    
    mail: 1259203802@qq.com

    date: 2025-03-20

最近我的 PVE 存放虚拟机的磁盘空间明显不足，经常爆缸（系统直接死机无法访问），于是在我多次删除我囤积的 ISO 镜像之后，依然还有问题，于是今天集中解决了一下。

我询问了 GPT，大概原理是虚拟机里删除的东西并不会真正删除，而是一直存储着（缓存着）。所以我们要安装一个组件，并且执行一条命令即可：

```bash
apt install -y libguestfs-tools
virt-sparsify --in-place /var/lib/vz/images/105/vm-105-disk-0.qcow2 # 105只是示例，要具体看虚拟机的配置情况。
```

这样就轻松完成了磁盘的清理，我清理出来几乎一半的磁盘空间，这下爽玩咯😊😋~