---
title: 通过配置文件修改docker容器端口映射
date: 2018-07-04 15:18:48
updated: 2018-07-05 16:22:40
comments: true
categories:
- docker
tags:
- docker
---

对于修改docker容器端口映射，我们通常会想到将当前容器生成一个镜像，然后重新运行生成的镜像，再添加上端口的映射以达到修改端口的目的。

不过，还有一种方式是修改docker容器配置文件的方式去修改容器的端口映射，相比重新生成镜像来说，这种方式便捷了很多。

##### 关闭运行中的docker容器

```shell
docker stop container_name
```

##### 停止系统中运行的docker服务

```shell
systemctl stop docker
```

##### 修改配置文件

```shell
vim /var/lib/docker/containers/[container_id]/hostconfig.json
# container_id为容器id
```

```shell
"4000/tcp": [ 
{
 "HostIp": "0.0.0.0",
 "HostPort": "80"
 }
]
# 4000端口为容器内端口，80为实体机端口
```

##### 修改完成后重启docker服务和docker容器

```shell
systemctl start docker
docker start container_name
```