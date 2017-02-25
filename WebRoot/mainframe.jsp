<%@ page contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>振华诚信信息管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="css/indexkongzhi.css">
</head>

<script type="text/javascript"> 
   function resetIframeSize()
    { 
    var a=document.body.clientWidth-260; 
    document.getElementById("frameright").style.width=a+"px";
    } 
window.onload=resetIframeSize; 
window.onresize=resetIframeSize;
    </script> 


<body id="mainbody">
<div id="Container">
    <div id="Header">
        <div id="logo">

     	  	 <table id="personinformation">
		    <tr>
 		     <td align="center">用户名：</td>
 		     <td align="center"><%=session.getAttribute("usernamecheck")%></td>
 		     <td align="center">职&nbsp;&nbsp;&nbsp;&nbsp;务：</td>
   		   <td align="center"><%=session.getAttribute("zhiwu")%></td>
  			  </tr>
 			   <tr>
		      <td align="center">部&nbsp;&nbsp;&nbsp;&nbsp;门：</td>
		      <td colspan="3" style="width:160px;" align="center"><%=session.getAttribute("bumen")%></td>
		      </tr>
			</table>
			
		      <div style="position:absolute;bottom:7px;right:0px;margin:0px;padding:0px;font-size:15px;">
		      <img src="image/bangzhu.png" alt="帮助" style="height:40px;width:30px;cursor:pointer;" onclick="javascript:window.open('guizhang.pdf','_blank','top=20,left=200,width=800,height=1000,menubar=no,scrollbars=yes,toolbar=no,status=no');"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		      <img src="image/zhuye.png" alt="主页" style="height:40px;width:30px;cursor:pointer;" onclick="javascript:window.location.href='mainframe.jsp';"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		      <img src="image/tuichu.png" alt="退出" style="height:40px;width:30px;cursor:pointer;" onclick="javascript:window.location.href='jieguo/zhuxiao.jsp';"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		      </div>		
			
         </div>
        
    </div>
    <div id="Content">
        <iframe src="leftframe.jsp" id="frameleft"  marginheight="0" marginwidth="0"  scrolling="no" frameborder="0"> </iframe>
 		 <iframe src="gerenxinyong/grxymain.jsp" id="frameright"  marginheight="0" marginwidth="0" frameborder="0"> </iframe>
	</div>

    <div class="Clear"></div>
    <div id="Footer" style="color:white;text-align:center;">
    <div style="margin-top:12px;">
   ©CopyRight 2016 Inc All Rights Reserved. 上海滴创电子科技有限公司 版权所有
    </div>
    </div>
</div>
<span style="color: #4083E2"></span>
<span style="color: #FFFFFF"></span>
</body>
</html>

