# jyyslide-md-script 安装指南

> author: Haohahahaha (Haorui Zhang)
> 
> mail: 1259203802@qq.com
>
> date: 2023-12-07

!!! info "引言"

    ysyx 是个非常好的项目，与此同时南大 jyy 老师的 OS 课也是非常棒的课程……那么这两者有什么共同之处呢？不难看出，ysyx 主讲的 yzh 老师的课程 PPT 与 jyy 老师的 PPT 有着异曲同工之处——都采用了[Reveal.js](https://revealjs.com/)为基础框架，在此之上进行定制。

	作为大佬后面打酱油的计算机领域一哥……们儿，在自己这个小天地进行交流的时候，也不免会想到用这样的方式展示自己的 PPT 更酷一些啦。于是前些日子就开始查文档配环境，后来很幸运在 Github 看到了这个项目：[jyyslide-md](https://github.com/zweix123/jyyslide-md)，但我在构建的时候发现配置起来还是有一些麻烦的，为了后人能够更加方便地使用起来，我决定写一个脚本——[jyylide-md-script](https://github.com/Haohahahaha/jyyslide-md-scripts)，本文即为脚本尚不成熟时的辅助性安装文档。

## 准备：文件夹创建和克隆仓库

为你的工作环境创建这样的目录结构：

```bash
[Work_DIR]
└─ [YOUR_PPT_Repo_folder] 

```

同时在 Github 上创建文件夹同名仓库。

在 `[Work_DIR]` 下打开终端，进行如下操作：

```bash
# make new folder
mkdir [YOUR_PPT_Repo_folder] 

# clone my repo
git clone https://github.com/Haohahahaha/jyyslide-md-scripts.git

# remove all git info which in that cloned repo
rm -rf jyyslide-md-scripts/.git*

# copy all files to your folder
cp jyyslide-md-scripts/* [YOUR_PPT_Repo_folder]

```

## 安装

!!! note "安装指令都在 `scripts/install.sh` 里面"

### 配置环境

```bash
# working Dirctory: [YOUR_PPT_Repo_folder]

# install jyyslide-md
sudo apt install python3
sudo apt install python3-pip
python3 -m pip install poetry
git clone https://github.com/zweix123/jyyslide-md.git
(cd jyyslide-md && python3 -m poetry install)

```

### 配置环境变量

```bash
# get your working directory's absolute path
# please copy the results to replace the variable '$FILEPATH' below
pwd

# 打开你的 shell 配置文件，我们这里默认 shell 为 zsh
vim ~/.zshrc

# 在配置文件内的最后添加以下内容
# configure environment variables
export JYYSLIDE_HOME=$FILEPATH/jyyslide-md
export MYSLIDE_HOME=$FILEPATH
export MYSLIDE_SCRIPT=$MYSLIDE_HOME/scripts

# configure some QUICK shorcut commands
alias pptnew="$MYSLIDE_SCRIPT/new.sh $1"
alias pptgen="$MYSLIDE_SCRIPT/gen.sh $1"
alias pptdel="$MYSLIDE_SCRIPT/delete.sh $1"
alias pptopen="$MYSLIDE_SCRIPT/open.sh $1"
alias pptshow="$MYSLIDE_SCRIPT/show.sh $1"
alias pptupd="$MYSLIDE_SCRIPT/update.sh"

# 最后执行命令使其生效
source ~/.zshrc 
```

???+ info "这几个快捷指令的使用方式"

    - `pptnew [DOC_NAME]` 新建一个名为 `DOC_NAME` 的 markdown 文档，并直接用 `vim` 打开进行编辑

    - `pptgen [DOC_NAME]` 基于名为 `DOC_NAME` 的 markdown 文档生成名为 `DOC_NAME` 的网页PPT

    - `pptdel [DOC_NAME]` 删除名为 `DOC_NAME` 的 markdown 系列文件

    - `pptopen [DOC_NAME]` 打开已建立过 名为 `DOC_NAME` 的文档，进行编辑内容

    - `pptshow [DOC_NAME]` firefox打开生成的本地ppt页面

    - `pptupd` 上传更新的内容

### 设置你的 `[YOUR_PPT_Repo_folder]` 文件夹

```bash 
# new gitignore file
touch .gitignore
echo "jyyslide-md" >> .gitignore

# new folder
mkdir -p $MYSLIDE_HOME/docs
mkdir -p $MYSLIDE_HOME/pages
```

### 在 `[YOUR_PPT_Repo_folder]` 文件夹内配置你的 git

```bash
# git initialization
git init
git config --global user.email "$USER_EMAIL" # 输入你的邮箱
git config --global user.name "$USER_NAME" # 输入你的用户名
git remote add $REMOTE_NAME $GITHUB_REMOTE # 输入你的远程仓库名和远程仓库的SSH地址

```
> （关于什么是SSH地址，[请点击这里](http://cs.haohaha.cn/greenhand/de-en-code/de-en-code-info/#SSH)）

- 修改 `README.md`，将其内容全部删除，修改为你想要的样子。

- 修改好后，更改 `[YOUR_PPT_Repo_folder]/auto-update-this-repo.sh`，将最后一行的 `j-m-scripts` 更改为上方刚设置好的 `$REMOTE_NAME`

- 最后，执行一次 `bash auto-update-this-repo.sh` 后，在你的 Github 仓库设置中，打开 `Pages/Build and deployment/Branch`，选择 `master` 之后点击右侧 `Save` 保存，此时 Github 就开始构建你的PPT网页了。


