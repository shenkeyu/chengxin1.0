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



<title>�񻪳�����Ϣ����ϵͳ</title>
</head>

<%
String quanxian=session.getAttribute("bumen").toString();
if(quanxian!=""||quanxian!=null){
System.out.println("���Բ�ѯ��");
}else{
System.out.println("��ѯʧ�ܣ�");
out.println("<script>window.location.href='../zhenhuaindex.html';</script>");
};

session.setAttribute("chaxunyonghu", "");
%>


<script type="text/javascript"> 
function chakanbenren()
{ 
document.getElementById("neirong").src="neirongbenren.jsp";
} 
</script> 

<body onload="javascript:document.getElementById('mingzi').focus();">
<div style="background-image: url(../image/gerenxinyong/gerenzhanshibj.png);margin-left:20px;margin-top:7px;height:130px;line-height:130px;overflow:hidden;font-size:25px;width:100%;position:relative;">
<form name="formcha" target="neirong" action="grxyneirong.jsp">
<div style="position:absolute;bottom:13px;left:20px;">
<img src="../image/gerenxinyong/fontxingming.png" alt="����" style="height:30px;width:65px;vertical-align:middle;"/>
<input type="text" id="mingzi" name="mingzi">
<img src="../image/gerenxinyong/btnsousuo.png" alt="����" style="height:30px;width:50px;vertical-align:middle;cursor:pointer;" onclick="javascript:formcha.submit();"/>
<img src="../image/gerenxinyong/chakanbenren.png" alt="�鿴����" style="height:30px;width:90px;vertical-align:middle;cursor:pointer;" onclick="chakanbenren();"/>
</div>
</form>
</div>

<iframe src="grxyneirongmain.jsp" id="neirong"  name="neirong"  marginheight="0" marginwidth="0"  scrolling="no" frameborder="0" style="width:100%;height:900px"> </iframe>

</body>
</html>

