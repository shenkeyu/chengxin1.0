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
     if(request.getParameter("zuzhiming")!=null)
     session.setAttribute("neiming", request.getParameter("zuzhiming"));
System.out.println(session.getAttribute("neiming").toString());
     //�������ݿⲢ��ʼ����
      try{
       Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//����JDBC��������
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//�������ӵ����ݿ�      
		String USER = session.getAttribute("ssYONGHU").toString();
		String PWD = session.getAttribute("ssMIMA").toString();
		conn = DriverManager.getConnection(URL, USER, PWD);
       stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
       String sql="select * from nei";
	       if(session.getAttribute("neiming").toString()!=null&&session.getAttribute("neiming").toString()!="")
	       {
	       sql=sql+" where name Like '%"+session.getAttribute("neiming").toString().trim()+"%'";
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
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">��ҵ����</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">��ַ</td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center">���˴���</td>
	<td colspan=2 style="border:1px solid #CCCCCC;height:20px;"  align="center">����</td>
	</tr>    
    <%
     //����forѭ�����PageSize����ȡ��һҳ�е�����
     for(int i=1;i<=PageSize;i++)
     {
    %>  
	<tr>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs.getString("name")%></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs.getString("dizhi")%></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><%=rs.getString("faren") %></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><a href="DeleteRecord.jsp?recordid=<%=rs.getString("id")%>" onClick="return confirm('ȷ��ɾ����ɾ����ҵ�������ҵ���е���Ϣ��һ��ɾ��');">ɾ��</a></td>
	<td style="border:1px solid #CCCCCC;height:20px;"  align="center"><a href="ModifyRecord.jsp?recordid=<%=rs.getString("id")%>">�޸�</a></td>
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
out.println("<center>�����ڴ���ҵ��</center>");
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

