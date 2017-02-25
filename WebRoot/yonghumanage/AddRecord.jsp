<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="zhenhua.sql.SqlUtils" pageEncoding="gb2312"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>振华诚信信息管理系统</title>
</head>

<body  onload="javascript:document.getElementById('personIDcard').focus();">
<script type="text/javascript">
function checkInsert()
{
var IDcard=document.getElementById("personIDcard").value;
var pwd=document.getElementById("personpwd").value;
var personname=document.getElementById("personname").value;
var personbumen=document.getElementById("personbumen").value;
var person2bumen=document.getElementById("person2bumen").value;
var person3bumen=document.getElementById("person3bumen").value;
var persongangweizhiwu=document.getElementById("persongangweizhiwu").value;
var flag=false;

	if(IDcard!=null&&IDcard!=""){
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
	}else{
	alert("请输入您的卡号！");
	document.getElementById("personIDcard").focus();
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

%>

<form action="AddRecord.jsp" method="post" name="formchaxun">
   <table cellspacing="0" cellpadding="0" style="margin-left:20px;margin-top:20px;border:1px solid #CCCCCC;height:200px;">
            <tr>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px"  align="center">卡号：</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="personIDcard" name="personIDcard"></td>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">用户名：</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="personname" name="personname"></td>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">密码：</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="personpwd"  name="personpwd" type="password"></td>
         	</tr>
         	<tr>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px"  align="center">一级部门：</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="personbumen" name="personbumen"></td>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">二级部门：</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="person2bumen" name="person2bumen"></td>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">三级部门：</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="person3bumen" name="person3bumen"></td>
         	</tr>
         	<tr>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">岗位职务：</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="persongangweizhiwu" name="persongangweizhiwu" ></td>
         	<td colspan=4 style="border:1px solid #CCCCCC;height:50px;"  align="center">
         	<input type="submit" value="添加用户" onclick="javascript:return checkInsert();"></td>
         	</tr>
   </table>

</form>
<% 
request.setCharacterEncoding("utf-8");
     	 boolean flag=false;
    	 boolean flagpanduan=false;
     	 String personIDcard=request.getParameter("personIDcard");
		 String personname=request.getParameter("personname");
	     String personpwd=request.getParameter("personpwd");
	     String personbumen=request.getParameter("personbumen");
	     String person2bumen=request.getParameter("person2bumen");
	     String person3bumen=request.getParameter("person3bumen");
	     String persongangweizhiwu=request.getParameter("persongangweizhiwu");
		System.out.println(personname);
	     if((personname!=null)&&(personpwd!=null)&&(personIDcard!=null)&&(personbumen!=null)&&(person2bumen!=null)&&(person3bumen!=null)&&(persongangweizhiwu!=null))
	     {
		     personname=personname.trim();
		     personpwd=personpwd.trim();
		     personIDcard=personIDcard.trim();
		     personbumen=personbumen.trim();
		     person2bumen=person2bumen.trim();
		     person3bumen=person3bumen.trim();
		     persongangweizhiwu=persongangweizhiwu.trim();
		     if((personname!=null)&&(personpwd!=null)&&(personIDcard!=null)&&(personbumen!=null)&&(person2bumen!=null)&&(person3bumen!=null)&&(persongangweizhiwu!=null))
		     {
		     flagpanduan=true;
		     };
		     System.out.println(flagpanduan+personname);
	     };
	     if(flagpanduan==true){     
			 	  try{
			      String sql="insert into person (personname,personpwd,personIDcard,personbumen,person2bumen,person3bumen,persongangweizhiwu) values (?,?,?,?,?,?,?)";    
				      if(request.getParameter("personIDcard")!=null)
					  {				
					    String [] param={personname,personpwd,personIDcard,personbumen,person2bumen,person3bumen,persongangweizhiwu};
					    SqlUtils sqlUtils=new SqlUtils();
						flag=sqlUtils.update(sql, param);
						System.out.println(flag);
									      	  if(flag==true) 
										      {
										      String s="用户添加成功";
											  out.println("<script>alert('"+s+"');</script>");
										      System.out.println(s);
										      }else
										      {
										      String s="用户添加失败，已存在此卡号的用户，请重新输入！";
											  out.println("<script>alert('"+s+"');</script>");
										      System.out.println(s);
										      };
					  };
			      }catch(Exception e){
			       System.out.println(e.getMessage());
			      };

			};
 

%>

</body>



</html>

