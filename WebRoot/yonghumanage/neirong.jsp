<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.sql.*" pageEncoding="gb2312"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>�񻪳�����Ϣ����ϵͳ</title>
</head>



<body id="rightbody" >


<%
	request.setCharacterEncoding("utf-8");
     //����ÿ����ҳ��ʾ���ʼ�¼(ÿҳ��ʾ�ļ�¼��)
     int PageSize=30;
     
     //��������ʾ��ҳ��(��ʼҳ)
     int ShowPage=1;
     
     //ResultSet�ļ�¼����(�ܼ�¼��)
     int RowCount=0;
     
     //ResultSet��ҳ�������(��ҳ��)
     int PageCount=0;
     
     Connection conn=null;
     Statement stmt=null;
     ResultSet rs=null;
     if(request.getParameter("yonghuming")!=null)
     session.setAttribute("yonghuming", request.getParameter("yonghuming"));
     if(request.getParameter("yonghukahao")!=null)
     session.setAttribute("yonghukahao", request.getParameter("yonghukahao"));
System.out.println(session.getAttribute("yonghukahao").toString());
System.out.println(session.getAttribute("yonghuming").toString());
     //�������ݿⲢ��ʼ����
      try{
       Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//����JDBC��������
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName=zhenhua";//�������ӵ����ݿ�      
		String USER = "sa";
		String PWD = "sky123456";
		conn = DriverManager.getConnection(URL, USER, PWD);
       stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
       String sql="select * from person";
       if((session.getAttribute("yonghukahao").toString()!=null)&&(session.getAttribute("yonghukahao").toString()!=""))
       {
	       if(session.getAttribute("yonghuming").toString()!=null&&session.getAttribute("yonghuming").toString()!="")
	       {
	       sql=sql+" where personname Like '%"+session.getAttribute("yonghuming").toString().trim()+"%' and personIDcard='"+session.getAttribute("yonghukahao").toString().trim()+"'";
	    	}else{
	    	sql=sql+" where personIDcard='"+session.getAttribute("yonghukahao").toString().trim()+"'";
	    	};
    	}else if(session.getAttribute("yonghukahao").toString()==null||session.getAttribute("yonghukahao").toString()=="")
    	{
    		if(session.getAttribute("yonghuming").toString()!=null&&session.getAttribute("yonghuming").toString()!="")
	       {
	       sql=sql+" where personname Like '%"+session.getAttribute("yonghuming").toString().trim()+"%'";
	    	};
    	};
    	System.out.println(sql);
       rs=stmt.executeQuery(sql);
       //��ָ���������һ����¼
       rs.last();       
       //��ȡ��¼����       
       RowCount=rs.getRow();
       System.out.println(RowCount);
       //������ʾ��ҳ��(�ؼ�)
       PageCount=((RowCount%PageSize)==0?(RowCount/PageSize):(RowCount/PageSize)+1);
      }catch(Exception e){
       System.out.println(e.getMessage());
      };
  
if(RowCount>0){  %>  
     
<center>
 <%
     String ToPage=request.getParameter("ToPage");     
     //�ж��Ƿ�ȡ��ToPage����
     if(ToPage!=null)
     {
      //ȡ��ָ����ʾ�ķ�ҳҳ��
      ShowPage=Integer.parseInt(ToPage);      
      //���������ж��û������ҳ���Ƿ���ȷ
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
     //��������ʾҳ�ĵ�һ�ʼ�¼λ��
     rs.absolute((ShowPage-1)*PageSize+1); 
    %>
    <h3>��ǰ�ڵ�
    <font size="4" color="red"><%=ShowPage %></font>ҳ,��<%=PageCount %>ҳ</h3>
    <p>
   
   	<table cellspacing="0" cellpadding="0" style="margin-left:0px;margin-top:5px;border:1px solid #CCCCCC;width:90%;">
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">�û���</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">����</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">����</td>
	<td colspan=2 style="border:1px solid #CCCCCC;height:20px;"  align="center">����</td>
	</tr>    
    <%
     //����forѭ�����PageSize����ȡ��һҳ�е�����
     for(int i=1;i<=PageSize;i++)
     {
    %>  
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs.getString("personname")%></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs.getString("personIDcard")%></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs.getString("personbumen") %></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><a href="DeleteRecord.jsp?recordid=<%=rs.getString("personIDcard")%>" onClick="return confirm('ȷ��ɾ����ɾ���û������û����е���Ϣ��һ��ɾ��');">ɾ��</a></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><a href="ModifyRecord.jsp?recordid=<%=rs.getString("personIDcard")%>">�޸�</a></td>
	</tr>
     <p>    
     <%
      //������������������һ����¼ʱ,��ָ���Ƶ����һ�ʼ�¼֮��
       if(!rs.next())
       {
        //����forѭ��
        break;
       }
      };
      %>
      </table>

      
      
      <table>
       <tr>
      <%
       //�жϵ�ǰ�Ƿ��ڵ�һҳ,���ǵ�һҳ������ʾ����һҳ����һҳ������
       if(ShowPage!=1)
       {
      %>
       <td width=150>
        <a href="neirong.jsp?ToPage=<%=1 %>">��һҳ</a>
       </td> 
       <td width=150>
        <a href="neirong.jsp?ToPage=<%=ShowPage-1 %>">��һҳ</a>
       </td>
      <% 
       }
       //�ж��Ƿ������һҳ���ǣ�����ʾ�����һҳ����һҳ
       if(ShowPage!=PageCount)
       {
       %>
        <td width=150>
         <a href="neirong.jsp?ToPage=<%=ShowPage+1 %>">��һҳ</a>
        </td>
        <td width=150>
         <a href="neirong.jsp?ToPage=<%=PageCount %>">���һҳ</a>
        </td>
        <%
         }
         %>
         </tr>
         <tr>
         <td colspan="4" align="center">
          <form action="neirong.jsp" method="post" name="form1">
           <input type="text" name="ToPage" value="<%=ShowPage %>" style="height:25px;width:40px">ҳ
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
out.println("<center>�����ڴ��û���</center>");
 };  
     //ִ�йرո�������Ĳ���
    try{
     rs.close();
     stmt.close();
     conn.close();
    }catch(Exception e){
     System.out.println(e.getMessage());
    };
 %>
</body>
</html>

