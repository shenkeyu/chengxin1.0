<%@ page language="java" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'SendMail.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
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
    <form action="SendMail" enctype="multipart/form-data" method="post">
    <table cellspacing="2" cellpadding="2" border="0">      
      <tr><td>收件人</td><td>
          <input type="text" name="to" size="30"></td>
      </tr>
      <tr>
        <td>发件人</td>
        <td>
          <input type="text" name="from" size="30">        </td>
      </tr>
      <tr>
        <td>主题</td>
        <td>
          <input type="text" name="subject" size="30">        </td>
      </tr>
       <tr>
        <td>附件</td>
        <td>
          <input type="file" name="attachment" size="30">        </td>
      </tr>
      <tr>
      <td>正文</td>
        <td><textarea cols="50" rows="15" name="body"></textarea></td>
      </tr>
      <tr>
      <td></td>
        <td>
          <input type="submit" value="提交">
          <input type="reset" value="重置">        </td>
      </tr>
    </table>
  </form>
  </body>
</html>
