---
title: ssm通过poi导出word
date: 2018-02-28 11:25:13
updated: 2018-05-15 11:22:04
comments: true
categories:
- Java
tags:
- ssm
- poi
---

应公司开发项目的需求，需要编写一个，通过前台传入的id查询数据库中的title和abs字段的信息，以word的形式下载到本地进行查看。这里我通过poi的方式进行数据封装word，同时进行word排版，最后进行下载。在后续的开发中可能回遇到下载成excal表格，到时候我会定期更新。

```java
@RequestMapping(value ="/downloadforreport.action")
public void xiazaiword(HttpServletResponse response){
	try{
		XWPFDocument doc = new XWPFDocument(); // 创建一个word文档
		XWPFParagraph p1 = doc.createParagraph(); // 创建一个段落为p1
		p1.setAlignment(ParagraphAlignment.CENTER); // p1段落内容设置居中
		XWPFParagraph p2 = doc.createParagraph(); // 创建另一个段落为p2
		XWPFRun r1 = p1.createRun(); // 为p1段落创建文本内容r1
		r1.setText("hahahaha"); // 为r1设置内容
		r1.setFontSize(20); // r1字体大小为20
		r1.setBold(true); // r1字体加粗
		XWPFRun r2 = p2.createRun(); // 为p2段落创建文本内容r2
		r2.setText("xixixixixi"); // 为r2设置内容
		response.setCharacterEncoding("utf-8"); // 设置编码格式
		response.setContentType("multipart/form-data"); // java中通用下载文件
		response.setHeader("Content-Disposition", "attachment;fileName=downfile.docx" ); // 设置文件头和文件名
		OutputStream out = response.getOutputStream(); // 创建一个输出流
		doc.write(out); // 开始写入
		out.close(); // 关闭输出流
	}catch(Exception e){
		e.printStackTrace();
	}
}
```

<br>

接下来通过浏览器访问方法名进行测试

<br>

![测试方法是否成功](/blog/images/ssm通过poi导出word/64dd3ac9ad9c294b849b31d1e1f5f724.png)

<br>

对于其它word的格式设置，可以百度”poi导出word“相关文章进行查看。
