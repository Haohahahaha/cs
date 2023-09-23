# 多分支仓库的创建与上传

> Create Date: 2023-05-12 19:28
>
> Author: 瀚哲

## 创建仓库

### 初始化Git仓库

```bash
git init
git config user.name "my_GitHub_username"	# 创建此文件夹内的GitHub用户名，如果需要全局设置，则在"config"后面加"--global"
git config user.email "my_GitHub_email"		# 创建此文件夹内的GitHub账户，如果需要全局设置，同上。
```

### 查看状态并提交代码到本地仓库

```bash
git status
git branch -M master
touch README.md
git add .	# 添加此文件夹内所有改变的文件
git commit -m "commit_info"		# 提交代码到本次仓库，"commit_info"为本次提交的注释信息
```

### 将本地仓库与远程仓库连接

```bash
git remote add origin MY_GIT_SSH_OR_HTTPS
git push -u origin master	# 将master即主分支的内容提交到远程仓库
git branch --all	# 查看本地和远程的所有分支
```

## Git分支的创建

> 无论是在本地仓库还是远程仓库上，特别是在做项目的时候,你一般都是不会直接提交到`master(主分支)`，都是提交到另外一个分支如`dev`分支。
>
> 当然在本地你可能为了方便直接在`master`上开发代码，但是一般最好都是另建一个分支，开发好一定的代码，再合并提交到`master`，最后再推送到远程仓库的`dev`分支（你的boss不会让你直接提交到`master`，因为可能还有别的同事也在开发，boss会将你们的代码进行合并然后才提交到`master`）。
>
> 接下来来实现在本地新建一个`dev`分支,修改内容后提交合并到`master`，然后提交到远程仓库的`dev` 。

```bash
git branch -b BRANCH_NAME	# 本地新建分支，并切换到新分支
git branch BRANCH_NAME		# 本地新建分支，不切换到新分支

git branch -l	# 列出分支

git checkout BRANCH_NAME	# 切换到某一分支
```

## Git本地分支上传到GitHub仓库某分支

在GitHub上新建名为 `MY_NEW_BRANCH` 的分支

上传命令为：

```bash 
git push origin <LOCAL_BRANCH_NAME>:<MY_NEW_BRANCH>		# 这个是语法，且如果远程仓库上没有对应的分支名，远程会自动创建。
```

