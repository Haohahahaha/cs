# 基于 红米 5 Plus 的 刷机优化流程

!!! info ""
    
    author: Haohahahaha (Haorui Zhang)
    
    mail: 1259203802@qq.com

    date: 2025-04-18

!!! example "这起源于一段“悲惨”的故事"

    众所周知，到了 2025 年这个时间点，发布并在役了九年之久的 红米 5 Plus (4+64) 手机早应该躺在某个收纳盒里，或是被机主装裱起来收藏纪念……可是，我的老伙计还在跟我继续战斗，驮着我的 四个微信号 和 两个QQ号😆！为了优化手机性能，根据[晨钟酱](https://space.bilibili.com/251013709)的教程降级了微信，当然手机处于 Root 状态……可是就在前一周，大概是忘了伪装 Root 的原因，微信将我的四个微信号全都报了“登录环境异常”的错误，并且限期7天解锁，否则永封。好在我及时解封了三个账号，还有一个手机号，大概是因为所谓的“电诈高手”们盗了号（之前某一天疯狂接收到陌陌、快手、抖音、微博、微信的验证码，估计就是在借着我手机号注册，当时我就抢注+注销了），新注册的防御微信又忘了实名，结果没办法解锁，直接被永封了😅，注销都不行。
    
    于是我注意到，既然要玩机，就得玩儿彻底，玩儿好。所以我花了两天时间搞定了 刷机+Root+…… 的流程，借此把我需要的功能都鼓捣了一遍。当然，我的老手机跑三个微信分身也确实是难为它了……是时候换手机了。这篇文章来记录一下全流程，以备后续换机的时候快速施工用。

!!! danger "anyway，必须要记得转移手机内的数据，别怪我不提醒，都多大的人了🙄"

## 1. 解锁BL + TWRP + 刷机 + Root

???+ note "解锁 BootLoader"

    参考链接：[小米手机 BL 解锁操作指南 - MIUI 历史版本](https://miuiver.com/how-to-unlock-xiaomi-phone/)（链接丢了再找一个相关教程就是了）

    这是线刷之前的必备工作，线刷主要是用 fastboot 指令来刷入刷机包，或者刷入各区域的内容（如 Root 是刷 boot 分区、TWRP 是刷入 recovery 分区）。可以说是一切的开始。

    得益于 ==我这个机子足够老==，并且我也是牢米的十年老用户，解锁BL对我来说还是小问题，甚至不用等7天登录时间之类的。

    😡但是，据我最近在网上搜索的信息，牢米要五级+答题，简称“小米高考”。虽然我看了看题，对我个人来说也就还好，但是我为什么要买牢米呢？图他贵还没有USB2.0吗（2000-3000价位，再贵了我也不舍得刷了）？

    🥰于是一加来了，被一众 Root 信徒簇拥着！（笑）虽然一加的手机 USB3.0 只在数字系列有，但无伤大雅，性价比够高 + 方便 Root 就已经满足了我的需求！

    所以读者如果想玩的话，记得看看自己手机/意向手机的解锁难度！
    > 参考视频：[想 ROOT ? 先了解各厂商的BL解锁规则吧！](https://www.bilibili.com/video/BV18aFZeTEeW)

???+ note "刷入第三方 recovery: TWRP"

    这部分主要是为了刷入类原生等非官方的卡刷包而准备的。

    参考链接：
    
    1. [小米手机刷 TWRP 方法 - MIUI 历史版本](https://miuiver.com/how-to-flash-twrp/)
    
    2. [谷歌官方 Fastboot 工具](https://dl.google.com/android/repository/platform-tools-latest-windows.zip)
    
    3. [TWRP 支持设备列表](https://twrp.me/Devices/)

    核心命令：`.\fastboot flash recovery twrp-3.4.0-0-davinci.img`

    至于 “卡米” 问题，由于我是随后立即刷入三方卡刷包，故不存在这个问题。且我的官包一般都是先进行了 Root，已有 Magisk，故上方链接的内容对本博客内容无用，不做记录。

???+ note "线刷"

    参考链接：

    1. [小米手机线刷方式刷机指南](https://miuiver.com/how-to-flash-xiaomi-phone/)
    
    2. [线刷包合集 - MIUI 历史版本](https://miuiver.com/)
    
    3. [MiFlash 线刷工具 - MIUI 历史版本](https://miuiver.com/miflash/) [备用官方 2019-12-06 版本](https://cdnorg.d.miui.com/tools/MiFlash2019-12-06-0.zip)
    
    基本步骤：

    - 打开 MiFlash，左上角选择 解压了的刷机包 目录（注意，是 image 上一级目录）
    
    - 手机进入 Fastboot 模式，连接上电脑，MiFlash 点击 “加载设备”
    
    - 🤬右下角务必选择 “全部删除”，而不是 “全部删除并 lock”，不然你还得再来一遍解锁 BL。
    
    - 好了点击刷机即可，等一会手机自动重启进入系统即可（进入有点慢也别着急，初始化嘛）。

???+ note "卡刷"

    参考链接：

    1. [主页 | 萤火虫资源站](https://www.yhcres.top/)
    
    2. 但实际上用来备份主站的 [123网盘](https://www.123pan.com/s/3mrrVv-PcxJv) 下载速度更快，顶多下载的时候要你五毛钱（笑，总比 miuiver 便宜不是吗）
    
    3. [使用 TWRP 刷 MIUI 开发版方法 - MIUI 历史版本](https://miuiver.com/install-miui-developer-rom/)

    基本步骤：

    - 最好准备一张 TF 卡，这样便于多个卡刷包放到一起，这个不行就刷下一个（笑）
    
    - 下载卡刷包，至于卡刷包在哪嘛……XDA Forum！（不是）去上面的参考链接里看看吧，你会大开眼界的（毕竟刚开始接触的话，新手可能不知道有很多优秀的第三方 ROM 的名字）！
    
    - 卡刷前的必备步骤：2/3/4/5清——，包含 n 项的清除，即简称为 “n 清”
        1. 双清：Data、Cache
        2. 三清：Data、Cache、Dalvik Cache
        3. 四清：Data、Cache、Dalvik Cache、System分区
        4. 五清：Data、Cache、Dalvik Cache、System分区、内置存储
        刷非官包建议五清（哦对到这一步你还没转移数据别赖我啊）

    - 然后在 TWRP 里选择安装，找好 ROM 包刷机即可，刷完重启。

???+ note "利用面具来 Root"

    参考链接：

    1. [安装 Magisk 获取 Root 权限指南 - MIUI历史版本](https://miuiver.com/install-magisk-for-xiaomi/)
    
    2. [从刷机包提取 `boot.img` 文件方法 - MIUI历史版本](https://miuiver.com/extracting-boot-img/)
    
    3. [Magisk releases - GitHub](https://github.com/topjohnwu/Magisk/releases)
   
    基本步骤：

    1. 查询
        1. Ramdisk：应用主界面即可查看 “是” 或 “否”。
        2. vbmeta：参考[链接](https://miuiver.com/existence-of-vbmeta-partition/)吧，本博客不适用就不详细记录了。
    
    2. 提取
        1. Ramdisk 是：提取 `boot.img`
        2. Ramdisk 否：提取 `recovery.img`
        线刷包解压提取，卡刷包[新机型从解压的 payload.bin 文件里提取](https://miuiver.com/extracting-boot-img/)，老机型直接提取
    
    3. 生成修补文件
        1. 把文件拷入手机，然后用 Magisk 的 （第一个）安装，默认一步步往下走，就生成好了。
        2. 其余情况具体看参考链接里的教程吧。
    
    4. 刷写
        1. 生成好的镜像复制回电脑
        2. 手机进入 Fastboot 模式，电脑执行命令，刷入：
        ```
        # 如果之前修补 boot.img 文件请用这个命令
        fastboot flash boot magisk_patched-25200_pU6ZV.img

        # 如果之前修补 init_boot.img 文件请用这个命令
        fastboot flash init_boot magisk_patched-25200_pU6ZV.img

        # 如果之前修补 recovery.img 文件请用这个命令
        fastboot flash recovery magisk_patched-25200_pU6ZV.img
        ```
    5. 重启：`fastboot reboot`
   
## 2. 底层组件 + 模块 + LSPosed + 伪装 +

???+ note "底层组件：温控 + 监控 + 调度"

    使用的软件有：`淦！MIUI温控` `PerfMon+` `Scene4` `MT管理器` 

    记得给 Root 权限。


???+ note "Magisk 模块安装"

    参考链接：
    
    1. [8个超实用功能模块推荐，让手机成为更好的工具 —— [Magisk&Xposed模块推荐 ep.1]](https://www.bilibili.com/video/BV1fB4y1v7B5)

    我目前安装了以下模块：

    1. Universal GMS Doze：https://github.com/gloeyisk/universal-gms-doze
    
    2. WiFi Bounding：https://github.com/Magisk-Modules-Repo/wifi-bonding
    
    3. Google Dialer Mod：https://github.com/jacopotediosi/GoogleDialerMod
    
    4. Uperf：https://github.com/yc9559/uperf
    
    5. 指纹支付：https://github.com/eritpchy/FingerprintPay
    
    6. Scene 的附加模块（自动安装）
    
    7. 淦MIUI温控（扩展模块）（自动安装）
    
    8. 爱玩机工具箱（应用核心功能拓展）（自动安装）
    
    9. 音量键极速救砖（自动安装）

???+ note "安装 LSPosed"

    参考链接：

    1. [LSPosed 安装教程 - Magisk 中文网](https://magiskcn.com/lsposed-install)
    
    2. [Release - LSPosed - GitHub](https://github.com/LSPosed/LSPosed/releases/tag/v1.9.2)

    基本步骤：

    1. 面具右上角设置，打开 Zygisk
    
    2. 从本地安装 下载好的 LSP 模块，重启
    
    3. 通知栏有 LSP 入口（或用拨号键输入 `*#*#5776733#*#*`），进入
    
    4. 点击底部中间图标 “概览”，检测激活信息（一般都是已激活）
    
    5. 点击底部最右侧图标 “设置”，打开 “状态通知”，点击 “创建快捷方式”。

???+ note "伪装 Root 和 LSPosed"

    安装 Shamiko 模块：

    1. 下载 Shamiko 模块到手机，在 Magisk 模块界面点击从本地安装，选择 Shamiko 模块文件，安装后重启手机。

    2. 之后检查 Zygisk 是否正常开启，以及 Shamiko 模块是否正常运行。

    隐藏 Magisk 应用：
    
    1. 点击 Magisk 软件右上角设置图标，点击“隐藏 Magisk 应用”
    
    2. 在安装未知应用界面中找到 Magisk，开启“允许来自此来源的应用”
    
    3. 输入伪装应用名称（保持默认“Settings”即可），等待后台下载应用重新安装
    
    4. 安装后允许 Magisk 启动新安装的隐藏应用，按提示创建桌面快捷图标，然后重启手机
   
    对软件隐藏 Root：

    1. 点击 Magisk 软件右上角设置图标，点击“配置排除列表”
    
    2. 选择要隐藏 Root 的软件（如果找不到软件，点击右上角菜单，选中“显示系统应用”和“显示操作系统”）
    
    3. 正确添加方法：先点击软件图标展开软件所有进程，再勾选，确认已选择软件的所有进程
    
    4. 设置后，返回 Magisk 主界面，关闭 Magisk 软件，这时就可以测试隐藏效果了

    LSPosed 寄生：现最新版本已实现默认寄生模式，故无需配置。

## 2.5 美化 + 更多 Magisk/LSP 模块

!!! warning "目前还没有实践，放到下个机子上吧。"

## 3. 应用多开 + 桌面模式 + 远控

???+ note "应用多开：炼妖壶 + 爱玩机工具 + ADB"

    参考链接：

    1. [【炼妖壶】免ROOT实现手机多开，直接安装好手机内部，无需框架！](https://www.bilibili.com/video/BV1fW421w7Ac)
    2. [无视系统限制，免 root 双开任意应用](https://www.bilibili.com/video/BV1Z44y1Y7a6)
    3. [炼妖壶无限多开ROOT专用版，APP秒开无延迟！](https://www.bilibili.com/video/BV15E42137hj)
    4. [第3条的补丁：安卓炼妖壶，多用户空间无限多开微信方法教学！](https://www.bilibili.com/video/BV1Nb421q7ed)
   
    基本步骤：

    1. Platform-Tools 已经在 “刷入第三方 recovery: TWRP” 中有链接了，总之下载好。
    
    2. 记得在开发者选项里打开 ADB 调试哈。

    3. 安装 爱玩机工具，选择 应用相关-应用多开，右上角解除多开限制，重启即可。
    
    4. 继续在电脑上用 `adb shell` 即可：

    ```shell
    # 1. 获取超级权限
    su
    # 2. 设置多开的数量，这一步不行，需要用参考链接 4 中的爱玩机工具 解除限制
    setprop persist.sys.max_profiles 100
    # 3. 生成空间
    # 最后的 123 可以替换为任意备注。
    pm create-user --profileOf 0 --managed 123
    # 4. 安装炼妖壶
    pm install-existing --user 19 com.oasisfeng.island
    # 5. 赋予管理员权限
    dpm set-profile-owner --user 19 com.oasisfeng.island/.IslandDeviceAdminReceiver
    # 6. 启动空间
    am start-user 19
    # 7. 多开软件
    pm install-existing --user 19 com.microsoft.emmx
    
    # 无限循环3-7

    # 小技巧 获取空间id
    pm list users
    ```

    !!! danger "但是目前发现自己建立的空间，微信无法调用输入法，我用的蓝牙键盘解决，这个问题暂时搁置在这。"
    
???+ note "桌面模式：DisplayLink + Shizuku + 屏易连 + 微软桌面 + SmartDock"

    参考链接：

    1. [Display Link apk](https://www.synaptics.com/products/displaylink-usb-graphics-software-android-apk)
    
    2. [Release - Shizuku - GitHub](https://github.com/RikkaApps/Shizuku/releases)
    
    3. 屏易连：又称“安卓屏连”，加QQ群才能领取（不过倒是免费）。
        1.[安卓屏连兼容性测试 - 腾讯文档](https://docs.qq.com/doc/DUUN2ZWZpQmhZUkhZ) 
   
    4. 微软桌面 / SmartDock：Play有，没有自己找吧，很简单。
    5. [【教程】USB2.0有线投屏“多屏异显”，支持安卓和苹果！](https://www.bilibili.com/video/BV1FrX6YXE4N)
    6. [【教程】安卓手机如何开启“PC模式”？](https://www.bilibili.com/video/BV1Hy421z7ZJ)
   
   
    目前这部分硬件没到齐，所以还没有具体测试，后续补充。

???+ note "远控：Parsec / RDP / 向日葵 / Moonlight……"

    这几个软件 Parsec 最好用，我这破机子用来解码个 1080p60 还是绰绰有余的（甚至也不发热），前提是远端也有显卡用来编码哈。

    微软 RDP 的好处就是可以用自己的公网服务器（腾讯云阿里云之类的）做个跳板，实现 控制端与被控端 在双方均无公网时的中转，非常棒。

    向日葵：傻瓜软件，Linux中有点不好安装罢了（安装教程在[这里](https://cs.haohaha.cn/02-ubuntu/04-Remote/Sunlogin/)）

    Moonlight 一直看着挺好，但是没啥需求，硬件左拼右凑又很麻烦，所以没做实验。

## 4. App使用与优化

???+ note "Proxy: SSR"

    诶呦科学上网嘛。

???+ note "私有云：NextCloud + Talk + OnlyOffice"

    自己搭个私有云就是好啊（笑）

???+ note "养老软件01：QQ Play版 暗黑模式"

    参考链接：

    > （其实这俩办法一样）

    1. [QQ PLAY 开启夜间模式和简洁模式](https://www.kokodayo.site/index.php/archives/82/)
    
    2. [安装play版QQ并解决简洁模式启用失败问题](https://www.ordosx.tech/2023/09/%E5%AE%89%E8%A3%85play%E7%89%88QQ%E5%B9%B6%E8%A7%A3%E5%86%B3%E7%AE%80%E6%B4%81%E6%A8%A1%E5%BC%8F%E5%90%AF%E7%94%A8%E5%A4%B1%E8%B4%A5%E9%97%AE%E9%A2%98/)
    
    3. [HTTP Proxy Client 3](https://apkpure.com/http-proxy-client/com.assets.androidproxy/download/3)，后续版本都是流氓XAPK，功能没区别。
    
    4. [LightProxy - GitHub](https://github.com/alibaba/lightproxy)，电脑端。

    这里的解决办法：

    1. 手机端：安装 HTTP Proxy Client
    
    2. 电脑端：安装 LightProxy
    
    3. 电脑端配置——在默认配置文件中添加一下内容：
        ```bash
        http://showv6.gtimg.cn https://showv6.gtimg.cn
        http://iv6.gtimg.cn https://iv6.gtimg.cn
        http://gxh.material.qq.com https://gxh.material.qq.com
        # 下一行非必须添加，可能对 QQ 空间有用
        http://qzonestyle.gtime.cn https://qzonestyle.gtime.cn 
        ```

    4. 手机端连接：
        - 在 HTTP Proxy Client 中输入上述代理地址，启动服务后便可前往 QQ PLAY 尝试切换简洁模式和夜间模式了。
        - 如果是由国内版本切换为 Play 版本，请务必在使用代理前打开一次 QQ 加载资源，待数据下载完毕后（网速接近 0）再尝试使用代理。
  
    5. 注意事项
        - 如 Windows 防火墙弹出请求，别忘了允许连接；
        - 切换成功一次后便可自由切换主题，也可以开启夜间模式跟随系统。

???+ note "养老软件02：百度地图与离线包"

    来源：晨钟酱养老软件合集

    这是真好用，又简洁又舒服。下个离线包直接起飞！

???+ note "养老软件03：百度网盘 + 微博国际版 + 美团 + 支付宝"

    来源：晨钟酱养老软件合集

???+ note "最新软件：微信 + bilibili + 网易云音乐 + 番茄Todo + 淘宝"


## 结语

这次可算是把手机折腾明白了（笑），也算是 suffer in PVE 之后的通关奖励吧😋！以后有新的主题、插件和应用等，我会继续开新博客更新。也祝我以后能弄个好点儿的机子来，别这么难受了，哈哈哈😆