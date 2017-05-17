<%@ page language="java" import="java.sql.*" contentType="text/html; charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>">
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
String quanxian1=session.getAttribute("bumen").toString().trim();
String quanxian2=session.getAttribute("bumen2").toString().trim();
String quanxian3=session.getAttribute("bumen3").toString().trim();
if(quanxian1!=""||quanxian1!=null){
System.out.println("可以查询！");
}else{
System.out.println("查询失败！");
out.println("<script>window.parent.location.href='../zhenhuaindex.html';</script>");
};
if(quanxian1.equals("工艺装备部")||quanxian1.equals("QHSE部")||quanxian1.equals("生产管理部")){
System.out.println("有权限查询111！");
}else{
System.out.println("无查询权限！");
};
%>
<body>
<div style="top:13px;left:20px;"></div>
<% /////////////////////////////////////////////分隔线//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////%>
<%if(quanxian1.equals("生产管理部")){ %>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
     //设置每张网页显示三笔记录(每页显示的记录数)
     int PageSize=2;
     
     //设置欲显示的页数(初始页)
     int ShowPage=1;
     
     //ResultSet的记录笔数(总记录数)
     int RowCount=0;
     
     //ResultSet分页后的总数(总页数)
     int PageCount=0;
     
     Connection conn=null;
     Statement stmt=null;
     ResultSet rs=null;
     String s1=null,s2=null;
     if(request.getParameter("neinamepjcha")!=null)
     {
    s1=new String(request.getParameter("neinamepjcha").getBytes("ISO-8859-1"),"gb2312");
    s1=s1.trim();
     session.setAttribute("neinamepjcha", s1);
     };
     if(request.getParameter("neijifenpjcha")!=null)
     {
     s2=new String(request.getParameter("neijifenpjcha").getBytes("ISO-8859-1"),"gb2312");
     s2=s2.trim();
     session.setAttribute("neijifenpjcha", s2);
     };
     System.out.println("11111111生产管理部");
		System.out.println(session.getAttribute("neinamepjcha").toString());
		System.out.println(session.getAttribute("neijifenpjcha").toString());
		String panduan=session.getAttribute("neinamepjcha").toString().trim();//判断卡号不为空再执行
	if(panduan!=""){
	%>
	
	<%
     //连接数据库并初始数据
      try{
       Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//设置连接的数据库      
		String USER = session.getAttribute("ssYONGHU").toString();
		String PWD = session.getAttribute("ssMIMA").toString();
		conn = DriverManager.getConnection(URL, USER, PWD);
       stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
       String sql="select * from neistandardhe "; 
       if(session.getAttribute("neinamepjcha")==null||session.getAttribute("neinamepjcha").equals(""))
       {
           if(session.getAttribute("neijifenpjcha")==null||session.getAttribute("neijifenpjcha").equals(""))
	       {
	      System.out.println("s2:"+session.getAttribute("neijifenpjcha"));
	    	}else{
	    	 sql=sql+" where neido Like '%"+session.getAttribute("neijifenpjcha")+"%' and fenshucheck=1";
	    	};
    	}else{
    	 System.out.println("s1:"+session.getAttribute("neinamepjcha"));
	       if(session.getAttribute("neijifenpjcha")==null||session.getAttribute("neijifenpjcha").equals(""))
	       {
	       sql=sql+" where name like '%"+session.getAttribute("neinamepjcha")+"%' and fenshucheck=1";
	    	}else{
	       sql=sql+" where neido Like '%"+session.getAttribute("neijifenpjcha")+"%' and name like '%"+session.getAttribute("neinamepjcha")+"%' and fenshucheck=1";
	    	};
    	};
    	System.out.println(sql);
       rs=stmt.executeQuery(sql);
       //将指标移至最后一条记录
       rs.last();       
       //获取记录总数       
       RowCount=rs.getRow();
       System.out.println(RowCount);
       //计算显示的页数(关键)
       PageCount=((RowCount%PageSize)==0?(RowCount/PageSize):(RowCount/PageSize)+1);
      }catch(Exception e){
       System.out.println(e.getMessage());
      };
  
if(RowCount>0){  %>  
     
<center>
 <%
     String ToPage=request.getParameter("ToPage");     
     //判断是否取得ToPage参数
     if(ToPage!=null)
     {
      //取得指定显示的分页页数
      ShowPage=Integer.parseInt(ToPage);      
      //下面的语句判断用户输入的页数是否正确
      if(ShowPage>=PageCount)
      {
       ShowPage=PageCount;
      }
      else if(ShowPage<=0)
      {
       ShowPage=1;
      }
     }; 
     System.out.println(PageSize); 
     rs.first();
     //计算欲显示页的第一笔记录位置
     rs.absolute((ShowPage-1)*PageSize+1); 
    %>
    <h3>当前在第
    <font size="4" color="red"><%=ShowPage %></font>页,共<%=PageCount %>页</h3>
    <p>
   
   	<table cellspacing="0" cellpadding="0" style="margin-left:0px;margin-top:5px;border:1px solid #CCCCCC;width:98%;">
   	<tr>
   	<td colspan=5  style="border:1px solid #CCCCCC;font-size:20px;height:28px;"  align="center">
   	<div style=""><br>生产进度评价</br></div>
   	</td> 
   	</tr> 
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">内分包商名称</td>
	<td style="border:1px solid #CCCCCC;height:20px;width:500px;"  align="center">计分规则</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">分值</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">操作</td>
	</tr> 
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs.getString("name")%></td>
	<td style="border:1px solid #CCCCCC;height:20px;width:500px;"  align="left">

	该公司生产节点达到的完成率目标为：<input id="shengchanmubiao">
	</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="left">按照红头文件上公式计算</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">
	<form style="center" action="Neishengchanjifen" method="post"  onsubmit="return jisuan();">
	<input name="neiname" type="hidden" value="<%=rs.getString("name")%>">
	<input name="neifen" id="neifenscl" type="hidden" value="0">
	<input name="neifenshu" type="hidden" value="<%=rs.getString("fenshu")%>">
	<input name="neido" type="hidden" value="生产节点考核">
	<input name="fenshucheck" type="hidden" value="<%=rs.getString("fenshucheck")%>">
	<input name="erjicheck" type="hidden" value="1">
	<input type="submit" value="计分">
	<script type="text/javascript">
	function jisuan()
    {
    var flag=confirm('确认开展计分处理吗？确认，将对此用户此项进行计分');
    var tei=0;
    var te=0.0;
    var fen=0.0;
	if(flag){
	    var mubiao=0;
	    mubiao=window.document.getElementById("shengchanmubiao").value;
		    if(mubiao!=""&&mubiao!=null)
		    {
		    	var reg=/^[1-9]\d*$|^0$/; // 注意：故意限制了 0321 这种格式，如不需要，直接reg=/^\d+$/;
			    if(reg.test(mubiao)==true)
			    {
			    tei=parseInt(mubiao-90);
			    te=parseFloat(tei);
			    		if(te>=10.0){
					    fen=100.0;
					    }else if((te>=8.0)&&(te<10.0)){
					    fen=95.0;
					    }else if((te>=0.0)&&(te<8.0)){
					    var mubiaof=parseFloat(mubiao/100);
					    fen=((1-(1-mubiaof)*2)*100);
					    }else if(te<0.0){
					    var mubiaof=parseFloat(mubiao/100);
					    fen=((1-(1-mubiaof)*3)*100);
					    };
					    if(fen<0.0){
					    fen=0.0;
					    };
			    var fanhui=0.0;
			    fanhui=fen-100.0;
			    fanhui=parseFloat(fanhui).toFixed(2);
			     alert("计分成功！"+"扣"+(-fanhui)+"分");
			    window.document.getElementById("neifenscl").value=fanhui;
			   // window.document.getElementsByName("neido").value="低于质量目标"+(-fen)+"个百分点扣"+(-fanhui)+"分";
			    return true;
			    }else{
			    alert("输入的完成率不是纯数字！失败！");
   				return false;
			    };
		    }else{
		    alert("输入的完成率不能为空！失败！");
		    return false;
		    };
	 }else{
	 return false;
	 }; 
    };
 	</script>
	</form>
	</td>
	</tr>      
    <%
     //利用for循环配合PageSize属性取出一页中的数据
     for(int i=1;i<=PageSize;i++)
     {
    %>  
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs.getString("name")%></td>
	<td style="border:1px solid #CCCCCC;height:20px;width:500px;"  align="left"><%=rs.getString("neido") %></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="left"><%=rs.getString("neifen") %></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">
	
	<form style="center" action="Neishengchanjifen" method="post">
	<input name="neiname" type="hidden" value="<%=rs.getString("name")%>">
	<input name="neido" type="hidden" value="<%=rs.getString("neido")%>">
	<input name="neifen" type="hidden" value="<%=rs.getString("neifen")%>">
	<input name="neifenshu" type="hidden" value="<%=rs.getString("fenshu")%>">
	<input name="fenshucheck" type="hidden" value="<%=rs.getString("fenshucheck")%>">
	<input name="erjicheck" type="hidden" value="<%=rs.getString("erjicheck")%>">
	<input type="submit" onClick="return confirm('确认开展计分处理吗？确认，将对此用户此项进行计分');" value="计分">
	</form>
	</td>
	</tr>
     <p>    
     <%
      //下面的语句用于输出最后一条记录时,将指针移到最后一笔记录之后
       if(!rs.next())
       {
        //跳出for循环
        break;
       }
      };
      %>
      </table>      
      
      <table>
       <tr>
      <%
       //判断当前是否在第一页,不是第一页，则显示到第一页与下一页的连接
       if(ShowPage!=1)
       {
      %>
       <td width=150>
        <a href="neipingjia/neipjmain.jsp?ToPage=<%=1 %>">第一页</a>
       </td> 
       <td width=150>
        <a href="neipingjia/neipjmain.jsp?ToPage=<%=ShowPage-1 %>">上一页</a>
       </td>
      <% 
       }
       //判断是否在最后一页，是，则显示到最后一页和下一页
       if(ShowPage!=PageCount)
       {
       %>
        <td width=150>
         <a href="neipingjia/neipjmain.jsp?ToPage=<%=ShowPage+1 %>">下一页</a>
        </td>
        <td width=150>
         <a href="neipingjia/neipjmain.jsp?ToPage=<%=PageCount %>">最后一页</a>
        </td>
        <%
         }
         %>
         </tr>
         <tr>
         <td colspan="4" align="center">
          <form action="neipingjia/neipjmain.jsp" method="post" name="form1">
           <input type="text" name="ToPage" value="<%=ShowPage %>" style="height:25px;width:40px">页
            <a href="javascript:window.document.form1.submit();">GO</a>
          </form>
         </td>
         </tr>
       </table>

   <script language="javascript">
    function go()
    {
       window.document.form1.submit();
    };
   </script>
</center>

 <%}else{
out.println("<center>不存在此记录！</center>");
 };  
     //执行关闭各个对象的操作
    try{
     rs.close();
     stmt.close();
     conn.close();
    }catch(Exception e){
     System.out.println(e.getMessage());
    };
        };//panduan的结束
 %>
<%////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// %>
<%
     //设置每张网页显示三笔记录(每页显示的记录数)
     int PageSize1=2;
     
     //设置欲显示的页数(初始页)
     int ShowPage1=1;
     
     //ResultSet的记录笔数(总记录数)
     int RowCount1=0;
     
     //ResultSet分页后的总数(总页数)
     int PageCount1=0;
     
     Connection conn1=null;
     Statement stmt1=null;
     ResultSet rs1=null;
		String panduan1=session.getAttribute("neinamepjcha").toString().trim();//判断卡号不为空再执行
	if(panduan1!=""){
	%>
	
	<%
     //连接数据库并初始数据
      try{
       Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//设置连接的数据库      
		String USER = session.getAttribute("ssYONGHU").toString();
		String PWD = session.getAttribute("ssMIMA").toString();
		conn1 = DriverManager.getConnection(URL, USER, PWD);
       stmt1=conn1.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
       String sql="select * from neistandardhe "; 
       if(session.getAttribute("neinamepjcha")==null||session.getAttribute("neinamepjcha").equals(""))
       {
           if(session.getAttribute("neijifenpjcha")==null||session.getAttribute("neijifenpjcha").equals(""))
	       {
	      System.out.println("s2:"+session.getAttribute("neijifenpjcha"));
	    	}else{
	    	 sql=sql+" where neido Like '%"+session.getAttribute("neijifenpjcha")+"%' and fenshucheck=4";
	    	};
    	}else{
    	 System.out.println("s1:"+session.getAttribute("neinamepjcha"));
	       if(session.getAttribute("neijifenpjcha")==null||session.getAttribute("neijifenpjcha").equals(""))
	       {
	       sql=sql+" where name like '%"+session.getAttribute("neinamepjcha")+"%' and fenshucheck=4";
	    	}else{
	       sql=sql+" where neido Like '%"+session.getAttribute("neijifenpjcha")+"%' and name like '%"+session.getAttribute("neinamepjcha")+"%' and fenshucheck=4";
	    	};
    	};
    	System.out.println(sql);
       rs1=stmt1.executeQuery(sql);
       //将指标移至最后一条记录
       rs1.last();       
       //获取记录总数       
       RowCount1=rs1.getRow();
       System.out.println(RowCount1);
       //计算显示的页数(关键)
       PageCount1=((RowCount1%PageSize1)==0?(RowCount1/PageSize1):(RowCount1/PageSize1)+1);
      }catch(Exception e){
       System.out.println(e.getMessage());
      };
  
if(RowCount1>0){  %>  
     
<center>
 <%
     String ToPage1=request.getParameter("ToPage1");     
     //判断是否取得ToPage参数
     if(ToPage1!=null)
     {
      //取得指定显示的分页页数
      ShowPage1=Integer.parseInt(ToPage1);      
      //下面的语句判断用户输入的页数是否正确
      if(ShowPage1>=PageCount1)
      {
       ShowPage1=PageCount1;
      }
      else if(ShowPage1<=0)
      {
       ShowPage1=1;
      }
     }; 
     System.out.println(PageSize1); 
     rs1.first();
     //计算欲显示页的第一笔记录位置
     rs1.absolute((ShowPage1-1)*PageSize1+1); 
    %>
    <h3>当前在第
    <font size="4" color="red"><%=ShowPage1 %></font>页,共<%=PageCount1 %>页</h3>
    <p>
   
   	<table cellspacing="0" cellpadding="0" style="margin-left:0px;margin-top:5px;border:1px solid #CCCCCC;width:98%;">
   	<tr>
   	<td colspan=5  style="border:1px solid #CCCCCC;font-size:20px;height:28px;"  align="center">
   	<div style=""><br>经验管理评价</br></div>
   	</td> 
   	</tr> 
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">用户名</td>
	<td style="border:1px solid #CCCCCC;height:20px;width:500px;"  align="center">计分规则</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">分值</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">操作</td>
	</tr>    
    <%
     //利用for循环配合PageSize属性取出一页中的数据
     for(int i=1;i<=PageSize1;i++)
     {
    %>  
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs1.getString("name")%></td>
	<td style="border:1px solid #CCCCCC;height:20px;width:500px;"  align="left"><%=rs1.getString("neido") %></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="left"><%=rs1.getString("neifen") %></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">
	
	<form style="center" action="Neijingyanjifen" method="post" >
	<input name="neiname" type="hidden" value="<%=rs1.getString("name")%>">
	<input name="neido" type="hidden" value="<%=rs1.getString("neido")%>">
	<input name="neifen" type="hidden" value="<%=rs1.getString("neifen")%>">
	<input name="neifenshu" type="hidden" value="<%=rs1.getString("fenshu")%>">
	<input name="erjicheck" type="hidden" value="<%=rs1.getString("erjicheck")%>">
	<input type="submit" onClick="return confirm('确认开展计分处理吗？确认，将对此用户此项进行计分');" value="计分">
	</form>
	</td>
	</tr>
     <p>    
     <%
      //下面的语句用于输出最后一条记录时,将指针移到最后一笔记录之后
       if(!rs1.next())
       {
        //跳出for循环
        break;
       }
      };
      %>
      </table>      
      
      <table>
       <tr>
      <%
       //判断当前是否在第一页,不是第一页，则显示到第一页与下一页的连接
       if(ShowPage1!=1)
       {
      %>
       <td width=150>
        <a href="neipingjia/neipjmain.jsp?ToPage=<%=1 %>">第一页</a>
       </td> 
       <td width=150>
        <a href="neipingjia/neipjmain.jsp?ToPage=<%=ShowPage1-1 %>">上一页</a>
       </td>
      <% 
       }
       //判断是否在最后一页，是，则显示到最后一页和下一页
       if(ShowPage1!=PageCount1)
       {
       %>
        <td width=150>
         <a href="neipingjia/neipjmain.jsp?ToPage=<%=ShowPage1+1 %>">下一页</a>
        </td>
        <td width=150>
         <a href="neipingjia/neipjmain.jsp?ToPage=<%=PageCount1 %>">最后一页</a>
        </td>
        <%
         }
         %>
         </tr>
         <tr>
         <td colspan="4" align="center">
          <form action="neipingjia/neipjmain.jsp" method="post" name="form4">
           <input type="text" name="ToPage" value="<%=ShowPage1 %>" style="height:25px;width:40px">页
            <a href="javascript:go1();">GO</a>
          </form>
         </td>
         </tr>
       </table>

   <script language="javascript">
    function go1()
    {
       window.document.form4.submit();
    };
   </script>
</center>

 <%}else{
out.println("<center>不存在此记录！</center>");
 };  
     //执行关闭各个对象的操作
    try{
     rs1.close();
     stmt1.close();
     conn1.close();
    }catch(Exception e){
     System.out.println(e.getMessage());
    };
        };//panduan的结束
 %>	
<%//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// %>
			
<%
     //设置每张网页显示三笔记录(每页显示的记录数)
     int PageSize2=2;
     
     //设置欲显示的页数(初始页)
     int ShowPage2=1;
     
     //ResultSet的记录笔数(总记录数)
     int RowCount2=0;
     
     //ResultSet分页后的总数(总页数)
     int PageCount2=0;
     
     Connection conn2=null;
     Statement stmt2=null;
     ResultSet rs2=null;
		String panduan2=session.getAttribute("neinamepjcha").toString().trim();//判断卡号不为空再执行
	if(panduan2!=""){
	%>
	
	<%
     //连接数据库并初始数据
      try{
       Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//设置连接的数据库      
		String USER = session.getAttribute("ssYONGHU").toString();
		String PWD = session.getAttribute("ssMIMA").toString();
		conn2 = DriverManager.getConnection(URL, USER, PWD);
       stmt2=conn2.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
       String sql="select * from neistandardhe "; 
       if(session.getAttribute("neinamepjcha")==null||session.getAttribute("neinamepjcha").equals(""))
       {
           if(session.getAttribute("neijifenpjcha")==null||session.getAttribute("neijifenpjcha").equals(""))
	       {
	      System.out.println("s2:"+session.getAttribute("neijifenpjcha"));
	    	}else{
	    	 sql=sql+" where neido Like '%"+session.getAttribute("neijifenpjcha")+"%' and fenshucheck=6";
	    	};
    	}else{
    	 System.out.println("s1:"+session.getAttribute("neinamepjcha"));
	       if(session.getAttribute("neijifenpjcha")==null||session.getAttribute("neijifenpjcha").equals(""))
	       {
	       sql=sql+" where name like '%"+session.getAttribute("neinamepjcha")+"%' and fenshucheck=6";
	    	}else{
	       sql=sql+" where neido Like '%"+session.getAttribute("neijifenpjcha")+"%' and name like '%"+session.getAttribute("neinamepjcha")+"%' and fenshucheck=6";
	    	};
    	};
    	System.out.println(sql);
       rs2=stmt2.executeQuery(sql);
       //将指标移至最后一条记录
       rs2.last();       
       //获取记录总数       
       RowCount2=rs2.getRow();
       System.out.println(RowCount2);
       //计算显示的页数(关键)
       PageCount2=((RowCount2%PageSize2)==0?(RowCount2/PageSize2):(RowCount2/PageSize2)+1);
      }catch(Exception e){
       System.out.println(e.getMessage());
      };
  
if(RowCount2>0){  %>  
     
<center>
 <%
     String ToPage2=request.getParameter("ToPage");     
     //判断是否取得ToPage参数
     if(ToPage2!=null)
     {
      //取得指定显示的分页页数
      ShowPage2=Integer.parseInt(ToPage2);      
      //下面的语句判断用户输入的页数是否正确
      if(ShowPage2>=PageCount2)
      {
       ShowPage2=PageCount2;
      }
      else if(ShowPage2<=0)
      {
       ShowPage2=1;
      }
     }; 
     System.out.println(PageSize2); 
     rs2.first();
     //计算欲显示页的第一笔记录位置
     rs2.absolute((ShowPage2-1)*PageSize2+1); 
    %>
    <h3>当前在第
    <font size="4" color="red"><%=ShowPage2 %></font>页,共<%=PageCount2 %>页</h3>
    <p>
   
   	<table cellspacing="0" cellpadding="0" style="margin-left:0px;margin-top:5px;border:1px solid #CCCCCC;width:98%;">
   	<tr>
   	<td colspan=5  style="border:1px solid #CCCCCC;font-size:20px;height:28px;"  align="center">
   	<div style=""><br>综合管理评价</br></div>
   	</td> 
   	</tr> 
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">用户名</td>
	<td style="border:1px solid #CCCCCC;height:20px;width:500px;"  align="center">计分规则</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">分值</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">操作</td>
	</tr>    
    <%
     //利用for循环配合PageSize属性取出一页中的数据
     for(int i=1;i<=PageSize2;i++)
     {
    %>  
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs2.getString("name")%></td>
	<td style="border:1px solid #CCCCCC;height:20px;width:500px;"  align="left"><%=rs2.getString("neido") %></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="left"><%=rs2.getString("neifen") %></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">
	
	<form style="center" action="Neizonghejifen" method="post" name="formzh">
	<input name="neiname" type="hidden" value="<%=rs2.getString("name")%>">
	<input name="neido" type="hidden" value="<%=rs2.getString("neido")%>">
	<input name="neifen" type="hidden" value="<%=rs2.getString("neifen")%>">
	<input name="neifenshu" type="hidden" value="<%=rs2.getString("fenshu")%>">
	<input name="erjicheck" type="hidden" value="<%=rs2.getString("erjicheck")%>">
	<input type="submit" onClick="return confirm('确认开展计分处理吗？确认，将对此用户此项进行计分');" value="计分">
	</form>
	</td>
	</tr>
     <p>    
     <%
      //下面的语句用于输出最后一条记录时,将指针移到最后一笔记录之后
       if(!rs2.next())
       {
        //跳出for循环
        break;
       }
      };
      %>
      </table>      
      
      <table>
       <tr>
      <%
       //判断当前是否在第一页,不是第一页，则显示到第一页与下一页的连接
       if(ShowPage2!=1)
       {
      %>
       <td width=150>
        <a href="neipingjia/neipjmain.jsp?ToPage=<%=1 %>">第一页</a>
       </td> 
       <td width=150>
        <a href="neipingjia/neipjmain.jsp?ToPage=<%=ShowPage2-1 %>">上一页</a>
       </td>
      <% 
       }
       //判断是否在最后一页，是，则显示到最后一页和下一页
       if(ShowPage2!=PageCount2)
       {
       %>
        <td width=150>
         <a href="neipingjia/neipjmain.jsp?ToPage=<%=ShowPage2+1 %>">下一页</a>
        </td>
        <td width=150>
         <a href="neipingjia/neipjmain.jsp?ToPage=<%=PageCount2 %>">最后一页</a>
        </td>
        <%
         }
         %>
         </tr>
         <tr>
         <td colspan="4" align="center">
          <form action="neipingjia/neipjmain.jsp" method="post" name="form6">
           <input type="text" name="ToPage" value="<%=ShowPage2 %>" style="height:25px;width:40px">页
            <a href="javascript:go2();">GO</a>
          </form>
         </td>
         </tr>
       </table>

   <script language="javascript">
    function go2()
    {
       window.document.form6.submit();
    };
   </script>
</center>

 <%}else{
out.println("<center>不存在此记录！</center>");
 };  
     //执行关闭各个对象的操作
    try{
     rs2.close();
     stmt2.close();
     conn2.close();
    }catch(Exception e){
     System.out.println(e.getMessage());
    };
    };//panduan的结束
 %>				
<% /////////////////////////////////////////////分隔线//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////%>		                               
			<%}else if(quanxian1.equals("QHSE部")&&quanxian2.equals("质量监督室")){//是QHSE-Q时
				%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
     //设置每张网页显示三笔记录(每页显示的记录数)
     int PageSize=15;
     
     //设置欲显示的页数(初始页)
     int ShowPage=1;
     
     //ResultSet的记录笔数(总记录数)
     int RowCount=0;
     
     //ResultSet分页后的总数(总页数)
     int PageCount=0;
     
     Connection conn=null;
     Statement stmt=null;
     ResultSet rs=null;
     String s1=null,s2=null;
     if(request.getParameter("neinamepjcha")!=null)
     {
    s1=new String(request.getParameter("neinamepjcha").getBytes("ISO-8859-1"),"gb2312");
    s1=s1.trim();
     session.setAttribute("neinamepjcha", s1);
     };
     if(request.getParameter("neijifenpjcha")!=null)
     {
     s2=new String(request.getParameter("neijifenpjcha").getBytes("ISO-8859-1"),"gb2312");
     s2=s2.trim();
     session.setAttribute("neijifenpjcha", s2);
     };
     System.out.println("11111111");
		System.out.println(session.getAttribute("neinamepjcha").toString());
		System.out.println(session.getAttribute("neijifenpjcha").toString());
		String panduan=session.getAttribute("neinamepjcha").toString().trim();//判断卡号不为空再执行
	if(panduan!=""){
	%>
	
	<%
     //连接数据库并初始数据
      try{
       Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//设置连接的数据库      
		String USER = session.getAttribute("ssYONGHU").toString();
		String PWD = session.getAttribute("ssMIMA").toString();
		conn = DriverManager.getConnection(URL, USER, PWD);
       stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
       String sql="select * from neistandardhe"; 
       if(session.getAttribute("neinamepjcha")==null||session.getAttribute("neinamepjcha").equals(""))
       {
           if(session.getAttribute("neijifenpjcha")==null||session.getAttribute("neijifenpjcha").equals(""))
	       {
	      System.out.println("s2:"+session.getAttribute("neijifenpjcha"));
	    	}else{
	    	 sql=sql+" where neido Like '%"+session.getAttribute("neijifenpjcha")+"%' and fenshucheck=2";
	    	};
    	}else{
    	 System.out.println("s1:"+session.getAttribute("neinamepjcha"));
	       if(session.getAttribute("neijifenpjcha")==null||session.getAttribute("neijifenpjcha").equals(""))
	       {
	       sql=sql+" where name like '%"+session.getAttribute("neinamepjcha")+"%' and fenshucheck=2";
	    	}else{
	       sql=sql+" where neido Like '%"+session.getAttribute("neijifenpjcha")+"%' and name like '%"+session.getAttribute("neinamepjcha")+"%' and fenshucheck=2";
	    	};
    	};
    	System.out.println(sql);
       rs=stmt.executeQuery(sql);
       //将指标移至最后一条记录
       rs.last();       
       //获取记录总数       
       RowCount=rs.getRow();
       System.out.println(RowCount);
       //计算显示的页数(关键)
       PageCount=((RowCount%PageSize)==0?(RowCount/PageSize):(RowCount/PageSize)+1);
      }catch(Exception e){
       System.out.println(e.getMessage());
      };
  
if(RowCount>0){  %>  
     
<center>
 <%
     String ToPage=request.getParameter("ToPage");     
     //判断是否取得ToPage参数
     if(ToPage!=null)
     {
      //取得指定显示的分页页数
      ShowPage=Integer.parseInt(ToPage);      
      //下面的语句判断用户输入的页数是否正确
      if(ShowPage>=PageCount)
      {
       ShowPage=PageCount;
      }
      else if(ShowPage<=0)
      {
       ShowPage=1;
      }
     }; 
     System.out.println(PageSize); 
     rs.first();
     //计算欲显示页的第一笔记录位置
     rs.absolute((ShowPage-1)*PageSize+1); 
    %>
    <h3>当前在第
    <font size="4" color="red"><%=ShowPage %></font>页,共<%=PageCount %>页</h3>
    <p>
   
   	<table cellspacing="0" cellpadding="0" style="margin-left:0px;margin-top:5px;border:1px solid #CCCCCC;width:98%;">
   	<tr>
   	<td colspan=5  style="border:1px solid #CCCCCC;font-size:20px;height:28px;"  align="center">
   	<div style=""><br>质量控制评价</br></div>
   	</td> 
   	</tr> 
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">用户名</td>
	<td style="border:1px solid #CCCCCC;height:20px;width:500px;"  align="center">计分规则</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">分值</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">操作</td>
	</tr> 
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs.getString("name")%></td>
	<td style="border:1px solid #CCCCCC;height:20px;width:500px;"  align="left">
	本月报验合格率为：<input id="hegelv">
	</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="left">报验合格率按照红头文执行</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">
	<form style="center" action="Neizhiliangjifen" method="post" name="formzhiliang" onsubmit="return jisuan();">
	<input name="neiname" type="hidden" value="<%=rs.getString("name")%>">
	<input name="neido" type="hidden" value="报验合格率">
	<input name="neifen" id="neifenzl" type="hidden" value="0" >
	<input name="neifenshu" type="hidden" value="<%=rs.getString("fenshu")%>">
	<input name="erjicheck" type="hidden" value="1">
	<input type="submit"  value="计分">
	<script type="text/javascript">
	function jisuan()
    {
    var flag=confirm('确认开展计分处理吗？确认，将对此用户此项进行计分');
    var fen=0;
	if(flag){
	    var hegelv;
	    hegelv=window.document.getElementById("hegelv").value;
		    if(hegelv!=""&&hegelv!=null)
		    {
		    	var reg=/^[1-9]\d*$|^0$/; // 注意：故意限制了 0321 这种格式，如不需要，直接reg=/^\d+$/;
			    if(reg.test(hegelv)==true)
			    {
			    fen=parseInt(hegelv-100);
			    var fanhui=0;
			    fanhui=50+2*fen-100;
			    window.document.getElementById("neifenzl").value=fanhui;
			   // window.document.getElementsByName("neido").value="低于质量目标"+(-fen)+"个百分点扣"+(-fanhui)+"分";
			    alert("计分成功！"+"得"+(fanhui)+"分");
			    window.document.formzhiliang.submit();
			    //return true;
			    }else{
			    alert("输入的报验合格率不是纯数字！失败！");
   				return false;
			    }
		    }else{
		    alert("输入的报验合格率不能为空！失败！");
		    return false;
		    };
		    return false;
	 }else{
	 return false;
	 }; 
    };
	</script>
	</form>
	</td>
	</tr>   
    <%
     //利用for循环配合PageSize属性取出一页中的数据
     for(int i=1;i<=PageSize;i++)
     {
    %>  
	<tr>

	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs.getString("name")%></td>
	<td style="border:1px solid #CCCCCC;height:20px;width:500px;"  align="left"><%=rs.getString("neido") %></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="left"><%=rs.getString("neifen") %></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">
	<form style="center" action="Neizhiliangjifen" method="post">
	<input name="neiname" type="hidden" value="<%=rs.getString("name")%>">
	<input name="neido" type="hidden" value="<%=rs.getString("neido")%>">
	<input name="neifen" type="hidden" value="<%=rs.getString("neifen")%>">
	<input name="neifenshu" type="hidden" value="<%=rs.getString("fenshu")%>">
	<input name="erjicheck" type="hidden" value="<%=rs.getString("erjicheck")%>">
	<input type="submit" onClick="return confirm('确认开展计分处理吗？确认，将对此用户此项进行计分');" value="计分">
	</form>
	</td>
	</tr>
     <p>    
     <%
      //下面的语句用于输出最后一条记录时,将指针移到最后一笔记录之后
       if(!rs.next())
       {
        //跳出for循环
        break;
       }
      };
      %>
      </table>      
      
      <table>
       <tr>
      <%
       //判断当前是否在第一页,不是第一页，则显示到第一页与下一页的连接
       if(ShowPage!=1)
       {
      %>
       <td width=150>
        <a href="neipingjia/neipjmain.jsp?ToPage=<%=1 %>">第一页</a>
       </td> 
       <td width=150>
        <a href="neipingjia/neipjmain.jsp?ToPage=<%=ShowPage-1 %>">上一页</a>
       </td>
      <% 
       }
       //判断是否在最后一页，是，则显示到最后一页和下一页
       if(ShowPage!=PageCount)
       {
       %>
        <td width=150>
         <a href="neipingjia/neipjmain.jsp?ToPage=<%=ShowPage+1 %>">下一页</a>
        </td>
        <td width=150>
         <a href="neipingjia/neipjmain.jsp?ToPage=<%=PageCount %>">最后一页</a>
        </td>
        <%
         }
         %>
         </tr>
         <tr>
         <td colspan="4" align="center">
          <form action="neipingjia/neipjmain.jsp" method="post" name="form2">
           <input type="text" name="ToPage" value="<%=ShowPage %>" style="height:25px;width:40px">页
            <a href="javascript:window.document.form1.submit();">GO</a>
          </form>
         </td>
         </tr>
       </table>

   <script language="javascript">
    function go()
    {
       window.document.form2.submit();
    };
   </script>
</center>

 <%}else{
out.println("<center>不存在此记录！</center>");
 };  
     //执行关闭各个对象的操作
    try{
     rs.close();
     stmt.close();
     conn.close();
    }catch(Exception e){
     System.out.println(e.getMessage());
    };
    };//panduan的结束
 %>				
<% /////////////////////////////////////////////分隔线//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////%>				
			<%}else if(quanxian1.equals("QHSE部")&&quanxian2.equals("安全保卫室")){//是QHSE-H时
				%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
     //设置每张网页显示三笔记录(每页显示的记录数)
     int PageSize=15;
     
     //设置欲显示的页数(初始页)
     int ShowPage=1;
     
     //ResultSet的记录笔数(总记录数)
     int RowCount=0;
     
     //ResultSet分页后的总数(总页数)
     int PageCount=0;
     
     Connection conn=null;
     Statement stmt=null;
     ResultSet rs=null;
     String s1=null,s2=null;
     if(request.getParameter("neinamepjcha")!=null)
     {
    s1=new String(request.getParameter("neinamepjcha").getBytes("ISO-8859-1"),"gb2312");
    s1=s1.trim();
     session.setAttribute("neinamepjcha", s1);
     };
     if(request.getParameter("neijifenpjcha")!=null)
     {
     s2=new String(request.getParameter("neijifenpjcha").getBytes("ISO-8859-1"),"gb2312");
     s2=s2.trim();
     session.setAttribute("neijifenpjcha", s2);
     };
     System.out.println("11111111");
		System.out.println(session.getAttribute("neinamepjcha").toString());
		System.out.println(session.getAttribute("neijifenpjcha").toString());
		String panduan=session.getAttribute("neinamepjcha").toString().trim();//判断卡号不为空再执行
	if(panduan!=""){
	%>
	
	<%
     //连接数据库并初始数据
      try{
       Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//设置连接的数据库      
		String USER = session.getAttribute("ssYONGHU").toString();
		String PWD = session.getAttribute("ssMIMA").toString();
		conn = DriverManager.getConnection(URL, USER, PWD);
       stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
       String sql="select * from neistandardhe "; 
       if(session.getAttribute("neinamepjcha")==null||session.getAttribute("neinamepjcha").equals(""))
       {
           if(session.getAttribute("neijifenpjcha")==null||session.getAttribute("neijifenpjcha").equals(""))
	       {
	      System.out.println("s2:"+session.getAttribute("neijifenpjcha"));
	    	}else{
	    	 sql=sql+" where neido Like '%"+session.getAttribute("neijifenpjcha")+"%' and fenshucheck=3";
	    	};
    	}else{
    	 System.out.println("s1:"+session.getAttribute("neinamepjcha"));
	       if(session.getAttribute("neijifenpjcha")==null||session.getAttribute("neijifenpjcha").equals(""))
	       {
	       sql=sql+" where name like '%"+session.getAttribute("neinamepjcha")+"%' and fenshucheck=3";
	    	}else{
	       sql=sql+" where neido Like '%"+session.getAttribute("neijifenpjcha")+"%' and name like '%"+session.getAttribute("neinamepjcha")+"%' and fenshucheck=3";
	    	};
    	};
    	System.out.println(sql);
       rs=stmt.executeQuery(sql);
       //将指标移至最后一条记录
       rs.last();       
       //获取记录总数       
       RowCount=rs.getRow();
       System.out.println(RowCount);
       //计算显示的页数(关键)
       PageCount=((RowCount%PageSize)==0?(RowCount/PageSize):(RowCount/PageSize)+1);
      }catch(Exception e){
       System.out.println(e.getMessage());
      };
  
if(RowCount>0){  %>  
     
<center>
 <%
     String ToPage=request.getParameter("ToPage");     
     //判断是否取得ToPage参数
     if(ToPage!=null)
     {
      //取得指定显示的分页页数
      ShowPage=Integer.parseInt(ToPage);      
      //下面的语句判断用户输入的页数是否正确
      if(ShowPage>=PageCount)
      {
       ShowPage=PageCount;
      }
      else if(ShowPage<=0)
      {
       ShowPage=1;
      }
     }; 
     System.out.println(PageSize); 
     rs.first();
     //计算欲显示页的第一笔记录位置
     rs.absolute((ShowPage-1)*PageSize+1); 
    %>
    <h3>当前在第
    <font size="4" color="red"><%=ShowPage %></font>页,共<%=PageCount %>页</h3>
    <p>
   
   	<table cellspacing="0" cellpadding="0" style="margin-left:0px;margin-top:5px;border:1px solid #CCCCCC;width:98%;">
   	<tr>
   	<td colspan=5  style="border:1px solid #CCCCCC;font-size:20px;height:28px;"  align="center">
   	<div style=""><br>安全管理评价</br></div>
   	</td> 
   	</tr> 
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">用户名</td>
	<td style="border:1px solid #CCCCCC;height:20px;width:500px;"  align="center">计分规则</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">分值</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">操作</td>
	</tr>    
    <%
     //利用for循环配合PageSize属性取出一页中的数据
     for(int i=1;i<=PageSize;i++)
     {
    %>  
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs.getString("name")%></td>
	<td style="border:1px solid #CCCCCC;height:20px;width:500px;"  align="left"><%=rs.getString("neido") %></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="left"><%=rs.getString("neifen") %></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">
	
	<form style="center" action="Neianquanjifen" method="post">
	<input name="neiname" type="hidden" value="<%=rs.getString("name")%>">
	<input name="neido" type="hidden" value="<%=rs.getString("neido")%>">
	<input name="neifen" type="hidden" value="<%=rs.getString("neifen")%>">
	<input name="neifenshu" type="hidden" value="<%=rs.getString("fenshu")%>">
	<input name="erjicheck" type="hidden" value="<%=rs.getString("erjicheck")%>">
	<input type="submit" onClick="return confirm('确认开展计分处理吗？确认，将对此用户此项进行计分');" value="计分">
	</form>
	</td>
	</tr>
     <p>    
     <%
      //下面的语句用于输出最后一条记录时,将指针移到最后一笔记录之后
       if(!rs.next())
       {
        //跳出for循环
        break;
       }
      };
      %>
      </table>      
      
      <table>
       <tr>
      <%
       //判断当前是否在第一页,不是第一页，则显示到第一页与下一页的连接
       if(ShowPage!=1)
       {
      %>
       <td width=150>
        <a href="neipingjia/neipjmain.jsp?ToPage=<%=1 %>">第一页</a>
       </td> 
       <td width=150>
        <a href="neipingjia/neipjmain.jsp?ToPage=<%=ShowPage-1 %>">上一页</a>
       </td>
      <% 
       }
       //判断是否在最后一页，是，则显示到最后一页和下一页
       if(ShowPage!=PageCount)
       {
       %>
        <td width=150>
         <a href="neipingjia/neipjmain.jsp?ToPage=<%=ShowPage+1 %>">下一页</a>
        </td>
        <td width=150>
         <a href="neipingjia/neipjmain.jsp?ToPage=<%=PageCount %>">最后一页</a>
        </td>
        <%
         }
         %>
         </tr>
         <tr>
         <td colspan="4" align="center">
          <form action="neipingjia/neipjmain.jsp" method="post" name="form3">
           <input type="text" name="ToPage" value="<%=ShowPage %>" style="height:25px;width:40px">页
            <a href="javascript:go();">GO</a>
          </form>
         </td>
         </tr>
       </table>

   <script language="javascript">
    function go()
    {
       window.document.form3.submit();
    };
   </script>
</center>

 <%}else{
out.println("<center>不存在此记录！</center>");
 };  
     //执行关闭各个对象的操作
    try{
     rs.close();
     stmt.close();
     conn.close();
    }catch(Exception e){
     System.out.println(e.getMessage());
    };
    };//panduan的结束
 %>	
 <% /////////////////////////////////////////////分隔线//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////%>				

 <% /////////////////////////////////////////////分隔线//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////%>				
			<%}else if(quanxian1.equals("工艺装备部")){//是QHSE-H时
				%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
     //设置每张网页显示三笔记录(每页显示的记录数)
     int PageSize=15;
     
     //设置欲显示的页数(初始页)
     int ShowPage=1;
     
     //ResultSet的记录笔数(总记录数)
     int RowCount=0;
     
     //ResultSet分页后的总数(总页数)
     int PageCount=0;
     
     Connection conn=null;
     Statement stmt=null;
     ResultSet rs=null;
     String s1=null,s2=null;
     if(request.getParameter("neinamepjcha")!=null)
     {
    s1=new String(request.getParameter("neinamepjcha").getBytes("ISO-8859-1"),"gb2312");
    s1=s1.trim();
     session.setAttribute("neinamepjcha", s1);
     };
     if(request.getParameter("neijifenpjcha")!=null)
     {
     s2=new String(request.getParameter("neijifenpjcha").getBytes("ISO-8859-1"),"gb2312");
     s2=s2.trim();
     session.setAttribute("neijifenpjcha", s2);
     };
     System.out.println("11111111");
		System.out.println(session.getAttribute("neinamepjcha").toString());
		System.out.println(session.getAttribute("neijifenpjcha").toString());
		String panduan=session.getAttribute("neinamepjcha").toString().trim();//判断卡号不为空再执行
	if(panduan!=""){
	%>
	
	<%
     //连接数据库并初始数据
      try{
       Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//设置连接的数据库      
		String USER = session.getAttribute("ssYONGHU").toString();
		String PWD = session.getAttribute("ssMIMA").toString();
		conn = DriverManager.getConnection(URL, USER, PWD);
       stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
       String sql="select * from neistandardhe "; 
       if(session.getAttribute("neinamepjcha")==null||session.getAttribute("neinamepjcha").equals(""))
       {
           if(session.getAttribute("neijifenpjcha")==null||session.getAttribute("neijifenpjcha").equals(""))
	       {
	      System.out.println("s2:"+session.getAttribute("neijifenpjcha"));
	    	}else{
	    	 sql=sql+" where neido Like '%"+session.getAttribute("neijifenpjcha")+"%' and fenshucheck=5";
	    	};
    	}else{
    	 System.out.println("s1:"+session.getAttribute("neinamepjcha"));
	       if(session.getAttribute("neijifenpjcha")==null||session.getAttribute("neijifenpjcha").equals(""))
	       {
	       sql=sql+" where name like '%"+session.getAttribute("neinamepjcha")+"%' and fenshucheck=5";
	    	}else{
	       sql=sql+" where neido Like '%"+session.getAttribute("neijifenpjcha")+"%' and name like '%"+session.getAttribute("neinamepjcha")+"%' and fenshucheck=5";
	    	};
    	};
    	System.out.println(sql);
       rs=stmt.executeQuery(sql);
       //将指标移至最后一条记录
       rs.last();       
       //获取记录总数       
       RowCount=rs.getRow();
       System.out.println(RowCount);
       //计算显示的页数(关键)
       PageCount=((RowCount%PageSize)==0?(RowCount/PageSize):(RowCount/PageSize)+1);
      }catch(Exception e){
       System.out.println(e.getMessage());
      };
  
if(RowCount>0){  %>  
     
<center>
 <%
     String ToPage=request.getParameter("ToPage");     
     //判断是否取得ToPage参数
     if(ToPage!=null)
     {
      //取得指定显示的分页页数
      ShowPage=Integer.parseInt(ToPage);      
      //下面的语句判断用户输入的页数是否正确
      if(ShowPage>=PageCount)
      {
       ShowPage=PageCount;
      }
      else if(ShowPage<=0)
      {
       ShowPage=1;
      }
     }; 
     System.out.println(PageSize); 
     rs.first();
     //计算欲显示页的第一笔记录位置
     rs.absolute((ShowPage-1)*PageSize+1); 
    %>
    <h3>当前在第
    <font size="4" color="red"><%=ShowPage %></font>页,共<%=PageCount %>页</h3>
    <p>
   
   	<table cellspacing="0" cellpadding="0" style="margin-left:0px;margin-top:5px;border:1px solid #CCCCCC;width:98%;">
   	<tr>
   	<td colspan=5  style="border:1px solid #CCCCCC;font-size:20px;height:28px;"  align="center">
   	<div style=""><br>工艺技术评价</br></div>
   	</td> 
   	</tr> 
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">用户名</td>
	<td style="border:1px solid #CCCCCC;height:20px;width:500px;"  align="center">计分规则</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">分值</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">操作</td>
	</tr>    
    <%
     //利用for循环配合PageSize属性取出一页中的数据
     for(int i=1;i<=PageSize;i++)
     {
    %>  
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs.getString("name")%></td>
	<td style="border:1px solid #CCCCCC;height:20px;width:500px;"  align="left"><%=rs.getString("neido") %></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="left"><%=rs.getString("neifen") %></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">
	
	<form style="center" action="Neigongyijifen" method="post" name="formgy">
	<input name="neiname" type="hidden" value="<%=rs.getString("name")%>">
	<input name="neido" type="hidden" value="<%=rs.getString("neido")%>">
	<input name="neifen" type="hidden" value="<%=rs.getString("neifen")%>">
	<input name="neifenshu" type="hidden" value="<%=rs.getString("fenshu")%>">
	<input name="erjicheck" type="hidden" value="<%=rs.getString("erjicheck")%>">
	<input type="submit" onClick="return confirm('确认开展计分处理吗？确认，将对此用户此项进行计分');" value="计分">
	</form>
	</td>
	</tr>
     <p>    
     <%
      //下面的语句用于输出最后一条记录时,将指针移到最后一笔记录之后
       if(!rs.next())
       {
        //跳出for循环
        break;
       }
      };
      %>
      </table>      
      
      <table>
       <tr>
      <%
       //判断当前是否在第一页,不是第一页，则显示到第一页与下一页的连接
       if(ShowPage!=1)
       {
      %>
       <td width=150>
        <a href="neipingjia/neipjmain.jsp?ToPage=<%=1 %>">第一页</a>
       </td> 
       <td width=150>
        <a href="neipingjia/neipjmain.jsp?ToPage=<%=ShowPage-1 %>">上一页</a>
       </td>
      <% 
       }
       //判断是否在最后一页，是，则显示到最后一页和下一页
       if(ShowPage!=PageCount)
       {
       %>
        <td width=150>
         <a href="neipingjia/neipjmain.jsp?ToPage=<%=ShowPage+1 %>">下一页</a>
        </td>
        <td width=150>
         <a href="neipingjia/neipjmain.jsp?ToPage=<%=PageCount %>">最后一页</a>
        </td>
        <%
         }
         %>
         </tr>
         <tr>
         <td colspan="4" align="center">
          <form action="neipingjia/neipjmain.jsp" method="post" name="form5">
           <input type="text" name="ToPage" value="<%=ShowPage %>" style="height:25px;width:40px">页
            <a href="javascript:go();">GO</a>
          </form>
         </td>
         </tr>
       </table>

   <script language="javascript">
    function go()
    {
       window.document.form5.submit();
    };
   </script>
</center>

 <%}else{
out.println("<center>不存在此记录！</center>");
 }; %> 
 <%    //执行关闭各个对象的操作
    try{
     rs.close();
     stmt.close();
     conn.close();
    }catch(Exception e){
     System.out.println(e.getMessage());
    };%>
<%};//panduan的结束
};
 %>	
<% /////////////////////////////////////////////分隔线//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////%>				
<%String panduanpp=session.getAttribute("neinamepjcha").toString();//判断卡号不为空再执行
if(panduanpp==""){%>
<div style="margin-top:3px;margin-left:0px;">请查询相关内分包商，然后做出评分！</div>
<%};%>
</body>
</html>

