<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="gb2312"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>�񻪳�����Ϣ����ϵͳ</title>
</head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<body onload="javascript:document.getElementById('yonghukahao').focus();">
<div style="background:#1845EA;color:#FFFFFF;margin-left:20px;margin-top:11px;height:50px;line-height:50px;overflow:hidden;font-size:25px;font:����,����;margin-bottom:0px;padding-bottom:0px;width:100%;">
<div style="margin-top:7px;"><img src="../image/menu/self_16.png" alt="�û�����" style="height:22px;width:22px;vertical-align:middle;"/>�û�����</div>
</div>
<%
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian.equals("�ۺϼƻ���")){
System.out.println("�û�����ɹ���");
}else{
System.out.println("�û�����ʧ�ܣ�");
out.println("<script>window.alert('û���û�����Ȩ��');window.location.href='"+basePath+"gerenxinyong/grxymain.jsp';</script>");
};

session.setAttribute("yonghuming", "");
session.setAttribute("yonghukahao", "");	

%>

   <div style="margin-top:0px;margin-left:20px;background:#22B5FF;padding-top:0px;height:50px;line-height:50px;overflow:hidden;font-size:20px;width:100%;">
   <div style="margin-top:15px;">
   <img src="../image/menu/award_star.png" alt="�û�����" style="height:22px;width:22px;vertical-align:middle;"/>
   <a href="AddRecord.jsp" style="color:blue;">�����û�</a>
   </div>
   </div>
	<form  target="neirong" action="neirong.jsp" method="post" name="formchaxun">
   <table cellspacing="0" cellpadding="0" style="margin-left:20px;margin-top:20px;border:1px solid #CCCCCC;height:50px;">
            <tr>
         	<td style="width:50px;font-size:15px;border:1px solid #CCCCCC;height:50px"  align="center">���ţ�</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="yonghukahao" name="yonghukahao"></td>
         	<td style="width:70px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">�û�����</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="yonghuming"  name="yonghuming"></td>
         	<td style="border:1px solid #CCCCCC;height:50px;"  align="center"><input type="submit" value="��ѯ"></td>
         	</tr>
   </table>

</form>

<iframe src="neirong.jsp" id="neirong"  name="neirong"  marginheight="0" marginwidth="0"  scrolling="no" frameborder="0" style="width:100%;height:900px"> </iframe>


</body>



</html>

