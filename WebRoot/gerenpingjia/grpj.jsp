<%@ page contentType="text/html; charset=gb2312"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
#namess{
border: none;
height:30px;
width:200px;
font-size:24px;
}
</style>



<title>振华诚信信息管理系统</title>
</head>

<%
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian!=""||quanxian!=null){
System.out.println("可以查询！");
System.out.println(quanxian);
}else{
System.out.println("查询失败！");
out.println("<script>window.location.href='../jieguo/error.jsp';</script>");
};


     session.setAttribute("kahaopjcha", "");
     session.setAttribute("jifenpjcha", "");
%>

<body onload="javascript:document.getElementById('kahaocha').focus();">
<%if(quanxian.equals("人力资源部")||quanxian.equals("QHSE部")){
System.out.println("可以显示界面！");
%>
<form name="formcha" target="neirong" action="grpjmain.jsp">
<div style="margin-top:13px;margin-left:20px;">
ID卡号：<input type="text" id="kahaocha" name="kahaocha">
计分规则： <input type="text" id="jifencha" name="jifencha">
<img src="../image/gerenxinyong/btnsousuo.png" alt="搜索" style="height:30px;width:50px;vertical-align:middle;cursor:pointer;" onclick="javascript:formcha.submit();"/>
</div>
</form>

<iframe src="grpjmain.jsp" id="neirong"  name="neirong"  marginheight="0" marginwidth="0"  scrolling="no" frameborder="0" style="margin-top:13px;margin-left:20px;width:100%;height:900px"> </iframe>

<% }else{
System.out.println("不可以显示界面！");
out.println("<b>无查询权限</b>");
};%>
</body>
</html>


