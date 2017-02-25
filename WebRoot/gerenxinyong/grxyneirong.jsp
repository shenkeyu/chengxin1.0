<%@ page language="java" import="java.sql.*" pageEncoding="utf-8"%>

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
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

String quanxian=session.getAttribute("bumen").toString();
if(quanxian!=""||quanxian!=null){
System.out.println("可以查询！");
}else{
System.out.println("查询失败！");
out.println("<script>window.location.href='../zhenhuaindex.html';</script>");
};
%>
<body>
<table>
<tr>
<%
 try{
	Connection con3 = null;
 		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName=zhenhua";//设置连接的数据库      
		String USER = "sa";
		String PWD = "sky123456";
		con3 = DriverManager.getConnection(URL, USER, PWD);
		String ss=request.getParameter("namecha");
		//String ss=new String(request.getParameter("namecha").getBytes("ISO-8859-1"),"gb2312");
		Statement stmt3= con3.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			      String sql3="select * from person where personname like '%"+ss.trim()+"%'";    
				  System.out.println(sql3);
				  ResultSet rs3=stmt3.executeQuery(sql3);
				  //rs.first();
				  int row3=0;
				  int rowCount3=rs3.getRow();
				  System.out.println(rowCount3);
				  String style1="background-image: url(../image/zongtu/lvbj.png);margin-left:20px;margin-top:10px;height: 352px;width: 302px;";
				  String style2="background-image: url(../image/zongtu/lvzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;";
				  while(rs3.next())
				  {
				  float fenshu=Float.parseFloat(rs3.getString("personfenshu").trim());
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
										<div id="firstdiv1" style="<%=style1%>">
										<br>
										<br>
										<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										姓名：<%=rs3.getString("personname").trim()%>
										&nbsp;&nbsp;&nbsp;&nbsp;
										<br>&nbsp;
										<br>&nbsp;
										<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										部门：<%=rs3.getString("personbumen").trim()%><br>
										<br>&nbsp;
										<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										卡号：<%=rs3.getString("personIDcard").trim()%>
										<div id="firstfendiv1" style="<%=style2%>">
										<div style="height:29px;margin-left:210px;margin-top:15px;vertical-align:middle;color:black;font-size:20px;">
										<%=rs3.getFloat("personfenshu")%>
										</div>
										</div>
										</div>		
								</td>

<%			  	row3++;
				if(row3==5)
				break;
				  }
		rs3.close();			
		con3.close();
		stmt3.close();
		//if(rowCount3==0) out.println("<center>不存在此用户！</center>");
				
}catch(Exception e){
System.out.println(e.getMessage());
};
 %>
</tr>
</table>
</body>
</html>

