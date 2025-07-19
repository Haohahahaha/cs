# X230 黑苹果不完美教程

!!! info ""
    
    author: Haohahahaha (Haorui Zhang)
    
    mail: 1259203802@qq.com

    date: 2021-11-17

!!! quote "注：我这个没办法用AirDrop和Handoff，网速也慢，我改的16:10的2K屏开了HiDPI后只能16:9，祝大家找到更完美的方案。"

这是[最基本的教程](https://www.ibmnb.com/forum.php?mod=viewthread&tid=1857633)，我用它来改编的，基本思路一样。

`Big Sur`我用的黑果小兵的[Big Sur 11.4 20F71三引导版](https://mp.weixin.qq.com/s/OCIfBloDn7fUwlbgG_Hm-w)。

引导盘制作软件为balenaEtcher和DiskGenius，有X230专用EFI，是在[这个帖子](https://www.ibmnb.com/forum.php?mod=viewthread&tid=2001607&highlight=x230%2BBig)里找到的。注意：不同机型不同系统版本用到的EFI是不一样的，最好找配套的教程～

安装黑苹果首先要把硬盘转为"GUID"模式(分区表类型为GPT)后点击保存。其次看你安装黑苹果的版本如果是10.15以上会让你选APFS抹掉,低版本就MACOS扩展抹掉就好。

进入系统之后需要挂载硬盘和U盘的EFI分区，要用到Clover Configurator，这个可以自行找一下，其实上一段那个帖子里的EFI文件夹里找找也能找到。

我参考[这个教程](https://www.ibmnb.com/forum.php?mod=viewthread&tid=1743388)的登陆iCloud以及使用iMessage和FaceTime的部分，用到的OpenCore Configurator最好是0.6.3版（因为上面给的EFI就是0.6.3版），但我下载了一个0.6.2的修改了之后的`config.plist`文件也起作用了，就没继续找。

这是[HiDPI的部分](https://post.smzdm.com/p/alpzq4kg/)，其中有一个小bug：BigSur的`/System`文件夹无法修改，我们可以用挂在到其他目录然后赋予读写权限的办法来更改其中内容，[这是链接](https://www.zhihu.com/question/403361335/answer/1583471375)

其他的使用习惯根据个人来决定，[百度一下，你就知道～](https://www.baidu.com)

我只附一个：[Finder使用技巧](https://blog.csdn.net/weixin_39504171/article/details/103781678?utm_medium=distribute.pc_aggpage_search_result.none-task-blog-2~aggregatepage~first_rank_ecpm_v1~rank_v31_ecpm-1-103781678.pc_agg_new_rank&utm_term=macos+%E6%B7%BB%E5%8A%A0%E4%BD%8D%E7%BD%AE+%E8%AE%BF%E8%BE%BE&spm=1000.2123.3001.4430)

#### 由于这些都不是我原创，只不过是我在一个故纸堆里找到的还能用的一个个补丁，所以向这些大佬致敬～（不得不说，装个macOS我至少重装了八九回系统，一回一个小时，真的折磨人）

瀚哲于2021·11·17晚