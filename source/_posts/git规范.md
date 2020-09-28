---
title: Git规范
date: 2019-11-29 08:50:04
updated: 2019-12-11 10:18:53
categories:
- Git
tags:
- git
---

#### <a style="color: #4078c0;">导读</a>

> 为了避免歧义，文档大量使用了「能愿动词」，对应的解释如下：
>
> - **必须**（Must） - 只能这样子做，请无条件遵循，没有别的选项；
> - **绝不**（Must Not）- 严令禁止，在任何情况下都不能这样做；
> - **应该**（Should） - 强烈建议这样做，但是不强求；
> - **不应该**（Should Not） - 强烈建议不这样做，但是不强求；
> - **可以**（May） - 选择性高一点
>
> 参考：[RFC 2119](https://www.ietf.org/rfc/rfc2119.txt)



#### <a style="color: #4078c0;">branch</a>

##### 长期分支

- master —— 主分支，**必须**也是线上最新代码的分支。

- dev —— 开发人员的基础分支，所有的开发功能分支（feat）都**必须**从dev分支上进行拉取，同时也**必须**合并到dev分支。

- test —— 测试分支，需要将dev分支合并到测试分支，进行功能的测试，如果没有问题，再将test分支合并到dev上，进行新功能的上线。

##### 短期分支

- hotfixes —— 紧急分支，用于修改master分支上的错误，修改后**必须**将此分支合并到master和dev分支。
- feature —— 功能分支，功能分支**必须**从dev分支切出，完成后提交pr，review后**必须**合并到dev。
- fix —— bug分支，用与修改非生产环境出现的bug。

##### 分支规范

###### feature分支

feature分支命名**必须**遵循feat-{yourname}/{featurename}#{issues}

###### hotfixes分支

hotfixes分支命名**必须**遵循hotfix-{yourname}/{hotfixname}#{issues}

###### fix分支

fix分支命名**必须**遵循fix-{yourname}/{fixname}#{issues}

<p style="color: red;">*注：</p>
- yourname —— 姓名
- featurename —— 功能分支名
- hotfixes —— 紧急分支名
- fix —— bug分支名
- issues —— 对应的issues，如果存在就写



#### <a style="color: #4078c0;">commit</a>

##### commit分类

- feat —— 功能，feat: 添加登陆功能
- fix —— bug，fix: 修改登录接口错误
- hotfix —— 紧急，hotfix: 修改生产环境登录接口错误
- docs —— 文档，docs: 修改README
- style —— 不影响代码含义的更改（空格、格式、缺少分号等）style: 删除空格，删除console
- perf —— 提高性能的代码更改 perf: 优化打包后的文件大小
- test —— 添加缺失测试或纠正现有测试 test: 添加对什么方法为0的单元测试
- build —— 影响生成系统或外部依赖项的更改（示例范围：gulp、broccoli、npm）build: 修改webpack打包配置 / build: 添加js-cookies包
- ci —— 对CI配置文件和脚本的更改 ci: 修改xxx.yaml文件
- chore —— 其他不修改src或测试文件的更改，如在根目录下的其他文件 chore: 修改时间格式化函数
- refactor —— 既不修复错误也不添加功能的代码更改 refactor: 添加.gitignore
- revert —— 还原以前的提交 revert: #62



#### <a style="color: #4078c0;">pull request</a>

- pr**必须**提交到dev分支，并由组长或项目管理人员进行review后没有问题进行合并
- pr遇到冲突时，**必须**应该自己解决
- pr**应该**简述功能信息



#### <a style="color: #4078c0;">merge</a>

- dev分支

  代码通过提交pr（同时写明信息）后，**必须**有至少一个人进行review，review后没有问题可以合并到dev分支

- hotfix分支

  代码应从master分支切出，修改完成后**必须**提交两个pr分别到master和dev，在reviewer审查没问题后合并到master和dev

- fix分支

  代码从dev分支切出，在修改完成后**必须**提交pr（同时写明信息）后，在reviewer审查没问题后合并到dev

- feat分支

  代码从dev分支切出，在功能完成后**必须**提交pr（同时写明信息）后，在reviewer审查没问题后合并到dev

- test分支

  代码**必须**从dev分支合并进来

  

#### <a style="color: #4078c0;">tag</a>

格式：vx.y.z，如v1.0.0。其中x代表主版本号，y代表次版本号，z代表补丁号

如果只修改了bug则对z进行加一

新增功能，向下兼容，没有删除功能对y进行加一

不向下兼容，删除功能对x进行加一

- master分支

  master分支在每次更新生产环境时**必须**打tag，同时**应该**标注出基本信息




#### <a style="color: #4078c0;">注意事项</a>

- **绝不**能直接提交代码到master，dev，test分支
- **必须**有一个reviewer
- 合并到master和test应由reviewer进行
- 除master，dev，test分支，其他所有分支**应该**在使用完成后进行销毁删除