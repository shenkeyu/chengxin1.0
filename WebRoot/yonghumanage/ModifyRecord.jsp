<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="zhenhua.sql.SqlUtils,zhenhua.sql.Persons,java.util.List,java.sql.*" pageEncoding="gb2312"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>�񻪳�����Ϣ����ϵͳ</title>
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
									alert("�����������볤��Ϊ6-16λ��");
									document.getElementById("personpwd").focus();
									flag=false;
									};
							}else{
							alert("�������������룡");
							document.getElementById("personpwd").focus();
							flag=false;
							};
						}else{
						alert("���������ĸ�λְ��");
						document.getElementById("persongangweizhiwu").focus();
						flag=false;
						};
					}else{
					alert("�����������������ţ�");
					document.getElementById("person3bumen").focus();
					flag=false;
					};
				}else{
				alert("���������Ķ������ţ�");
				document.getElementById("person2bumen").focus();
				flag=false;
				};
			}else{
			alert("����������һ�����ţ�");
			document.getElementById("personbumen").focus();
			flag=false;
			};
		}else{
		alert("�����������û�����");
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
if(quanxian.equals("�ۺϼƻ���")){
System.out.println("�û�����ɹ���");
}else{
System.out.println("�û�����ʧ�ܣ�");
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
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//����JDBC��������
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//�������ӵ����ݿ�      
		String USER = session.getAttribute("ssYONGHU").toString();
		String PWD = session.getAttribute("ssMIMA").toString();
		con = DriverManager.getConnection(URL, USER, PWD);
		Statement stmt= con.createStatement();
			String sql ="select * from person where personIDcard='"+personIDcard.trim()+"'";		
			ResultSet rs = stmt.executeQuery(sql);
				while(rs.next())
				{				
				System.out.println("�鵽���û�");
%>
								<form action="doupdateRecord.jsp" method="post" name="formchaxun">
								   <table cellspacing="0" cellpadding="0" style="margin-left:20px;margin-top:20px;border:1px solid #CCCCCC;height:200px;">
								            <tr>
								         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px"  align="center">���ţ�</td>
								         	<td style="border:1px solid #CCCCCC;height:50px;"><%=rs.getString("personIDcard").trim()%><input
					type="hidden" name="recordid" id="recordid" value=<%=rs.getString("personIDcard").trim()%>></td>
								         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">�û�����</td>
								         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="personname" name="personname" value="<%=rs.getString("personname").trim()%>"></td>
								         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">���룺</td>
								         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="personpwd"  name="personpwd" type="password" value="<%=rs.getString("personpwd").trim()%>"></td>
								         	</tr>
								         	<tr>
								         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px"  align="center">һ�����ţ�</td>
								         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="personbumen" name="personbumen" value="<%=rs.getString("personbumen").trim()%>"></td>
								         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">�������ţ�</td>
								         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="person2bumen" name="person2bumen" value="<%=rs.getString("person2bumen").trim()%>"></td>
								         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">�������ţ�</td>
								         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="person3bumen" name="person3bumen" value="<%=rs.getString("person3bumen").trim()%>"></td>
								         	</tr>
								         	<tr>
								         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">��λְ��</td>
								         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="persongangweizhiwu" name="persongangweizhiwu" value="<%=rs.getString("persongangweizhiwu").trim()%>"></td>
								         	<td colspan=4 style="border:1px solid #CCCCCC;height:50px;"  align="center">
								         	<input type="submit" value="�޸��û�" onclick="javascript:return checkInsert();"></td>
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
			     	String s0="δ�ҵ����޸��û���";
					out.println("<script>alert('"+s0+"');window.location.href='neirong.jsp';</script>");  
			      };
 };

%>

</body>



</html>

