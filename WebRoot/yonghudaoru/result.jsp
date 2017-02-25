<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>用户导入结果</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">


  </head>
  
  <body>
 		 <div style="margin-left:40px;margin-top:25px;width:800px;font-size:30px">
<img src="../image/menu/award_star.png" alt="用户增加" style="height:30px;width:30px;vertical-align:middle;"/>
  ${requestScope.message }
  <br>
  <br>
  <a href="fileread。jsp" style="width:200px;font-size:18px;">&nbsp;返回用户录入&nbsp;</a>
   		 </div>
  </body>
</html>
