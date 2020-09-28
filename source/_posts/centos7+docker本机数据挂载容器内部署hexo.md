---
title: centos7+docker本机数据挂载容器内部署hexo
date: 2018-01-19 14:14:13
updated: 2018-05-15 11:03:10
comments: true
categories:
- hexo
tags:
- Centos7
- docker
- hexo
typora-root-url: ./
---

本篇文章继容器内部署hexo后，有些人为了能够让自己的数据更安全一些，会想到备份的问题，我在这里提供一种方式以同步本机数据和容器内hexo数据，说到底就是以挂载的方式将我们的数据挂载进docker的hexo的容器内。

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
   ## --name: 容器名   -p: 端口映射   -d: 以守护进程方式运行（后台）  -v: 挂载目录（本机目录 : 容器内hexo文档目录）
   docker run  -d --name some-hexo -p 4000:4000 -v /home/sj_hexo:/opt/hexo/ipple1986/source/_posts  ipple1986/hexo 
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

7. 启动成功后查看本机挂载目录的内容和hexo容器内文档目录的内容是否一致，一致表示成功（注：如果挂载目录里没有内容页面可能看不到任何效果）

   ```shell
   docker ps ## 查看正在运行的容器信息
   docker exec -it 容器名 /bin/bash ## 进入容器内部
   ll source/_posts/ ## 查看容器内的文章，与第5步启动容器时候的本机目录下的文章做对比
   ```

   ![容器挂载成功图片](/blog/centos7+docker本机数据挂载容器内部署hexo/20180119142656.png)

8. 注：部署成功后，每次更换主题，发布文章后都要执行以下命令

   ```shell
   hexo clean && hexo g ## 清除缓存，重新构建
   exit ## 退出容器内
   docker restart 容器名
   ```
