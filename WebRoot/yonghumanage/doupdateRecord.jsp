<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.sql.*" pageEncoding="gb2312"%>
<%
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian.equals("综合计划处")){
System.out.println("用户管理成功！");
}else{
System.out.println("用户管理失败！");
out.println("<script>window.location.href='../zhenhuaindex.html';</script>");
};


		request.setCharacterEncoding("utf-8");
     	 String personIDcard=request.getParameter("recordid");
					    	 boolean flagpanduan1=false;
					     	 String personname=request.getParameter("personname");
						     String personpwd=request.getParameter("personpwd");
						     String personbumen=request.getParameter("personbumen");
						     String person2bumen=request.getParameter("person2bumen");
						     String person3bumen=request.getParameter("person3bumen");
						     String persongangweizhiwu=request.getParameter("persongangweizhiwu");
							 if((personname!=null)&&(personpwd!=null)&&(personIDcard!=null)&&(personbumen!=null)&&(person2bumen!=null)&&(person3bumen!=null)&&(persongangweizhiwu!=null))
						     {
							     personname=personname.trim();
							     personpwd=personpwd.trim();
							     personIDcard=personIDcard.trim();
							     personbumen=personbumen.trim();
							     person2bumen=person2bumen.trim();
							     person3bumen=person3bumen.trim();
							     persongangweizhiwu=persongangweizhiwu.trim();
							     if((personname!=null)&&(personpwd!=null)&&(personIDcard!=null)&&(personbumen!=null)&&(person2bumen!=null)&&(person3bumen!=null)&&(persongangweizhiwu!=null))
							     {
							     flagpanduan1=true;
							     };
							     System.out.println(flagpanduan1+personname);
						     };
						     if(flagpanduan1==true){     
								 	  try{
								 			Connection con = null;
								 			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
								 			String URL = "jdbc:sqlserver://localhost:1433;DatabaseName=zhenhua";//设置连接的数据库      
								 			String USER = "sa";
								 			String PWD = "sky123456";
								 			con = DriverManager.getConnection(URL, USER, PWD);
								 			Statement stmt= con.createStatement();
											      String sql="update person set personname='"+personname.trim()+"',personpwd='"+personpwd.trim()+"',personbumen='"+personbumen.trim()+"',person2bumen='"+person2bumen.trim()+"',person3bumen='"+person3bumen.trim()+"',persongangweizhiwu='"+persongangweizhiwu.trim()+"' where personIDcard='"+personIDcard.trim()+"'";
											      System.out.println(sql);
											      int RowCount= stmt.executeUpdate(sql);
								 		       //获取记录总数       
								 		     		 System.out.println("受影响数据行数为"+RowCount);
								 					if(RowCount>0)
								 					{	
															      String s="用户修改成功";
																  out.println("<script>alert('"+s+"');window.location.href='neirong.jsp';</script>");
															      System.out.println(s);
															     
										  			};
								      }catch(Exception e){
								       System.out.println(e.getMessage());
								       	String s0="用户修改失败";
										out.println("<script>alert('"+s0+"');window.location.href='neirong.jsp';</script>");  
								      };
					
								};

%>


