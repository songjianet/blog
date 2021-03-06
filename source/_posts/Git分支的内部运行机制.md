---
title: Git分支的内部运行机制
date: 2018-06-07 14:22:22
updated: 2018-06-07 17:14:14
comments: true
categories:
- Git
tags:
- git
---

首先我们在深入了解git分支工作原理之前，要了解一下git时间线的概念。

在我们每次提交代码的时候，git都把他们串成一条时间线，这个时间线就是一个分支。在一个项目中如果只有一个时间线，我们把它叫做主分支（master）。而head严格来说不是指向提交，而是指向一个分支，再有这个分支指向提交，所以我们可以理解成head之乡的就是当前的分支。

在只有一个时间线的时候（即只有一个主分支master），git会用head指向分支，再由分支指向最新的提交点。

![7de4ebc75849494691021c2c86551952](/blog/images/Git分支的内部运行机制/7de4ebc75849494691021c2c86551952.png)

当每次提交的时候git会将head指向的分支向前移动，这样，随着项目不断地更新，时间线也会越来越长。

![8fb2340888c996459c099483ae905e5e](/blog/images/Git分支的内部运行机制/8fb2340888c996459c099483ae905e5e.png)

当我们去创建一个新分支dev并且使用时，由于项目没有做出任何改变，所以dev分支指向的时间点和master指向的时间点是相同的。

![173f807d11d39c42a755e1b3320e00dc](/blog/images/Git分支的内部运行机制/173f807d11d39c42a755e1b3320e00dc.png)

在dev分支向仓库提交代码时，向前移动的时间点也是dev分支的时间点，并不是master主分支的时间点。

![4484d8b1590eb54d933c3faded84b765](/blog/images/Git分支的内部运行机制/4484d8b1590eb54d933c3faded84b765.png)

当我们要进行master和dev分支项目合并时候，我们要切换到master分支，将master分支指向dev分支的时间点上。

![d63a3cfcc99caf41a5a12490369c943c](/blog/images/Git分支的内部运行机制/d63a3cfcc99caf41a5a12490369c943c.png)

在成功将代码合并后master分支指向的时间点和dev分支指向的时间点是相同的。当我们在pull master的时候我们pull到的项目中就是带有dev分支更改的内容。

![7bd5fd68f0e28e418edef46fc5f2e5b0](/blog/images/Git分支的内部运行机制/7bd5fd68f0e28e418edef46fc5f2e5b0.png)

在分支合并完成后我们可以选择将dev分支进行删除，删除dev分支就是把dev指针删除。当然，删除dev分支后我们的仓库中也就只有master一个分支了。
