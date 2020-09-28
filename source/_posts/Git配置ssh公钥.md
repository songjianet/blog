---
title: Git配置ssh公钥
date: 2018-05-10 21:53:30
updated: 2018-05-17 9:05:50
comments: true
categories:
- Git
tags:
- git
---

最近有人希望我对git做一些介绍，为此我特意开出一个大的分类专门记录一些git方向的基本操作和错误总结。而基本的如何去注册、登录git这样的操作也没有什么必要去讲，所以第一篇关于git方向的文章我打算讲一下如何去通过git bash去配置git的ssh公钥。

##### 打开git bash终端

![TIM图片20180514093902](TIM图片20180514093902.png)

![TIM图片20180514093957](TIM图片20180514093957.png)

##### 进行命令输入

进入文件加查看

```shell
cd ~/.ssh/ 
```

如果提示 “No such file or directory”使用下面命令创建

```shell
mkdir ~/.ssh
```

配置全局的name和email，这里事GitHub账号和邮箱

```shell
git config --global user.name "you Account" 
git config --global user.email "you email" 
```

生成ssh公钥

```shell
ssh-keygen -t rsa -C "you email"
```

查看生成的公钥文件

```shell
cd ~/.ssh
ll
```

![8ad702a410ed244db09c45c4d6ffd372](8ad702a410ed244db09c45c4d6ffd372.png)

登录自己的GitHub，点击自己头像下面的setting

![9b89261ef18cb14fa0545d543cbbc4cd](9b89261ef18cb14fa0545d543cbbc4cd.png)

点击左侧的SSH and GPG keys，然后再点击右上方的new SSH Key 

![d9a6dc081fb9004cbd3004b472fa3c69](d9a6dc081fb9004cbd3004b472fa3c69.png)

拷贝id_rsa.pub文件中的所有内容到下图的key区域，然后在title起一个名字，最后点击Add SSH Key 

![89e88906086d9d40b79361192b53805d](89e88906086d9d40b79361192b53805d.png)
