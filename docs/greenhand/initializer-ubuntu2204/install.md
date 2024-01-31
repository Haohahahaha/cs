# Ubuntu 22.04 虚拟机自动化安装

> author: Haohahahaha (Haorui Zhang)
>
> mail: 1259203802@qq.com
>
> date: 2023-12-13

!!! info "本文章为仓库适配教程"

	仓库地址：[initializer-ubuntu2204](https://github.com/Haohahahaha/initializer-ubuntu2204)

!!! info "在线与本地化"

	本脚本的部分命令可在有本地资源的时候省去下载在线资源的时间，实现本地化安装。

	本地化脚本均以 `-local.sh` 为文件名后缀

!!! note "安装步骤"

	### 更新源

	### 安装必要软件包与工具链（含ysyx）

	!!! tip "2024-01-31 补丁"

		为了在 VSCode 上使用起来更加舒适，可在 Windows 上使用。

		同时 Ubuntu 上面的使用也应补全舒适度。

		故需要安装以下组件：

		- For Windows: 
			- `SSH`：开启SSH服务
			- `net-tools`：查询ipv4地址
		- For Ubuntu：
		    - `imwheel`：解决鼠标滚轮慢的问题

	```bash 
	sudo ./1-workflow.sh
	```

	### Windows 下安装 Clash for Windows 并在虚拟机内设置本地代理

	下载 Windows 平台的 CfW 并安装：

	??? warning "Linux平台失效，更改实现方法"

		Clash for Windows 已停止维护，所以我已经将在线下载的地址改为我提供的 Windows 原版安装包，[点击下载](https://github.com/Haohahahaha/cs/raw/master/docs/greenhand/Ubuntu2204-greenhand/Clash.for.Windows.Setup.0.20.39.ia32.exe)

	关于如何设置服务，这里有[详细步骤](https://cs.haohaha.cn/greenhand/Ubuntu2204-greenhand/Ubuntu2204-greenhand/#1_2)

	虚拟机内设置代理：

	安装net-tools，执行ifconfig，查询本地代理服务器地址
	
	```bash
	sudo apt install net-tools
	ifconfig
	```

	观察 ens33 下 inet 的 ip 地址，记住前三段，最后替代为1

	打开系统设置，Network-VPN-Network Proxy内，将 `HTTP Proxy` `HTTPS Proxy` `Socks Host` 的第一格内容填入刚才的 ip 地址，第二格内容（代理端口）填写 CfW 默认的 `7890`，即可完成设置。

	### 安装 zsh 并使用 oh-my-zsh 美化

	!!! warning "注意，这里不能使用 sudo，因为会改变安装路径。我们此处是给用户安装。"

	```bash
	./3-ohmyzsh-1.sh
	```

	跳转到 zsh 后
	
	```zsh
	source ~/3-ohmyzsh-2.sh
	```

	### 安装中文输入法（搜狗）
	
	```bash
	sudo ./4-SogouInputMethod-1.sh
	```

	根据脚本最后一行的提示，设置系统的语言设置，[启用Fcitx 4](http://cs.haohaha.cn/greenhand/Ubuntu2204-greenhad/Ubuntu2204-greenhand/#open-fcitx)
	
	执行第二条脚本

	```bash
	sudo ./4-SogouInputMethod-2.sh
	```

	重启后添加输入法，步骤[在此](http://cs.haohaha.cn/greenhand/Ubuntu2204-greenhad/Ubuntu2204-greenhand/#configure-sogou)

	### 安装办公软件，可选配

	不需要的可以注释掉，这里的软件包可能过时，但我本地有一套，故常用本地安装，可在校内节省很大一部分下载时间。

	```bash
	sudo ./5-officeTools.sh
	```

	### 设置字体为苹果字体

	这个也是包含了本地包才能执行，主要资源在 `resources/` 目录下。

	也可以自行创建 `./resources/fonts/` 文件夹，自行上网寻找资源，将苹方字体的所有 `.ttf` 文件放入即可。

	```bash
	sudo ./6-fonts.sh
	```

	### 初始化git，并获取 SSH key, 上传到 Github

	```bash
	./7-ssh-github.sh
	```

	之后请按[此步骤](https://cs.haohaha.cn/greenhand/Blog-intialization/blog-init/#ssh-key-github)进行Github的配置。

???+ warning "尚未完善的功能"

	一键全自动安装，限于技术实力，目前还没有开发完成。本安装教程为辅助说明文档，当开发完成后将会优化。
