# 01月21日 - 预学习2.(2)

!!! success "今日学习"

    1. 预学习 - [2. Linux 系统安装和基本使用](https://ysyx.oscc.cc/docs/2306/preliminary/0.2.html)

    > 注：链接首选为讲义，其次为视频。

!!! tip "阅读树"
    - VimTutor
    - [`GDB` 入门教程](https://linuxconfig.org/)

!!! note "VimTutor-笔记"
 
    - [x] 移动键：`h` `j` `k` `l`
    - [x] 保存 - `w`，退出 - `q`，强制 - `!`
    - [x] 删除字符 - `x`，删除单词 - `d`，删除整行 - `dd`(单行)/`dn`(以下n行)
    - [x] 定位符：
        - 数字代表单词个数，
        - 词尾 - `e`，（下个词的）词首（首字母之前） - `w`，
        - 行首 - `0`，行尾 - `$` 
    - [x] 插入 - `i`，追加 - `a`(字符后)/`A`(整行后) 
    - [x] 撤销 - `u`(撤销一次)/`U`(撤销整行操作)
    - [x] 放入 - `p`(在光标指向的字符后) 
        - 与 `dd` 共同作 复制-粘贴 用
    - [x] 替换 - `r`(单个字符：w)，替换 - `R`(打开替换模式，从本光标开始替换)
    - [x] 更改 - `c`(至末尾)，`cc`(本行末尾)/`ce`(本词末尾)/结合数字+定位符
    - [x] 显示所在位置 `CTRL-G`，
    - 跳转整篇首行 - `G`，跳转整篇末尾 - `gg`, 跳转到第n行 - `nG`
    - [x] 向后搜索 - `/`，向前搜索 - `?`
        - 跳转下一个搜索结果 - `n`，跳上一个 - `N`
        - 返回搜索前的位置 - `CTRL-O`，前进到搜索后的位置 - `CTRL-I`
    - [x] 匹配括号 - `%`(在光标指向任一单括号时使用)
    - [x] 替换 - `:s/old/new`(只替换第一个匹配的)
        - 替换整行所有匹配 - 末尾加`/g`
        - 替换第n行的内容 - `:ns/old/new/g`
        - 替换整篇内容 - `:%s/old/new/g`
        - 替换整篇内容并每个询问是否替换 - `:%s/old/new/gc`
    - [x] 执行外部命令 - `:!` 或 `:![COMMAND]`
    - [x] 存储为 - `:w [FILE_NAME]`
        - 删除某个文件 - `:!rm [FILE_NAME]`
    - [x] 选中部分内容 - `v`，并且可以另存为新文件。
    - [x] 新建一行并编辑：下方 - `o`，上方 - `O`
    - [x] 复制 - `y`，复制整行 - `yy`
    - [x] 搜索大小写/高亮设置 
        - `ic` / `ignorecase` 忽略大写/小写
        - `is` / `incsearch` 展示部分匹配搜索
        - `hls` / `hlsearch` 展示匹配高亮
        - 前缀 `no` - 关闭模式
    - [x] 帮助 - `:help`，后面可加搜索内容，退出时 `:q`
    - [x] 开启更多特性 - 编辑 `~/.vimrc`(Unix)
    - [x] 开始编辑 - `:e` 
    - [x] 提示命令 - 输入指令首字母x后 `:x`，键入 `CTRL-D`获得提示
    - [x] 补全 - `TAB` 键，可补全命令或者文件名
    
    更多信息，请 `:help user-manual`。

!!! note "GDB Tutorial"

    - 使生成报错文件的一键脚本：
        ```bash
        if ! grep -qi 'kernel.core_pattern' /etc/sysctl.conf; then
            sudo sh -c 'echo "kernel.core_pattern=core.%p.%u.%s.%e.%t" >> /etc/sysctl.conf'
            sudo sysctl -p
        fi
        ulimit -c unlimited
        ``` 
    - 持久化不限制内核文件大小的脚本：
        ```bash
        sudo bash -c "cat << EOF > /etc/security/limits.conf
        * soft core unlimited
        * hard core unlimited
        EOF
        ``` 
    - `core.%p.%u.%s.%e.%t`:   
        - `%p`: Process ID
        - `%u`: User ID
        - `%s`: Signal number
        - `%e`: Executable filename
        - `%t`: Time of the crash
    - About Signal Number: See `man 7 signal` - "Standard signals"
    - GDB Usage
        - `bt` - BackTrace: To gives us a trace of the current state (procedure after procedure called) of the program.
            - multiple threads feature: `thread apply all bt` to obtain a backtrace for all threads which were running as the program crashed.
        - `#n` - frame No.n, like a procedure in code for the time being.
            - `#0` is the last function which was being executed by the program when it crashed.
        - There are also show us some useful info like procedure name, variable value and the line where the issue happened in the file.
        - `f n` is to jump to frame No.n.
        - `list` - list source code **where the frame was called**. (It's only available if the actual source code is available.)
            - GDB does not check if there is a source code revision match!
            - It is thus of paramount importance that you use the exact same source code revision as the one from which your binary was compiled.
        - `p` - print
            - `p a` means to print the value `a`.
     
    That's all. And I really need more time to learn `Usage of GDB`.