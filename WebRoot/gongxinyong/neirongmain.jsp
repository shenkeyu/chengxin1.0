<%@ page language="java" import="java.sql.*" contentType="text/html; charset=utf-8"%>
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
String quanxian=session.getAttribute("bumen").toString();
if(quanxian!=""||quanxian!=null){
System.out.println("可以查询！");
}else{
System.out.println("查询失败！");
out.println("<script>window.location.href='../zhenhuaindex.html';</script>");
};
%>
<body>

<center><div style="font-size:20px;margin-top:20px">供应商榜单</div></center>
<img src="../image/zongtu/first5.png" alt="前五名" style="height:50px;width:100%;margin-left:20px;margin-top:10px;vertical-align:middle;"/>
<table>
<tr>
<%
 try{

	Connection con = null;
 		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName=zhenhua";//设置连接的数据库      
		String USER = "sa";
		String PWD = "sky123456";
		con = DriverManager.getConnection(URL, USER, PWD);
		Statement stmt= con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			      String sql="select * from gong order by fenshu desc";    
				  System.out.println(sql);
				  ResultSet rs=stmt.executeQuery(sql);
				  //rs.first();
				  int row=0;
				  int rowCount=rs.getRow();
				  System.out.println(rowCount);
				  String style1="background-image: url(../image/zongtu/lvbj.png);margin-left:20px;margin-top:10px;height: 352px;width: 302px;";
				  String style2="background-image: url(../image/zongtu/lvzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;";
				  while(rs.next())
				  {
				  float fenshu=Float.parseFloat(rs.getString("fenshu").trim());
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
										<br>&nbsp;
										<br><center><%=rs.getString("name").trim()%></center>
										<br>&nbsp;
										<br>&nbsp;
										<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										法人姓名：<%=rs.getString("faren").trim()%><br>
										<br>&nbsp;
										<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										注册资本：<%=rs.getString("ziben").trim()%>万元
										<div id="firstfendiv1" style="<%=style2%>">
										<div style="height:29px;margin-left:210px;margin-top:15px;vertical-align:middle;color:black;font-size:20px;">
										<%=rs.getFloat("fenshu")%>
										</div>
										</div>
										</div>		
								</td>

<%			  	row++;
				if(row==5)
				break;
				  }
		rs.close();			
		con.close();
		stmt.close();
				
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
	Connection con1 = null;
 		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL1 = "jdbc:sqlserver://localhost:1433;DatabaseName=zhenhua";//设置连接的数据库      
		String USER1 = "sa";
		String PWD1 = "sky123456";
		con1 = DriverManager.getConnection(URL1, USER1, PWD1);
		Statement stmt1= con1.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			      String sql1="select * from gong order by fenshu asc";    
				  System.out.println(sql1);
				  ResultSet rs1 = stmt1.executeQuery(sql1);
				  //rs1.first();
				  int row1=0;
				  int rowCount1=rs1.getRow();
				  String style3="background-image: url(../image/zongtu/hongbj.png);margin-left:20px;margin-top:10px;height: 347px;width: 295px;";
				  String style4="background-image: url(../image/zongtu/hongzong.png);height:69px;width:295px;margin-left:0px;margin-top:20px;vertical-align:middle;";
				  while(rs1.next())
				  {
				  float fenshu=Float.parseFloat(rs1.getString("fenshu").trim());
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
										<div id="lastdiv1" style="<%=style3%>">
										<br>
										<br>
										<br>&nbsp;
										<br><center><%=rs1.getString("name").trim()%></center>
										<br>&nbsp;
										<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										法人姓名：<%=rs1.getString("faren").trim()%><br>
										<br>&nbsp;
										<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										注册资本：<%=rs1.getString("ziben").trim()%>万元
										<div id="lastfendiv1" style="<%=style4%>">
										<div style="height:29px;margin-left:210px;margin-top:15px;vertical-align:middle;color:black;font-size:20px;">
										<%=rs1.getFloat("fenshu")%>
										</div>
										</div>
										</div>	
		</td>

<%			  	row1++;
				if(row1==5)
				break;
				  }
		rs1.close();			
		con1.close();
		stmt1.close();
		
}catch(Exception e){
System.out.println(e.getMessage());
};
 %>

</tr>
</table>
</body>
</html>

