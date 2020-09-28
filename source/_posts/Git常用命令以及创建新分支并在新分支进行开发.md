---
title: Git常用命令以及创建新分支并在新分支进行开发
date: 2018-06-07 11:37:54
updated: 2018-06-07 17:16:47
comments: true
categories:
- Git
tags:
- git
- git checkout
- git branch
---

这些天因为自己新项目的原因要进行分支的操作，为此想到了博客中还有关于git方面的文章。为此，我在这里详细的介绍下关于git分支的操作。

关于git分支在实际开发中的应用还是很广泛的。普遍来讲，各个公司都不会允许所有码农将代码直接提交到主分支（master）上，主分支只作为为所有码农下载项目（pull）使用。

那么，我们无法将自己写的代码直接提交到master上，应该怎么办。最通常的方式就是将项目从master上pull下来，然后创建一个自己名字命名的分支，然后我们把修改的项目提交到自己的分支上，再有项目经理或者以上级别的人进行分支合并，将所有人的分支合并到master上。这样其他人在pull master的时候就能更新到除了自己以外所有人的代码。

由于前几两篇关于git的文章我并没有对git常用命令进行讲解，所以在操作分支的时候各位也应该是对master push pull有所了解了。

##### git常用命令

```shell
$ git rm 文件名 # 删除本地git仓库文件，提交后远程服务器上的文件会被删除
$ git status # 查看状态
$ git add 文件名 # 添加记录
$ git add * # 添加所有文件
$ git commit -m "描述此次提交的内容" # 添加描述
$ git pull origin master # 从主分支同步数据
$ git push origin master # 提交数据到主分支
$ git branch # 查看分支
$ git branch 分支名 # 创建分支
$ git checkout 分支名 # 切换分支
$ git checkout -b 分支名 # 创建+切换分支
$ git branch -d 分支名 # 删除分支
$ git branch -D 分支名 # 强制删除分支
$ git push origin :分支名 # 删除远程分支
$ git checkout --file # 撤销修改
$ git merge 分支名 # 合并某分支到当前分支
```

那么，介绍完了常用命令之后，我们应该如何新建分支进行工作

##### 选择master pull或者新项目直接git clone默认master

```shell
$ git checkout master
$ git pull
```

##### 创建分支

```shell
$ git checkout -b dev
```

##### 将新建的分支push到远端

```shell
$ git push origin dev
```

##### 拉取远端分支

```shell
$ git pull

There is no tracking information for the current branch.
Please specify which branch you want to merge with.
See git-pull(1) for details.

git pull <remote> <branch>

If you wish to set tracking information for this branch you can do so with:

git branch --set-upstream-to=origin/<branch> dev
# 当前分支并没有和本地分支关联
```

##### 关联分支

```shell
$ git branch--set-upstream-to=origin/dev
```

##### 再次拉取

```shell
$ git pull
```

有关git分支内部工作原理的信息，请查看<a href="http://www.songjian.site:4000/2018/06/07/Git%E5%88%86%E6%94%AF%E7%9A%84%E5%86%85%E9%83%A8%E8%BF%90%E8%A1%8C%E6%9C%BA%E5%88%B6/">Git分支的内部运行机制</a>