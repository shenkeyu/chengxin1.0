<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="zhenhua.sql.SqlUtils,zhenhua.sql.Persons,java.util.List,java.sql.*" pageEncoding="gb2312"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>振华诚信信息管理系统</title>
</head>

<body  onload="javascript:document.getElementById('personIDcard').focus();">
<script type="text/javascript">
function checkInsert()
{
var pwd=document.getElementById("personpwd").value;
var personname=document.getElementById("personname").value;
var personbumen=document.getElementById("personbumen").value;
var person2bumen=document.getElementById("person2bumen").value;
var person3bumen=document.getElementById("person3bumen").value;
var persongangweizhiwu=document.getElementById("persongangweizhiwu").value;
var flag=false;

		if(personname!=null&&personname!=""){
			if(personbumen!=null&&personbumen!=""){
				if(person2bumen!=null&&person2bumen!=""){
					if(person3bumen!=null&&person3bumen!=""){
						if(persongangweizhiwu!=null&&persongangweizhiwu!=""){
							if(pwd!=null&&pwd!=""){
									if(pwd.length>5&&pwd.length<16){
									flag=true;
									}else{
									alert("输入有误，密码长度为6-16位！");
									document.getElementById("personpwd").focus();
									flag=false;
									};
							}else{
							alert("请输入您的密码！");
							document.getElementById("personpwd").focus();
							flag=false;
							};
						}else{
						alert("请输入您的岗位职务！");
						document.getElementById("persongangweizhiwu").focus();
						flag=false;
						};
					}else{
					alert("请输入您的三级部门！");
					document.getElementById("person3bumen").focus();
					flag=false;
					};
				}else{
				alert("请输入您的二级部门！");
				document.getElementById("person2bumen").focus();
				flag=false;
				};
			}else{
			alert("请输入您的一级部门！");
			document.getElementById("personbumen").focus();
			flag=false;
			};
		}else{
		alert("请输入您的用户名！");
		document.getElementById("personname").focus();
		flag=false;
		};	
	
	if(flag){
	document.forms.item(0).submit();
	};
	return flag;	
};
</script>
<%
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian.equals("综合计划处")){
System.out.println("用户管理成功！");
}else{
System.out.println("用户管理失败！");
out.println("<script>window.location.href='../zhenhuaindex.html';</script>");
};

		request.setCharacterEncoding("utf-8");
     	 boolean flag=false;
    	 boolean flagpanduan=false;
     	 String personIDcard=request.getParameter("recordid");
     	 System.out.println(personIDcard);
if(personIDcard!=null&&personIDcard!="")
{
	try {
		Connection con = null;
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//设置连接的数据库      
		String USER = session.getAttribute("ssYONGHU").toString();
		String PWD = session.getAttribute("ssMIMA").toString();
		con = DriverManager.getConnection(URL, USER, PWD);
		Statement stmt= con.createStatement();
			String sql ="select * from person where personIDcard='"+personIDcard.trim()+"'";		
			ResultSet rs = stmt.executeQuery(sql);
				while(rs.next())
				{				
				System.out.println("查到此用户");
%>
								<form action="doupdateRecord.jsp" method="post" name="formchaxun">
								   <table cellspacing="0" cellpadding="0" style="margin-left:20px;margin-top:20px;border:1px solid #CCCCCC;height:200px;">
								            <tr>
								         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px"  align="center">卡号：</td>
								         	<td style="border:1px solid #CCCCCC;height:50px;"><%=rs.getString("personIDcard").trim()%><input
					type="hidden" name="recordid" id="recordid" value=<%=rs.getString("personIDcard").trim()%>></td>
								         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">用户名：</td>
								         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="personname" name="personname" value="<%=rs.getString("personname").trim()%>"></td>
								         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">密码：</td>
								         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="personpwd"  name="personpwd" type="password" value="<%=rs.getString("personpwd").trim()%>"></td>
								         	</tr>
								         	<tr>
								         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px"  align="center">一级部门：</td>
								         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="personbumen" name="personbumen" value="<%=rs.getString("personbumen").trim()%>"></td>
								         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">二级部门：</td>
								         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="person2bumen" name="person2bumen" value="<%=rs.getString("person2bumen").trim()%>"></td>
								         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">三级部门：</td>
								         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="person3bumen" name="person3bumen" value="<%=rs.getString("person3bumen").trim()%>"></td>
								         	</tr>
								         	<tr>
								         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">岗位职务：</td>
								         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="persongangweizhiwu" name="persongangweizhiwu" value="<%=rs.getString("persongangweizhiwu").trim()%>"></td>
								         	<td colspan=4 style="border:1px solid #CCCCCC;height:50px;"  align="center">
								         	<input type="submit" value="修改用户" onclick="javascript:return checkInsert();"></td>
								         	</tr>
								   </table>
								
								</form>
<%
						}  	   
		 		rs.close();			
				con.close();
				stmt.close();


			      }catch(Exception e){
			       System.out.println(e.getMessage());
			     	String s0="未找到待修改用户！";
					out.println("<script>alert('"+s0+"');window.location.href='neirong.jsp';</script>");  
			      };
 };

%>

</body>



</html>

