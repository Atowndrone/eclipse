<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
		<link rel="stylesheet" href="css/customPage.css">
		<link rel="stylesheet" href="css/bootstrap.min.css" >
		<script type="text/javascript" src="js/bootstrap.min.js" ></script>
		<script type="text/javascript" src="js/bootstrap-paginator.min.js" ></script>
		<script type="text/javascript" src="js/customPage.js"></script>
		<meta charset="utf-8" />
		
<script type="text/javascript">
	$(function(){
		$("#div").html("文档就绪函数已启动！");
		
		$("#button").click(function(){
			//alert("删除成功！");
			var obj = $("input[name='chbox']");/* 通过name的值来获取input标签的行数 */
			var check_ed = [];/* 定义一个数组用来接收选中的复选框所在行的编号 */
			//alert(obj.length);
			for(i=0;i<obj.length;i++){/* 遍历所有的行号 */
				if(obj[i].checked){/* 判断被选中的行号 */
					//alert(obj[i].value);
					check_ed.push(obj[i].value);/* 将选中的行号填充到数组 */
					//alert(check_ed);
				}
			}
			/* 删除选中的复选框 */
			$("input[name='chbox']:checked").each(function(){
				/*var n = $(this).parents("tr[name='delMore']").index(); 将选中的行号赋值给变量n */
				/* 当表格使用了thead后者tbody，$(this).parents("tr")会获取到thead里面的tr，也就是会删除表头
				使用id定位tr同样会删除表头，使用name定位tr同样会删除，也就说使用标签定位同样会删除表头。只能去掉表头和表体*/
				/* $("table#main-tab").find("tr:eq("+n+")").remove();通过表单批量删除选中的行号 */
				var n = $(this).parent().parent();/* 此方法就是直接获取input标签的父标签的父标签 */
				n.remove();/* 然后直接移除input标签的父标签的父标签，也就是tr,这样就不会移除表头，即使有表头和标体的存在。 */
			});
			var selected=JSON.stringify(check_ed);
			$.post("delMore.do",{"check_ed":selected},function(data){
				 if(data>0){
					 alert("删除成功！"+data);
				 }else{
					 alert("删除失败！请联系管理员！");
				 }
			 },"json");
			
			/* 传统的ajax方式 */
			//var req = new XMLHttpRequest();/* 创建异步对象 */
			//var url = "del.do?num="+selected;
			//req.open("post",url,true);/* 指定与服务器连接请求的类型，URL路径，（true）异步方式 */
			//alert("异步");
			//req.setRequestHeder("Content-Type","application/x-www-form-urlencoded;charset=UTF-8");/* 设定Content-Type头信息，模拟HTTP POST方法发送一个表单 */
			//req.send();/* 发送请求 */
			//alert("异步");
			//req.onreadystatechange = function(){/* 设置回调函数（每次状态改变的响应事件） */
				//if(req.readystate==4&&req.status==200){/* 判断异步对象的状态（4表示发送完毕）和服务器返回字符串值（200表示就绪） */
					//var data = req.responseText;/* 获取回服务器响应的字符串值 */
					//alert(data);
				//}
			//}
		});
		/* 添加按钮事件 */
		$("input[id='add']").click(function(){
			$("button[id='add']").click();/* 调用模态框事件方法 */
	    });
		/* 添加模态框添加事件 */
		$("button[id='add']").click(function(){
	    	   //alert("添加");
	    });
		/* 修改事件 */
		$("input[id='update']").click(function(){
			alert("修改");
			var n;
			var obj=$("input[name='chbox']:checked");
			//alert(obj.length);
			if(obj.length==1){
				n=obj[0].value;
				alert(n);
			}else{
				alert("请选择一条信息修改！");
				}
			$.post("asynchronous.do",{"operate":n},function(data){
				$("input[id='upxh']").val(data.xh);
				$("input[id='upname']").val(data.name);
				$("input[id='upage']").val(data.age);
				$("input[id='upsex']").val(data.sex);
				var dat=data.birthday;
				var date = new Date(dat);//创建时间对象，不给时间戳默认为当前系统时间
				var Y = date.getFullYear() + '-';//获取年份
				var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';//获取月份
				var D = date.getDate() + '';//获取日期
				var birthday=Y+M+D;//拼接年月日
				$("input[id='upbirthday']").val(birthday);
				$("input[id='upaddress']").val(data.address);
				$("input[id='uptel']").val(data.tel);
				
				alert(data.name);
				/* 调用模态框激活按钮 */
				$("button[id='update']").click();
				
			},"json");
		});
		/* 激活模态框按钮 */
		$("button[id='update']").click(function(){
			
		});
		//百度分页
		$.post("show1.do",null,function(data){
			//alert(data[0].xh);
			var page = $(".page").CustomPage({
	            pageSize: 5,
	            count: data.length,
	            current: 1
	        });
			
		},"json");
		
		
	});

</script>
</head>
<body>
	
	<!-- 表格 -->
		<div class="container">
			<table id="main-tab" class="table table-bordered">
						<!-- 表头 -->
						<thead>
							<tr >
								<td><input id="button" type="button" value="删除多项"></input>
									<!-- <a href="sutdents/add.jsp">添加</a> -->
									<input id="add" type="button" value="添加" >
									<input id="update" type="button" value="修改" >
								</td>
								<td>学号</td>
								<td>姓名</td>
								<td>年龄</td>
								<td>性别</td>
								<td>出生日期</td>
								<td>地址</td>
								<td>电话</td>
								<td>年级</td>
							</tr>
						</thead>
						<!-- 表体 -->
						<tbody>
							<c:forEach items="${pageInfo.list}" var="students">
								<tr name="delMore" >
									<td><input id="chbox" name="chbox" type="checkbox" value="${students.xh}"/>
									<a href="del.do?operate=${students.xh}" >删除</a>
									<a href="singleFind.do?operate=${students.xh}">修改</a>
									</td>
									<td value="${students.xh }" >${students.xh }</td>
									<td value="${students.name }" >${students.name }</td>
									<td value="${students.age }">${students.age }</td>
									<td value="${students.sex }">${students.sex }</td>
									<td value=""><fmt:formatDate value="${students.birthday}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
									<td value="${students.address }">${students.address }</td>
									<td value="${students.tel }">${students.tel }</td>
									<td value="${students.gid }">${students.gid }</td>
								</tr>
							</c:forEach>
						</tbody>
			</table>
		</div>
		 <!-- 添加模态框容器 -->
		 
		<div class="container">
		<button type="button" class="btn btn-success" data-toggle="modal" 
		 data-target="#popUpWindow" id="add"  style="display:none" >Click me!</button>
		 <div class="modal fade" id="popUpWindow">
			 <div class="modal-dialog">
				 <div class="modal-content">
					 <!-- header -->
					 <div class="modal-header">
						 <!-- 右上角的x关闭 -->
						 <button type="button" class="close" 
						 data-dismiss="modal" >&times;</button>
						 <h3 class="modal-title">Login</h3>
					 </div>
					<!--  body -->
					 <div class="modal-body">
						 <form role="form" action="add.do" method="post">
							 <div class="form-group">
							 	<input name="xh" type="text" class="form-control" placeholder="学号" >
							 </div>
							 <div class="form-group">
								 <input name="name" type="" class="form-control" placeholder="姓名" >
							 </div>
							 <div class="form-group">
								 <input name="age" type="text" class="form-control" placeholder="年龄" >
							 </div>
							 <div >
								 <select name="sex" class="form-control" id="sex">
								 	<option class="form-control" value="" selected="selected" >性别</option>
									<option class="form-control" value="男">男</option>
									<option value="女">女</option>
									
								</select><br/>
							 </div>
							 <div class="form-group">
								 <input name="birthday" type="date" class="form-control" placeholder="出生日期" >
							 </div>
							 <div class="form-group">
								 <input name="address" type="text" class="form-control" placeholder="地址" >
							 </div>
							 <div class="form-group">
								 <input name="tel" type="text" class="form-control" placeholder="电话" >
							 </div>
							 <div class="form-group">
							 	<select name="gid" class="form-group" >
										<option class="form-group" value ="1">1</option>
										<option class="form-group" value ="2">2</option>
										<option class="form-group" value ="3">3</option>
										<option class="form-group" value ="4">4</option>
									</select>
							 </div>
							 
							 <div class="modal-footer">
							 	<button class="btn btn-primary" type="reset">重置</button>
								<button class="btn btn-primary" type="submit">提交</button>
							</div>
						 </form>
					 </div>
					<!--  footer -->
				 </div>
			 </div>
		 </div>
	</div>

	<!-- 修改模态框容器 -->
		<div class="container">
		<!-- 激活模态框按钮 -->
		<button type="button" class="btn btn-success" data-toggle="modal" 
		 data-target="#updateWindows" id="update"  style="display:none" >Click me!</button>
		<!-- data-target用于引起id="popUpWindow"的div -->
		 <div class="modal fade" id="updateWindows">
			 <div class="modal-dialog">
				 <div class="modal-content">
					 <!-- header -->
					 <div class="modal-header">
						 <!-- 右上角的x关闭 -->
						 <button type="button" class="close" 
						 data-dismiss="modal" >&times;</button>
						 <h3 class="modal-title">Login</h3>
					 </div>
					<!--  body -->
					 <div class="modal-body">
						 <form role="form" action="update.do" method="post">
							 <div class="form-group">
							 	<input name="xh" id="upxh" readonly="readonly" type="text" class="form-control" placeholder="xuhao" >
							 </div>
							 <div class="form-group">
								 <input name="name" id="upname" type="text" class="form-control" placeholder="姓名" >
							 </div>
							 <div class="form-group">
								 <input name="age" id="upage" type="text" class="form-control" placeholder="年龄" >
							 </div>
							 <div >
								 <select name="sex" id="upsex" class="form-control" id="sex">
								 	<option class="form-control" value="" selected="selected" >性别</option>
									<option class="form-control" value="男" <c:if test="${students.sex eq '男' }">selected="selected"</c:if>>男</option>
									<option value="女" <c:if test="${students.sex eq '女' }">selected="selected"</c:if> >女</option>
									
								</select><br/>
							 </div>
							 <div class="form-group">
								 <input name="birthday" id="upbirthday" type="text" class="form-control" placeholder="出生日期" value="" >
							 </div>
							 <div class="form-group">
								 <input name="address" id="upaddress" type="text" class="form-control" placeholder="地址" >
							 </div>
							 <div class="form-group">
								 <input name="tel" id="uptel" type="text" class="form-control" placeholder="电话" >
							 </div>
							 
							 <div class="modal-footer">
							 	<button class="btn btn-primary" type="reset">重置</button>
								<button class="btn btn-primary" type="submit">提交</button>
							</div>
						 </form>
					 </div>
					<!--  footer -->
				 </div>
			 </div>
		 </div>
	</div>

<nav align="center" aria-label="Page navigation">
  <ul class="pagination">
    <li>
      <a href="show.do?pageNum=${pageInfo.prePage==0?1:pageInfo.prePage }" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    <!-- 第一页 -->
    <li><a href="show.do?pageNum=${(pageInfo.pageNum>3?((pageInfo.pageNum-2)>=(pageInfo.pages-4)?(pageInfo.pages-4):pageInfo.pageNum-2):1)}">
    <!-- 如果下一页大于3，那么就是当前页，否则就是第一页 ；如果当前页大于-->
    <!-- 如果当前页大于总页数减4，那么当前页就是总页数减4；否则当前页就是当前页减2 -->
    ${(pageInfo.pageNum>3?((pageInfo.pageNum-2)>=(pageInfo.pages-4)?(pageInfo.pages-4):pageInfo.pageNum-2):1)}</a></li>
    <!-- 第二页 -->
    <li><a href="show.do?pageNum=${(pageInfo.pageNum>3?((pageInfo.pageNum-1)>=(pageInfo.pages-3)?(pageInfo.pages-3):pageInfo.pageNum-1):2)}">
    ${(pageInfo.pageNum>3?((pageInfo.pageNum-1)>=(pageInfo.pages-3)?(pageInfo.pages-3):pageInfo.pageNum-1):2)}</a></li>
    <!-- 第三页 -->
    <li><a href="show.do?pageNum=${(pageInfo.pageNum>3?((pageInfo.pageNum)>=(pageInfo.pages-2)?(pageInfo.pages-2):pageInfo.pageNum):3)}">
    ${(pageInfo.pageNum>3?((pageInfo.pageNum)>=(pageInfo.pages-2)?(pageInfo.pages-2):pageInfo.pageNum):3)}</a></li>
    <!-- 第四页 -->
    <li><a href="show.do?pageNum=${(pageInfo.pageNum>3?((pageInfo.pageNum+1)>=(pageInfo.pages-1)?(pageInfo.pages-1):pageInfo.pageNum+1):4)}">
    ${(pageInfo.pageNum>3?((pageInfo.pageNum+1)>=(pageInfo.pages-1)?(pageInfo.pages-1):pageInfo.pageNum+1):4)}</a></li>
	<!-- 第五页 -->   
    <li><a href="show.do?pageNum=${(pageInfo.pageNum>3?((pageInfo.pageNum+2)>=(pageInfo.pages)?(pageInfo.pages):pageInfo.pageNum+2):5)}">
    ${(pageInfo.pageNum>3?((pageInfo.pageNum+2)>=(pageInfo.pages)?(pageInfo.pages):pageInfo.pageNum+2):5)}</a></li>
    <li>
      <a href="show.do?pageNum=${pageInfo.nextPage>0?pageInfo.nextPage:pageInfo.navigateLastPage}" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>
<!-- <div class="page"></div> -->
</body>
</html>