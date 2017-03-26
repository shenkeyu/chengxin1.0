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
     	 String filepath=request.getParameter("realpath");
     	 System.out.println(filepath);
					    	 boolean flagpanduan1=false;
							 if(filepath!=null)
						     {
							     filepath=filepath.trim();
							     if(filepath!="")
							     {
							     flagpanduan1=true;
							     };
							     System.out.println(filepath);
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
											String sql="restore database zhenhua from disk='"+filepath+"' with replace";
											System.out.println(sql);
											      int RowCount= stmt.executeUpdate(sql);
								 		       //获取记录总数       
								 		     		 System.out.println("受影响数据行数为"+RowCount);
								 					if(RowCount>0)
								 					{	
															      String s="系统恢复成功";
																  out.println("<script>alert('"+s+"');window.location.href='beifenhuifu.jsp';</script>");
															      System.out.println(s);
															     
										  			};
								      }catch(Exception e){
								       System.out.println(e.getMessage());
								       	String s0="系统恢复失败";
										out.println("<script>alert('"+s0+"');window.location.href='beifenhuifu.jsp';</script>");  
								      };
					
								};

%>


