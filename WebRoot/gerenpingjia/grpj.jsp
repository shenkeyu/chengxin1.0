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
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian!=""||quanxian!=null){
System.out.println("���Բ�ѯ��");
System.out.println(quanxian);
}else{
System.out.println("��ѯʧ�ܣ�");
out.println("<script>window.location.href='../jieguo/error.jsp';</script>");
};


     session.setAttribute("kahaopjcha", "");
     session.setAttribute("jifenpjcha", "");
%>

<body onload="javascript:document.getElementById('kahaocha').focus();">
<%if(quanxian.equals("������Դ��")||quanxian.equals("QHSE��")){
System.out.println("������ʾ���棡");
%>
<form name="formcha" target="neirong" action="grpjmain.jsp">
<div style="margin-top:13px;margin-left:20px;">
ID���ţ�<input type="text" id="kahaocha" name="kahaocha">
�Ʒֹ��� <input type="text" id="jifencha" name="jifencha">
<img src="../image/gerenxinyong/btnsousuo.png" alt="����" style="height:30px;width:50px;vertical-align:middle;cursor:pointer;" onclick="javascript:formcha.submit();"/>
</div>
</form>

<iframe src="grpjmain.jsp" id="neirong"  name="neirong"  marginheight="0" marginwidth="0"  scrolling="no" frameborder="0" style="margin-top:13px;margin-left:20px;width:100%;height:900px"> </iframe>

<% }else{
System.out.println("��������ʾ���棡");
out.println("<b>�޲�ѯȨ��</b>");
};%>
</body>
</html>


