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
String quanxian=session.getAttribute("bumen").toString();
if(quanxian!=""||quanxian!=null){
System.out.println("可以查询！");
}else{
System.out.println("查询失败！");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
out.println("<script>window.alert('没有查询管理权限');window.location.href='"+basePath+"gerenxinyong/grxymain.jsp';</script>");
};

session.setAttribute("chaxungong", "");
%>

<body onload="javascript:document.getElementById('mingzi').focus();">


<div style="background-image: url(../image/zuzhixinyong/zuzhizhanshibj.png);margin-left:20px;margin-top:7px;height:130px;line-height:130px;overflow:hidden;font-size:25px;width:100%;position:relative;">
<form name="formcha" target="neirong" action="neirong.jsp">
<div style="position:absolute;bottom:13px;left:20px;">
<img src="../image/zuzhixinyong/zuzhiming.png" alt="姓名" style="height:30px;width:120px;vertical-align:middle;"/>
<input type="text" id="mingzi" name="mingzi">
<img src="../image/zuzhixinyong/btnsousuo.png" alt="搜索" style="height:30px;width:50px;vertical-align:middle;cursor:pointer;"  onclick="javascript:formcha.submit();"/>
</div>
</form>
</div>
<iframe src="neirongmain.jsp" id="neirong"  name="neirong"  marginheight="0" marginwidth="0"  scrolling="no" frameborder="0" style="width:100%;height:900px"> </iframe>

</body>
</html>

