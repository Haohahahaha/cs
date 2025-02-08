# 多分支仓库的创建与上传

!!! info ""

    Create Date: 2023-05-12 19:28

    Author: 瀚哲

!!! info "更新日志"

    20250208：由于OSCA组队开发需求，故来添加更新。

    20230512：第一次编写。


## 初始化Git仓库

```bash
mkdir [test]  # 新建文件夹 test 以存放某仓库文件
git init    # 初始化 Git
git config user.name "[my_GitHub_username]"	# 创建此文件夹内的GitHub用户名，如果需要全局设置，则在"config"后面加"--global"
git config user.email "[my_GitHub_email]"		# 创建此文件夹内的GitHub账户，如果需要全局设置，同上。
git remote add [origin] [MY_GIT_SSH_OR_HTTPS] # 添加远程仓库地址
# `origin`只是远程仓库的代称，可以更改为你想要的任意英文拼写。
git pull    # 拉取远程主线，如果有的话
git pull [MY_GIT_SSH_OR_HTTPS]  # 如初次使用，且为合作者，直接从某仓库拉取主线
```

## Git分支的创建

> 无论是在本地仓库还是远程仓库上，特别是在做项目的时候,你一般都是不会直接提交到`master(主分支)`，都是提交到另外一个分支如`dev`分支。
>
> 当然在本地你可能为了方便直接在`master`上开发代码，但是一般最好都是另建一个分支，开发好一定的代码，再合并提交到`master`，最后再推送到远程仓库的`dev`分支（你的boss不会让你直接提交到`master`，因为可能还有别的同事也在开发，boss会将你们的代码进行合并然后才提交到`master`）。
>
> 接下来来实现在本地新建一个`dev`分支,修改内容后提交合并到`master`，然后提交到远程仓库的`dev` 。

```bash
git branch -b [BRANCH_NAME]	# 本地新建分支，并[切换]到新分支
git branch [BRANCH_NAME]		# 本地新建分支，[不切换]到新分支

git branch -l	# 列出分支

git checkout [BRANCH_NAME]	# 切换到某一分支
```

## 查看状态 && 提交代码到远程仓库

```bash
git status  # 查看 git 状态
touch README.md     # 新建文件 README.md （可以编辑）
git add README.md	# 添加需要改变的文件 README.md
git commit -m "[commit_info]"		# 提交代码到本次仓库，"commit_info"为本次提交的注释信息
git push -u [origin] master	# 将 master 即主分支的内容提交到远程仓库

# git branch --all	# 查看本地和远程的所有分支
git branch -r   # 查看远程分支
```

## Git本地分支上传到GitHub仓库某分支

初次上传时，可在 GitHub 仓库上新建名为 `MY_NEW_BRANCH` 的分支

上传命令为：

```bash 
git push origin [LOCAL_BRANCH_NAME]:[MY_NEW_BRANCH] 
# 这个是语法，且如果远程仓库上没有对应的分支名，远程会自动创建。
```

## 合并分支与解决冲突

- 这个地方可直接在 GitHub 网页上操作，时间原因不做截图了。

## 仍需解决

- pull request 之后的邮件提醒设置（提醒管理者检查并处理merge请求）