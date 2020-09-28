---
title: docker部署portainer（单机和集群）
date: 2018-01-19 17:07:13
updated: 2018-05-15 11:08:36
comments: true
categories:
- docker
tags:
- Centos7
- docker
- docker swarm
- portainer
---

近两三年来docker的热度不断上升，很多公司都采用集群化的docker部署方案，也有很多技术爱好者和IT行业人士，使用单机版的docker部署一些自己的博客之列的，在这里我主要介绍以下单机版基于Centos7的docker图形化管理界面portainer的安装和docker swarm集群下portainer的安装。

（一）单机版docker图形化管理界面portainer的安装

1. 在Centos7中安装docker

   ```
   yum install docker -y
   ```

2. 设置docker自动启动和启动docker服务

   ```shell
   systemctl enable docker
   systemctl start docker
   ```

3. 安装portainer图形化管理界面，查看portainer容器运行状态（如果成功运行，就可以通过ip:9000访问portainer管理页面了，如果服务启动成功，浏览器查看不到页面，请看第4步）

   ```shell
   docker volume create portainer_data
   docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
   docker ps
   ```

4. 关闭或者使9000端口通过防火墙

   ```shell
   systemctl enable firewalld ## 关闭防火墙开机自启
   systemctl stop firewalld ## 关闭防火墙
   ################################################################
   firewall-cmd --add-port=9000/tcp --permanent ## 永久开放9000端口
   firewall-cmd --add-port=9000/tcp 
   ## 开放9000端口（在没有关闭防火墙自启的时候，重启后9000端口将不在防火墙的白名单中）
   ```


（二）集群版docker swarm图形化管理界面portainer的安装

1. 首先配置三台机器的hosts文件，使（三台机器）docker集群能够互相发现，10.70.23.60作为manager节点，10.70.23.61和10.70.23.62分别作为node1和node2节点

   ```shell
   cat /etc/hosts
   127.0.0.1 localhost
   10.70.23.60 manager
   10.70.23.61 node1
   10.70.23.62 node2

   ```

2. 在manager机器上配置ssh免密登录，通过ssh-copy-id分发给node1和node2机器

   ```shell
   ssh-keygen -t rsa -P ''
   ssh-copy-id -i .ssh/id_rsa.pub root@10.70.23.61
   ssh-copy-id -i .ssh/id_rsa.pub root@10.70.23.62
   ```

3. 在manager机器上安装ansible，通过ansible分发命令（注:这里选择关闭防火墙，实际环境中可自行开放端口）

   ```shell
   yum -y install ansible
   vim /etc/ansible/hosts 
   ## 手动将10.70.23.61和10.70.23.62加入到文件最后，之后用于ansible分发命令使用
   cat /etc/ansible/hosts | grep -v ^# | grep -v ^$ 
   ## 查看ansible/hosts的节点
   [node]
   10.70.23.61
   10.70.23.62
   vim /etc/selinux/config ## 将SELINUX=enforcing替换为SELINUX=disabled
   ansible node -m copy -a 'src=/etc/selinux/config dest=/etc/selinux/'
   systemctl stop firewalld
   systemctl disable firewalld
   ansible node -a 'systemctl stop firewalld' 
   ## 通过ansible在manager机器上执行命令，分发给所有node机器
   ansible node -a 'systemctl disable firewalld'
   ## 通过ansible在manager机器上执行命令，分发给所有node机器
   ```

4. 在manager机器上安装docker，同时设置docker开机自启和启动docker

   ```shell
   yum install -y yum-utils device-mapper-persistent-data lvm2
   yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
   yum list docker-ce --showduplicates | sort -r
   ## 如果本地有镜像源可以不用操作上面的三条命令
   yum -y install docker-ce
   systemctl start docker
   systemctl enable docker
   ```

5. 在manager机器上使用ansible在所有node节点上安装docker

   ```shell
   ansible node -m copy -a 'src=/etc/yum.repos.d/docker-ce.repo dest=/etc/yum.repos.d/'
   ## 如果本地有镜像源可以不用操作上面的命令
   ansible node -m yum -a "state=present name=docker-ce"
   ansible node -a 'systemctl start docker'
   ansible node -a 'systemctl enable docker'
   ```

6. 在manager机器上创建docker swarm集群

   ```shell
   docker swarm init --listen-addr 0.0.0.0
   Swarm initialized: current node (a1tno675d14sm6bqlc512vf10) is now a manager.
   To add a worker to this swarm, run the following command:
       docker swarm join --token SWMTKN-1-3sp9uxzokgr252u1jauoowv74930s7f8f5tsmm5mlk5oim359e-dk52k5uul50w49gbq4j1y7zzb 10.70.23.60:2377
   To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
   ```

7. 在manager机器上查看docker swarm节点信息

   ```shell
   docker node ls
   ID                           HOSTNAME      STATUS      AVAILABILITY   MANAGER STATUS
   a1tno675d14sm6bqlc512vf10 *  manager        Ready         Active           Leader
   ```

8. 在manager机器上查看加入manager管理节点的命令

   ```shell
   docker swarm join-token manager
   To add a manager to this swarm, run the following command:
       docker swarm join --token SWMTKN-1-3sp9uxzokgr252u1jauoowv74930s7f8f5tsmm5mlk5oim359e-7tdlpdnkyfl1bnq34ftik9wxw 10.70.23.60:2377
   ```

9. 在各个node机器上执行第八条执行后的命令，使得所有node机器加入manager集群中

   ```shell
   docker swarm join --token SWMTKN-1-3sp9uxzokgr252u1jauoowv74930s7f8f5tsmm5mlk5oim359e-dk52k5uul50w49gbq4j1y7zzb 10.70.23.60:2377
   ## 执行上面的命令后提示下面的信息，表示加入node节点加入manager集群成功
   This node joined a swarm as a worker. 
   ```

10. 在manager上查看node节点是否成功加入集群环境中

   ```shell
   docker node ls
   ID                        HOSTNAME    STATUS  AVAILABILITY  MANAGER STATUS
   7zkbqgrjlsn8c09l3fagtfwre     node1  Ready      Active              
   a1tno675d14sm6bqlc512vf10 *   manager  Ready      Active         Leader
   apy9zys2ch4dlwbmgdqwc0pn3     node2  Ready      Active
   ```

11. 在manager上查看docker swarm的管理网络

    ```shell
    docker network ls
    NETWORK ID          NAME                DRIVER              SCOPE
    05efca714d2f        bridge              bridge              local
    c9cd9c37edd7        docker_gwbridge     bridge              local
    10ac9e48d81b        host                host                local
    n60tdenc5jy7        ingress             overlay             swarm
    a9284277dc18        none                null                local
    ```

12. 在manager机器上安装portainer

    ```shell
    docker service create \
    --name portainer \
    --publish 9000:9000 \
    --constraint 'node.role == manager' \
    --mount type=bind,src=//var/run/docker.sock,dst=/var/run/docker.sock \
    portainer/portainer \
    -H unix:///var/run/docker.sock

    docker images |grep portainer
    portainer/portainer  latest  07cde96d4789   2 weeks ago  10.4MB

    docker service ls                    ## 查看集群列表
    ID              NAME        MODE     REPLICAS      IMAGE             PORTS
    p5bo3n0fmqgz  portainer  replicated    1/1   portainer/portainer:latest   *:9000->9000/tcp
    ```

13. 在浏览器中输入ip:9000访问即可看到

![全站搜索示例图片](1516354296.jpg)