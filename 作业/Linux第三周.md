1、显示/etc目录下，以非字母开头，后面跟了一个字母以及其它任意长度任意字符的文件或目录
2、复制/etc目录下所有以p开头，以非数字结尾的文件或目录到/tmp/mytest1目录中。
3、将/etc/issue文件中的内容转换为大写后保存至/tmp/issue.out文件中
4、请总结描述用户和组管理类命令的使用方法并完成以下练习：
   (1)、创建组distro，其GID为2019；
   (2)、创建用户mandriva, 其ID号为1005；基本组为distro；
   (3)、创建用户mageia，其ID号为1100，家目录为/home/linux
   (4)、给用户mageia添加密码，密码为mageedu，并设置用户密码7天后过期
   (5)、删除mandriva，但保留其家目录；
   (6)、创建用户slackware，其ID号为2002，基本组为distro，附加组peguin；
   (7)、修改slackware的默认shell为/bin/tcsh；
   (8)、为用户slackware新增附加组admins；



# 正则表达式及其应用

**正则表达式**（英语：Regular Expression，常简写为regex、regexp或RE），又称**正则表示式**、**正则表示法**、**规则表达式**、**常规表示法**。正则表达式使用单个字符串来描述、匹配一系列符合某个句法规则的字符串。在很多文本编辑器里，正则表达式通常被用来检索、替换那些符合某个模式的文本。

Linux中很多命令都支持正则表达式，比如接下来要提到的grep命令，而接下来我们要讲的内容也将以grep命令结合正则表达式，来充分介绍一些常用的用法。

正则表达式有两种：标准正则表达式和扩展正则表达式。

正则表达式的元字符从功能上可以分为以下四类：字符匹配，次数匹配，位置锚点，分组和逻辑组合。以下也将逐一介绍。





补充：

>许多[程序设计语言](https://baike.tw.wjbk.site/baike-程序设计语言)都支持利用正则表达式进行字符串操作。例如，在[Perl](https://baike.tw.wjbk.site/baike-Perl)中就内建了一个功能强大的正则表达式引擎。正则表达式这个概念最初是由[Unix](https://baike.tw.wjbk.site/baike-Unix)中的工具软件（例如[sed](https://baike.tw.wjbk.site/baike-Sed)和[grep](https://baike.tw.wjbk.site/baike-Grep)）普及开的。
>
>最初的正则表达式出现于[理论计算机科学](https://baike.tw.wjbk.site/baike-理論計算機科學)的[自动控制](https://baike.tw.wjbk.site/baike-自动控制)理论和[形式化语言](https://baike.tw.wjbk.site/baike-形式化语言)理论中。在这些领域中有对计算（自动控制）的模型和对[形式化语言](https://baike.tw.wjbk.site/baike-形式化语言)描述与分类的研究。
>
>1940年，[沃伦·麦卡洛克](https://baike.tw.wjbk.site/baike-沃伦·麦卡洛克)与[Walter Pitts](https://baike.tw.wjbk.site/w/index.php?title=Walter_Pitts&action=edit&redlink=1)将[神经系统](https://baike.tw.wjbk.site/baike-神经系统)中的神经元描述成小而简单的自动控制元。
>
>1950年代，数学家[斯蒂芬·科尔·克莱尼](https://baike.tw.wjbk.site/baike-斯蒂芬·科尔·克莱尼)利用称之为“正则集合”的数学符号来描述此模型。[肯·汤普逊](https://baike.tw.wjbk.site/baike-肯·汤普逊)将此符号系统引入编辑器[QED](https://baike.tw.wjbk.site/w/index.php?title=QED_(文字編輯器)&action=edit&redlink=1)，随后是[Unix](https://baike.tw.wjbk.site/baike-Unix)上的编辑器[ed](https://baike.tw.wjbk.site/w/index.php?title=Ed_(文字編輯器)&action=edit&redlink=1)，并最终引入[grep](https://baike.tw.wjbk.site/baike-Grep)。自此以后，正则表达式被广泛地应用于各种Unix或[类Unix](https://baike.tw.wjbk.site/baike-类Unix)系统的工具中。正则表达式的POSIX规范，分为基本型正则表达式（Basic Regular Expression，BRE）和扩展型正则表达式（Extended Regular Express，ERE）两大流派。在兼容POSIX的UNIX系统上，grep和egrep之类的工具都遵循POSIX规范，一些数据库系统中的正则表达式也符合POSIX规范。grep、vi、sed都属于BRE，是历史最早的正则表达式，因此元字符必须转译之后才具有特殊含义。egrep、awk则属于ERE，元字符不用转译。





## 1.1 正则表达式中字符匹配

