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
if(quanxian1.equals("物资采购部")){
System.out.println("有权限查询111！");
}else{
System.out.println("无查询权限！");
};
%>
<body>
<div style="top:13px;left:20px;"></div>
<% /////////////////////////////////////////////分隔线//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////%>
<%if(quanxian1.equals("物资采购部")&&quanxian2.equals("供应链室")){ %>
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
     if(request.getParameter("gongnamecha")!=null)
     {
    s1=new String(request.getParameter("gongnamecha").getBytes("ISO-8859-1"),"gb2312");
    s1=s1.trim();
     session.setAttribute("gongnamepjcha", s1);
     };
     if(request.getParameter("gongjifencha")!=null)
     {
     s2=new String(request.getParameter("gongjifencha").getBytes("ISO-8859-1"),"gb2312");
     s2=s2.trim();
     session.setAttribute("gongjifenpjcha", s2);
     };
     System.out.println("11111111");
		System.out.println(session.getAttribute("gongnamepjcha").toString());
		System.out.println(session.getAttribute("gongjifenpjcha").toString());
		String panduan=session.getAttribute("gongnamepjcha").toString().trim();//判断卡号不为空再执行
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
       String sql="select * from gongstandardhe "; 
       if(session.getAttribute("gongnamepjcha")==null||session.getAttribute("gongnamepjcha").equals(""))
       {
           if(session.getAttribute("gongjifenpjcha")==null||session.getAttribute("gongjifenpjcha").equals(""))
	       {
	      System.out.println("s2:"+session.getAttribute("gongjifenpjcha"));
	    	}else{
	    	 sql=sql+" where gongdo Like '%"+session.getAttribute("gongjifenpjcha")+"%'";
	    	};
    	}else{
    	 System.out.println("s1:"+session.getAttribute("gongnamepjcha"));
	       if(session.getAttribute("gongjifenpjcha")==null||session.getAttribute("gongjifenpjcha").equals(""))
	       {
	       sql=sql+" where name like '%"+session.getAttribute("gongnamepjcha")+"%'";
	    	}else{
	       sql=sql+" where gongdo Like '%"+session.getAttribute("gongjifenpjcha")+"%' and name Like'%"+session.getAttribute("gongnamepjcha")+"%'";
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
   	<div style=""><br>供应商评价</br></div>
   	</td> 
   	</tr> 
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">外包商名字</td>
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
	<td style="border:1px solid #CCCCCC;height:20px;width:500px;"  align="left"><%=rs.getString("gongdo") %></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="left"><%=rs.getString("gongfen") %></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">
	
	<form style="center" action="gongjifen" method="post">
	<input name="gongname" type="hidden" value="<%=rs.getString("name")%>">
	<input name="gongdo" type="hidden" value="<%=rs.getString("gongdo")%>">
	<input name="gongfen" type="hidden" value="<%=rs.getString("gongfen")%>">
	<input name="gongfenshu" type="hidden" value="<%=rs.getString("fenshu")%>">
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
        <a href="gongpingjia/gongpjmain.jsp?ToPage=<%=1 %>">第一页</a>
       </td> 
       <td width=150>
        <a href="gongpingjia/gongpjmain.jsp?ToPage=<%=ShowPage-1 %>">上一页</a>
       </td>
      <% 
       }
       //判断是否在最后一页，是，则显示到最后一页和下一页
       if(ShowPage!=PageCount)
       {
       %>
        <td width=150>
         <a href="gongpingjia/gongpjmain.jsp?ToPage=<%=ShowPage+1 %>">下一页</a>
        </td>
        <td width=150>
         <a href="gongpingjia/gongpjmain.jsp?ToPage=<%=PageCount %>">最后一页</a>
        </td>
        <%
         }
         %>
         </tr>
         <tr>
         <td colspan="4" align="center">
          <form action="gongpingjia/gongpjmain.jsp" method="post" name="form1">
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
<% /////////////////////////////////////////////分隔线//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////%>				
		<%}			
 %>
<%String panduan2=session.getAttribute("gongnamepjcha").toString();//判断卡号不为空再执行
if(panduan2==""){%>
<div style="margin-top:3px;margin-left:0px;">请查询相关外分包商公司名称，然后做出评分！</div>
<%};%>
</body>
</html>

