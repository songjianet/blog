---
title: vue使用钩子函数做路由鉴权
date: 2018-08-09 16:35:35
updated: 2018-08-09 17:20:00
comments: true
categories:
- WEB前端
tags:
- vue
- vue-router
- 钩子函数
---

一般情况下，在用户未登录的时候我们一些功能是不能让用户使用的，当我们点击这些连接的时候会跳转到登陆的页面，当用户登陆后才能够进行操作，这个功能我们简称路由鉴权，在vue中我们使用路由鉴权，需要使用vue的钩子函数以及vue-router路由管理。

##### 1.全局引入vue-router

```shell
npm install vue-router
```

##### 2.路由文件配置

在vue项目中的src目录下，新建router文件夹，并创建一个index.js的文件。

![1533804813](/blog/vue使用钩子函数做路由鉴权/1533804813.jpg)

##### 3.vue-router文件编写

```typescript
import Vue from 'vue' // 导入vue
import VueRouter from 'vue-router' // 导入vue-router
import Menu1 from '@/components/menu1' // 导入一个组建
import Menu2 from '@/components/menu2'
import Login from '@/components/login'
import UpdateUserInfo from '@/components/updateUserInfo'
Vue.use(VueRouter) // 使用vue-router
export default new VueRouter({
  routes: [
    // 设置起始页面重定向
    {
      path: '/',
      redirect: '/Menu1',
      name: '主页'
    },
    {
      path: '/Menu1',
      name: 'Menu1',
      component: Menu1
    },
    {
      path: '/Menu2',
      name: 'Menu2',
      component: Menu2
    },
    {
      path: '/Login',
      name: 'Login',
      component: Login
    },
    {
      path: '/UpdateUserInfo',
      name: 'UpdateUserInfo',
      component: UpdateUserInfo,
      meta: {
        requireAuth: true // 路由鉴权
      }
    }
  ]
})
```

##### 4.登录功能

我在这里请求的时候跟后端代码并非同源，所以涉及到了跨域的问题，正常情况下，想做路由鉴权测试可以直接将登陆的用户名和密码写死。

```vue
<template>
	<div>
        <label>账号</label>
        <Input v-model="userInfo.userName"/>
        <label>密码</label>
        <Input v-model="userInfo.password"/>
        <label>验证码</label>
        <Input v-model="userInfo.code"/>
        <Button type="primary" @click="doLogin">登 录</Button>
	</div>
</template>
<script>
    export default {
        name: 'login',
        data () {
            return {
                userInfo: {
                    userName: '',
                    password: '',
                    code: ''
                }
            }
        },
        methods: {
            doLogin () {
      if (this.userInfo.userName === '') {
        alert('用户名不能为空')
        return false
      }
      if (this.userInfo.password === '') {
        alert('密码不能为空')
        return false
      }
      if (this.userInfo.code === '') {
        alert('验证码不能为空')
        return false
      }
      fetch(`/api/user/login?mobile=${this.userInfo.userName}&password=${this.userInfo.password}&code=${this.userInfo.code}`, {
                  method: 'get',
                  // 允许跨域cookies
                  credentials: 'include'
              })
              .then(function (res) {
                  if (res.status === 200) {
                      res.json().then(data => {
                          window.localStorage.setItem('hhh', data.userInfo.mobile)
                          sessionStorage.setItem('hhh', data.userInfo.mobile)
                      })
                  } else {
                  }
              })
              this.$store.commit('setLogin', this.userInfo) // 提交store，在使用路由鉴权时候可以省略
              this.$router.push('/') // 路由跳转
            }
        }
    }
</script>
```

##### 5.main.js文件编写钩子函数

```typescript
import router from './router' // 引入我们的vue-router文件
new Vue({
  el: '#app',
  router, // 全局配置router
  store,
  components: {App},
  template: '<App/>'
})

// 登录路由鉴权
router.beforeEach((to, from, next) => {
  // 判断要去的路由界面是不是要鉴权
  if (to.matched.some(res => res.meta.requireAuth)) { // 指向路由配置中的requireAuth: true
  // 查看是否登陆
    let user = sessionStorage.getItem('hhh')
    if (user === null) {
      // 没登录的做处理
      alert('请先登录')
      next({
        path: '/Login'
      })
    } else {
      // 登陆的正常跳
      next()
    }
  } else {
    // 不需要鉴权的正常跳
    next()
  }
})
```

##### 6.效果展示

![666](/blog/vue使用钩子函数做路由鉴权/666.gif)
