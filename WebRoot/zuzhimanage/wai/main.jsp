<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="gb2312"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>�񻪳�����Ϣ����ϵͳ</title>
</head>

<body onload="javascript:document.getElementById('zuzhiming').focus();">
<div style="background:#1845EA;color:#FFFFFF;margin-left:20px;margin-top:11px;height:50px;line-height:50px;overflow:hidden;font-size:25px;font:����,����;margin-bottom:0px;padding-bottom:0px;width:100%;">
<div style="margin-top:7px;"><img src="../../image/menu/self_16.png" alt="�ڷְ��̹���" style="height:22px;width:22px;vertical-align:middle;"/>��ְ��̹���</div>
</div>
<%
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian.equals("�ۺϼƻ���")){
System.out.println("��ְ��̹���ɹ���");
}else{
System.out.println("��ְ��̹���ʧ�ܣ�");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
out.println("<script>window.alert('û����ְ��̹���Ȩ��');window.location.href='"+basePath+"gerenxinyong/grxymain.jsp';</script>");
};

session.setAttribute("waiming", "");	

%>

   <div style="margin-top:0px;margin-left:20px;background:#22B5FF;padding-top:0px;height:50px;line-height:50px;overflow:hidden;font-size:20px;width:100%;">
   <div style="margin-top:15px;">
   <img src="../../image/menu/award_star.png" alt="�û�����" style="height:22px;width:22px;vertical-align:middle;"/>
   <a href="AddRecord.jsp" style="color:blue;">���������</a>
   </div>
   </div>
	<form  target="neirong" action="neirong.jsp" method="post" name="formchaxun">
   <table cellspacing="0" cellpadding="0" style="margin-left:20px;margin-top:20px;border:1px solid #CCCCCC;height:50px;">
            <tr>
         	<td style="width:170px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">��ְ������ƣ�</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="zuzhiming"  name="zuzhiming"></td>
         	<td style="border:1px solid #CCCCCC;height:50px;"  align="center"><input type="submit" value="��ѯ"></td>
         	</tr>
   </table>

</form>

<iframe src="neirong.jsp" id="neirong"  name="neirong"  marginheight="0" marginwidth="0"  scrolling="no" frameborder="0" style="width:100%;height:900px"> </iframe>


</body>



</html>

