<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="zhenhua.sql.SqlUtils,zhenhua.sql.Persons,java.util.List,java.sql.*" pageEncoding="gb2312"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>�񻪳�����Ϣ����ϵͳ</title>
</head>

<body  onload="javascript:document.getElementById('dizhi').focus();">
<script type="text/javascript">
function checkInsert()
{

var dizhi=document.getElementById("dizhi").value;
var faren=document.getElementById("faren").value;
var ziben=document.getElementById("ziben").value;
var chengliriqi=document.getElementById("chengliriqi").value;
var yingyeriqi=document.getElementById("yingyeriqi").value;


if(faren.length==""){
		window.alert("�����뷨�˴�������");
		document.getElementById("faren").focus();
		return false;
};
if(dizhi.length==""){
		window.alert("�������ַ��");
		document.getElementById("dizhi").focus();
		return false;
};
if(ziben.length==""){
		window.alert("������ע���ʱ���");
		document.getElementById("ziben").focus();
		return false;
};
if(chengliriqi.length==""){
		window.alert("������������ڣ�");
		document.getElementById("chengliriqi").focus();
		return false;
};
if(yingyeriqi.length==""){
		window.alert("������Ӫҵ���ޣ�");
		document.getElementById("yingyeriqi").focus();
		return false;
};


if(isNaN(ziben))//��֤�ʱ�Ϊ����
{
		window.alert("ע���ʱ�ӦΪ���֣�");
		document.getElementById("ziben").focus();
		return false;
};


if(isDate(chengliriqi)==false)
{
return false;
}
if(isDate(yingyeriqi)==false)
{
return false;
}

return true;

};
function isDate(str){  
  //�������ȷ�����ڸ�ʽ����true,���򷵻�false  
  //var regExp=/\b\d{4}-\d{1,2}-\d{1,2}\b/;  
    //�ж������ʽyyyy-mm-dd  
    if (str!=str.match(/\d{4}.\d{2}.\d{2}/ig))  {  
        alert('���������ڸ�ʽΪ��yyyy.mm.dd!');  
        return false;  
    }  
  
    var tmpArr=str.split('.');  
      
   var rYear=parseInt(tmpArr[0]);  
    var rMonth=parseInt(tmpArr[1]);  
    var rDay=parseInt(tmpArr[2]);  
    //�ж���  
    if((rMonth>12)||(rMonth<1)){  
    alert('�·��������!');  
    return false;  
    };  
    
    if(rYear>9999){  
    alert('����������!');  
    return false;  
    }; 
  
  var rYearflag=false;  
  
    //�ж�����  
    if (((rYear%100)==0)&&((rYear%4)==0)){  
      rYearflag=true;  
    }else if((rYear%4) == 0){  
      rYearflag=true;  
    }else{  
    rYearflag=false;   
    };  
  
    if(((",1,3,5,7,8,10,12,").indexOf(","+rMonth+",")!=-1)&&(rDay<32)){  
      return true;  
    }else if(((",4,6,9,11,").indexOf(","+rMonth+",") !=-1)&&(rDay<31)){  
      return true;  
    }else if(rDay<29){  
    return true;  
    }else if(rYearflag&&(rDay<30)){  
    return true;  
    }else{  
    alert('���������!');  
    return false;  
  	};  
};
</script>
<%
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian.equals("�ۺϼƻ���")){
System.out.println("�û�����ɹ���");
}else{
System.out.println("�û�����ʧ�ܣ�");
out.println("<script>window.location.href='����/../zhenhuaindex.html';</script>");
};

		request.setCharacterEncoding("utf-8");
     	 boolean flag=false;
    	 boolean flagpanduan=false;
     	 String personIDcard=request.getParameter("recordid");
     	 System.out.println(personIDcard);
if(personIDcard!=null&&personIDcard!="")
{
	try {
		Connection con = null;
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//����JDBC��������
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//�������ӵ����ݿ�      
		String USER = session.getAttribute("ssYONGHU").toString();
		String PWD = session.getAttribute("ssMIMA").toString();
		con = DriverManager.getConnection(URL, USER, PWD);
		Statement stmt= con.createStatement();
			String sql ="select * from wai where id="+personIDcard.trim();		
			ResultSet rs = stmt.executeQuery(sql);
				while(rs.next())
				{				
				System.out.println("�鵽����ҵ");
%>

<form action="doupdateRecord.jsp" method="post" id="formchaxun" onsubmit="javascript:return checkInsert();">
   <table cellspacing="0" cellpadding="0" style="margin-left:20px;margin-top:20px;border:1px solid #CCCCCC;height:200px;">
            <tr>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">��˾���ƣ�</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><%=rs.getString("name").trim()%><input
					type="hidden" name="recordid" id="recordid" value=<%=Integer.toString(rs.getInt("id"))%>></td>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px"  align="center">��ַ��</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="dizhi" name="dizhi" value="<%=rs.getString("dizhi").trim()%>"></td>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">���˴���</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="faren" name="faren" value="<%=rs.getString("faren").trim()%>"></td>

         	</tr>
         	<tr>

         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">ע���ʱ�<br>����Ԫ���˴�ֻ��д���֣���</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="ziben" name="ziben" value="<%=rs.getString("ziben").trim()%>"></td>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">�������ڣ�<br>(2000.01.01)</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="chengliriqi" name="chengliriqi" value="<%=rs.getString("chengliriqi").trim()%>"></td>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">Ӫҵ���ޣ�<br>(2000.01.01)</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="yingyeriqi" name="yingyeriqi" value="<%=rs.getString("yingyeriqi").trim()%>"></td>
         	</tr>

         	<tr>
         	<td colspan=6 style="border:1px solid #CCCCCC;height:50px;"  align="center">
         	<input type="submit" value="�޸��û�" ></td>
         	</tr>
   </table>

</form>
<%
						}  	   
		 		rs.close();			
				con.close();
				stmt.close();


			      }catch(Exception e){
			       System.out.println(e.getMessage());
			     	String s0="δ�ҵ����޸���ҵ��";
					out.println("<script>alert('"+s0+"');window.location.href='neirong.jsp';</script>");  
			      };
 };

%>

</body>



</html>

