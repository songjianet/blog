---
title: MockJS在vue项目中的基本使用规则（包含增删改查）
date: 2019-02-11 20:55:15
updated: 2019-02-14 21:56:06
comments: true
categories:
- WEB前端
tags:
- vue
- axios
- MockJS
---

#### 基本介绍

​	在前端开发的过程中我们经常会遇到后端人员因为某些因素导致接口不能使用（例如：后端功能并为编写完成，后端接口出现bug等）。传统的方式是前端开发者去等待后端开发者去解决这些问题后再进行开发。但是这样不仅会大大增加前后端的依赖性，还会加大了开发成本。

​	这时，前端开发者回去思考，有没有什么东西能够去模拟后端的接口返回数据，并且在后端接口尚未编写完成时，使得前后端的依赖耦合降到最低。并且如果在后端接口报错的情况下，前端可以通过搭配axios访问一些看似真实的mock数据，将其展现在页面中。



#### mock基本语法

##### mock语法两层规范

- 数据模板（DTD）
- 数据占位符（DPD）

##### DTD规则

一个完整的DTD模板格式

```javascript
'name|rule': value
```

- name：属性名
- rule：属性规则
- value：属性值（属性值类型决定生成数据的类型）

七种属性规则

```javascript
'name|mix-max': value
'name|count': value
'name|mix-max.dmix-dmax': value
'name|min-max.dcount': value
'name|count.dmin-dmax': value
'name|count.dcount': value
'name|+step': value
```

属性值类型为String

```javascript
let data = Mock.mock({
    'name|1-3': 'a', // 随机生成a, aa, aaa中的一个
    'name1|2': 'b' // 生成bb
})
```

属性值类型为Number

```javascript
let data = Mock.mock({
    'name|+1': 4, // 初始值为4，每次循环自增1
    'name1|7-30': 0, // 生成一个7-30之间的数，其中0只是为了确定Number类型
    'name2|2-456.1-10': 0 // 生成一个整数在2-456之间的数，小数部分为1-10位，其中0只是为了确定Number类型
})
```

属性值类型为Boolean

```javascript
let data = Mock.mock({
    'name|1'： 'true'， // 生成true和false的概率各为1/2，其中true只是为了确定Boolean类型
    'name1|2-5'： 'true' // 生成true的概率为2/(2+5)，生成false的概率为5/(2+5)，其中true只是为了确定Boolean类型
})
```

属性值类型为Object

```javascript
const obj = {a: 1, b: 2, c: 3, d: 4, e: 5}
let data = Mock.mock({
    'name|2-4': obj, // 从obj中随机选择2-4个属性
    'name1|2': obj // 从obj中随机选择2个属性
})
```

属性值类型为Array

```javascript
const arr = [1, 2, 3, 4, 5]
let data = Mock.mock({
    'name|1': arr, // 从arr中随机选择一个值
    'name1|+1': arr, // 从arr中顺序选择一个值，第一次循环值为arr[0]的值，第二次为arr[1]的值
    'name2|1-3': arr // 基于arr重复生成1-3次，组合成新数组
})
```

属性值类型为Function

```javascript
const func = (x) => {return x + 10}
let data = Mock.mock({
    'name': func(77) // 得到func的返回值
})
```

属性值类型为RegExp

```javascript
let data = Mock.mock({
    'name': /[a-z][A-Z]/,
    'name1': /\d{1,3}/
})
```

##### DPD规则

​	DPD通过使用@标识符去生成一些固定类别的字符串类型的数据，例如生成姓名，句子或者一句话等。

```javascript
let data = Mock.mock({
    'name': '@province', // 省
    'name1': '@city', // 市
    'name2': '@county', // 县
    'name3': '@url', // url
    'name4': '@cname' // 姓名
})
```

<span style="color:red">
    *文章中列举的只是一小部分，完整使用方式请查阅
</span>[官方文档](http://mockjs.com/)。



#### 安装方式

1.通过npm安装

```shell
npm install mockjs
```

2.通过yarn安装

```shell
yarn add mockjs
```

3.通过bower安装

```shell
bower install mockjs
```

4.通过cdn方式引入

```html
<script src="http://mockjs.com/dist/mock.js"></script>
```

​	

#### 在vue项目中的使用

##### 创建及引入

​	在vue项目的src目录下面创建一个mock的文件夹，并在文件夹中创建一个mock.js的文件，并且在main.js中进行引入。

![1549892138375](1549892138375.jpg)



##### 编写基本的mock数据

​	首先我们要实现在vue项目下使用mock数据进行增删改查，就要先去使用规则生成一些数据。

```javascript
import Mock from 'mockjs'

let testData = Mock.mock({
	"user|1-4": [
		{
			'name': '@cname',
			'age|18-60': 0,
			'_id|+1': 0
		}
	]
})
```

​	对外暴露接口，使得能够通过axios来对接口。

```javascript
let getData = () => {
	return testData
}

Mock.mock('/api/getData', 'get', getData)
```



##### 通过GET请求mock数据

```vue
<script>
	export default {
		name: 'testMock',
		mounted() {
			this.getTestData()
		},
		methods: {
			getTestData () {
				this.axios.get('/api/getData')
						.then(res => {
							console.log(res)
						})
						.catch(err => {
							console.log(err)
						})
			}
		}
	}
</script>
```



##### 请求成功示例

![1550151804716](1550151804716.jpg)



#### 总结

​	文中对增删改查只列举了一个查询信息的例子，实际删除，修改，添加和我们实际与后台人员对接接口的逻辑是一样的，在这里就不在介绍了。