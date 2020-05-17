# Linux基础相关知识点

## 1. Linux的系统目录

### 1.1 查看Linux发行版的系统相关性信息及查看系统目录

#### 1.1.1 查看系统相关信息

显示系统内核版本

```bash
[flamenca@localhost ~]$ uname -r
3.10.0-1062.el7.x86_64
```

显示操作系统的发行版本

```bash
[flamenca@localhost ~]$ cat /etc/os-release 
NAME="CentOS Linux"
VERSION="7 (Core)"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="7"
PRETTY_NAME="CentOS Linux 7 (Core)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:centos:centos:7"
HOME_URL="https://www.centos.org/"
BUG_REPORT_URL="https://bugs.centos.org/"

CENTOS_MANTISBT_PROJECT="CentOS-7"
CENTOS_MANTISBT_PROJECT_VERSION="7"
REDHAT_SUPPORT_PRODUCT="centos"
REDHAT_SUPPORT_PRODUCT_VERSION="7"

```

显示主机名

```bash
[flamenca@localhost ~]$ hostname
localhost.localdomain
```



#### 1.1.2 查看目录信息

通过命令```tree```来查看对应目录的全貌，我们要查看系统目录，所以按如下输入：

```bash
[flamenca@localhost ~]$ man tree
# 先看看用法
NAME
       tree - list contents of directories in a tree-like format.

SYNOPSIS
       tree  [-acdfghilnpqrstuvxACDFQNSUX]  [-L  level  [-R]]
       # 这里有个 -L 选项，只显示层数，我们不需要将系统整个目录铺开，只想看根目录/下的第一层系统目录。
```

所以，我们应该在命令行输入：```tree -L 1 /```

```bash
[flamenca@localhost ~]$ tree -L 1 /
/
├── bin -> usr/bin
├── boot
├── dev
├── etc
├── home
├── lib -> usr/lib
├── lib64 -> usr/lib64
├── media
├── mnt
├── opt
├── proc
├── root
├── run
├── sbin -> usr/sbin
├── srv
├── sys
├── tmp
├── usr
└── var

19 directories, 0 files

```

那么这些目录到底是有什么用呢？为啥是这样定义目录的捏？

请看下一小节

### 1.2 LInux系统目录名称规律及相关用途

你知道FHS（Filesystem Hierarchy Standard 文件系统层次结构标准）吗？

不知道的话看补充吧，多数Linux发行版遵从FHS标准并且声明其自身政策以维护FHS的要求。

```bash
/
# 文件系统从根目录下开始,用"/"表示

    /bin # 所有用户可用的基本命令程序文件

    /sbin # 提供系统管理使用的工具程序

    /boot # 引导加载器必须用到的各种静态文件：kernel、initramfs、grub等

    /dev # 存储特殊文件或设备文件：
    	# 设备有两种类型：字符设备（线性设备,有顺序）、块设备（随机设备）；

    /etc # 系统程序的配置文件，只能为静态

    /home # 普通的家目录的集中位置：一般每个普通用户的家目录默认为此目录下雨用户名同名的子目录。
    	/home/USERNAME

    /root # 管理员的家目录，可选；

    /lib # 为系统启动或根文件系统上的应用程序(/bin, /sbin）提供共享库，以及为内核提供内核模块
        libc.so.* # 动态链接C库
        ld* # 运行时链接器/加载器
        modules # 用于存储内核模块的目录

    /lib64 # 64位系统特有的存放共享库的路径：

    /media # 便携式设备挂载点，cdrom ，floppy等；

    /mnt # 其他文件系统的临时挂载点

    /opt # 插件的安装位置 Add-on application，第三方应用程序

    /srv # 当前主机为服务提供的数据，不具有通用型

    /tmp # 临时文件，几乎所有程序都会用到的目录，可供所有用户执行写入操作，有特殊权限

    /usr # /usr Hierarchy,全局共享只读数据路径，
        bin，sbin
        lib,  lib64
        include # C程序的头文件
        share # 命令手册页和自带文档等架构特有的的文件的存储路径位置
        local # 另一个层级目录
        X11R6 # X-Window程序的安装目录
        src # 程序源码文件的存储位置

    /usr/local # local hierarchy,让系统管理员安装本地应用程序：也通常用于安装第三方程序

    /var # variable data files, 存储经常发生变化的数据目录：
        cache # Application cache data 应用缓存数据
        lib # Variable state information 可变状态信息


    /proc # 基于内存的虚拟文件系统，内核和进程存储其相关信息，他们多为内核参数，例如：net.ipv4.ip_forward, 虚拟为net/ipv4/ip_forward,存储于/proc/sys/下，因此完整路径为/proc/sys/net/ipv4/ip_forward


    /sys # sysfs虚拟文件系统提供了一种比 proc 更为理想的访问内核数据的途径，比/proc更新，更灵活
                # 为管理LInux设备提供了一种同一模型的接口

```



补充：

> [FHS 文件系统层次结构标准](https://baike.tw.wjbk.site/baike-文件系统层次结构标准)
>
> [关于```/sys```的一些知识](https://www.ibm.com/developerworks/cn/linux/l-cn-sysfs/)



## 2. 文件的元数据

### 2.1 什么是文件的元数据

文件的元数据简单来说是指文件的属性、大小、创建时间、访问时间、属主属组等信息。

在linux中我们用```stat```命令来查看文件的元数据信息

```bash
[flamenca@localhost ~]$ stat lovers.txt 
File: ‘lovers.txt’
Size: 82        	Blocks: 8          IO Block: 4096   regular file
Device: fd02h/64770d	Inode: 102         Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/flamenca)   Gid: ( 1000/flamenca)
Context: unconfined_u:object_r:user_home_t:s0
Access: 2020-02-24 17:30:08.449000473 +0800
Modify: 2020-01-07 15:37:45.610944099 +0800
Change: 2020-01-07 15:37:45.610944099 +0800
Birth: -

```



​	补充：

>元数据（Metadata）
>
>其它文件保存信息常常伴随着文件自身保存在文件系统中。文件长度可能是分配给这个文件的区块数，也可能是这个文件实际的字节数。文件最后修改时间也许记录在文件的时间戳中。有的文件系统还保存文件的创建时间，最后访问时间及属性修改时间。（不过大多数早期的文件系统不记录文件的时间信息）其它信息还包括文件设备类型（如：区块数，字符集，套接口，子目录等等），文件所有者的ID，组ID，还有访问权限（如：只读，可执行等等）。



### 2.2 三个时间戳

在上面我们看到了一个文件的元数据信息，在信息的下方，有三行带时间的信息，我们将其称之为时间戳(Timestamp)：

```bash
Access: 2020-02-24 17:30:08.449000473 +0800
# Access 是 Access time的意思,表示文件的访问时间,简写为 atime ,当读写文件内容时,更新 atime
Modify: 2020-01-07 15:37:45.610944099 +0800
# Modify 是 Modify time的意思,表示文件的修改时间,简写为 mtime ,当文件内容或数据发生改变,更新 mtime
Change: 2020-01-07 15:37:45.610944099 +0800
# Change 是 Change time的意思,表示文件的改变时间,简写为 ctime ,当文件的元数据发生改变时,更新 ctime
```

补充：

>时间戳 Timestamp
>
>时间戳（Timestamp）是指在一连串的数据中加入辨识文本，如时间或日期，用以保障本地端（local）数据更新顺序与远程（remote）一致。

### 2.3 修改时间戳

我们可以使用```touch```命令来修改时间戳，那么如何修改？我们先看一下```touch```的相关说明：

```bash
[flamenca@localhost ~]$ man touch
NAME
       touch - change file timestamps

SYNOPSIS
       touch [OPTION]... FILE...

DESCRIPTION
       Update the access and modification times of each FILE to the current time.
       # 使用该命令更新文件的访问和修改时间为当前时间
		...
		
		-a     change only the access time
		# 只更新访问时间
		
		-m     change only the modification time
		# 只更新修改时间
       	-t STAMP
              use [[CC]YY]MMDDhhmm[.ss] instead of current time
        # 使用格式化的时间文本来替代默认的当前时间
        # CC	表示世纪
        # YY	表示年
        # MM	表示月
        # DD	表示日
        # hh	表示小时
        # mm	表示分钟
        # ss	表示秒
        # 其中世纪(CC)、年(YY)、秒(ss)在中括号[]中，代表其为可选项。
        # 例如：202002241850.30	代表：2020年02月24日18时50分30秒
```

现在我们实践一下吧！

```bash
[flamenca@localhost ~]$ stat lovers.txt 
  File: ‘lovers.txt’
  Size: 82        	Blocks: 8          IO Block: 4096   regular file
Device: fd02h/64770d	Inode: 102         Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/flamenca)   Gid: ( 1000/flamenca)
Context: unconfined_u:object_r:user_home_t:s0
Access: 2020-02-24 17:30:08.449000473 +0800
Modify: 2020-01-07 15:37:45.610944099 +0800
Change: 2020-01-07 15:37:45.610944099 +0800
 Birth: -
# 上半部分是原先‘lovers.txt’文件的元数据，三个时间戳更新前的样子
[flamenca@localhost ~]$ touch lovers.txt 
# 使用touch命令更新时间戳
[flamenca@localhost ~]$ stat lovers.txt 
  File: ‘lovers.txt’
  Size: 82        	Blocks: 8          IO Block: 4096   regular file
Device: fd02h/64770d	Inode: 102         Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/flamenca)   Gid: ( 1000/flamenca)
Context: unconfined_u:object_r:user_home_t:s0
Access: 2020-02-24 18:37:58.945143949 +0800
Modify: 2020-02-24 18:37:58.945143949 +0800
Change: 2020-02-24 18:37:58.945143949 +0800
Birth: -
# 更新后的时间戳


#######################################################################

[flamenca@localhost ~]$ touch -a lovers.txt 
# 使用-a选项只更新 atime
[flamenca@localhost ~]$ stat lovers.txt 
  File: ‘lovers.txt’
  Size: 82        	Blocks: 8          IO Block: 4096   regular file
Device: fd02h/64770d	Inode: 102         Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/flamenca)   Gid: ( 1000/flamenca)
Context: unconfined_u:object_r:user_home_t:s0
Access: 2020-02-24 18:41:14.582078349 +0800	
# atime 变成当前时间
Modify: 2020-02-24 18:37:58.945143949 +0800
Change: 2020-02-24 18:41:14.582078349 +0800
# ctime 随 atime 而变化
Birth: -

########################################################################
[flamenca@localhost ~]$ touch -m lovers.txt 
# 使用 -m 选项只更新 mtime
[flamenca@localhost ~]$ stat lovers.txt 
  File: ‘lovers.txt’
  Size: 82        	Blocks: 8          IO Block: 4096   regular file
Device: fd02h/64770d	Inode: 102         Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/flamenca)   Gid: ( 1000/flamenca)
Context: unconfined_u:object_r:user_home_t:s0
Access: 2020-02-24 18:41:14.582078349 +0800
Modify: 2020-02-24 18:43:28.536351251 +0800
# mtime 更新为当前时间
Change: 2020-02-24 18:43:28.536351251 +0800
# ctime 随 mtime 而变化
Birth: -

#########################################################################
[flamenca@localhost ~]$ touch -t 202002241851.30 lovers.txt 
# 用 -t 的选项更新 atime、mtime
[flamenca@localhost ~]$ stat lovers.txt 
  File: ‘lovers.txt’
  Size: 82        	Blocks: 8          IO Block: 4096   regular file
Device: fd02h/64770d	Inode: 102         Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1000/flamenca)   Gid: ( 1000/flamenca)
Context: unconfined_u:object_r:user_home_t:s0
Access: 2020-02-24 18:51:30.000000000 +0800
# atime 更新为设定好的时间
Modify: 2020-02-24 18:51:30.000000000 +0800
# mtime 更新为设定好的时间
Change: 2020-02-24 18:55:57.055288317 +0800


```



## 3. 硬链接和软链接

对于一个文件的信息，在Linux上被分成两部分：数据（data）与元数据(matadata)。

数据，即指文件的数据内容是存放在文件对应的数据块中的，数据块是记录文件真实内容的地方，而元数据则是文件的附加属性，元数据中的inode是个整数，它才是用来区分每一个不同文件的唯一标识，而非文件名，inode类似于我们的身份证号，每个文件都有一个唯一的inode。而文件名仅仅是用来方便人们的记忆和使用，系统寻找文件是通过文件的inode号来寻找正确的文件数据块。

为了解决文件共享的问题，Linux中引入了两种链接：硬链接(hard link)和软链接(soft link，又称为符号链接：symbolic link) ，链接不仅实现了linux系统共享，还带来了隐藏文件路径、增加权限安全及节省存储等好处，具体实现方法可以通过```ln```创建链接文件

```bash
ln [OPTION]...[-T] TARGET LINK_NAME
# TARGET 指需要创建链接文件的目标文件
# LINK_NAME 指生成的链接文件名

# ln 命令常用选项说明：
-b # 覆盖以前先备份
-d , -F , --directory # 允许超级用户制作目录的硬链接，系统如果限制则可能出错
-f , --force # 强制执行
-i , --interactive # 交互模式
-n , --no-dereferenc # 把符号链接视为一般目录
-s , --symbolic # 软链接(符号链接)
-v , --verbose # 显示详细处理过程
-S , --suffix=SUFFIX # 指定备份的文件后缀
--help # 显示帮助信息
--version # 显示版本信息

```



补充：

> [Make links between files](http://www.gnu.org/software/coreutils/manual/html_node/ln-invocation.html)



### 3.1 硬链接

硬链接本质就是对一个文件起多个文件名。所以表现为其中一个inode号可以对应多个文件名。换言之，就是对一个文件使用了多个别名，这些别名的inode号相同。

```bash
[flamenca@localhost ~]$ ln lovers.txt Dove.txt
# 对lover.txt 文件创建硬链接 Dove.txt
[flamenca@localhost ~]$ ls -li
total 12
     ...
      102 -rw-rw-r--. 2 flamenca flamenca   82 Feb 24 18:51 Dove.txt
	...
      102 -rw-rw-r--. 2 flamenca flamenca   82 Feb 24 18:51 lovers.txt
	...
# 此时我们得到了硬链接 Dove.txt


```

那么如何验证其指向的文件是相同的？

 *验证方法：我们向原 lover.txt 文件中写入数据，如果查看 Dove.txt 中数据也发生变化，证明指向文件相同* 

```bash
[flamenca@localhost ~]$ echo lovers to Dove > lovers.txt 
# 写一句话覆盖原 lovers.txt 中的内容
[flamenca@localhost ~]$ cat lovers.txt 
lovers to Dove
# 查看 lovers.txt 内容已发生改变
[flamenca@localhost ~]$ cat Dove.txt 
lovers to Dove
# 查看 Dove.txt 内容已发生改变
```

由于硬链接是有着相同 inode 号仅文件名不同的文件，因此硬链接存在以下特点：

1. 文件有相同的inode以及data block

2. 只能对已有的文件进行创建(区别于软链接)

3. 不能跨分区创建硬链接

4. 不能对目录进行创建，只可对文件创建

5. 删除一个硬链接文件并不影响其他有相同 inode 号的文件

   

### 3.2 软链接

软链接与硬链接不同，当文件数据块中存放的内容是另一个文件的路径指向的话，则这个文件就是软链接。

其实软链接就是一个普通文件，只是他对应的数据块内容有点特殊。

软链接有着自己的inode号以及数据块，所以创建软链接没有与硬链接类似的诸多限制

其特点如下：

	1. 软链接有自己的文件属性及权限
 	2. 可对不存在的文件或者目录创建软链接(区别于硬链接)
 	3. 软链接可跨分区创建
 	4. 软链接可对文件或目录创建
 	5. 创建软链接时，链接计数不会增加
 	6. 删除软链接并不影响被指向的文件，但若被指向的文件被删除，则相关软链接被称为死链接，若被指向路径文件被重新创建，死链接可恢复为正常的软链接

我们用```ln -s```命令来创建软链接

```bash
[flamenca@localhost ~]$ ln -s lovers.txt lovers.txt.link
[flamenca@localhost ~]$ ls -li
total 12
	...
      102 -rw-rw-r--. 2 flamenca flamenca   15 Feb 24 21:59 lovers.txt
      124 lrwxrwxrwx. 1 flamenca flamenca   10 Feb 24 22:26 lovers.txt.link -> lovers.txt
	...
# 软链接创建成功，创建软链接并不会增加链接数


# 使用相对路径创建软链接 
[flamenca@localhost Music]$ ln -s ../bak/link.txt link.txt.link

# 对目录或文件路径创建软链接
[flamenca@localhost Music]$ ln -s dir dir.link
```



## 4. Linux上常用的文件管理类命令

### 4.1 查看文件列表

使用```ls```命令可以查看文件的列表

选项 :

- ```-a``` 显示所有文件及目录 (ls内定将文件名或目录名称开头为"."的视为隐藏档，不会列出)
- ```-l``` 除文件名称外，亦将文件型态、权限、拥有者、文件大小等资讯详细列出
- ```-r``` 将文件以相反次序显示(原定依英文字母次序)
- ```-t``` 将文件依建立时间之先后次序列出
- ```-A ```同 ```-a``` ，但不列出 "." (目前目录) 及 ".." (父目录)
- ```-F ```在列出的文件名称后加一符号；例如可执行档则加 "*", 目录则加 "/"
- ```-R``` 若目录下有文件，则以下之文件亦皆依序列出



### 4.2 查看文件属性信息

使用```stat```命令查看文件属性

选项：

- ```-b``` 列出辨识结果，不显示文件名
- ```-c``` 详细显示指令执行过程，便于排错或者分析执行的情形
- ```-f FILE``` 指定名称文件，其内容有一个或多个文件名时，依顺序辨识这些文件类型
- ```-L``` 直接显示符号链接所指向的文件类别
- ```-i``` 输出文件对应的MIME的类型
- ```-v``` 显示版本信息
- ```-z``` 尝试去解读压缩文件的内容

### 4.3 创建文件

我们使用```touch```可以设置文件的修改与访问时间，如果指定的文件不存在，则使用默认权限创建文件。

``` touch [OPTION]...FILE...```

选项：

- ```-a``` 表示只更改访问时间atime

- ```-c``` 不新建任何文件

- ```-m``` 只更改mtime

  

### 4.4 复制文件

使用```cp```命令来复制文件和目录

```cp [OPTION]... [-T] SOURCE DEST```

选项：

- ```-a``` 此参数的效果和同时指定"-dpR"参数相同；
- ```-d``` 当复制符号连接时，把目标文件或目录也建立为符号连接，并指向与源文件或目录连接的原始文件或目录；
- ```-f``` 强行复制文件或目录，不论目标文件或目录是否已存在；
- ```-i``` 覆盖既有文件之前先询问用户；
- ```-l``` 对源文件建立硬连接，而非复制文件；
- ```-p``` 保留源文件或目录的属性；
- ```-r``` 递归处理，将指定目录下的所有文件与子目录一并处理；
- ```-s``` 对源文件建立符号连接，而非复制文件；
- ```-u``` 使用这项参数后只会在源文件的更改时间较目标文件更新时或是名称相互对应的目标文件并不存在时，才复制文件；
- ```-S``` 在备份文件时，用指定的后缀“SUFFIX”代替文件的默认后缀；
- ```-b``` 覆盖已存在的文件目标前将目标文件备份；
- ```-v``` 详细显示命令执行的操作。



### 4.5 移动及重命名文件

使用```mv```命令来实现文件的移动、对文件或者目录重命名，或者将一个文件从一个目录移动到另一个目录，如果该文件已经存在，那么目标文件内容将会被覆盖。

选项：

- ```-b``` 当文件存在时，覆盖前，为其创建一个备份
- ```-f``` 直接覆盖不在提示
- ```-i``` 交互式操作，覆盖前会先提示用户
- ```-u``` 当源文件比目标文件新，或者目标文件不存在时才执行
- ```-S --suffix=SUFFIX``` 为备份文件制定后缀，而不使用默认后缀
- ```-t``` 指定源文件要移动到目标目录



### 4.6 删除文件

文件的删除和目录的删除都可以使用```rm```命令

```rm [OPTION]... FILE...```

选项：

- ```-f``` 强制删除文件，在删除时不加确认，并且自动忽略不存在的文件
- ```-i``` 在删除每个文件之前请求确认
- ```-d``` 删除空目录文件，非空目录不能删除
- ```-r``` 递归删除
- ```-v``` 显示详细的执行过程



## 6. vim基础设置

### 6.1 将tab缩进改为4个字符

首先可以在控制模式下输入```:  set tabstop=4```

其次我们要修改vim的配置文件```.vimrc```,文件的位置在```~/.vimrc``` 中。

在文件中输入：``` set tabstop=4```之后保存退出即可。

补充：

>每个人在使用vim时都有不同的喜好设置，对于功能强大的vim而言，能设置的东西实在是太多了。所以当我们需要一些vim相对于新手而言较为友好的设置的话，可以使用其他的配置文件，将其作为我们自己的vim配置，在github上会有一些大佬分享自己的vim设置，有些对于使用vim的新手来说非常的方便，所以有空的话不妨找一找~