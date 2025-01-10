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

## 安装流程

!!! note "1. 注册 Github 账号"

	STFW.

!!! note "2. 建立个人资料仓库与博客仓库"

	STFW.

!!! note "3. 获取 SSH key 并上传到 Github"

	在 [Ubuntu 22.04 虚拟机自动化安装 - 获取 SSH key](http://cs.haohaha.cn/greenhand/initializer-ubuntu2204/install/#git-ssh-key-github) 中已获取到 `SSH Key`

	复制 `~/.ssh/id_rsa.pub` 内所有内容

	在 Github 个人设置中，`SSH and GPG keys` 点击 `New SSH key` 添加刚才获取到的 SSH key 即可。

!!! note "4. 设置与配置本地仓库文件夹"

	```bash
	mkdir [YOUR_folder] # 建立本地文件夹，建议与 Git 仓库同名，便于记忆
	cd [YOUR_folder] # 进入本地文件夹
	git init # Git 初始化 这个文件夹
	git config --global user.name "YOUR_NAME" # 设置全局用户名，自行设置，可建议与 GitHub 账号同名
	git config --global user.email "YOUR_EMAIL" # 设置全局邮箱，自行设置，可建议与 GitHub 账号同邮箱
	git remote add REMOTE_NAME GITHUB_REMOTE # 设置 GitHub 远程仓库地址的名称，注意后面要用
	```

!!! note "5. 设置远程仓库 Github Actions 的权限"

	- 在 Settings-Actions-General 中 `Workflow Perimissions` 选择 `Read and Write permissions`

!!! note "6. 初始化仓库内容并上传到远程"

	- 克隆仓库 [initializer-material-blog](https://github.com/Haohahahaha/initializer-material-blog)

!!! danger "7. 编辑以下文件"

  	`auto-update-this-repo.sh`：

	- 将第四行 `init-material` 改为刚刚设置好的 远程仓库地址名 [REMOTE_NAME]

  	`mkdocs.yml`

	- 在第30行 `nav` 开始，编辑你的文章目录，关于设置 `navigation` 板块，请见[此处](https://squidfunk.github.io/mkdocs-material/tutorials/blogs/navigation/)，亦可参考我个人其他仓库的 `mkdocs.yml` 。

  	`README.md`
	
	- 介绍文件，不可删除。显示在 GitHub 仓库的主页

  	`docs/index.md`

	- 博客主页，自行编辑。

  	`docs/CNAME` # 个人自定义网址

	- 如已购买域名解析，请将设置好的解析名称写入本文件，以便之后启用 `Custom Domain`。
	- 如未购买，记得要删除。

	
!!! note "8. 设置 Github Deploy 分支与自定义网址"

	- Settings-Pages 中 `Build and Deployment`-`Branch` 选择 `gh-pages`，点击 `Save` 保存

	- `Custom domain` 下可设置自己的网址

!!! note "9. markdown语法与博客排版+选题+维护"

	- [markdown-it demo](https://markdown-it.github.io/)

	- [如何看待程序员持续写技术博客 - Raven 的回答](https://www.zhihu.com/question/41802793/answer/2435610889)
