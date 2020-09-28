---
title: docker配置国内镜像源
date: 2018-08-08 18:12:50
updated: 2018-08-08 18:12:50
comments: true
categories:
- docker
tags:
- Centos7
- docker
---

由于docker hub是在国外的，我们有时候并不能很快的下载一个image，甚至还有timeout的情况，所以我们会选择去使用中国的docker image，在我们使用中国的镜像源的时候需要进行一些简单的配置。

##### 一. 中国有哪些可用的镜像源

docker在中国有四个不错的镜像源，分别是阿里，网易，DaoCloud ，Docker中国区官方镜像 。这些都是可以让大家随意使用的镜像源，同事也是中国最优质的镜像源。

##### 二. 配置docker中国区官方镜像 

在这里我使用的是Docker中国区官方镜像源，目前该镜像库只包含流行的公有镜像，而私有镜像仍需要从美国镜像库中拉取，通过vi修改/etc/docker/daemon.json文件。

```json
{ 
	"registry-mirrors": ["https://registry.docker-cn.com"] 
}
```

##### 三. 重新加载修改过的docker配置文件

```shell
systemctl daemon-reload 
```

##### 四. 重启docker服务

```shell
systemctl restart docker
```

##### 五. 重新拉取镜像

```shell
docker pull <imagename>
```