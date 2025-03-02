# 02月02日 - 预学习2.(4)

!!! success "今日学习"

    1. 预学习 - [2. Linux 系统安装和基本使用](https://ysyx.oscc.cc/docs/2306/preliminary/0.2.html)
    2. 预学习 - [4. 复习C语言](https://ysyx.oscc.cc/docs/2306/preliminary/0.3.html)

    > 注：链接首选为讲义，其次为视频。

!!! tip "阅读树"

    - [Linux 101](https://101.ustclug.org/)(6)

???+ note "Linux 101(6)"

    - `wget`
        - 输入含url的文件 - `-i`
        - 输出文件 - `-O`
        - 后台运行 - `-b`
        - 打印调试信息 - `-d` / `--debug`
    - `curl`
        - 指定文件名保存 - `-o`
        - 默认文件名保存 - `-O`
        - 只展示响应头内容 - `-Z`
    - `diff [File1] [File2]`
    - `head` or `tail` 
        - 指定行数 - `-n <NUM>`
        - 指定字节数 - `-c <NUM>`
    - `sed` - 还是来个简单例子吧（from 讲义）
        ```bash
        sed 's/hello/world/g' file  # 将文件 file 中的 hello 全局（global）替换为 world 后输出
        sed 's/hello/world/' file  # 将文件 file 的每一行第一个出现的 hello 替换为 world 后输出
        ```
    - 特殊字符
        - 反斜杠 - 消除单个字符的特殊含义（空格和制表符、反斜杠、各种引号、$、!）
        - 双引号 - 消除空白字符切分参数的特殊含义
        - 单引号 - 消除所有特殊字符的特殊含义
        - 反引号 - 括起来的内部被解释为命令
            - `$(cmd)` 是相同的含义，界限更明确，且可以嵌套。
    - `read` - 读取用户输入
        - 避免 `\` 视为转义符号 - `-r`
        - 设置输出的提示信息 - `-p`
    - `echo` - 输出变量信息
        - 结尾不输出换行符 - `-n`
        - 解析文本中的转义字符 - `-e`
        > `printf` 也是个命令，可以用来输出。类似 C 的同名函数。
    - 算术运算
        - `expr` - 计算算术表达式值
        - `let` - 赋值表达式值到变量
        - 表达式风格 - `(( 表达式 ))`
    - 条件表达式 - `[ 条件表达式 ]`
        - 字符串比较（结果为真返回0）
            - 两个串相等 - `=`
            - 两个串不等 - `!=`
            - 串长度非0 - `-n`
            - 串长度为0 - `-z`
        - 数值比较 - `-eq` / `-ne` / `-gt` / `-ge` / `-lt` / `-le`
        - 文件状态 - `-r` / `-w` / `-x` / `-f`(file) / `-d`(dir) / `-s`(size)
        - 符合逻辑表达式 - `!` / `-a`(and) / `-o`(or)
    - 流程控制
        - `if-elif-else-fi`
        - `case...in-esac`
        - `for...in-do-done`
        - `while/until-do-done`
        > 注意，其中的 `commands` 必须不为空，{==空的地方==}用 `:` 代替。 
    - 函数
        ```bash
        # POSIX syntax
        name() {
            commands
            [return <int>]
        }
        ``` 
    - Bash 脚本调试
        - bash [OPTIONS] [FILE]
            - `-x` - 将执行的每一条命令和结果依次打印出来
            - `-n` - 读一遍不执行，检查语法错误
            - `-v` - 边执行脚本边打印
    - [Advance] 类 C 的 for 循环
        ```bash
        for((assignment;condition;next));do
            command_1;
            command_2;
        done;
        ```
    - [Advance] Fork 炸弹😋
        ```bash
        :()
        {
            # 递归执行这个函数，且传给后一个函数，并在后台执行（调用产生的子函数不会回收）
            :|: &   
        };
        :
        ``` 

???+ note "Learn C The Hard Way"