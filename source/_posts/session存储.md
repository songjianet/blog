---
title: session存储
date: 2018-05-15 14:28:04
updated: 2018-05-15 17:05:58
comments: true
categories:
- Java
tags:
- java
- jsp
- js
---

在WEB开发中，服务器可以为每个用户浏览器创建一个会话对象（session对象），注意：一个浏览器独占一个session对象（默认情况下）。因此，在需要保存用户数据时，服务器程序可以把用户数据写到用户浏览器独占的session中，当用户使用浏览器访问其它程序时，其它程序可以从用户的session中取出该用户的数据，为用户服务。 

##### 导入依赖包

```java
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
```

##### 使用request 获取session

HttpSession是不能new出来的，要从HttpServletRequest中调用getSession方法得到。一般也就是request.getSession(); 

```java
HttpSession session = request.getSession();
```

##### 对session的操作

```java
session.setAttribute("key", value); // 设置
session.getAttribute("key"); // 获取
session.removeAttribute("key"); // 移出
session.invalidate(); // 删除所有session中保存的键
```

##### jsp中获取session

```jsp
<%= session.getAttribute("key") %>
```

##### 后台示例

```java
@ResponseBody
@RequestMapping(value = "/getBigDatalist.action", method = RequestMethod.POST)
public AjaxBean getBigDatalist(Integer page,HttpServletResponse response, HttpServletRequest request) {
    response.setCharacterEncoding("UTF=8"); // 设置响应的编码方式
    response.setContentType("text/html;charset=UTF-8"); // 设置响应的内容类型
    HttpSession session = request.getSession(); // 创建一个session对象
    Page<dashujvBean> list = service.getBigDatalist(new RowBounds(page, 10));
    session.setAttribute("pageSize", list.getPageSize());
    long count = list.getTotal();
    ajaxBean = new AjaxBean();
    ajaxBean.setSuccess(true);
    ajaxBean.setData(list);
    ajaxBean.setCount(count);
    return ajaxBean;
}
```