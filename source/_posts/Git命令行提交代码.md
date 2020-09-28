---
title: Git命令行提交代码
date: 2018-05-24 13:23:33
updated: 2018-05-24 13:58:31
comments: true
categories:
- Git
tags:
- git
---

上篇文章<a href="http://www.songjian.site:4000/2018/05/10/Git%E9%85%8D%E7%BD%AEssh%E5%85%AC%E9%92%A5/">Git配置ssh公钥</a>后，我们详细讲解一下如何将自己的代码推送到git服务器。

##### 首先我们要带开GitHub网页，新建一个项目

![c03b4962514cfc4580928f9b05b4b719](/blog/Git命令行提交代码/c03b4962514cfc4580928f9b05b4b719.png)

##### 为项目起一个名字，然后点击创建项目

![732545bcd42d434dbd3528f08a2b9b1b](/blog/Git命令行提交代码/732545bcd42d434dbd3528f08a2b9b1b.png)

##### 在新跳转的页面中，我们可以看到一些git bash的命令，这些命令就是告诉我们在新建的项目中第一次推送代码需要做的事情

![d560cd64cb98ca4e8640e04f0d428d1d](/blog/Git命令行提交代码/d560cd64cb98ca4e8640e04f0d428d1d.png)

##### 命令含义

```shell
echo "# ceshi" >> README.md 
# 为项目创建一个说明的文档，内容是ceshi，文档格式为markdown，后续可以在此文档中增加对项目的内容介绍
git init
# 对本地的git仓库进行初始化，此时会在执行命令的目录多出一个.git的隐藏文件
git add README.md
# 将此文件加入到索引库中，此处可以用*代替，表示添加所有文件到索引库
git commit -m "first commit"
# 为这次提交的文件写一个说明
git remote add origin git@github.com:xxxxxxxx/ceshi.git
# 添加到git远程仓库
git push -u origin master
# 将本地项目推送到git远程仓库的主分支上
```
