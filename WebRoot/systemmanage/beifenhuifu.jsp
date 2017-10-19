<%@ page language="java"  pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">    
    <title>用户导入</title>    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  <script language=javascript>
function openDialog(type){
    var fd = new ActiveXObject("MSComDlg.CommonDialog");
    fd.Filter = type;
    fd.FilterIndex = 2; 
     fd.MaxFileSize = 128;
    fd.ShowSave();
    if(fd.filename=="" || fd.filename.length<1)
    {return false;};
    document.getElementById("filepathcun").value=fd.filename;
    document.form2.submit();
    return true;
};
function check(){  
 var obj=document.getElementByid("file");
var path=getFullPath(obj);  
    document.getElementById("realpath").value=path;
    document.form1.submit();
    return true;
}; 
function get(id){
var obj=document.getElementByid("file");
var path=getFullPath(obj);
document.getElementById("realpath").value=path;
return true;
};
function getFullPath(obj) 
{ 
	if(obj) 
	{ 	
	if (window.navigator.userAgent.indexOf("MSIE")>=1) //ie 
	{ 
	obj.select(); 
	return document.selection.createRange().text; 
	}else if(window.navigator.userAgent.indexOf("Firefox")>=1) //firefox 
	{ 
	if(obj.files) 
	{ 
	return obj.files.item(0).getAsDataURL(); 
	}; 
	return obj.value; 
	}; 
	return obj.value; 
	}; 
};
</script>

  <body>
 <%
 String quanxian=session.getAttribute("bumen").toString().trim();
 if(quanxian.equals("综合计划处")){
System.out.println("管理成功！");
}else{
System.out.println("管理失败！");
out.println("<script>window.alert('没有备份恢复权限');window.location.href='"+basePath+"gerenxinyong/grxymain.jsp';</script>");
}; 
  %>
  <table>
<tr>
<td><center>
  <form name="form1" style="center" action="<%=basePath%>/systemmanage/huifu.jsp" method="post" enctype="multipart/form-data" onsubmit="return check();">
  <label></label>
  <label></label>
  <table style="margin-left:40px;margin-top:25px;width:600px;cellspacing:0px;cellpadding:0px;border:0px;font-size:18px;">
    <tr>
    <td colspan=2 align="center" style="width:600px;height:30px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
    <b>备份恢复模块</b>
    </td>      
    </tr>
    <tr>
      <td align="center" style="width:200px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
     <br>    
      选择恢复的系统文件
         <br>
         </td>
      <td align="center" style="width:400px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="file" name="file" id="file" value="浏览" onchange="get('path')"/>
        <input type="hidden"  id="realpath" name="realpath" value="">
      </label>
         <br>
         </td>
    </tr>
    <tr>
      <td align="center" style="width:200px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="submit" name="Submit" value="系统恢复" />
      </label> 
         <br>
         </td>
      <td align="center"  style="width:400px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="reset" name="Submit2" value="重    置" />
      </label>
         <br>
      </td>
    </tr>
    </table>
    </form>
    </center>
    </td>
    </tr>
        <tr>
        <td colspan=2 align="center">
        <form name="form2" style="center" action="<%=basePath%>/systemmanage/beifen.jsp" method="post" enctype="multipart/form-data"  onsubmit="javascript:return openDialog('*.*');">
        <br><input type="hidden" id="filepathcun" name="filepathcun"> <input type="submit" value="备份系统">
        <br>
        <br>
        <br>
        数据备份在D盘目录下，按照时间进行备份递增
        </form>

	</td>
    </tr>
   </table> 

  </body>
</html>
