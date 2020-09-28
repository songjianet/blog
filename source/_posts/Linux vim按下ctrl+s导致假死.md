---
title: Linux vim按下ctrl+s导致假死
date: 2018-05-17 10:10:37
updated: 2018-05-17 10:10:37
comments: true
categories:
- Linux
tags:
- Linux
- vim
---

最近看到同事操作vim编辑器再保存退出的时候经常会按<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;"> ctrl + s </code>然后导致界面卡死，最终选择重新远程连接，这时候Linux会判断你这次vim操作并没有进行保存而强制退出，这时Linux会生成一个缓存文件，导致下次在编辑这个文件的时候进入选择模式，当然我们可以把缓存文件删除，也可以解决这个问题，不过导致这个问题发生归根到底都是不熟悉vim操作造成的。

在vim中如果按下了<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;"> ctrl + s </code>会终止屏幕输出（即停止回显） ，在这期间你按的所有按键都是有效的，被记录到文件中的，只不过是你自己看不见而已。

我们可以通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;"> ctrl + q </code>恢复屏幕输出，你刚才敲的都显示出来了 。