<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
		<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
		
		<!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
		
		<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
		<meta charset="utf-8" />
</head>
<body>

	<form  action="update.do" method="post">
		<div align="left">
			学号：<input id="xh" name="xh" type="text" readonly="readonly" value="${students.xh }" /><br/>
			姓名：<input id="name" name="name" type="text" value="${students.name }"/><br/>
			年龄：<input id="age" name="age" type="text" value="${students.age }"/><br/>
			
			性别：<select name="sex" id="sex">
					<option value="男" <c:if test="${students.sex eq '男' }">selected="selected"</c:if>>男</option>
					<option value="女" <c:if test="${students.sex eq '女' }">selected="selected"</c:if>>女</option>
				</select><br/>
				
			生日：<input id="birthday" name="birthday" type="text" value='<fmt:formatDate value="${students.birthday}" pattern="yyyy-MM-dd"></fmt:formatDate>'/><br/>
			地址：<input id="address" name="address" type="text" value="${students.address }"/><br/>
			电话：<input id="tel" name="tel" type="text" value="${students.tel }"/><br/>
		<button type="submit" >提交</button>
		</div>
	</form>
</body>
</html>