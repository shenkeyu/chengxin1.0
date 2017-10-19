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
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
out.println("<script>window.alert('没有查询管理权限');window.location.href='"+basePath+"gerenxinyong/grxymain.jsp';</script>");
};


     session.setAttribute("gongnamepjcha", "");
     session.setAttribute("gongjifenpjcha", "");
%>

<body onload="javascript:document.getElementById('gongnamecha').focus();">
<%if(quanxian.equals("物资采购部")){
System.out.println("可以显示界面！");
%>
<form name="formcha" target="neirong" action="gongpjmain.jsp">
<div style="margin-top:13px;margin-left:20px;">
供应商名称：<input type="text" id="gongnamecha" name="gongnamecha">
计分规则： <input type="text" id="gongjifencha" name="gongjifencha">
<img src="../image/gerenxinyong/btnsousuo.png" alt="搜索" style="height:30px;width:50px;vertical-align:middle;cursor:pointer;" onclick="javascript:formcha.submit();"/>
</div>
</form>

<iframe src="gongpjmain.jsp" id="neirong"  name="neirong"  marginheight="0" marginwidth="0"  scrolling="no" frameborder="0" style="margin-top:13px;margin-left:20px;width:100%;height:900px"> </iframe>

<% }else{
System.out.println("不可以显示界面！");
out.println("<br><br><br><center><b><font size='18px'>无查询权限</font></b><center>");
};%>
</body>
</html>


