---
title: centos7+docker容器内部署wordpress集成环境
date: 2018-01-19 23:58:13
updated: 2018-05-15 11:06:56
comments: true
categories:
- docker
tags:
- Centos7
- docker
- wordpress
---

本篇文章记录详细讲解基于Centos7系统下容器化部署wordpress博客系统，传统在Centos7中部署wordpress需要LNMP的集成环境，而使用docker部署，我们只需要一个mysql和wordpress的镜像，然后启动镜像即可。

1. 在Centos7中安装docker运行环境（此处安装的为docker-ee版本，docker-ce版本也可以）

   ```sh
   yum install docker -y
   ```

2. 配置docker自动启动和启动docker

   ```shell
   systemctl enable docker
   systemctl start docker
   ```

3. docker下载wordpress镜像和mysql镜像

   ```shell
   docker pull mysql
   docker pull wordpress
   ```

4. 查看docker 镜像是否下载成功（使用docker images看到如下图所示，表示镜像下载成功）

   ```shell
   docker images
   REPOSITORY                  TAG             IMAGE ID            CREATED             SIZE
   docker.io/mysql             latest          f008d8ff927d        3 days ago          408.5 MB
   docker.io/wordpress         latest          28084cde273b        10 days ago         408.1 MB
   ```

5. 启动这个镜像（docker默认下载下来的是一个镜像，当这个镜像启动的时候就会创建一个基于这个镜像的容器，这里使用的是容器内部署hexo，如果需要把项目挂载到本机的目录操作，请查看我博客左上角docker分类中的另一篇部署文章）

   ```shell
   ## --name: 容器名   -p: 端口映射   -d: 以守护进程方式运行（后台）
   docker run --name mysql_db -e MYSQL_ROOT_PASSWORD=yourpassword -d docker.io/mysql
   ## 执行完命令后看到如下一长串的数字加字母组合，表示容器创建成功
   0d9cee50df329966d679d545167b5c39ba5dc970ac194f582e73f8182df6dd7f
   docker run --name some-wordpress --link mysql_db:mysql -p 80:80 -d docker.io/wordpress
   0d9cee50df329966d679d545167b5c39ba5dc970ac194f582e73f8182df6dd7f
   ```

6. 接下来查看docker启动的容器信息（docker ps -a是查看所有创建过的容器，包括没启动的容器）

   ```shell
   docker ps
   CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                    NAMES

   2ca12f671c97        docker.io/wordpress   "docker-entrypoint.sh"   14 hours ago        Up 14 hours         0.0.0.0:80->80/tcp       some-wordpress
   7bd5e6166d46        docker.io/mysql       "docker-entrypoint.sh"   14 hours ago        Up 14 hours         3306/tcp                 mysql_db
   ## 看到如上信息表示你的wordpress集成环境已经创建完毕，通过访问本机ip:80访问，就能看到默认的注册wordpress的欢迎注册页面
   ```


![wordpress后台管理示例页面](1234567890.png)