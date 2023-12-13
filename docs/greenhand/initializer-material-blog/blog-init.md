# 基于 mkdocs-material 的个人博客搭建

> author: Haohahahaha (Haorui Zhang)
>
> mail: 1259203802@qq.com
>
> date: 2023-12-12

!!! info "本文章含仓库适配"

	仓库地址：[initializer-material-blog](https://github.com/Haohahahaha/initializer-material-blog)

!!! question "前置条件 (二选一)"

	- [Ubuntu 22.04 工作台搭建全流程](http://cs.haohaha.cn/greenhand/Ubuntu2204-greenhand/Ubuntu2204-greenhand/)

	- [Ubuntu 22.04 虚拟机自动化安装](http://cs.haohaha.cn/greenhand/initializer-ubuntu2204/install/)

!!! note "安装流程"

	### 注册 Github 账号

	STFW.

	### 建立个人资料仓库与博客仓库

	STFW.

	### 获取 SSH key 并上传到 Github

	在 [Ubuntu 22.04 虚拟机自动化安装 - 获取 SSH key](http://cs.haohaha.cn/greenhand/initializer-ubuntu2204/install/#git-ssh-key-github) 中已获取到 SSH Key

	复制 ~/.ssh/id_rsa.pub 内所有内容

	在 Github 个人设置中，`SSH and GPG keys` 点击 `New SSH key` 添加刚才获取到的 SSH key 即可。

	### 设置与配置本地仓库文件夹

	```bash
    mkdir [YOUR_folder]
	cd [YOUR_folder]
	git init
	git config --global user.name "YOUR_NAME"
	git config --global user.email "YOUR_EMAIL"
	git remote add REMOTE_NAME GITHUB_REMOTE
	```

	### 设置远程仓库 Github Actions 的权限

	- 在 Settings-Actions-General 中 `Workflow Perimissions` 选择 `Read and Write permissions`

    ### 初始化仓库内容并上传到远程

	- 克隆仓库 [initializer-material-blog](https://github.com/Haohahahaha/initializer-material-blog)

	- 编辑以下文件

	```bash
	auto-update-this-repo.sh
	mkdocs.yml
	README.md
	docs/index.md
	docs/CNAME # 个人自定义网址
	```
    ### 设置 Github Deploy 分支与自定义网址

	- Settings-Pages 中 `Build and Deployment`-`Branch` 选择 `gh-pages`，点击 `Save` 保存

		- `Custom domain` 下可设置自己的网址

	### markdown语法与博客排版+选题+维护

	[如何看待程序员持续写技术博客 - Raven 的回答](https://www.zhihu.com/question/41802793/answer/2435610889)
