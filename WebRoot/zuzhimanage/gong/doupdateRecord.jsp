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
     	 String name=request.getParameter("recordid");
					    	 boolean flagpanduan1=false;
					     	 String dizhi=request.getParameter("dizhi");
						     String faren=request.getParameter("faren");
						     String ziben=request.getParameter("ziben");
						     String chengliriqi=request.getParameter("chengliriqi");
						     String yingyeriqi=request.getParameter("yingyeriqi");
						     System.out.println(name+dizhi+faren+ziben+chengliriqi+yingyeriqi);
							 if((name!=null)&&(dizhi!=null)&&(faren!=null)&&(ziben!=null)&&(chengliriqi!=null)&&(yingyeriqi!=null))
						     {
							     name=name.trim();
							     dizhi=dizhi.trim();
							     faren=faren.trim();
							     ziben=ziben.trim();
							     chengliriqi=chengliriqi.trim();
							     yingyeriqi=yingyeriqi.trim();
							     if((name!=null)&&(dizhi!=null)&&(faren!=null)&&(ziben!=null)&&(chengliriqi!=null)&&(yingyeriqi!=null))
							     {
							     flagpanduan1=true;
							     };
							     System.out.println(flagpanduan1+name);
						     };
						     if(flagpanduan1==true){     
								 	  try{
								 			Connection con = null;
								 			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//����JDBC��������
								 			String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//�������ӵ����ݿ�      
								 			String USER = session.getAttribute("ssYONGHU").toString();
								 			String PWD = session.getAttribute("ssMIMA").toString();
								 			con = DriverManager.getConnection(URL, USER, PWD);
								 			Statement stmt= con.createStatement();
											      String sql="update gong set dizhi='"+dizhi.trim()+"',faren='"+faren.trim()+"',ziben='"+ziben.trim()+"',chengliriqi='"+chengliriqi.trim()+"',yingyeriqi='"+yingyeriqi.trim()+"' where id="+name.trim();
											      System.out.println(sql);
											      int RowCount= stmt.executeUpdate(sql);
								 		       //��ȡ��¼����       
								 		     		 System.out.println("��Ӱ����������Ϊ"+RowCount);
								 					if(RowCount>0)
								 					{	
															      String s="��ҵ�޸ĳɹ�";
																  out.println("<script>alert('"+s+"');window.location.href='neirong.jsp';</script>");
															      System.out.println(s);
															     
										  			};
								      }catch(Exception e){
								       System.out.println(e.getMessage());
								       	String s0="��ҵ�޸�ʧ��";
										out.println("<script>alert('"+s0+"');window.location.href='neirong.jsp';</script>");  
								      };
					
								}else{
							       	String s0="��ҵ�޸���Ϣ��д��ȫ";
									out.println("<script>alert('"+s0+"');window.location.href='neirong.jsp';</script>"); 
								};
			

%>


