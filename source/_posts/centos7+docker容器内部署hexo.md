---
title: centos7+docker容器内部署hexo
date: 2018-01-19 13:30:13
updated: 2018-05-15 11:03:57
comments: true
categories:
- hexo
tags:
- Centos7
- docker
- hexo
---

本篇文章记录详细讲解基于Centos7系统下容器化部署hexo静态博客系统，随着近年来容器化部署广泛普及，使得越来越多的人在做一个项目的时候会考虑到容器化部署的方案。而个人构建博客系统我本人也是比较看好docker+hexo的部署方式的。从整个博客系统的渲染速度和维护管理来讲，hexo有着超越wordpress的优越条件，本人也是用过wordpress，近年来wordpress的发展显得过于臃肿。

1. 在Centos7中安装docker运行环境（此处安装的为docker-ee版本，docker-ce版本也可以）

   ```sh
   yum install docker -y
   ```

2. 配置docker自动启动和启动docker

   ```shell
   systemctl enable docker
   systemctl start docker
   ```

3. docker下载hexo镜像

   ```shell
   docker pull ipple1986/hexo
   ```

4. 查看docker 镜像是否下载成功（使用docker images看到如下图所示，表示镜像下载成功）

   ```shell
   docker images
   REPOSITORY                  TAG             IMAGE ID            CREATED             SIZE
   docker.io/ipple1986/hexo    latest          8eb73a3f4772        7 months ago        426.7 MB
   ```

5. 启动这个镜像（docker默认下载下来的是一个镜像，当这个镜像启动的时候就会创建一个基于这个镜像的容器，这里使用的是容器内部署hexo，如果需要把项目挂载到本机的目录操作，请查看我博客左上角docker分类中的另一篇部署文章）

   ```shell
   ## --name: 容器名   -p: 端口映射   -d: 以守护进程方式运行（后台）
   docker run -d --name some-hexo -p 4000:4000 ipple1986/hexo 
   ## 执行完命令后看到如下一长串的数字加字母组合，表示容器创建成功
   0d9cee50df329966d679d545167b5c39ba5dc970ac194f582e73f8182df6dd7f
   ```

6. 接下来查看docker启动的容器信息（docker ps -a是查看所有创建过的容器，包括没启动的容器）

   ```shell
   docker ps
   CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                    NAMES
   
   42374e8d1d18        ipple1986/hexo        "hexo server"            22 hours ago        Up 2 hours          0.0.0.0:4000->4000/tcp   some-hexo
   ## 看到如上信息表示你的hexo已经创建完毕，通过访问本机ip:4000访问，就能看到默认的hexo的欢迎页面
   ```

7. 注：部署成功后，每次更换主题，发布文章后都要执行以下命令

   ```shell
   hexo clean && hexo g ## 清除缓存，重新构建
   exit ## 退出容器内
   docker restart 容器名
   ```