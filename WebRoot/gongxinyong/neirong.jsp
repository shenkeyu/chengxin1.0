<%@ page language="java" import="java.sql.*" pageEncoding="utf-8"%>

<html>
<head>
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


String quanxian=session.getAttribute("bumen").toString();
if(quanxian!=""||quanxian!=null){
System.out.println("可以查询！");
}else{
System.out.println("查询失败！");
out.println("<script>window.location.href='../zhenhuaindex.html';</script>");
};
%>
<body>
<center><div style="font-size:20px;margin-top:20px">供应商清单</div></center>
<%
     //设置每张网页显示三笔记录(每页显示的记录数)
     int PageSize=5;
     
     //设置欲显示的页数(初始页)
     int ShowPage=1;
     
     //ResultSet的记录笔数(总记录数)
     int RowCount=0;
     
     //ResultSet分页后的总数(总页数)
     int PageCount=0;
     Connection con3=null;
     Statement stmt3=null;
     ResultSet rs3=null;
     String style1="background-image: url(../image/zongtu/lvbj.png);margin-left:6px;margin-top:10px;height: 352px;width: 302px;";
	String style2="background-image: url(../image/zongtu/lvzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;";
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
     if(request.getParameter("mingzi")!=null)
     {
     String ss=new String(request.getParameter("mingzi").getBytes("ISO-8859-1"),"gb2312");
     session.setAttribute("chaxungong", ss);
	};
 try{
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//设置连接的数据库      
		String USER = session.getAttribute("ssYONGHU").toString();
		String PWD = session.getAttribute("ssMIMA").toString();
		con3 = DriverManager.getConnection(URL, USER, PWD);
		System.out.println(session.getAttribute("chaxunyonghu").toString());
		stmt3= con3.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		String sql3="select * from gong where name like '%"+session.getAttribute("chaxungong").toString().trim()+"%'";    
		System.out.println(sql3);
		rs3=stmt3.executeQuery(sql3);
				  //rs.first();
				  int row3=0;
				  int rowCount3=rs3.getRow();
				  System.out.println(rowCount3);
				         //将指标移至最后一条记录
       rs3.last();       
       //获取记录总数       
       RowCount=rs3.getRow();
       System.out.println(RowCount);
       //计算显示的页数(关键)
       PageCount=((RowCount%PageSize)==0?(RowCount/PageSize):(RowCount/PageSize)+1);
       }catch(Exception e){
       System.out.println(e.getMessage());
      };

if(RowCount>0){ 
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
     rs3.first();
     //计算欲显示页的第一笔记录位置
     rs3.absolute((ShowPage-1)*PageSize+1); 
%>
    <center>
    <div style="margin-top:40px;">
    <h3>当前在第
    <font size="4" color="red"><%=ShowPage %></font>页,共<%=PageCount %>页</h3>
    </div>
    </center>
    <p>
    <center>
<table>
<tr>				 
<%
     //利用for循环配合PageSize属性取出一页中的数据
     for(int i=1;i<=PageSize;i++)
     {
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////判断何种颜色界面		 
				  float fenshu=Float.parseFloat(rs3.getString("fenshu").trim());
							  if(fenshu>90)
							  {
							  style1="background-image: url(../image/zongtu/lvbj.png);margin-left:6px;margin-top:10px;height: 352px;width: 302px;";
							  style2="background-image: url(../image/zongtu/lvzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;";
							  }else if(fenshu>80&&fenshu<=90)
							  {
							  style1="background-image: url(../image/zongtu/lanbj.png);margin-left:6px;margin-top:10px;height: 354px;width: 302px;";
							  style2="background-image: url(../image/zongtu/lanzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;";
							  }else if(fenshu>=70&&fenshu<=80)
							  {
							  style1="background-image: url(../image/zongtu/huangbj.png);margin-left:6px;margin-top:10px;height: 354px;width: 302px;";
							  style2="background-image: url(../image/zongtu/huangzong.png);height:69px;width:300px;margin-left:0px;margin-top:20px;vertical-align:middle;";
							  }else if(fenshu<70){
							  style1="background-image: url(../image/zongtu/hongbj.png);margin-left:6px;margin-top:10px;height: 347px;width: 295px;";
							  style2="background-image: url(../image/zongtu/hongzong.png);height:69px;width:295px;margin-left:0px;margin-top:20px;vertical-align:middle;";
							  };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////							  
%>
								<td style="vertical-align:middle;align:left;width:323px">
										<div id="firstdiv1" style="<%=style1%>">
										<br>
										<br>
										<br>&nbsp;
										<br><center><%=rs3.getString("name").trim()%></center>
										<br>&nbsp;
										<br>&nbsp;
										<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										法人姓名：<%=rs3.getString("faren").trim()%><br>
										<br>&nbsp;
										<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										注册资本：<%=rs3.getString("ziben").trim()%>万元
										<div id="firstfendiv1" style="<%=style2%>">
										<div style="height:29px;margin-left:210px;margin-top:15px;vertical-align:middle;color:black;font-size:20px;">
										<%=(float)(Math.round(rs3.getFloat("fenshu")*100))/100%>
										</div>
										</div>
										</div>		
								</td>
		 <%
      //下面的语句用于输出最后一条记录时,将指针移到最后一笔记录之后
       if(!rs3.next())
       {
        //跳出for循环
        break;
       }
      };
      %>
</tr>
</table>
</center>
<%//////////////////////////多页实现行///////////////////////////%>
<center>
<div style="margin-top:30px;"></div>
      <table>
       <tr>
      <%
       //判断当前是否在第一页,不是第一页，则显示到第一页与下一页的连接
       if(ShowPage!=1)
       {
      %>
       <td width=150>
        <a href="neirong.jsp?ToPage=<%=1 %>">第一页</a>
       </td> 
       <td width=150>
        <a href="neirong.jsp?ToPage=<%=ShowPage-1 %>">上一页</a>
       </td>
      <% 
       };
       //判断是否在最后一页，是，则显示到最后一页和下一页
       if(ShowPage!=PageCount)
       {
       %>
        <td width=150>
         <a href="neirong.jsp?ToPage=<%=ShowPage+1 %>">下一页</a>
        </td>
        <td width=150>
         <a href="neirong.jsp?ToPage=<%=PageCount%>">最后一页</a>
        </td>
       <%
        };
       %>
         </tr>
         <tr>
         <td colspan="4" align="center">
         <div style="margin-top:30px;"></div>
          <form action="neirong.jsp" method="post" name="form1">
           <input type="text" name="ToPage" value="<%=ShowPage%>" style="height:25px;width:40px">页
            <a href="javascript:window.document.form1.submit();">GO</a>
          </form>
         </td>
</tr>
</table>
 </center>      
    <script language="javascript">
    function go()
    {
       window.document.form1.submit();
    };
   </script>
<%//////////////////////////多页实现行///////////////////////////%>

       
 <%}else{
out.println("<center>不存在此企业！</center>");
 };  
 try{
     //执行关闭各个对象的操作
     rs3.close();
     stmt3.close();
     con3.close();
}catch(Exception e){
     System.out.println(e.getMessage());
};
 %>


</body>
</html>

