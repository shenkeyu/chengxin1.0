<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="zhenhua.sql.SqlUtils" pageEncoding="gb2312"%>
<%
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian.equals("综合计划处")){
System.out.println("用户管理成功！");
}else{
System.out.println("用户管理失败！");
out.println("<script>window.location.href='../zhenhuaindex.html';</script>");
};


request.setCharacterEncoding("utf-8");
     	 boolean flag=false;
     	 String personIDcard=request.getParameter("recordid");
		System.out.println(request.getParameter("recordid"));
	     
	     try{
			     if(personIDcard!=null&&personIDcard!="")
			     {
			      String sql="delete from person where personIDcard=?;";    
		
					    String [] param={personIDcard};
					    SqlUtils sqlUtils=new SqlUtils();
						flag=sqlUtils.update(sql, param);
						System.out.println(flag);
									      	  if(flag==true) 
										      {
										      String s2="用户删除成功";
											  out.println("<script>alert('"+s2+"');window.location.href='neirong.jsp';</script>");
										      System.out.println(s2);
										      }else
										      {
										      String s3="用户删除失败，此用户已被删除！";
											  out.println("<script>alert('"+s3+"');window.location.href='neirong.jsp';</script>");
										      System.out.println(s3);
										      };
				};
		}catch(Exception e){
		System.out.println(e.getMessage());
		String s4="用户删除失败，没有此用户！";
		out.println("<script>alert('"+s4+"');window.location.href='neirong.jsp';</script>");
		};
%>


