<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%
	boolean flagmima = false;
	request.setCharacterEncoding("utf-8");
	String pwdusername=session.getAttribute("usernamecheck").toString();
	String pwdpersonid=session.getAttribute("personidcheck").toString();
	int pwdpersonidint= Integer.valueOf(pwdpersonid);//强制装换为整形
	String sqlpwd1=request.getParameter("firstpwd");
	String sqlpwd2=request.getParameter("secondpwd");
	String sqloldpwd=request.getParameter("oldpwd");
	Connection con = null;
	try {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName=zhenhua";//设置连接的数据库      
		String USER = "sa";
		String PWD = "sky123456";
		con = DriverManager.getConnection(URL, USER, PWD);
		Statement stmt= con.createStatement();
		System.out.println(pwdpersonidint);
			String sql ="select * from person where personid="+pwdpersonidint+" and personname='"+pwdusername+"' and personpwd='"+sqloldpwd.trim()+"'";		
			ResultSet rs = stmt.executeQuery(sql);
				while(rs.next()&&sqlpwd1.equals(sqlpwd2.trim()))
				{				
					System.out.println("数据库查到了");
 					try{
	 					PreparedStatement stmtupdate=con.prepareStatement("update person set personpwd=? where personid=?");
	 					stmtupdate.setString(1, sqlpwd1);
	 					stmtupdate.setInt(2,pwdpersonidint);
	 					stmtupdate.executeUpdate(); 
	 					System.out.println("修改成功！");
	 					stmtupdate.close();
	 					flagmima=true;
	 					}catch(Exception e){
	 					System.out.println("未修改成功！");
	 					e.printStackTrace();
	 					};	
	 							
				} ;	
		stmt.close();			
		con.close();
		System.out.println("数据库连接成功！");
	} catch (Exception ex) {
 		System.out.println("出现意外，信息是：" + ex.getMessage());
		ex.printStackTrace();
	};

	if (flagmima) {
		response.sendRedirect("../jieguo/successmima.jsp");
	} else {
		response.sendRedirect("../jieguo/errormima.jsp");
		System.out.println("非法用户");
	};
%>


