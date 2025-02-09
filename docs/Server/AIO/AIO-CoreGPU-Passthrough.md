# 核显直通笔记

!!! info ""
    
    author: Haohahahaha (Haorui Zhang)
    
    mail: 1259203802@qq.com

    date: 2025-02-10

!!! note "参考文献"
    - [Intel 核显直通 optionROM - gangqizai @ GitHub](https://github.com/gangqizai/igd)
        
        - [华硕主板设置核心显卡显存大小方法 - IPANSON官方知识库](https://knowledge.ipason.com/ipKnowledge/knowledgedetail.html/1567)
  
    - [pve虚拟机设置及独显直通 - firemakergk @ GitHub](https://github.com/firemakergk/aquar-build-helper/blob/master/details/pve%E8%99%9A%E6%8B%9F%E6%9C%BA%E8%AE%BE%E7%BD%AE%E5%8F%8A%E7%8B%AC%E6%98%BE%E7%9B%B4%E9%80%9A.md)
  
    - [直通Intel12代核显给ubuntu22虚拟机并配置jellyfin实现硬解 - firemakergk @ GitHub](https://github.com/firemakergk/aquar-build-helper/blob/master/details/%E7%9B%B4%E9%80%9AIntel12%E4%BB%A3%E6%A0%B8%E6%98%BE%E7%BB%99ubuntu22%E8%99%9A%E6%8B%9F%E6%9C%BA%E5%B9%B6%E9%85%8D%E7%BD%AEjellyfin%E5%AE%9E%E7%8E%B0%E7%A1%AC%E8%A7%A3.md)
    
    - [PVE 直通并强制拆分 iommu group 编译 PVE 内核 - 企鹅大大的博客](https://qiedd.com/1894.html)
    
    - [硬件直通 - 国光的PVE环境搭建教程](https://pve.sqlsec.com/4/2/#vfio)

!!! info "准备的文件"

    来源：[使用方法 - gangqizai @ GitHub](https://github.com/gangqizai/igd?tab=readme-ov-file#%E4%BD%BF%E7%94%A8%E6%96%B9%E6%B3%95)
    
    - 本ROM 需要使用两个rom文件:
        
        - 核显直通 OptionROM: `gen12_igd.rom` --各平台基本通用
        
        - GOP ROM: --- 根据不同核显平台选择相应rom文件，11-13代酷睿用 `gen12_gop.rom`

## 1. 传入文件

- 把上述两个rom file copy to `/use/share/kvm/`

## 2. PVE 显卡直通设定

- 编辑 `grub`，增加选项
  
    ```bash
    # 打开此文件
    vim /etc/default/grub   
    # 将此行修改为示例的样子
    GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt initcall_blacklist=sysfb_init pcie_acs_override=downstream"
    # 更新 grub 
    # update-grub
    ```

- 编辑 `/etc/modules`，增加以下 module
    
    ```bash
    # 打开此文件
    vim /etc/modules
    # 添加如下四行
    vfio
    vfio_iommu_type1
    vfio_pci
    vfio_virqfd
    # 此时再更新 grub 即可。
    update-grub
    ```

- 把显卡驱动加入黑名单

    ```bash
    # 编辑黑名单文件（如没有即新建）
    vim /etc/modprobe.d/pve-blacklist.conf
    # 添加如下几行
    blacklist i915
    blacklist snd_hda_intel 
    blacklist snd_hda_codec_hdmi
    # 可能还可以添加几行
    blacklist nvidiafb
    blacklist nouveau
    blacklist nvidia
    blacklist radeon
    blacklist amdgpu
    ```

- 执行 `lspci -n | grep -E "0300"` 查看并记录核显 VendorID 和 DeviceID，通过设备ID绑定vfio-pci 
    
    ```bash
    # 编辑此文件
    #     但我现在觉得可能是作者写错了，应该是vfio.conf。
    #     反正我两个都建了，内容一模一样（有点懒）
    vim /etc/modprobe.d/vifo.conf
    # 在文件中添加一行
    #     "ids=8086:a780" 仅为示例！
    #     且可通过 `,` 连接多个设备ID，以将多个设备绑定到 vfio-pci 
    #     > vifo.conf 没有 disable_vga=1，有的删掉！
    options vfio-pci ids=8086:a780
    # 更新
    update-initramfs -u
    # 重启
    #     重启后添加设备时应该可以看到核显了。
    reboot
    ``` 

## 3. 按要求新建虚拟机

新建虚拟机的操作：

1. 机型必须 {==i440fx==} ，（QEMU不支持Q35 核显Legacy模式下显示，可以定制QEMU支持Q35，不在本文讨论） 

2. scsi控制器设置为 {==VirtIO SCSI==} 

3. 将BIOS设置为 {==OVMF(UEFI)==}，EFI存储设置为local-lvm即可（这个看实际命名），Intel核显已不支持传统BIOS启动.

4. {==添加TPM==}，TPM存储设置为local-lvm即可，版本v2.0  

5. CPU设置下：将类型设置为 {==host==} ,这样可以获取cpu的所有指令集 

6. 虚拟机内存 {==至少4G==} ，小于4G可能有问题

7. 网络设置下： 将“模型”设置为 {==VirtIO(半虚拟化)==}，这是除了直通网卡外性能最好的方案。

8. 新建好后{==添加 PCI 设备==}-选择原始设备，应该可以看到 intel 核显与声卡了。
   
    1. 选择原始设备的时候，最左侧一列为 ID，核显 ID 通常为 `0000:00:02.0`，声卡 ID 通常为 `0000:00:1f.3`。

9. 将 显示 设置为 {==无==}

## 4. 修改虚拟机配置文件

1. 核显PCI加入legacy-igd=1以支持核显Legacy模式下显示
   
2.  args加入：-set device.hostpci0.addr=02.0 -set device.hostpci0.x-igd-gms=0x2 -set device.hostpci0.x-igd-opregion=on
    
    1.  ~~args中的 “-debugcon file:/root/d-debug.log -global isa-debugcon.iobase=0x402” 为调试文件，介意的不加~~
    
    2.  建议 x-igd-gms=0x2，同时注意BIOS设定：DVMT pre allocated，不要大过64M
   
!!! info "BIOS 设定 DVMT"
    - 这里说的是物理机的 BIOS。
    - 华硕主板的选项在 `高级` - `北桥` - `显示设置` - `DVMT Pre-allocated`，默认 64M，检查一下，不对改正即可。

最后结果如下：

```bash
args: -set device.hostpci0.addr=02.0 -set device.hostpci0.x-igd-gms=0x2 -set device.hostpci0.x-igd-opregion=on -debugcon file:/root/igd_debug.log -global isa-debugcon.iobase=0x402
# ……中间为conf已有内容
hostpci0: 0000:00:02.0,legacy-igd=1,romfile=gen12_igd.rom
hostpci1: 0000:00:1f.3,romfile=gen12_gop.rom
```

!!! tip "可用的辅助命令"
    ```bash
    # 查询系统状态是否确实开启了IOMMU
    dmesg | grep -e DMAR -e IOMMU -e AMD-Vi
    ```

!!! danger "注意事项"
    实测有部分主板不支持 ACS 功能，故 intel 硬件 IOMMU 打开时， intel 的声卡也和板载 intel 网卡相连。应注意此事，做好买个千兆网卡的准备。
    > 浩睿吐槽：omg，耗了我一宿，好累😪

!!! note "补充：[强制拆分IOMMU的办法](https://qiedd.com/1894.html)"

    经验：尝试了，但实际效果对 声卡-网卡 “绑定” 现象 无帮助，但有需求时依然可以参考。

## 5. 开机，安装驱动

- 此步骤略，只要有网，下载个 intel 的驱动确实有手就行。

---

结束啦，其实早就想做核显直通的笔记了（24年7月），结果这部分的施工最早也才是1月初哈城之旅。好啦，趁着2月这次机会，抓紧写好也不错嘛😉