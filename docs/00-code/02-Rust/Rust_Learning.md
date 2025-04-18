# Rust Learning

> author: Haohahahaha (Haorui Zhang)
>
> date: 2024-01-29~31
>
> email: 1259203802@qq.com

!!! note "学习的书籍"
    [The Rust Programming Language](https://doc.rust-lang.org/book)

!!! tip "仅为个人笔记"
    [个人学习仓库 - rust-rustlings-Haohahahaha](https://github.com/LearningOS/rust-rustlings-Haohahahaha)

    本笔记包含 `rustlings` 练习。

## 1. Getting Started

### 1.3 Hello, Cargo

!!! note "命令"

    ```bash
    cargo new   # 新建项目
    cargo build # 构建项目，生成的目标文件要去 target/build/ 查看
    cargo run   # 运行，直接看结果
    cargo check # 检查编译错误
    ```
!!! note "项目结构"
    
    ```bash
    [4.0K]  .
    ├── [ 155]  Cargo.lock  # 自动生成，掌握依赖库版本信息（Chap.2 提到）
    ├── [ 180]  Cargo.toml  # 列出项目信息、依赖等
    ├── [4.0K]  .git
    ├── [   8]  .gitignore
    ├── [4.0K]  src # 源代码
    │   └── [  45]  main.rs
    └── [4.0K]  target  # 生成的目标文件
        ├── [ 177]  CACHEDIR.TAG
        ├── [4.0K]  debug   # 调试生成的文件，生成快但运行慢
        ├── [4.0K]  release   # 发布的文件，生成慢（编译优化）但运行快
        └── [1.5K]  .rustc_info.json
    ```

## 2. Programming a Guessing Game

!!! warning "English Words"
    ```
    comes in handy  # 派上用场
    scope           # 作用域
    parentheses     # 圆括号
    immutable       # 不可变的，其中提取 mut 作为可变变量关键字 
    instance        # 实例（建立某种类型的实例）
    associated      # 关联（ ~ func，关联函数。可理解为成员函数？）
    append          # 附加
    hence           # 因此
    trivial         # 琐碎的，不重要的
    scenario        # 情景、场景   
    ultimately      # 最终
    insatiable      # 贪得无厌的
    ```

**语法部分：**

- `fn`：声明函数体

- `!`：宏

- `let`：创建变量

- `mut`：（变量的）可变属性

- `//`：注释

- `::`：关联函数/子函数/子类/父子关系……

- `use [LIB]`：引用名为 `[LIB]` 的库函数/包

- `io::stdin().readline()`：非覆写的输入函数

- `&`：引用（Reference），可大概理解为“指针”（而非在内存中复制多份）。

    默认不可变，可变写法：

    ```rust
    &mut guess
    ```
- 使用成员函数时，用新的一行或者一些空格会使语法结构清晰，可读性强。

    如：

    ```rust
    // 错误示范
    io::stdin().read_line(&mut guess).expect("Failed to read line");
    
    // 正确示范
    io::stdin()
        .read_line(&mut guess)
        .expect("Failed to read line");
    ```

    结果有两种“变体”——`variant`，分别是 `Ok` 和 `Err`。

    对结果返回时，可用 `expect()` 函数来判断返回结果是否合法。如果不合法（`Err`），则输出错误信息（函数内的字符串）；如果合法（`Ok`），则返回值。

- 打印变量值时，变量放在花括号 `{}` 内。

    如果打印的是表达式（的求值结果），则花括号空，然后（像C一样）在逗号后面按顺序写变量名。

- `match`：根据不同结果确定接下来要做什么，可根据不同情况进行处理

    - `Err(_)`：表示匹配所有错误
    >  The underscore, _, is a catchall value; in this example, we’re saying we want to match all Err values, no matter what information they have inside them. 

- `shadow`特性：允许同名不同类型，后者覆盖前者

- `:`：后面加强制转换的变量类型，转换用 `parse()` 子函数

- 循环：

    ```rust
    loop{
        // LOOP CODE
    }
    ```

---

*完成！*

输出如下：

```sh
# oslab @ oslab-virtual-machine in ~/Documents/Rust-Book-remaining/guessing_name on git:master x [21:56:44] 
$ cargo run
   Compiling guessing_name v0.1.0 (/home/oslab/Documents/Rust-Book-remaining/guessing_name)
    Finished dev [unoptimized + debuginfo] target(s) in 0.17s
     Running `target/debug/guessing_name`
Guess the number!
Please input your guess.
89
You guessed: 89
Too big!
Please input your guess.
50
You guessed: 50
Too small!
Please input your guess.
66
You guessed: 66
Too big!
Please input your guess.
59
You guessed: 59
Too small!
Please input your guess.
63
You guessed: 63
You win!
```

## 3. Common Programming Concepts

### 3.1 Variables and Mutability

- `let` 可“遮盖”类型，但 `mut` 只是改变值。

- 常量 `constant` 必须声明类型

### 3.2 Data Types

!!! note "Integer Literals in Rust"

    | Number literals  | Example       |
    | ---------------- | ------------- |
    | Decimal          | `98_222`      |
    | Hex              | `0xff`        |
    | Octal            | `0o77`        |
    | Binary           | `0b1111_0000` |
    | Byte (`u8` only) | `b'A'`        |

- Tuple

    - 多种类型组合而成

    - 可以用 `.[INDEX]` 的形式来访问元组内某个序号 `[INDEX]` 的元素（以0开始）
    
    - 可以解构，分别赋值给各个新建变量

- Array

    - 初始化值：`let a: [初始值; 元素个数];`

    - 规定变量类型：`let a: [元素类型; 元素个数] = [1, 2, ...];`

### 3.3 Functions

!!! warning "English Words"
    ```
    prevalent  # 盛行、普遍的
    ```

- 函数命名规则：`snake case`——全小写，单词之间用下划线分割

- 只要在调用者可见的作用域中定义函数即可，无先后顺序

- 函数的参数必须标明变量类型，用 `,` 隔开

- 声明（Statement）不能连续等号，因为声明不返回值。但可以声明变量后接大括号，里面接表达式（Expression），因为表达式返回值。

    - 单独的数字也是表达式

- 函数可在函数名称后面接：`-> [RETURN_VALUE_TYPE]`，这样可以规定返回值的类型。

### 3.5 Control Flow

- 赋值给变量的表达式可以是一个代码块，但是代码块的返回值类型必须与变量类型相同。

- `Loop`

    - `break` 后面可以接返回值;

    - 循环之前可以加标签，以便 `break` 识别；

- `while`

    - 循环条件不用加括号（哦对 `if` 也是）

- `for`

    - 遍历数组时不用写边界条件，只需要写 `for element in a` 即可。这是因为 `for` 使用了标准库提供的Range，它生成从一个数字开始到另一个数字之前的所有数字序列。

    - 还可以用 `.rev()` 和数字序列 `(x...n)` 实现倒计时：

      ```rust
      for number in (1...4).rev() {
          println!("{number}!");
      }
      ```

## 4. Understanding Ownership

### 4.1 What is Ownership?

- 对于存储在堆上的变量

    - 默认不可复制，只能移动。类似浅复制，只复制指针。

    - 需要“深复制”时，请使用 `clone()` 函数。

- 对于存储在栈上的变量

    - 直接复制

- `Copy` 与 `Drop` 特性

    - `Copy` 是针对栈上的变量的，简单的复制；
    
    - `Drop` 是针对堆上变量的，在作用域后回收变量。

    !!! quote "通常一组简单的标量值都可以实现 `Copy` ，但需要分配或是某种形式的资源的类型都不能实现 `Copy`。"
        以下是一些实现 `Copy` 特性的类型：
        - 所有的整数类型，如 u32。
        - 布尔类型，bool，具有值 true 和 false。
        - 所有的浮点类型，如 f64。
        - 字符类型，char。
        - 元组，如果它们只包含也实现了 Copy 的类型。例如，(i32, i32) 实现了 Copy，但 (i32, String) 不会。

- 函数也是一个作用域，堆上分配的变量进入函数就会被移动，之后再退出就调用了 `Drop` ，失效了；
- 但是栈上分配的变量是通过 `Copy` 进入函数，退出后可继续使用。

- 函数返回值只需要输入值即可，无需分号。

- 允许函数将参数传回去

### 4.2 References and Borrowing 

- 代替“返回给调用函数”的做法是：引用（Reference）。用符号 `&` 表示（其地址）。

- 解引用运算符是 `*` ，和 C 一样咯。

- 借用：创建一个引用。不允许修改引用的内容。

- 可变引用： `&mut VAR`（同时变量也必须是 `mut` 的）

    - 不能同时对某个变量进行多次可变借用。

    - 但可以使用花括号来创建新的作用于，允许多个可变引用，只是不能同时存在。

    - 对某一个变量来说，不可变引用后面不能再用可变引用，因为要保证不可变引用是 `不变的` 。

- 悬空指针

    - 在函数里创建的 `String` ，返回时不能返回引用，因为创建的变量被释放。这时直接返回 `String` 类型即可。

### 4.3 The Slice Type

- 切片：存储对第一个元素的引用+一个长度

- 在后面索引可以用这样的语法：`[x..n]`，如果 `x = 0` 或 `n = len` ，则可以省略。

- 处理的只是UTF-8，多字节的字符不支持。

- `&String` 是字符串，`&str` 是字符串切片。所以参数一般写 `&str` 即可兼容字符串的传递（毕竟全部的切片也是切片，哈哈）

    ```rust
    let word_string = String::from("Hello, World"); // 创建 String 类型变量的方法
    let word = "hello, world"; // word 的类型是 &str ，即切片
    let fw = first_word(word); // 可以不用 & 符号直接传入，也可以用；String 则必须要用。
    ```

- 其他类型也可以用切片，工作方式与字符串切片相同，在向量里讨论。

## 5. Using Structs to Structure Related Data

### 5.1 Defining and Instantiating Structs

- 结构体与元组的不同：

    1. 元组类型必须相同，结构体内部可不同
    
    2. 元组只能顺序指定和访问，结构体可以为每个数据片段命名，更加灵活；

- 初始化时无需严格按照顺序。语法结构：

    ```rust
    let mut user1 = User {
        active: true,   // 用 : 来赋值
        username: String::from("someusername123"),  // 用 , 来结束一行
        email: String::from("someone@example.com"), // 不用 &str 是为了让每个实例都拥有其所有数据，且在整个结构体有效的时间内都有效
        sign_in_count = 1, // 最后一行别忘了
    };
    ```

- 获取结构体中的值，用 `.` 即可（和 C 一样）。若实例可变，可修改某个字段的值。但必须是整个实例可变，其中的某一个字段不能单独可变。

- 构建结构体实例函数中，参数可与结构体字段名相同，这样方便省略赋值语句：

    ```rust
    fn build_user(email: String, username: String) -> User {
        User {
            active: true,
            username,
            email,
            sign_in_count: 1,
        }
    }   
    ```

- 从已有的实例创建新实例时，只需对需要修改的字段进行修改，其余字段写`..user1`（例子） ，而且必须放在最后。

    - 不过被使用的实例里面的字段，被移动了，如果重新赋值就不会移动（*这里存疑*）

- Unit-Like Struct：

    - 可以起一个不含任何结构的结构体，然后创建实例。比如需要测试时，就可以设置实例为某种类型了。

- 结构体可以存储引用，但需要使用生命周期（*LifeTimes*）

### 5.2 An Example Program Using Structs

- `debug` 模式打印结构体:
    
    ```rust
    #[derive(Debug)]    // debug标签，放在程序最前面
    let rect1 = ... // 省略
    printfln!("{:?}", rect1);   // 注意打印时的固定格式： {:?}
    ```

