# Sublime研究

## 1.我想在新建```.sh```文件后再开头自动生成Author信息等内容

```bash
# 首选项——package control——install package——File Header
# 插件包名称为 File Header


# 配置插件包
# 首选项>Package Settings >File Header>Settings-User


# 可能会用到的变量
    "Default": {
        /*
        Builtin Variables
        =================

        - create_time

            The file created time. It will be automatically set when you create
            a new file if you use it.

            Can't be set custom.

        - author

            The file creator.

            FileHeader will set it automatically. If it's in
            a git repository and the `user.name` has been set, `autor`
            will set to `user.name`, otherwise it will be set to current
            system user.

            Can be set custom.

        - last_modified_by

            The file last modified by who? It is specially useful when
            cooperation programming.

            FileHeader will set it automatically. If it's in
            a git repository and the `user.name` has been set, `autor`
            will set to `user.name`, otherwise it will be set to current
            system logined user.

            Can be set custom.

        - last_modified_time

            The file last modified time.

            FileHeader will set it automatically when you save the file.

            Can't be set custom.

        - file_path

            The absolute path of the current file.

            FileHeader will update it automatically when you change it.

            Can't be set custom.

        - file_name

            The name of current file with extension.

            FileHeader will update it automatically when you change it.

            Can't be set custom.

        - file_name_without_extension

            The name of current file without extension.

            FileHeader will update it automatically when you change it.

            Can't be set custom.

        - project_name

            The project name.

            Note: `project_name` only works in ST3.

            Can't be set custom.
        */

        /*
        Email
        */
        "email": "email@example.com"

        // You can add more here......
    },
```



### 我需要额外加入的内容：

```bash
{
	"Default":{
		"author":"Flamenca",
		"QQ":"3260616343",
		"email":"flamenca@qq.com",
		"Description":"The test script",
		"URL":" "
		
	}

}
```

### 应用：

```bash
# FileHeader\template\header 目录 找到对应语言模板文件修改即可
# 修改shellscript.tmpl文件内容

#!/bin/bash 
#
############################################################
# @Author:	{{author}}
# @Date:	{{create_time}}
# @File Name:	{{file_name}}
# @Last Modified time: {{last_modified_time}}
# @Description: {{Description}}
# @mail: {{email}}

############################################################


# 保存退出


# 在sublime上右键点击空白区域，选择File Header > New File 再填入文件名，文件即可创建成功
```

