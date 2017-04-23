<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="zhenhua.sql.SqlUtils,zhenhua.sql.Persons,java.util.List,java.sql.*" pageEncoding="gb2312"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>振华诚信信息管理系统</title>
</head>

<body  onload="javascript:document.getElementById('dizhi').focus();">
<script type="text/javascript">
function checkInsert()
{

var dizhi=document.getElementById("dizhi").value;
var faren=document.getElementById("faren").value;
var ziben=document.getElementById("ziben").value;
var chengliriqi=document.getElementById("chengliriqi").value;
var yingyeriqi=document.getElementById("yingyeriqi").value;


if(faren.length==""){
		window.alert("请输入法人代表名！");
		document.getElementById("faren").focus();
		return false;
};
if(dizhi.length==""){
		window.alert("请输入地址！");
		document.getElementById("dizhi").focus();
		return false;
};
if(ziben.length==""){
		window.alert("请输入注册资本！");
		document.getElementById("ziben").focus();
		return false;
};
if(chengliriqi.length==""){
		window.alert("请输入成立日期！");
		document.getElementById("chengliriqi").focus();
		return false;
};
if(yingyeriqi.length==""){
		window.alert("请输入营业期限！");
		document.getElementById("yingyeriqi").focus();
		return false;
};


if(isNaN(ziben))//验证资本为数字
{
		window.alert("注册资本应为数字！");
		document.getElementById("ziben").focus();
		return false;
};


if(isDate(chengliriqi)==false)
{
return false;
}
if(isDate(yingyeriqi)==false)
{
return false;
}

return true;

};
function isDate(str){  
  //如果是正确的日期格式返回true,否则返回false  
  //var regExp=/\b\d{4}-\d{1,2}-\d{1,2}\b/;  
    //判断整体格式yyyy-mm-dd  
    if (str!=str.match(/\d{4}.\d{2}.\d{2}/ig))  {  
        alert('请输入日期格式为：yyyy.mm.dd!');  
        return false;  
    }  
  
    var tmpArr=str.split('.');  
      
   var rYear=parseInt(tmpArr[0]);  
    var rMonth=parseInt(tmpArr[1]);  
    var rDay=parseInt(tmpArr[2]);  
    //判断月  
    if((rMonth>12)||(rMonth<1)){  
    alert('月份输入错误!');  
    return false;  
    };  
    
    if(rYear>9999){  
    alert('年份输入错误!');  
    return false;  
    }; 
  
  var rYearflag=false;  
  
    //判断润年  
    if (((rYear%100)==0)&&((rYear%4)==0)){  
      rYearflag=true;  
    }else if((rYear%4) == 0){  
      rYearflag=true;  
    }else{  
    rYearflag=false;   
    };  
  
    if(((",1,3,5,7,8,10,12,").indexOf(","+rMonth+",")!=-1)&&(rDay<32)){  
      return true;  
    }else if(((",4,6,9,11,").indexOf(","+rMonth+",") !=-1)&&(rDay<31)){  
      return true;  
    }else if(rDay<29){  
    return true;  
    }else if(rYearflag&&(rDay<30)){  
    return true;  
    }else{  
    alert('天输入错误!');  
    return false;  
  	};  
};
</script>
<%
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian.equals("综合计划处")){
System.out.println("用户管理成功！");
}else{
System.out.println("用户管理失败！");
out.println("<script>window.location.href='。。/../zhenhuaindex.html';</script>");
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
			String sql ="select * from wai where id="+personIDcard.trim();		
			ResultSet rs = stmt.executeQuery(sql);
				while(rs.next())
				{				
				System.out.println("查到此企业");
%>

<form action="doupdateRecord.jsp" method="post" id="formchaxun" onsubmit="javascript:return checkInsert();">
   <table cellspacing="0" cellpadding="0" style="margin-left:20px;margin-top:20px;border:1px solid #CCCCCC;height:200px;">
            <tr>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">公司名称：</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><%=rs.getString("name").trim()%><input
					type="hidden" name="recordid" id="recordid" value=<%=Integer.toString(rs.getInt("id"))%>></td>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px"  align="center">地址：</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="dizhi" name="dizhi" value="<%=rs.getString("dizhi").trim()%>"></td>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">法人代表：</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="faren" name="faren" value="<%=rs.getString("faren").trim()%>"></td>

         	</tr>
         	<tr>

         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">注册资本<br>（万元，此处只填写数字）：</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="ziben" name="ziben" value="<%=rs.getString("ziben").trim()%>"></td>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">成立日期：<br>(2000.01.01)</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="chengliriqi" name="chengliriqi" value="<%=rs.getString("chengliriqi").trim()%>"></td>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">营业期限：<br>(2000.01.01)</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="yingyeriqi" name="yingyeriqi" value="<%=rs.getString("yingyeriqi").trim()%>"></td>
         	</tr>

         	<tr>
         	<td colspan=6 style="border:1px solid #CCCCCC;height:50px;"  align="center">
         	<input type="submit" value="修改用户" ></td>
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
			     	String s0="未找到待修改企业！";
					out.println("<script>alert('"+s0+"');window.location.href='neirong.jsp';</script>");  
			      };
 };

%>

</body>



</html>

