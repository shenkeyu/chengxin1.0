<%@ page language="java"  pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'login.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <script type="text/javascript">
 function change()
 { document.all.form1.method.value="regist"}
  
  
  </script>
  <body>
    <%
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian.equals("综合计划处")){
System.out.println("管理成功！");
}else{
System.out.println("管理失败！");
out.println("<script>window.alert('没有管理权限');window.location.href='"+basePath+"zhenhuaindex.html';</script>");
};
%>
    <form id="form1" name="form1" method="post" action="UserServlet">
    <input name="method" type="hidden" value="login" />
  <table width="400" border="1" align="center">
    <tr>
      <td width="100" height="32">用户名：</td>
      <td width="213"><input name="username" type="text" id="username" /></td>
    </tr>
    <tr>
      <td height="31">密码：</td>
      <td><input name="password" type="text" id="password" /></td>
    </tr>
    <tr>
      <td height="31"><label>
        <input type="submit" name="login" value="登陆" />
        <input type="submit" name="regist" value="注册" onclick="change()" />
      </label></td>
      <td><label>
        <input type="reset" name="reset" value="重置" />
      </label></td>
    </tr>
  </table>
</form>
  </body>
</html>
