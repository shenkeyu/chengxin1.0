<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.util.*,java.sql.*,zhenhua.sql.SqlUtils,zhenhua.sql.Persons" pageEncoding="gb2312"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

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
if(quanxian.trim()!=""){
System.out.println("���Բ�ѯ��");
}else{
System.out.println("��ѯʧ�ܣ�");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
out.println("<script>window.alert('û�в�ѯ����Ȩ��');window.location.href='"+basePath+"gerenxinyong/grxymain.jsp';</script>");
};

%>





<body onload="javascript:document.getElementById('namess').focus();">
<div style="background-image: url(../image/gerenxinyong/gerenzhanshibj.png);margin-left:20px;margin-top:7px;height:130px;line-height:130px;overflow:hidden;font-size:25px;width:100%;position:relative;">
<form>
<div style="position:absolute;bottom:13px;left:20px;">
<img src="../image/gerenxinyong/fontxingming.png" alt="����" style="height:30px;width:65px;vertical-align:middle;"/>
<input type="text" id="namess" name="name">
<img src="../image/gerenxinyong/btnsousuo.png" alt="����" style="height:30px;width:50px;vertical-align:middle;cursor:pointer;"/>
<img src="../image/gerenxinyong/chakanbenren.png" alt="�鿴����" style="height:30px;width:90px;vertical-align:middle;cursor:pointer;"/>
</div>
</form>
</div>

<img src="../image/zongtu/first5.png" alt="ǰ����" style="height:50px;width:100%;margin-left:20px;margin-top:10px;vertical-align:middle;"/>
<table>
<tr>
		<td style="vertical-align:middle;align:left;width:323px">
				<div id="firstdiv1" style="background-image: url(../image/zongtu/lvbj.png);margin-left:20px;margin-top:10px;height: 352px;width: 302px;">
				<br>
				<br>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				������111
				&nbsp;&nbsp;&nbsp;&nbsp;
				<br>&nbsp;
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�111<br>
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�111
				<div id="firstfendiv1" style="background-image: url(../image/zongtu/lvzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;">
				<div style="height:29px;margin-left:210px;margin-top:15px;vertical-align:middle;color:yellow;font-size:20px;">100
				</div>
				</div>
				</div>		
		</td>

		<td  style="vertical-align:middle;align:left;width:323px">
				<div id="firstdiv2" style="background-image: url(../image/zongtu/lvbj.png);margin-left:20px;margin-top:10px;height: 352px;width: 302px;">
				<br>
				<br>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				����������
				&nbsp;&nbsp;&nbsp;&nbsp;
				<br>&nbsp;
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ������ҵ��<br>
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�37546345
				<div id="firstfendiv2" style="background-image: url(../image/zongtu/lvzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;">
				<div style="height:29px;margin-left:210px;margin-top:15px;vertical-align:middle;color:yellow;font-size:20px;">121
				</div>
				</div>
				</div>
		</td>
		<td style="vertical-align:middle;align:left;width:323px">
				<div id="firstdiv3" style="background-image: url(../image/zongtu/lanbj.png);margin-left:20px;margin-top:10px;height: 354px;width: 302px;">
				<br>
				<br>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				�������·�
				&nbsp;&nbsp;&nbsp;&nbsp;
				<br>&nbsp;
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ��������鲿<br>
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�37523231
				<div id="firstfendiv3" style="background-image: url(../image/zongtu/lanzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;">
				<div style="height:29px;margin-left:210px;margin-top:15px;vertical-align:middle;color:yellow;font-size:20px;">115
				</div>
				</div>
				</div>
		</td>
		<td style="vertical-align:middle;align:left;width:323px">
				<div id="firstdiv4" style="background-image: url(../image/zongtu/lanbj.png);margin-left:20px;margin-top:10px;height: 354px;width: 302px;">
				<br>
				<br>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				��������Դ
				&nbsp;&nbsp;&nbsp;&nbsp;
				<br>&nbsp;
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ��ɹ���ҵ��<br>
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�375455453
				<div id="firstfendiv4" style="background-image: url(../image/zongtu/lanzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;">
				<div style="height:29px;margin-left:210px;margin-top:15px;vertical-align:middle;color:yellow;font-size:20px;">104
				</div>
				</div>
				</div>
		</td>
		<td style="vertical-align:middle;align:left;width:323px">
				<div id="firstdiv5" style="background-image: url(../image/zongtu/lanbj.png);margin-left:20px;margin-top:10px;height: 354px;width: 302px;">
				<br>
				<br>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				����������
				&nbsp;&nbsp;&nbsp;&nbsp;
				<br>&nbsp;
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�����ҵ��<br>
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�3754667456
				<div id="firstfendiv5" style="background-image: url(../image/zongtu/lanzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;">
				<div style="height:29px;margin-left:210px;margin-top:15px;vertical-align:middle;color:yellow;font-size:20px;">92
				</div>
				</div>
				</div>
		</td>
</tr>
</table>







<img src="../image/zongtu/last5.png" alt="������" style="height:50px;width:100%;margin-left:20px;vertical-align:middle;margin-top:10px;"/>




<table>
<tr>
		<td style="vertical-align:middle;align:left;width:323px">
				<div id="lastdiv1" style="background-image: url(../image/zongtu/hongbj.png);margin-left:20px;margin-top:10px;height: 347px;width: 295px;">
				<br>
				<br>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				������Ԭ����
				&nbsp;&nbsp;&nbsp;&nbsp;
				<br>&nbsp;
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�������ҵ��<br>
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�37534231
				<div id="lastfendiv1" style="background-image: url(../image/zongtu/hongzong.png);height:69px;width:295px;margin-left:0px;margin-top:20px;vertical-align:middle;">
				<div style="height:29px;margin-left:210px;margin-top:15px;vertical-align:middle;color:yellow;font-size:20px;">65</div>
				</div>
				</div>	
		</td>
		<td style="vertical-align:middle;align:left;width:323px">
				<div id="lastdiv2" style="background-image: url(../image/zongtu/hongbj.png);margin-left:20px;margin-top:10px;height: 347px;width: 295px;">
				<br>
				<br>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				����������
				&nbsp;&nbsp;&nbsp;&nbsp;
				<br>&nbsp;
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�������ҵ��<br>
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�375464454
				<div id="lastfendiv2" style="background-image: url(../image/zongtu/hongzong.png);height:69px;width:295px;margin-left:0px;margin-top:20px;vertical-align:middle;">
				<div style="height:29px;margin-left:210px;margin-top:15px;vertical-align:middle;color:yellow;font-size:20px;">69</div>
				</div>
				</div>	
		</td>
		<td style="vertical-align:middle;align:left;width:323px">
				<div id="lastdiv3" style="background-image: url(../image/zongtu/huangbj.png);margin-left:20px;margin-top:10px;height: 354px;width: 302px;">
				<br>
				<br>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				�������ŷ���
				&nbsp;&nbsp;&nbsp;&nbsp;
				<br>&nbsp;
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�Ԥ�㿼�˲�<br>
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�375482636
				<div id="lastfendiv3" style="background-image: url(../image/zongtu/huangzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;">
				<div style="height:29px;margin-left:210px;margin-top:15px;vertical-align:middle;color:black;font-size:20px;">75</div>
				</div>
				</div>	
		</td>
		<td style="vertical-align:middle;align:left;width:323px">
				<div id="lastdiv4" style="background-image: url(../image/zongtu/huangbj.png);margin-left:20px;margin-top:10px;height: 354px;width: 302px;">
				<br>
				<br>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				������������
				&nbsp;&nbsp;&nbsp;&nbsp;
				<br>&nbsp;
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�QHSE��<br>
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�378543452
				<div id="lastfendiv4" style="background-image: url(../image/zongtu/huangzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;">
				<div style="height:29px;margin-left:210px;margin-top:15px;vertical-align:middle;color:black;font-size:20px;">80</div>
				</div>
				</div>	
		</td>
		<td style="vertical-align:middle;align:left;width:323px">
				<div id="lastdiv5" style="background-image: url(../image/zongtu/huangbj.png);margin-left:20px;margin-top:10px;height: 354px;width: 302px;">
				<br>
				<br>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				������������
				&nbsp;&nbsp;&nbsp;&nbsp;
				<br>&nbsp;
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�����װ�䲿<br>
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				���ţ�00031
				<div id="lastfendiv5" style="background-image: url(../image/zongtu/huangzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;">
				<div style="height:29px;margin-left:210px;margin-top:15px;vertical-align:middle;color:black;font-size:20px;">89</div>
				</div>
				</div>	
		</td>
</tr>
</table>




</body>
</html>

