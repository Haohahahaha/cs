# 01月22日 - 预学习2.(3)

!!! success "今日学习"

    1. 预学习 - [2. Linux 系统安装和基本使用](https://ysyx.oscc.cc/docs/2306/preliminary/0.2.html)

    > 注：链接首选为讲义，其次为视频。

!!! tip "阅读树"

    - [Linux 101](https://101.ustclug.org/)(1-5)
    - [Tmux 使用教程](https://www.ruanyifeng.com/blog/2019/10/tmux.html)
  
!!! note "Linux 101(1-5)"

    > 因为基本都会，所以浏览一遍勾一下重点还不太会的。

    3. 软件安装与文件操作
        - [模式匹配](https://101.ustclug.org/Ch03/#pattern) - 匹配模式 glob 与 extglob
        - [TAR](https://101.ustclug.org/Ch03/#tar) 的常用选项
        - [tldr](https://101.ustclug.org/Ch03/#tldr) - 精简版 manual
        - [时间戳](https://101.ustclug.org/Ch03/supplement/#timestamp) 与 stat 查看工具
        - [压缩包多格式相关](https://101.ustclug.org/Ch03/supplement/#tar-alternative)
    4. 进程、前后台……
        - [htop](https://101.ustclug.org/Ch04/#htop) - 新学到用法了嘿，好玩好玩。
        - [Kill 命令](https://101.ustclug.org/Ch04/#kill-command) - `kill -l` 可显示所有信号名称 
        - {==[定制Tmux](https://101.ustclug.org/Ch04/#customizing-tmux)==} - 自制快捷键嘞~~
        - [at 命令](https://101.ustclug.org/Ch04/#at) - 单次计划任务
        - [CronTab!!!](https://101.ustclug.org/Ch04/#crontab) - 经典的周期性任务
        - 小插曲：`Ctrl-Alt-Fx`(x=1,2,...) 直接给我跳到纯命令行了，Ubuntu 跳回图形界面的快捷键是 `Ctrl-Alt-F7` 哈。
        - [Strace](https://101.ustclug.org/Ch04/supplement/#proc) 来啦 - 追踪程序使用的系统调用
    5. 用户与用户组……
        - [sudo](https://101.ustclug.org/Ch05/#sudo)：无密码执行sudo的小技巧，很有用。 

!!! note "Tmux 使用教程"

    主要记录一下常用的快捷键，免得忘掉。

    - 默认前缀键 `CTRL-B`
    - +`?` - 帮助信息
        - `ESC`/`q` - 退出  
    - 会话快捷键(个人不常用)
        - +`d`：{==分离当前会话==}
            - {==恢复会话命令==}：`tmux attach -t [Session_Name]`
        - +`s`：列出所有会话
        - +`$`：重命名当前会话
    - **{++窗格快捷键(pane)++}
        - +`%`：{==划分左右==}两个窗格。
        - +`"`：{==划分上下==}两个窗格。
        - +`<arrow key>`：光标切换到其他窗格。`<arrow key>`是指向要切换到的窗格的方向键，比如切换到下方窗格，就按方向键↓。
        - +`;`：光标切换到上一个窗格。
        - +`o`：光标{==切换到下一个窗格==}。
        - +`{`：当前窗格与上一个窗格交换位置。
        - +`}`：当前窗格与下一个窗格交换位置。
        - +`Ctrl-O`：所有窗格向前移动一个位置，第一个窗格变成最后一个窗格。
        - +`Alt-O`：所有窗格向后移动一个位置，最后一个窗格变成第一个窗格。
        - +`x`：{==关闭==}当前窗格。
        - +`!`：将当前窗格拆分为一个独立窗口。
        - +`z`：{==当前窗格全屏显示==}，再使用一次会变回原来大小。
        - +`Ctrl-<arrow key>`：按箭头方向调整窗格大小。
        - +`q`：显示窗格编号。
    - {++窗口快捷键(window)++}
        - +`c`：==创建一个新窗口==，状态栏会显示多个窗口的信息。
        - +`p`：==切换到上一个窗口==（按照状态栏上的顺序）。
        - +`n`：==切换到下一个窗口==。
        - +`<number>`：切换到指定编号的窗口，其中的<number>是状态栏上的窗口编号。
        - +`w`：==从列表中选择窗口==。
        - +`,`：==窗口重命名==。