---
title: CentOS6.9下对MySQL5.7的用户权限管理
date: 2018-04-17 8:39:24
updated: 2018-05-15 11:02:34
comments: true
categories:
- Linux
tags:
- CentOS6.9
- MySQL5.7
- MySQL权限分类
- MySQL5.7权限分配
---

在实际开发中的很多情况下，我们不免要对数据库根据用户的不同进行权限的分配。在MySQL数据库中，基本有28种权限，我们可以将其归类成三大类的权限。

#### MySQL的权限分类

##### 一）数据操作类

 <div class="table-responsive"><table class="table table-striped table-bordered table-hover"><tr><td>操作</td><td>含义</td></tr><tr><td>SELECT</td><td>查询权限</td></tr><tr><td>INSERT</td><td>插入权限</td></tr><tr><td>UPDATE</td><td>更新权限</td></tr><tr><td>DELETE</td><td>删除数据权限</td></tr><tr><td>FILE</td><td>文件访问权限</td></tr></table></div>

##### 二）结构操作类

<div class="table-responsive"><table class="table table-striped table-bordered table-hover"><tr><td>操作</td><td>含义</td></tr><tr><td>CREATE</td><td>创建数据库、表或索引权限</td></tr><tr><td>ALTER</td><td>更改表权限（添加字段或者索引等）</td></tr><tr><td>INDEX</td><td>索引权限</td></tr><tr><td>DROP</td><td>删除数据库或表权限</td></tr><tr><td>CREATE TEMPORARY TABLES</td><td>创建临时表权限</td></tr><tr><td>SHOW VIEW</td><td>查看视图权限</td></tr><tr><td>CREATE ROUTINE</td><td>创建存储过程权限</td></tr><tr><td>ALTER ROUTINE</td><td>更改存储过程权限</td></tr><tr><td>EXECUTE</td><td>执行存储过程权限</td></tr><tr><td>CREATE VIEW</td><td>创建视图权限</td></tr><tr><td>EVENT</td><td>可在数据下创建时间调度器权限</td></tr><tr><td>TRIGGER</td><td>可在数据下创建触发器权限</td></tr></table></div>

##### 三）管理操作类

<div class="table-responsive"><table class="table table-striped table-bordered table-hover"><tr><td>操作</td><td>含义</td></tr><tr><td>GRANT</td><td>赋予权限选项</td></tr><tr><td>SUPER</td><td>执行kill线程权限</td></tr><tr><td>PROCESS</td><td>查看进程权限</td></tr><tr><td>RELOAD</td><td>执行flush-hosts，flush-logs等权限</td></tr><tr><td>SHUTDOWN</td><td>创建临时表权限</td></tr><tr><td>SHOW DATABASES</td><td>关闭数据库权限</td></tr><tr><td>LOCK TABLES</td><td>可对其下所有表进行锁定权限</td></tr><tr><td>REFERENCES</td><td>未来MySQL特性的占位符</td></tr><tr><td>REPLICATION CLIENT</td><td>复制权限</td></tr><tr><td>REPLICATION SLAVE</td><td>复制权限</td></tr><tr><td>CREATE USER</td><td>创建用户权限</td></tr></table></div>



#### MySQL的权限操作（以root用户登录到数据库进行操作）

##### 一）创建用户

```shell
> CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
> CREATE USER 'username1'@'%' IDENTIFIED BY 'password1';
```

注：

username为用户名

password为用户密码

localhost只允许在本机登录数据库

%任何一台电脑上都可以远程登陆

##### 二）受理权限

```shell
> GRANT privileges ON databasename.tablename TO 'username'@'localhost';
```

注：

privileges为用户操作权限，例如select等，如果需要所有权限直接写all

databasename为数据库名，给某个用户访问某个数据库的权限，如果给某个用户所有库的访问权限可以用*表示

tablename为表名，如果为某个库下的所有表可以用*号表示

##### 三）撤销用户权限

```shell
> REVOKE privilege ON databasename.tablename FROM 'username'@'localhost';
```

##### 四）删除账号及权限

```shell
> REVOKE privilege ON databasename.tablename FROM 'username'@'localhost';
```

##### 五）查看用户的权限信息

```shell
> SHOW GRANTS FOR 'username'@'localhost';
```
##### 六）刷新权限操作

这里我需要着重的强调一下，如果使用delete对数据库用户删除后需要执行一遍刷新flush privileges;否则会报有1396错误；建议还是使用drop等相关命令进行做删除用户操作。

```shell
> flush privileges;
```