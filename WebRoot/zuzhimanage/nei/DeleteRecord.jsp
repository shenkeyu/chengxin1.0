<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="zhenhua.sql.SqlUtils" pageEncoding="gb2312"%>
<%
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian.equals("�ۺϼƻ���")){
System.out.println("�û�����ɹ���");
}else{
System.out.println("�û�����ʧ�ܣ�");
out.println("<script>window.location.href='../../zhenhuaindex.html';</script>");
};


request.setCharacterEncoding("utf-8");
     	 boolean flag=false;
     	 String personIDcard=request.getParameter("recordid");
		System.out.println(request.getParameter("recordid"));
	     
	     try{
			     if(personIDcard!=null&&personIDcard!="")
			     {
			      String sql="delete from nei where id=?";    
		
					    String [] param={personIDcard};
					    SqlUtils sqlUtils=new SqlUtils();
						flag=sqlUtils.update(sql, param);
						System.out.println(flag);
									      	  if(flag==true) 
										      {
										      String s2="��ҵɾ���ɹ�";
											  out.println("<script>alert('"+s2+"');window.location.href='neirong.jsp';</script>");
										      System.out.println(s2);
										      }else
										      {
										      String s3="��ҵɾ��ʧ�ܣ�����ҵ�ѱ�ɾ����";
											  out.println("<script>alert('"+s3+"');window.location.href='neirong.jsp';</script>");
										      System.out.println(s3);
										      };
				};
		}catch(Exception e){
		System.out.println(e.getMessage());
		String s4="��ҵɾ��ʧ�ܣ�û�д���ҵ��";
		out.println("<script>alert('"+s4+"');window.location.href='neirong.jsp';</script>");
		};
%>


