<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%
	boolean flag = false;
	request.setCharacterEncoding("utf-8");
	String username = request.getParameter("name");
	String pwd = request.getParameter("password");
	Connection con = null;
	session.setAttribute("ssURL","zhenhua");	
	session.setAttribute("ssYONGHU", "sa");	
	session.setAttribute("ssMIMA","sky123456");	
	try {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//设置连接的数据库      
		String USER = session.getAttribute("ssYONGHU").toString();
		String PWD = session.getAttribute("ssMIMA").toString();
		con = DriverManager.getConnection(URL, USER, PWD);
		Statement stmt= con.createStatement();
			String sql ="select * from person where personname='"+username+"'";		
			ResultSet rs = stmt.executeQuery(sql);
				while(rs.next())
				{				
				System.out.println("数据库查到了");
					if(pwd.equals(rs.getString("personpwd").trim())){
					session.setAttribute("personidcheck", rs.getString("personid").trim());	
					session.setAttribute("usernamecheck", rs.getString("personname").trim());
					session.setAttribute("zhiwu", rs.getString("persongangweizhiwu").trim());
					session.setAttribute("bumen", rs.getString("personbumen").trim());
					session.setAttribute("bumen2", rs.getString("person2bumen").trim());
					session.setAttribute("bumen3", rs.getString("person3bumen").trim());
					session.setAttribute("IDCard", rs.getString("personIDcard").trim());			
					flag = true;
					System.out.println("密码相同");
					};
				} ;	
	    rs.close();			
		con.close();
		stmt.close();
		System.out.println("数据库连接成功！");
	} catch (Exception ex) {
 		System.out.println("出现意外，信息是：" + ex.getMessage());
		ex.printStackTrace();
	};

	if (flag) {
		response.sendRedirect("../mainframe.jsp");
	} else {
		response.sendRedirect("../jieguo/error.jsp");
		System.out.println("非法用户");
	};
%>


