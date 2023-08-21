# Ubuntu 22.04 我的第一台实体机

> Author：张浩睿
>
> Date：2023年8月21日07:46

## 前言

得益于[一生一芯](https://ysyx.oscc.cc/docs/ics-pa/0.1.html)的思想，我用五百块给自己攒了一台主机，这样一来，我就有了以Linux为系统的主力机来让我“折腾”了（笑）。

这台机器的信息如下：

```zsh
OS: Ubuntu 22.04.3 LTS x86_64 
Host: X99 
Kernel: 6.2.0-26-generic 
Uptime: 59 mins 
Packages: 2229 (dpkg), 11 (snap) 
Shell: zsh 5.8.1 
Resolution: 1440x900 
DE: GNOME 42.9 
WM: Mutter 
WM Theme: Adwaita 
Theme: Yaru-olive-dark [GTK2/3] 
Icons: Yaru-olive [GTK2/3] 
Terminal: tmux 
CPU: Intel Xeon E5-2666 v3 (20) @ 3-.500GHz 
GPU: NVIDIA GeForce GT 620 
Memory: 2368MiB / 31925MiB 
```

是的，我这个“垃圾佬”的知识终于有了用武之地，这配置就算够用了，存储不够的话，翻翻我的百宝箱，我想我能找到一堆硬盘～

好，这次博客的主题是记录一下新生产力平台的配置情况，脱胎于之前我写过的[Ubuntu 22.04 工作台搭建全流程](http://cs.haohaha.cn/greenhand/Ubuntu2204-greenhand/Ubuntu2204-greenhand/)，加上近来我从 [NJU-PA0](https://ysyx.oscc.cc/docs/ics-pa/0.1.html) 学习到的一些非常酷的 Linux 使用技巧，形成了这次的平台配置。我发现，目前纯粹的 `Ubuntu 22.04` 已经能满足我的办公与学习需求了（其实是腾讯终于出新版 Linux QQ 了），平时带着 iPad 出行即可，非常轻量化。

下面是具体配置情况。

## 生产力平台配置

### 办公软件

> 这里列出了我所安装的一些软件，请读者自行搜索下载页面，部分不易找到准确信息的软件已附带链接。

- Linux QQ
- Baidu Netdisk
- [YesPlayMusic](https://github.com/qier222/YesPlayMusic)
- [Xmind2020](http://www.hushowly.com/articles/1943) （百度网盘已存档补丁）
- [Bilibili-Linux](https://github.com/msojocs/bilibili-linux)
- Tencent Document
- Tencent Meeting
- Typora
- iriun Webcam
- Sunlogin Client
- OBS
- Libre Office

### 工作组件

- tmux

- [Clash For Windows - Release (We need Linux ver.)](https://github.com/Fndroid/clash_for_windows_pkg/releases)

- [Driver of RTL8821CU - for my network & bluetooth adpter](https://github.com/KwanWaiPang/8821cu)

- adb for connecting my android phone

- zsh

- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) - I like theme `ys` .

- git

- wget

- vim

- ysyx-“SDK”

    ```bash
    apt-get install build-essential    # build-essential packages, include binary utilities, gcc, make, and so on
    apt-get install man                # on-line reference manual
    apt-get install gcc-doc            # on-line reference manual for gcc
    apt-get install gdb                # GNU debugger
    apt-get install git                # revision control system
    apt-get install libreadline-dev    # a library used later
    apt-get install libsdl2-dev        # a library used later
    apt-get install llvm llvm-dev      # llvm project, which contains libraries used later
    apt-get install llvm-11 llvm-11-dev # only for ubuntu20.04
    ```

- Chinese Input Method （我觉得用系统自带的也够了，因为搜狗要碰运气，百度还行）

> 关于 Vim Tmux 的美化和配置，我主要参考了 ysyx 的教程，目前还没有继续探索新的东西。
>
> Terminal 美化，详见[Ubuntu 22.04 工作台搭建全流程 - 终端美化](http://cs.haohaha.cn/greenhand/Ubuntu2204-greenhand/Ubuntu2204-greenhand/#2_2)这一节。
>
> 哦对了，记得 `.vimrc` 里需要注意的配置：
>
>   ```bash
>   set ts=4
>   colorscheme elflord
>   ```

---

（搓搓手）嗯～这次配置得非常不错，所有 windows 平台上的功能均能在 Linux 上原生解决了。

开心！:happy:-
