<%@ page contentType="text/html; charset=gb2312"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
out.println("<script>window.alert('û��ͳ��Ȩ��');window.location.href='"+basePath+"gerenxinyong/grxymain.jsp';</script>");
};
%>

<body onload="javascript:document.getElementById('qiyue').focus();">
<div style="center">
<center><div style="font-size:35px">ͳ�Ʒ���</div></center>
<form name="formtj" target="neirong" action="tj.jsp" method="post">
<div style="margin-top:13px;margin-left:20px;">
<center>�������·ݣ���<input type="text" id="qiyue" name="qiyue" value=1>����<input type="text" id="jieyue" name="jieyue" value=12>��
<br>  <input type="hidden" name="leixing" value="person">
<p> <input type="button" value="�������ͳ��" onclick="javascript:return jiancha1();">
&nbsp;<input type="button" value="�ڷְ������ͳ��" onclick="javascript:return jiancha2();">
<input type="button" value="��ְ���ͳ��" onclick="javascript:return jiancha3();">&nbsp;
 <input type="button" value="��Ӧ��ͳ��" onclick="javascript:return jiancha4();">
</center>
</div>
</form>
</div>

<iframe src="tj.jsp" id="neirong"  name="neirong"  marginheight="0" marginwidth="0"  scrolling="no" frameborder="0" style="margin-top:13px;margin-left:20px;width:100%;height:900px"> </iframe>


</body>
</html>

<script type="text/javascript">
function jiancha1()
{
var qiyue=document.getElementById("qiyue").value;
var jieyue=document.getElementById("jieyue").value;
var flag=false;
document.getElementById("leixing").value="person";
	if(qiyue!=null&&qiyue!=""){
		if(jieyue!=null&&jieyue!=""){
					if(!isNaN(qiyue)){
					   					if(!isNaN(jieyue)){
											   		if((jieyue-qiyue)>=0){
													   	if(jieyue>0&&jieyue<13&&qiyue>0&&qiyue<13){
														   		if((parseInt(jieyue)==jieyue)&&(parseInt(qiyue)==qiyue)){
																   flag=true;
																}else{
																   alert("��ʼ�·ݺͽ�ֹ�·ݱ���Ϊ����");
																   document.getElementById("qiyue").focus();
																   flag=false;
																}
														}else{
														   alert("��ʼ�·ݺͽ�ֹ�·ݱ�����1-12�·�֮��");
														   document.getElementById("qiyue").focus();
														   flag=false;
														}
													}else{
													   alert("��ֹ�·ݲ��ܱ���ʼ�·�С");
													   document.getElementById("qiyue").focus();
													   flag=false;
													}
											}else{
											   alert("��ֹ�·ݲ�������");
											   document.getElementById("jieyue").focus();
											   flag=false;
											}
					}else{
					   alert("��ʼ�·ݲ�������");
					   document.getElementById("qiyue").focus();
					   flag=false;
					}
		}else{
		alert("���������Ľ�ֹ�·ݣ�");
		document.getElementById("jieyue").focus();
		flag=false;
		};
	}else{
	alert("������������ʼ�·ݣ�");
	document.getElementById("qiyue").focus();
	flag=false;
	};
	
	if(flag){
	document.formtj.submit();
	};
	return flag;	
};
function jiancha2()
{
var qiyue=document.getElementById("qiyue").value;
var jieyue=document.getElementById("jieyue").value;
var flag=false;
document.getElementById("leixing").value="nei";
	if(qiyue!=null&&qiyue!=""){
		if(jieyue!=null&&jieyue!=""){
					if(!isNaN(qiyue)){
					   					if(!isNaN(jieyue)){
											   		if((jieyue-qiyue)>=0){
													   	if(jieyue>0&&jieyue<13&&qiyue>0&&qiyue<13){
														   		if((parseInt(jieyue)==jieyue)&&(parseInt(qiyue)==qiyue)){
																   flag=true;
																}else{
																   alert("��ʼ�·ݺͽ�ֹ�·ݱ���Ϊ����");
																   document.getElementById("qiyue").focus();
																   flag=false;
																}
														}else{
														   alert("��ʼ�·ݺͽ�ֹ�·ݱ�����1-12�·�֮��");
														   document.getElementById("qiyue").focus();
														   flag=false;
														}
													}else{
													   alert("��ֹ�·ݲ��ܱ���ʼ�·�С");
													   document.getElementById("qiyue").focus();
													   flag=false;
													}
											}else{
											   alert("��ֹ�·ݲ�������");
											   document.getElementById("jieyue").focus();
											   flag=false;
											}
					}else{
					   alert("��ʼ�·ݲ�������");
					   document.getElementById("qiyue").focus();
					   flag=false;
					}
		}else{
		alert("���������Ľ�ֹ�·ݣ�");
		document.getElementById("jieyue").focus();
		flag=false;
		};
	}else{
	alert("������������ʼ�·ݣ�");
	document.getElementById("qiyue").focus();
	flag=false;
	};
	
	if(flag){
	document.forms.item(0).submit();
	};
	return flag;	
};
function jiancha3()
{
var qiyue=document.getElementById("qiyue").value;
var jieyue=document.getElementById("jieyue").value;
var flag=false;
document.getElementById("leixing").value="wai";
	if(qiyue!=null&&qiyue!=""){
		if(jieyue!=null&&jieyue!=""){
					if(!isNaN(qiyue)){
					   					if(!isNaN(jieyue)){
											   		if((jieyue-qiyue)>=0){
													   	if(jieyue>0&&jieyue<13&&qiyue>0&&qiyue<13){
														   		if((parseInt(jieyue)==jieyue)&&(parseInt(qiyue)==qiyue)){
																   flag=true;
																}else{
																   alert("��ʼ�·ݺͽ�ֹ�·ݱ���Ϊ����");
																   document.getElementById("qiyue").focus();
																   flag=false;
																}
														}else{
														   alert("��ʼ�·ݺͽ�ֹ�·ݱ�����1-12�·�֮��");
														   document.getElementById("qiyue").focus();
														   flag=false;
														}
													}else{
													   alert("��ֹ�·ݲ��ܱ���ʼ�·�С");
													   document.getElementById("qiyue").focus();
													   flag=false;
													}
											}else{
											   alert("��ֹ�·ݲ�������");
											   document.getElementById("jieyue").focus();
											   flag=false;
											}
					}else{
					   alert("��ʼ�·ݲ�������");
					   document.getElementById("qiyue").focus();
					   flag=false;
					}
		}else{
		alert("���������Ľ�ֹ�·ݣ�");
		document.getElementById("jieyue").focus();
		flag=false;
		};
	}else{
	alert("������������ʼ�·ݣ�");
	document.getElementById("qiyue").focus();
	flag=false;
	};
	
	if(flag){
	document.forms.item(0).submit();
	};
	return flag;	
};
function jiancha4()
{
var qiyue=document.getElementById("qiyue").value;
var jieyue=document.getElementById("jieyue").value;
var flag=false;
document.getElementById("leixing").value="gong";
	if(qiyue!=null&&qiyue!=""){
		if(jieyue!=null&&jieyue!=""){
					if(!isNaN(qiyue)){
					   					if(!isNaN(jieyue)){
											   		if((jieyue-qiyue)>=0){
													   	if(jieyue>0&&jieyue<13&&qiyue>0&&qiyue<13){
														   		if((parseInt(jieyue)==jieyue)&&(parseInt(qiyue)==qiyue)){
																   flag=true;
																}else{
																   alert("��ʼ�·ݺͽ�ֹ�·ݱ���Ϊ����");
																   document.getElementById("qiyue").focus();
																   flag=false;
																}
														}else{
														   alert("��ʼ�·ݺͽ�ֹ�·ݱ�����1-12�·�֮��");
														   document.getElementById("qiyue").focus();
														   flag=false;
														}
													}else{
													   alert("��ֹ�·ݲ��ܱ���ʼ�·�С");
													   document.getElementById("qiyue").focus();
													   flag=false;
													}
											}else{
											   alert("��ֹ�·ݲ�������");
											   document.getElementById("jieyue").focus();
											   flag=false;
											}
					}else{
					   alert("��ʼ�·ݲ�������");
					   document.getElementById("qiyue").focus();
					   flag=false;
					}
		}else{
		alert("���������Ľ�ֹ�·ݣ�");
		document.getElementById("jieyue").focus();
		flag=false;
		};
	}else{
	alert("������������ʼ�·ݣ�");
	document.getElementById("qiyue").focus();
	flag=false;
	};
	
	if(flag){
	document.forms.item(0).submit();
	};
	return flag;	
};
</script>
