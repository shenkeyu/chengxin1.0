<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.sql.*" pageEncoding="gb2312"%>
<%
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian.equals("�ۺϼƻ���")){
System.out.println("�û�����ɹ���");
}else{
System.out.println("�û�����ʧ�ܣ�");
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
								 			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//����JDBC��������
								 			String URL = "jdbc:sqlserver://localhost:1433;DatabaseName=zhenhua";//�������ӵ����ݿ�      
								 			String USER = "sa";
								 			String PWD = "sky123456";
								 			con = DriverManager.getConnection(URL, USER, PWD);
								 			Statement stmt= con.createStatement();
											String sql="restore database zhenhua from disk='"+filepath+"' with replace";
											System.out.println(sql);
											      int RowCount= stmt.executeUpdate(sql);
								 		       //��ȡ��¼����       
								 		     		 System.out.println("��Ӱ����������Ϊ"+RowCount);
								 					if(RowCount>0)
								 					{	
															      String s="ϵͳ�ָ��ɹ�";
																  out.println("<script>alert('"+s+"');window.location.href='beifenhuifu.jsp';</script>");
															      System.out.println(s);
															     
										  			};
								      }catch(Exception e){
								       System.out.println(e.getMessage());
								       	String s0="ϵͳ�ָ�ʧ��";
										out.println("<script>alert('"+s0+"');window.location.href='beifenhuifu.jsp';</script>");  
								      };
					
								};

%>


