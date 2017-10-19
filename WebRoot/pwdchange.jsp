<%@ page contentType="text/html;charset=utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="css/indexkongzhiright.css">
<title>振华诚信信息管理系统</title>
</head>
<%
String quanxian=session.getAttribute("usernamecheck").toString().trim();
if(quanxian!=""||quanxian!=null){
System.out.println("可以查询！");
System.out.println(quanxian);
}else{
System.out.println("查询失败！");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
out.println("<script>window.alert('不合法用户');window.parent.location.href='"+basePath+"zhenhuaindex.html';</script>");
};
%>
<body id="changemimabody" onload="javascript:loadmimaye();">
	<form  name="changeform" method="post" target="_self" action="deal/dealmimachange.jsp">
		<div style="margin-left:30px;margin-top:20px;font-size:25px;">
			
			<table style="border:1px solid blue;">
			<tr>
			<td style="width:250px;text-align:center;height:50px;border:1px solid blue;">请输入原密码：</td>
			<td style="width:250px;text-align:center;height:50px;border:1px solid blue;"><input name="oldpwd" type="password"></td>
			</tr>
			<tr>
			<td style="width:250px;text-align:center;height:50px;border:1px solid blue;">请输入新密码：</td>
			<td style="width:250px;text-align:center;height:50px;border:1px solid blue;"><input name="firstpwd" type="password"></td>
			</tr>
			<tr>
			<td style="width:250px;text-align:center;height:50px;border:1px solid blue;">请再次输入新密码：</td>
			<td style="width:250px;text-align:center;height:50px;border:1px solid blue;"><input name="secondpwd" type="password"></td>
			</tr>
			<tr>
			<td style="width:200px;text-align:center;height:50px;border:1px solid blue;"><button id="checkmima" onClick="javacript:mimabijiao();">确定更改</button></td>
			<td style="width:200px;text-align:center;height:50px;border:1px solid blue;"><button id="quxiaomima" onClick="javacript:chongzhi();">重置输入</button></td>
			</tr>
			</table>
		</div>
	</form>
<script type="text/javascript">
function mimabijiao(){
var flag=false;
var oldpwd=document.getElementById("oldpwd").value;
var pwd1=document.getElementById("firstpwd").value;
var pwd2=document.getElementById("secondpwd").value;
	if(oldpwd!=null&&oldpwd!=""&&pwd1!=null&&pwd1!=""&&pwd2!=null&&pwd2!="")
	{	
			if(pwd1==pwd2)
			{
						if(pwd1.length<6||pwd1.length>16){
						alert("输入有误，密码长度为6-16位！");
						flag=false;
						}else{
						//alert("密码可以修改1");
						flag=true;
						};
			}else{
			flag=false;
			alert("两次输入的密码不一致，请重新输入！");
			};

	}else{		
	flag=false;
	alert("密码输入均不能为空！");
	};
	if(flag)
	{
	//alert("密码可以修改2");
	document.forms.namedItem("changeform").submit();
	}else{
	document.getElementById("oldpwd").focus();
	};
	return flag;
};
function chongzhi()
{
document.getElementById("oldpwd").value="";
document.getElementById("firstpwd").value="";
document.getElementById("secondpwd").value="";
document.getElementById("oldpwd").focus();
};
function loadmimaye(){
document.getElementById("oldpwd").value="";
document.getElementById("firstpwd").value="";
document.getElementById("secondpwd").value="";
document.getElementById("oldpwd").focus();
};
</script>

</body>

</html>

