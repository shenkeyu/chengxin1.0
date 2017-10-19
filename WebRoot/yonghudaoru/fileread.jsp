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
function downfile(str)
{
  window.location.href = str;
}
</script>
<%
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian.equals("综合计划处")){
System.out.println("用户导入管理成功！");
}else{
System.out.println("用户导入管理失败！");
out.println("<script>window.alert('没有用户导入管理权限');window.location.href='"+basePath+"gerenxinyong/grxymain.jsp';</script>");
};
%>
  <body>
  <form name="form1" style="center" action="readfile" method="post" enctype="multipart/form-data">
  <label></label>
  <label></label>
  <table style="margin-left:40px;margin-top:25px;width:600px;cellspacing:0px;cellpadding:0px;border:0px;font-size:18px;">
    <tr>
    <td colspan=2 align="center" style="width:600px;height:30px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
    <b>用户导入</b>
    </td>      
    </tr>
    <tr>
      <td align="center" style="width:200px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
     <br>    
      选择读取文件
         <br>
         </td>
      <td align="center" style="width:400px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="file" name="file"  value="浏览"/>
      </label>
         <br>
         </td>
    </tr>
    <tr>
      <td align="center" style="width:200px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="submit" name="Submit" value="提    交" />
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
        <tr>
        <td colspan=2 align="center" style="width:600px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
               <br>
        <br>
        <input type="button" value="下载导入模板格式" onclick="javascript:downfile('moban.xlsx');">
        <br>
        <br>
        注意：不要更改excel表格的后缀名xlsx,不要更改首行对应的标题，不要更改表格中单张表格的名称“renyuan”!!!
                <br>
        <br>
					</td>
    </tr>
  </table>
</form>
<br>

  <form name="form2" style="center" action="readfilemingqi" method="post" enctype="multipart/form-data">
  <label></label>
  <label></label>
  <table style="margin-left:40px;margin-top:25px;width:600px;cellspacing:0px;cellpadding:0px;border:0px;font-size:18px;">
    <tr>
    <td colspan=2 align="center" style="width:600px;height:30px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
    <b>名企用户导入</b>
    </td>      
    </tr>
    <tr>
      <td align="center" style="width:200px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
     <br>    
      选择读取文件
         <br>
         </td>
      <td align="center" style="width:400px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="file" name="file"  value="浏览"/>
      </label>
         <br>
         </td>
    </tr>
    <tr>
      <td align="center" style="width:200px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="submit" name="Submit" value="提    交" />
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
        <tr>
        <td colspan=2 align="center" style="width:600px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
               <br>
        <br>
        <input type="button" value="下载导入模板格式" onclick="javascript:downfile('mobanmingqi.xlsx');">
        <br>
        <br>
        注意：不要更改excel表格的后缀名xlsx,不要更改首行对应的标题，不要更改表格中单张表格的名称“renyuan2”!!!
                <br>
        <br>
					</td>
    </tr>
  </table>
</form>
<br>

  <form name="formsgd" style="center" action="readfilesgd" method="post" enctype="multipart/form-data">
  <label></label>
  <label></label>
  <table style="margin-left:40px;margin-top:25px;width:600px;cellspacing:0px;cellpadding:0px;border:0px;font-size:18px;">
    <tr>
    <td colspan=2 align="center" style="width:600px;height:30px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
    <b>施工队导入</b>
    </td>      
    </tr>
    <tr>
      <td align="center" style="width:200px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
     <br>    
      选择读取文件
         <br>
         </td>
      <td align="center" style="width:400px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="file" name="file"  value="浏览"/>
      </label>
         <br>
         </td>
    </tr>
    <tr>
      <td align="center" style="width:200px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="submit" name="Submit" value="提    交" />
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
        <tr>
        <td colspan=2 align="center" style="width:600px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
               <br>
        <br>
        <input type="button" value="下载导入模板格式" onclick="javascript:downfile('mobansgd.xlsx');">
        <br>
        <br>
        注意：不要更改excel表格的后缀名xlsx,不要更改首行对应的标题，不要更改表格中单张表格的名称“renyuan3”!!!
                <br>
        <br>
					</td>
    </tr>
  </table>
</form>
<br>

  <form name="form3" style="center" action="readfilenei" method="post" enctype="multipart/form-data">
  <label></label>
  <label></label>
  <table style="margin-left:40px;margin-top:25px;width:600px;cellspacing:0px;cellpadding:0px;border:0px;font-size:18px;">
    <tr>
    <td colspan=2 align="center" style="width:600px;height:30px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
    <b>内分包商导入</b>
    </td>      
    </tr>
    <tr>
      <td align="center" style="width:200px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
     <br>    
      选择读取文件
         <br>
         </td>
      <td align="center" style="width:400px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="file" name="file"  value="浏览"/>
      </label>
         <br>
         </td>
    </tr>
    <tr>
      <td align="center" style="width:200px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="submit" name="Submit" value="提    交" />
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
        <tr>
        <td colspan=2 align="center" style="width:600px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
               <br>
        <br>
        <input type="button" value="下载导入模板格式" onclick="javascript:downfile('mobannei.xlsx');">
        <br>
        <br>
        注意：不要更改excel表格的后缀名xlsx,不要更改首行对应的标题，不要更改表格中单张表格的名称“qiye”!!!
                <br>
        <br>
					</td>
    </tr>
  </table>
</form>
<br>

  <form name="form4" style="center" action="readfilewai" method="post" enctype="multipart/form-data">
  <label></label>
  <label></label>
  <table style="margin-left:40px;margin-top:25px;width:600px;cellspacing:0px;cellpadding:0px;border:0px;font-size:18px;">
    <tr>
    <td colspan=2 align="center" style="width:600px;height:30px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
    <b>外分包商导入</b>
    </td>      
    </tr>
    <tr>
      <td align="center" style="width:200px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
     <br>    
      选择读取文件
         <br>
         </td>
      <td align="center" style="width:400px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="file" name="file"  value="浏览"/>
      </label>
         <br>
         </td>
    </tr>
    <tr>
      <td align="center" style="width:200px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="submit" name="Submit" value="提    交" />
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
        <tr>
        <td colspan=2 align="center" style="width:600px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
               <br>
        <br>
        <input type="button" value="下载导入模板格式" onclick="javascript:downfile('mobanwai.xlsx');">
        <br>
        <br>
        注意：不要更改excel表格的后缀名xlsx,不要更改首行对应的标题，不要更改表格中单张表格的名称“qiye2”!!!
                <br>
        <br>
					</td>
    </tr>
  </table>
</form>
<br>

  <form  name="form5" style="center" action="readfilegong" method="post" enctype="multipart/form-data">
  <label></label>
  <label></label>
  <table style="margin-left:40px;margin-top:25px;width:600px;cellspacing:0px;cellpadding:0px;border:0px;font-size:18px;">
    <tr>
    <td colspan=2 align="center" style="width:600px;height:30px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
    <b>供应商导入</b>
    </td>      
    </tr>
    <tr>
      <td align="center" style="width:200px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
     <br>    
      选择读取文件
         <br>
         </td>
      <td align="center" style="width:400px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="file" name="file"  value="浏览"/>
      </label>
         <br>
         </td>
    </tr>
    <tr>
      <td align="center" style="width:200px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="submit" name="Submit" value="提    交" />
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
        <tr>
        <td colspan=2 align="center" style="width:600px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
               <br>
        <br>
        <input type="button" value="下载导入模板格式" onclick="javascript:downfile('mobangong.xlsx');">
        <br>
        <br>
        注意：不要更改excel表格的后缀名xlsx,不要更改首行对应的标题，不要更改表格中单张表格的名称“qiye3”!!!
                <br>
        <br>
					</td>
    </tr>
  </table>
</form>

  <form  name="form6" style="center" action="readhmd" method="post" enctype="multipart/form-data">
  <label></label>
  <label></label>
  <table style="margin-left:40px;margin-top:25px;width:600px;cellspacing:0px;cellpadding:0px;border:0px;font-size:18px;">
    <tr>
    <td colspan=2 align="center" style="width:600px;height:30px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
    <b>黑名单导入</b>
    </td>      
    </tr>
    <tr>
      <td align="center" style="width:200px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
     <br>    
      选择读取文件
         <br>
         </td>
      <td align="center" style="width:400px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="file" name="file"  value="浏览"/>
      </label>
         <br>
         </td>
    </tr>
    <tr>
      <td align="center" style="width:200px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
         <br>
      <label>
        <input type="submit" name="Submit" value="提    交" />
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
        <tr>
        <td colspan=2 align="center" style="width:600px;height:80px;cellspacing:0px;cellpadding:0px;border:1px solid blue;font-size:18px;">
               <br>
        <br>
        <input type="button" value="下载导入模板格式" onclick="javascript:downfile('mobanhmd.xlsx');">
        <br>
        <br>
        注意：不要更改excel表格的后缀名xlsx,不要更改首行对应的标题!请载入全部的黑名单，此操作方式为全部替换方式！不要更改表格中单张表格的名称“hmd”!!!
                <br>
        <br>
					</td>
    </tr>
  </table>
</form>

  </body>
</html>
