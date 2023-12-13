# Ubuntu 22.04 虚拟机自动化安装

> author: Haohahahaha (Haorui Zhang)
>
> mail: 1259203802@qq.com
>
> date: 2023-12-13

!!! info "在线与本地化"

	本脚本的部分命令可在有本地资源的时候省去下载在线资源的时间，实现本地化安装。

	本地化脚本均以 `-local.sh` 为文件名后缀

??? danger "部分功能失效"

	Clash for Windows 已停止维护，所以我已经将在线下载的地址改为我提供的原版安装包（位于 cs/greenhand/Ubuntu2204-greenhand/ ）

!!! note "安装步骤"

	```bash 
	sudo ./1-workflow.sh
	sudo ./2-cfw.sh
	./3-ohmyzsh-1.sh
	# 跳转到 zsh 后
	source ~/3-ohmyzsh-2.sh
	sudo ./4-SogouInputMethod-1.sh
	# 根据脚本最后一行的提示，设置系统的语言设置，启用Fcitx 4
	
	[](http://cs.haohaha.cn/greenhand/Ubuntu2204-greenhad/Ubuntu2204-greenhand/#open-fcitx)
	[](http://cs.haohaha.cn/greenhand/Ubuntu2204-greenhad/Ubuntu2204-greenhand/#configure-sogou)

	```

???+ warning "尚未完善的功能"
