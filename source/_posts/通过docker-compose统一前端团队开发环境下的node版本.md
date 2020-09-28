---
title: 通过docker-compose统一前端团队开发环境下的node版本
date: 2019-04-09 10:11:38
updated: 2019-04-09 17:43:22
comments: true
categories:
- docker
tags:
- vue
- node
- docker
- docker-compose
- Dockerfile
---

#### 前言

在写这篇文章的时候，我一直在犹豫给它的分类划分到前端比较好，还是划分到<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">docker</code>比较好。反复分析后觉得此篇文章重在讲解使用<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">docker-compose</code>去做团队的规范、统一，他的应用领域并不局限于控制<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">node</code>的版本，它也可以去统一<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">php</code>、<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">mysql</code>、甚至是前后台的所有环境等。

------

#### 导读

> [1] 如果你在阅读中发现错误或者存在某些问题可以通过邮件的形式发送到作者的邮箱，再收到邮件后作者会及时处理这些问题。
>
> [2] 阅读文章你需要了解<a href="https://yeasy.gitbooks.io/docker_practice/introduction/what.html>" target="_blank">Docker</a>、<a href="https://yeasy.gitbooks.io/docker_practice/compose/introduction.html" target="_blank">Compose</a>、<a href="https://yeasy.gitbooks.io/docker_practice/image/build.html" target="_blank">Dockerfile</a>、<a href="https://yeasy.gitbooks.io/docker_practice/basic_concept/image.html" target="_blank">Docker镜像</a>、<a href="https://yeasy.gitbooks.io/docker_practice/basic_concept/container.html" target="_blank">Docker容器以及Docker容器与传统虚拟化对比</a>。
>
> [3] 阅读文章你需要了解的技术有node，需要掌握的技术有vue，docker。
>
> [4] 参考资料：<a href="https://nodejs.org/zh-cn/" target="_blank">node</a>、<a href="https://cn.vuejs.org/" target="_blank">vue</a>、<a href="https://www.docker.com/" target="_blank">docker</a>可以参考官网文档，同时docker以及docker-docker-compose可以参考gitbooks上面的<a href="https://yeasy.gitbooks.io/docker_practice/" target="_blank">《Docker技术入门与实战》</a>一书。

#### 基本介绍

- docker最重要的概念就是容器，容器化与虚拟化技术区别就在于虚拟硬件和完整的操作系统。
- docker-compose最主要的作用在于对docker容器集群的快速编排。
- docker-compose中的service代指一个应用的容器，实际上可以包括若干运行相同镜像的容器实例。
- docker-compose中的project代指由一组关联的应用容器组成的一个完整业务单元，在docker-compose.yml文件中定义。

#### 编写Dockerfile

```dockerfile
FROM node:10.15 # 指定node版本

MAINTAINER username # 指定作者

WORKDIR /home/website # 指定容器内部的工作目录

CMD ["sh", "-c", "yarn install ; yarn serve"] # 容器启动后执行的命令
```

#### 编写docker-compose.yaml

```yaml
version: '3' # compose-file的语法版本
services: # 定义服务

  dev-web: # 服务名
    build: 
      context: . # 指定dockerfile所在文件夹的路径
      dockerfile: ./Dockerfile # dockerfile文件的相对路径
    ports:
      - 8080:8080 # 端口映射
    volumes:
      - ./:/home/website # 将项目中的文件挂在到容器内部的工作目录
```

#### 执行方式

```shell
docker-compose build # 首次执行或者修改配置文件后执行
docker-compose start # 启动
```

#### 总结

我们通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Dockerfile</code>去构建一个镜像，通过<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">docker-compose.yaml</code>文件将<code style="letter-spacing: 2px;font-weight:700;background-color:#e6effb;border-radius:3px;">Dockerfile</code>引入并且配置端口映射以及目录映射。目录映射会把我们本地的项目代码映射到容器中的工作目录，但是所有的依赖包实在容器启动后自动下载，这样就能保证团队中的代码和环境的统一。