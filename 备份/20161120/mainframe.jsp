
<%@ page contentType="text/html;charset=utf-8"%>
<%
request.setCharacterEncoding("utf-8");
String username=request.getParameter("name");
String pwd=request.getParameter("password");
 %>
<html>
<head>
<title>振华诚信信息管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="css/indexkongzhi.css">
</head>

<body id="mainbody">
<div id="Container">
    <div id="Header">
        <div id="logo">
       		 <div id="person">
     	  	 <table id="personinformation">
		    <tr>
 		     <td>用户名：<%=username%></td>
 		     <td>&nbsp;</td>
 		     <td>职务：</td>
   		   <td>&nbsp;</td>
  			  </tr>
 			   <tr>
		      <td>部门：</td>
		      <td colspan="3">&nbsp;</td>
			</table>
          	 </div>
        </div>
    </div>
    <div id="Content">
        <iframe src="leftframe.jsp" id="frameleft"  marginheight="0" marginwidth="0"  scrolling="no" frameborder="0"> </iframe>
 		 <iframe src="mainneirong.jsp" id="frameright"  marginheight="0" marginwidth="0"  scrolling="no" frameborder="0"> </iframe>
	</div>

    <div class="Clear"></div>
    <div id="Footer">Footer</div>
</div>
<span style="color: #4083E2"></span>
<span style="color: #FFFFFF"></span>
</body>
</html>

