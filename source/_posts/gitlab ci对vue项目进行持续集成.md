---
title: Gitlab CI对vue项目进行持续集成
date: 2018-10-16 15:32:04
updated: 2018-10-17 13:43:15
comments: true
categories:
- Git
tags:
- CentOS7
- Gitlab runner
- Gitlab ci
- Shell
- tcp
- Docker
- Dockerfile
- vue
---

#### 什么是持续集成

​	在软件工程中，持续集成（CI）是指将所有开发者的工作副本每天多次合并到主干的做法。Grady Booch 在1991年的 Booch method 中首次命名并提出了 CI 的概念，尽管在当时他并不主张每天多次集成。而 XP（Extreme programming，极限编程）采用了 CI 的概念，并提倡每天不止一次集成。



#### 使用Gitlib CI持续集成

​	在七月份的时候离职来到了一个初创型的公司，参与了不少的公司基础环境配置。对代码管理使用了本地Gitlib，使用docker pull下来的Gitlib镜像。所以对于我司项目的持续集成开始也考虑过Jenkins等，但是最后决定使用Gitlib的CI进行持续集成，不仅缩小了硬件资源，而且Gitlib本身集成了CI，使用起来会更方便。



#### 使用Gitlib CI的基本流程

​	对于前四步我在这里就不进行介绍了，主要从Runner机器的环境配置开始一步步的介绍。

​	1.安装至少两台CentOS7系统的机器

​	2.在一台机器上面安装docker

​	3.然后在docker环境中安装Gitlib

​	4.准备一个vue项目，提交到Gitlib中

​	5.在另一台机器中安装Runner

​	6.将Runner与Gitlib中的vue项目进行关联

​	7.更改docker服务tcp

​	8.编写CI文件

​	9.编写Dockerfile文件

​	9.反复的提交，更改直到解决问题



#### 安装Runner

##### 参考网址

<a href="https://docs.gitlab.com/runner/install/"> Gitlib Runner </a>官网

<a href="https://docs.gitlab.com/runner/install/docker.html#docker-image-installation-and-configuration"> Gitlib Runner Docker </a>环境安装文档

<a href="https://docs.gitlab.com/runner/register/index.html#docker"> Gitlib Runner Docker </a>注册

##### 1.安装docker

​	安装docker环境，建议使用官网的安装方式，不要使用yum等其他方式。因为官网的脚本对系统环境进		行了一些基础的配置。

```shell
curl -sSL https://get.docker.com/ | sh
```

##### 2.编写安装脚本install.sh

​	我们可以看到，官网的安装命令其实很长的，为此我们可以封装一个shell脚本，每次通过sh命令去执行脚本进行安装。而且按照官网的安装方式还会有一个bug，我们在文章的最后会进行介绍，当然你也可以先去查看<a href="#gitlab-runner"> gitlab-runner </a>。

​	![1](/blog/images/gitlab ci对vue项目进行持续集成/1.png)	

```shell
docker stop gitlab-runner
docker rm gitlab-runner

docker run -d --name gitlab-runner --restart always \
  -v /srv/runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest
```

##### 3.编写注册脚本register.sh

​	在我们把安装完Runner的镜像后，我们要进行Runner机器的注册。通过注册，我们能够与Gitlib的项目进行绑定。但是由于使用命令行注册很麻烦，所以我们要将注册编写成一个shell脚本，在这里要对url和token等一系列信息进行设置。<p style="color: red;">秘钥来自于Gitlib中你所选择的项目中的秘钥。</p>

![2](/blog/images/gitlab ci对vue项目进行持续集成/2.png)

```
docker run --rm -t -i -v /srv/runner/config:/etc/gitlab-runner --name gitlab-runner gitlab/gitlab-runner register \
  --non-interactive \
  --executor "docker" \
  --docker-image alpine:latest \
  --url "http://git.star/" \
  --registration-token "-my3Ce2mNjw1ByU56BAG" \
  --description "docker-runner" \
  --tag-list "admin" \
  --run-untagged \
  --locked="false"
```

##### 4.首先执行注册脚本，然后在执行安装脚本

```shell
sh register.sh
sh install.sh
```

##### 5.查看Runner是否创建成功

​	出现绿色圆圈表示创建成功。

![3](/blog/images/gitlab ci对vue项目进行持续集成/3.jpg)



#### 修改Runner机器中docker服务的tcp

​	使用vim找到/lib/systemd/system/docker.service这个文件，进行编辑。

```
vim /lib/systemd/system/docker.service
```

​	找到这段代码ExecStart=/usr/bin/dockerd，在后面添加。

```vim
ExecStart=/usr/bin/dockerd -H unix:///var/run/docker.sock -H tcp://0.0.0.0:2375
```

​	重新加载配置文件，重启docker服务。

```shell
systemctl daemon-reload
systemctl restart docker
```



#### 编写CI文件

<a href="https://fennay.github.io/gitlab-ci-cn/gitlab-ci-yaml.html"> CI文件 </a>文档

##### 1.在根目录中创建一个名问.gitlab-ci.yml的文件

##### 2.编写CI文件

​	在文件中涉及到了一个dind的镜像，这个镜像允许我们在dind容器中使用docker命令，在文章的最后我会对其进行讲解，当然你也可以现在去查看<a href="#dind"> dind </a>。

```yml
image: docker:stable # 基础镜像

variables:
  DOCKER_HOST: tcp://dev.star:2376 # tcp
  DOCKER_DRIVER: overlay2 # 驱动

stages: # 整个持续集成分成两步
- build
- deploy

build project: # job name
  image: node # 使用node镜像
  stage: build
  script:
  - npm install -g cnpm --registry=https://registry.npm.taobao.org # cnpm
  - cnpm install
  - cnpm run build
  - cp -r Dockerfile admin # 拷贝dockerfile文件
  cache:
    paths:
    - node_modules/ # 为node_modules增加缓存
  artifacts:
    expire_in: 1 week # 生成文件保存周期
    paths:
    - dist # 编译后生成的文件夹名

services:
- docker:dind # docker in docker Gitlib官方推荐支持docker命令的docker容器，关于docker in docker我们会在文章最后进行讲解

deploy project: # job name
  stage: deploy
  script:
  - docker build -t hema-admin-page . # 通过dockerfile构建docker images
  - docker stop hema-admin-page || true # 通过true解决流水线重启后容器依旧存在问题
  - docker rm hema-admin-page || true
  - docker run --rm -d -p 8082:80 --name hema-admin-page hema-admin-page # 启动这个镜像

```



#### 编写Dockerfile文件

​	在上面的CI文件中，我们看到了Dockerfile文件，这个文件也是在根目录下创建。<p style="color: red;">但是需要用命令创建，因为windows本身不支持创建不带文件后缀名的文件，当然也可以不用windows。</p>至于这个Dockerfile文件的用途就是pull一个nginx镜像，然后将我们在CI文件中编译出来的dist文件夹里面的内容拷贝到nginx的html目录中，然后在CI中的deploy环节build，run。

```dockerfile
FROM nginx
COPY ./dist/ /usr/share/nginx/html
EXPOSE 80
```



#### 提交代码测试

​	接下来我们要把.gitlab-ci.yml和Dockerfile文件提交到代码仓库，这时候在对应的项目中我们点击CI/CD能看到我们的持续集成的任务跑起来，但是有成功，有失败，很难一次成功，所以要反复的调试。

![4](/blog/images/gitlab ci对vue项目进行持续集成/4.jpg)

​	我们可以点击状态进入终端模式查看CI文件执行到了哪一步。

![5](/blog/images/gitlab ci对vue项目进行持续集成/5.jpg)

<br>

![6](/blog/images/gitlab ci对vue项目进行持续集成/6.jpg)



#### 有坑的环节

##### <p id="gitlab-runner">1.Gitlib runner</p>

​	我们在安装好docker的时候，官网推荐我们通过下面的这个命令下载并启动这个镜像容器。

```shell
docker run -d --name gitlab-runner --restart always \
  -v /srv/runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest
```

​	但是我们使用这个命令后，到了注册环节，官网给出的注册方式竟然也带了启动命令，看下面这段代码，但是这个容器并不会被创建，因为在下载的时候我们已经进行了容器的启动，所以会提示当前已经有个gitlab-runner的容器正在运行了。

```
docker run --rm -t -i -v /srv/runner/config:/etc/gitlab-runner --name gitlab-runner gitlab/gitlab-runner register
```

​	为此，我想到了一种解决办法。我们去执行第一条命令下载并启动容器的命令后通过stop和rm命令，将容器停止并删除<p style="color: red;">（一定要先停止容器，在删除容器，否则会报错，这是docker运行机制决定的，或者可以强制删除容器）</p>，然后执行注册的命令，这时候容器已经启动，我们可以docker ps进行查看，到这里并不是结束，如果不去执行第一条命令，我们的会看到这个结果。

![7](/blog/images/gitlab ci对vue项目进行持续集成/7.png)

​	这个三角形感叹号出现表示秘钥连接成功，但是我们的容器并不是在真正的运行，说白了，就是没有挂载第一条命令中的docker.sock文件，所以我们将容器停止删除掉后，再去执行第一条命令。

​	之所以要通过shell脚本进行安装和注册，就是因为中间的过程坑比较多。

##### <p id="dind">2.dind</p>

​	首先，我们为什么要用到dind这个镜像，因为我们在CI文件中的deploy环节中，如果直接使用nginx镜像，我们提交到仓库后，这个镜像默认是自动启动的，切没有指定tcp端口，所以我们在页面中无法查看。你也可能说我们可以将docker命令写到这个环节中，但是这样会报出一个没有docker命令的错误。导致这个错误产生的原因就是我们的nginx镜像已经启动，并且进去了这个容器中，但是这个nginx容器并没有docker命令。

​	![8](/blog/images/gitlab ci对vue项目进行持续集成/8.jpg)

​	所以，我们需要在docker容器中使用docker命令去下载一个nginx镜像，然后对这个镜像进行run。而Gitlib官方推荐我们的方式就是使用dind镜像，我们通过启动这个镜像，将我们的Dockerfile文件build出来一个新的镜像，然后去启动这个镜像。



#### 总结

​	对于持续集成在开发和部署过程中起到了非常大的作用，在第一次环境部署的过程中可能会很繁琐，但是在以后开发，团队协作的过程中，减少了团队的耦合性。
