<%@ page language="java" import="java.sql.*" contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%> 
<%@ page import="java.text.*"%>
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
if(quanxian1!=""||quanxian1!=null){
System.out.println("可以查询！");
}else{
System.out.println("查询失败！");
out.println("<script>window.alert('没有查询管理权限');window.location.href='"+basePath+"gerenxinyong/grxymain.jsp';</script>");
};
%>
<body>
<div style="top:13px;left:20px;"></div>
<% /////////////////////////////////////////////分隔线//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
     //设置每张网页显示三笔记录(每页显示的记录数)
     int PageSize=20;
     
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
     if(request.getParameter("wainamexiang")!=null)
     {
   // s1=new String(request.getParameter("wainamexiang").getBytes("ISO-8859-1"),"gb2312");
    //s1=s1.trim();
    s1=request.getParameter("wainamexiang").trim();
     session.setAttribute("wainamexiang", s1);
     };
	String panduan=session.getAttribute("wainamexiang").toString().trim();//判断卡号不为空再执行
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
       String sql="select * from waidorecord ";
		Calendar c = Calendar.getInstance();
       String currentyear=Integer.toString(c.get(Calendar.YEAR));
       String currentmonth=Integer.toString(c.get(Calendar.MONTH)+1);
       if(session.getAttribute("wainamexiang")==null||session.getAttribute("wainamexiang").equals(""))
       {
	      System.out.println("查询详单来源内容为空");
    	}else{
    	 System.out.println("s1:"+session.getAttribute("wainamexiang"));
	       sql=sql+" where wainame like '"+session.getAttribute("wainamexiang")+"%' and waidoyear="+currentyear+" and waidomonth="+currentmonth;
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
   	<td colspan=3  style="border:1px solid #CCCCCC;font-size:20px;height:28px;"  align="center">
   	<div style=""><br>本月详细清单情况</br></div>
   	</td> 
   	</tr> 
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">内分包商名称</td>
	<td style="border:1px solid #CCCCCC;height:20px;width:500px;"  align="center">计分情况</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">计分分值</td>
	</tr> 
     <%
     //利用for循环配合PageSize属性取出一页中的数据
     for(int i=1;i<=PageSize;i++)
     {
    %>  
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs.getString("wainame")%></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs.getString("waido")%></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs.getString("waifen")%></td>
	</tr> 
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
        <a href="waixinyong/waixiangdan.jsp?ToPage=<%=1 %>">第一页</a>
       </td> 
       <td width=150>
        <a href="waixinyong/waixiangdan.jsp?ToPage=<%=ShowPage-1 %>">上一页</a>
       </td>
      <% 
       }
       //判断是否在最后一页，是，则显示到最后一页和下一页
       if(ShowPage!=PageCount)
       {
       %>
        <td width=150>
         <a href="waixinyong/waixiangdan.jsp?ToPage=<%=ShowPage+1 %>">下一页</a>
        </td>
        <td width=150>
         <a href="waixinyong/waixiangdan.jsp?ToPage=<%=PageCount %>">最后一页</a>
        </td>
        <%
         }
         %>
         </tr>
         <tr>
         <td colspan="4" align="center">
          <form action="waixinyong/waixiangdan.jsp" method="post" name="form1">
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
			out.println("<br><br><center><h1>本月不存在计分！</h1></center><br><a href='javascript:window.history.go(-1);'>返回</a>");
		 };  
		     //执行关闭各个对象的操作
		    try{
		     rs.close();
		     stmt.close();
		     conn.close();
		    }catch(Exception e){
		     System.out.println(e.getMessage());
		    };%>
    
<%};//panduan的结束
 %>
<% /////////////////////////////////////////////分隔线//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////%>				
<%String panduanpp=session.getAttribute("wainamexiang").toString();//判断卡号不为空再执行
if(panduanpp==""){%>
<div style="margin-top:3px;margin-left:0px;">不存在此查询源</div>
<a href='javascript:window.history.go(-1);'>返回</a>
<%}%>
</body>
</html>

