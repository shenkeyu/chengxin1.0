<%@ page language="java"  pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'fileread.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <%
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian.equals("综合计划处")){
System.out.println("管理成功！");
}else{
System.out.println("管理失败！");
out.println("<script>window.alert('没有管理权限');window.location.href='"+basePath+"zhenhuaindex.html';</script>");
};
%>
  <body>
    <form action="readfile" method="post" enctype="multipart/form-data">
  <label></label>
  <label></label>
  <table width="417" border="1">
    <tr>
      <td width="121" height="27">选择读取文件</td>
      <td width="280"><label>
        <input type="file" name="file"  value="浏览"/>
      </label></td>
    </tr>
    <tr>
      <td><label>
        <input type="submit" name="Submit" value="提交" />
      </label></td>
      <td><label>
        <input type="reset" name="Submit2" value="重置" />
      </label></td>
    </tr>
  </table>
</form>
  </body>
</html>
