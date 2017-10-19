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



<title>振华诚信信息管理系统</title>
</head>

<%
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian.trim()!=""){
System.out.println("可以查询！");
}else{
System.out.println("查询失败！");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
out.println("<script>window.alert('没有查询管理权限');window.location.href='"+basePath+"gerenxinyong/grxymain.jsp';</script>");
};

%>





<body onload="javascript:document.getElementById('namess').focus();">
<div style="background-image: url(../image/gerenxinyong/gerenzhanshibj.png);margin-left:20px;margin-top:7px;height:130px;line-height:130px;overflow:hidden;font-size:25px;width:100%;position:relative;">
<form>
<div style="position:absolute;bottom:13px;left:20px;">
<img src="../image/gerenxinyong/fontxingming.png" alt="姓名" style="height:30px;width:65px;vertical-align:middle;"/>
<input type="text" id="namess" name="name">
<img src="../image/gerenxinyong/btnsousuo.png" alt="搜索" style="height:30px;width:50px;vertical-align:middle;cursor:pointer;"/>
<img src="../image/gerenxinyong/chakanbenren.png" alt="查看本人" style="height:30px;width:90px;vertical-align:middle;cursor:pointer;"/>
</div>
</form>
</div>

<img src="../image/zongtu/first5.png" alt="前五名" style="height:50px;width:100%;margin-left:20px;margin-top:10px;vertical-align:middle;"/>
<table>
<tr>
<%
 try{
			      String sql="select personname,personIDcard,personbumen,personfenshu from person where personname!=? order by personfenshu ";    
				  String [] param={"admin"};
				  SqlUtils sqlUtils=new SqlUtils();
				  Persons ps=new Persons();
				  List<Persons> ls=(List<Persons>)sqlUtils.query(sql,param,ps.getClass());
				  int row;
				  int rowCount=ls.size();
				  String style1="background-image: url(../image/zongtu/lvbj.png);margin-left:20px;margin-top:10px;height: 352px;width: 302px;";
				  String style2="background-image: url(../image/zongtu/lvzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;";
				  for(row=0;row<=5;row++)
				  {
				  Persons nowps=ls.get(row);
				  int fenshu=Integer.parseInt(nowps.getpersonfenshu());
							  if(fenshu>120)
							  {
							  style1="background-image: url(../image/zongtu/lvbj.png);margin-left:20px;margin-top:10px;height: 352px;width: 302px;";
							  style2="background-image: url(../image/zongtu/lvzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;";
							  }else if(fenshu>90&&fenshu<=120)
							  {
							  style1="background-image: url(../image/zongtu/lanbj.png);margin-left:20px;margin-top:10px;height: 354px;width: 302px;";
							  style2="background-image: url(../image/zongtu/lanzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;";
							  }else if(fenshu>70&&fenshu<=90)
							  {
							  style1="background-image: url(../image/zongtu/huangbj.png);margin-left:20px;margin-top:10px;height: 354px;width: 302px;";
							  style2="background-image: url(../image/zongtu/huangzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;";
							  }else if(fenshu<70){
							  style1="background-image: url(../image/zongtu/hongbj.png);margin-left:20px;margin-top:10px;height: 347px;width: 295px;";
							  style2="background-image: url(../image/zongtu/hongzong.png);height:69px;width:295px;margin-left:0px;margin-top:20px;vertical-align:middle;";
							  };
							  
%>
		<td style="vertical-align:middle;align:left;width:323px">
				<div id="firstdiv1" style=<%=style1%>>
				<br>
				<br>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				姓名：<%=nowps.getpersonname()%>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<br>&nbsp;
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				部门：<%=nowps.getpersonbumen()%><br>
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				卡号：<%=nowps.getpersonIDcard() %>
				<div id="firstfendiv1" style=<%=style2%>>
				<div style="height:29px;margin-left:210px;margin-top:15px;vertical-align:middle;color:yellow;font-size:20px;"><%=nowps.getpersonfenshu()%>
				</div>
				</div>
				</div>		
		</td>

<%			  
				  }
				
}catch(Exception e){
System.out.println(e.getMessage());
};
 %>
</tr>
</table>







<img src="../image/zongtu/last5.png" alt="后五名" style="height:50px;width:100%;margin-left:20px;vertical-align:middle;margin-top:10px;"/>

<table>
<tr>
<%
 try{
			      String sql1="select personname,personIDcard,personbumen,personfenshu from person where personname!=? order by personfenshu DESC";    
				  String [] param1={null};
				  SqlUtils sqlUtils1=new SqlUtils();
				  Persons ps1=new Persons();
				  List<Persons> ls1=(List<Persons>)sqlUtils1.query(sql1,param1,ps1.getClass());
				  int row1;
				  int rowCount1=ls1.size();
				  String style3="background-image: url(../image/zongtu/hongbj.png);margin-left:20px;margin-top:10px;height: 347px;width: 295px;";
				  String style4="background-image: url(../image/zongtu/hongzong.png);height:69px;width:295px;margin-left:0px;margin-top:20px;vertical-align:middle;";
				  for(row1=0;row1<=5;row1++)
				  {
				  Persons nowps=ls1.get(row1);
				  int fenshu=Integer.parseInt(nowps.getpersonfenshu());
							  if(fenshu>120)
							  {
							  style3="background-image: url(../image/zongtu/lvbj.png);margin-left:20px;margin-top:10px;height: 352px;width: 302px;";
							  style4="background-image: url(../image/zongtu/lvzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;";
							  }else if(fenshu>90&&fenshu<=120)
							  {
							  style3="background-image: url(../image/zongtu/lanbj.png);margin-left:20px;margin-top:10px;height: 354px;width: 302px;";
							  style4="background-image: url(../image/zongtu/lanzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;";
							  }else if(fenshu>70&&fenshu<=90)
							  {
							  style3="background-image: url(../image/zongtu/huangbj.png);margin-left:20px;margin-top:10px;height: 354px;width: 302px;";
							  style4="background-image: url(../image/zongtu/huangzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;";
							  }else if(fenshu<70){
							  style3="background-image: url(../image/zongtu/hongbj.png);margin-left:20px;margin-top:10px;height: 347px;width: 295px;";
							  style4="background-image: url(../image/zongtu/hongzong.png);height:69px;width:295px;margin-left:0px;margin-top:20px;vertical-align:middle;";
							  };
%>
		<td style="vertical-align:middle;align:left;width:323px">
				<div id="lastdiv1" style=<%=style3%>>>
				<br>
				<br>
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				姓名：<%=nowps.getpersonname()%>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<br>&nbsp;
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				部门：<%=nowps.getpersonbumen()%><br>
				<br>&nbsp;
				<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				卡号：<%=nowps.getpersonIDcard() %>
				<div id="lastfendiv1" style=<%=style4%>>>
				<div style="height:29px;margin-left:210px;margin-top:15px;vertical-align:middle;color:yellow;font-size:20px;"><%=nowps.getpersonfenshu()%></div>
				</div>
				</div>	
		</td>

<%			  
				  }
				
}catch(Exception e){
System.out.println(e.getMessage());
};
 %>

</tr>
</table>




</body>
</html>

