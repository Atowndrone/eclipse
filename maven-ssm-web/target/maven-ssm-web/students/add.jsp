<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form  action="add.do" method="post">
	<div align="left">
	学号：<input id="xh" name="xh" type="text"/><br/>
	姓名：<input id="name" name="name" type="text"/><br/>
	年龄：<input id="age" name="age" type="text"/><br/>
	
	性别：<select name="sex" id="sex">
			<option value="男">男</option>
			<option value="女">女</option>
		</select><br/>
	生日：<input id="birthday" name="birthday" type="date"/><br/>
	地址：<input id="address" name="address" type="text"><br/>
	电话：<input id="tel" name="tel" type="text"><br/>
	<button type="submit" >提交</button>
	</div>
	</form>
	
</body>
</html>