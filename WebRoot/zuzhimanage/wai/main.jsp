<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="gb2312"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>振华诚信信息管理系统</title>
</head>

<body onload="javascript:document.getElementById('zuzhiming').focus();">
<div style="background:#1845EA;color:#FFFFFF;margin-left:20px;margin-top:11px;height:50px;line-height:50px;overflow:hidden;font-size:25px;font:黑体,宋体;margin-bottom:0px;padding-bottom:0px;width:100%;">
<div style="margin-top:7px;"><img src="../../image/menu/self_16.png" alt="内分包商管理" style="height:22px;width:22px;vertical-align:middle;"/>外分包商管理</div>
</div>
<%
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian.equals("综合计划处")){
System.out.println("外分包商管理成功！");
}else{
System.out.println("外分包商管理失败！");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
out.println("<script>window.alert('没有外分包商管理权限');window.location.href='"+basePath+"gerenxinyong/grxymain.jsp';</script>");
};

session.setAttribute("waiming", "");	

%>

   <div style="margin-top:0px;margin-left:20px;background:#22B5FF;padding-top:0px;height:50px;line-height:50px;overflow:hidden;font-size:20px;width:100%;">
   <div style="margin-top:15px;">
   <img src="../../image/menu/award_star.png" alt="用户增加" style="height:22px;width:22px;vertical-align:middle;"/>
   <a href="AddRecord.jsp" style="color:blue;">增加外包商</a>
   </div>
   </div>
	<form  target="neirong" action="neirong.jsp" method="post" name="formchaxun">
   <table cellspacing="0" cellpadding="0" style="margin-left:20px;margin-top:20px;border:1px solid #CCCCCC;height:50px;">
            <tr>
         	<td style="width:170px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">外分包商名称：</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="zuzhiming"  name="zuzhiming"></td>
         	<td style="border:1px solid #CCCCCC;height:50px;"  align="center"><input type="submit" value="查询"></td>
         	</tr>
   </table>

</form>

<iframe src="neirong.jsp" id="neirong"  name="neirong"  marginheight="0" marginwidth="0"  scrolling="no" frameborder="0" style="width:100%;height:900px"> </iframe>


</body>



</html>

