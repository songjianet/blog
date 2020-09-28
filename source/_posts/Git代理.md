---
title: Git代理
date: 2018-12-09 18:05:28
updated: 2018-12-09 18:13:10
comments: true
categories:
- Git
tags:
- git
---

很多时候我们进行git clone的速度会很慢，为此我们可以通过代理的方式提高git的速度。

##### 设置http代理

```shell
git config --global https.proxy http://127.0.0.1:1080
git config --global https.proxy https://127.0.0.1:1080
```

##### 设置socks5代理

```shell
git config --global http.proxy 'socks5://127.0.0.1:1080' 
git config --global https.proxy 'socks5://127.0.0.1:1080'
```

##### 取消代理

```shell
git config --global --unset http.proxy
git config --global --unset https.proxy
```