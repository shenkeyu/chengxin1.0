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
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
out.println("<script>window.alert('û�в�ѯ����Ȩ��');window.location.href='"+basePath+"gerenxinyong/grxymain.jsp';</script>");
};


     session.setAttribute("gongnamepjcha", "");
     session.setAttribute("gongjifenpjcha", "");
%>

<body onload="javascript:document.getElementById('gongnamecha').focus();">
<%if(quanxian.equals("���ʲɹ���")){
System.out.println("������ʾ���棡");
%>
<form name="formcha" target="neirong" action="gongpjmain.jsp">
<div style="margin-top:13px;margin-left:20px;">
��Ӧ�����ƣ�<input type="text" id="gongnamecha" name="gongnamecha">
�Ʒֹ��� <input type="text" id="gongjifencha" name="gongjifencha">
<img src="../image/gerenxinyong/btnsousuo.png" alt="����" style="height:30px;width:50px;vertical-align:middle;cursor:pointer;" onclick="javascript:formcha.submit();"/>
</div>
</form>

<iframe src="gongpjmain.jsp" id="neirong"  name="neirong"  marginheight="0" marginwidth="0"  scrolling="no" frameborder="0" style="margin-top:13px;margin-left:20px;width:100%;height:900px"> </iframe>

<% }else{
System.out.println("��������ʾ���棡");
out.println("<br><br><br><center><b><font size='18px'>�޲�ѯȨ��</font></b><center>");
};%>
</body>
</html>


