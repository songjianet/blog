---
title: docker部署tomcat环境
date: 2018-01-20 12:02:13
updated: 2018-05-15 11:09:32
comments: true
categories:
- docker
tags:
- Centos7
- docker
- tomcat
---

本篇文章介绍一下在docker环境中部署tomcat容器，将项目挂载到外部。

1. 在系统环境中安装docker

   ```shell
   # yum install docker -y
   ```

2. 配置docker自启和启动docker

   ```shell
   # systemctl enable docker
   # systemctl start docker
   ```

3. 下载tomcat镜像

   ```shell
   # docker pull tomcat
   ```

4. 启动tomcat镜像

   ```shell
   # docker run --name jc_tomcat -v /home/jc_static_page:/usr/local/tomcat/webapps/ROOT -p 8080:8080 -d docker.io/tomcat
   ```

5. 分别查看本机的挂载目录里面的文件和容器内挂载目录里面的文件是否一致（没有文件的情况下，页面上有可能没有内容显示）

   ```shell
   # docker exec -it 容器名 /bin/bash
   ## 可以通过上面的命令进入tomcat容器内
   ```

6. 打开浏览器输入网址IP:8080即可看到tomcat项