<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="zhenhua.sql.SqlUtils,java.util.regex.Matcher,java.util.regex.Pattern" pageEncoding="gb2312"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>�񻪳�����Ϣ����ϵͳ</title>
</head>


<script type="text/javascript">
function checkInsert()
{
var zuzhiname=document.getElementById("zuzhiname").value;
var dizhi=document.getElementById("dizhi").value;
var faren=document.getElementById("faren").value;
var ziben=document.getElementById("ziben").value;
var chengliriqi=document.getElementById("chengliriqi").value;
var yingyeriqi=document.getElementById("yingyeriqi").value;

if(zuzhiname.length==""){
		window.alert("�����빫˾���ƣ�");
		document.getElementById("zuzhiname").focus();
		return false;
};
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


<body  onload="javascript:document.getElementById('zuzhiname').focus();">

<%
String quanxian=session.getAttribute("bumen").toString().trim();
if(quanxian.equals("�ۺϼƻ���")){
System.out.println("�û�����ɹ���");
}else{
System.out.println("�û�����ʧ�ܣ�");
out.println("<script>window.location.href='../../zhenhuaindex.html';</script>");
};

%>

<form action="AddRecord.jsp" method="post" id="formchaxun" onsubmit="javascript:return checkInsert();">
   <table cellspacing="0" cellpadding="0" style="margin-left:20px;margin-top:20px;border:1px solid #CCCCCC;height:200px;">
            <tr>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">��˾���ƣ�</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="zuzhiname" name="zuzhiname"></td>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px"  align="center">��ַ��</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="dizhi" name="dizhi"></td>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">���˴���</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="faren" name="faren"></td>

         	</tr>
         	<tr>

         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">ע���ʱ�<br>����Ԫ���˴�ֻ��д���֣���</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="ziben" name="ziben"></td>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">�������ڣ�<br>(2000.01.01)</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="chengliriqi" name="chengliriqi"></td>
         	<td style="width:100px;font-size:15px;border:1px solid #CCCCCC;height:50px;"  align="center">Ӫҵ���ޣ�<br>(2000.01.01)</td>
         	<td style="border:1px solid #CCCCCC;height:50px;"><input id="yingyeriqi" name="yingyeriqi"></td>
         	</tr>

         	<tr>
         	<td colspan=6 style="border:1px solid #CCCCCC;height:50px;"  align="center">
         	<input type="submit" value="����û�" ></td>
         	</tr>
   </table>

</form>
<% 
request.setCharacterEncoding("utf-8");
     	 boolean flag=false;
    	 boolean flagpanduan=false;
     	 String zuzhiname=request.getParameter("zuzhiname");
		 String dizhi=request.getParameter("dizhi");
	     String faren=request.getParameter("faren");
	     String ziben=request.getParameter("ziben");
	     String chengliriqi=request.getParameter("chengliriqi");
	     String yingyeriqi=request.getParameter("yingyeriqi");
		System.out.println(zuzhiname);
	     if((zuzhiname!=null)&&(dizhi!=null)&&(faren!=null)&&(ziben!=null)&&(chengliriqi!=null)&&(yingyeriqi!=null))
	     {
		     zuzhiname=zuzhiname.trim();
		     dizhi=dizhi.trim();
		     faren=faren.trim();
		     ziben=ziben.trim();
		     chengliriqi=chengliriqi.trim();
		     yingyeriqi=yingyeriqi.trim();
		     if(zuzhiname!=""&&(dizhi!="")&&(faren!="")&&(ziben!="")&&(chengliriqi!="")&&(yingyeriqi!="")){
		     flagpanduan=true;
		     }
		     System.out.println(flagpanduan+zuzhiname);
	     };
	     if(flagpanduan==true){     
			 	  try{
			      String sql="insert into gong (name,dizhi,faren,ziben,chengliriqi,yingyeriqi) values (?,?,?,?,?,?)";    
				      if(request.getParameter("zuzhiname")!=null)
					  {				
					    String [] param={zuzhiname,dizhi,faren,ziben,chengliriqi,yingyeriqi};
					    SqlUtils sqlUtils=new SqlUtils();
						flag=sqlUtils.update(sql, param);
						System.out.println(flag);
									      	  if(flag==true) 
										      {
										      String s="��˾��ӳɹ�";
											  out.println("<script>alert('"+s+"');</script>");
										      System.out.println(s);
										      }else
										      {
										      String s="��˾���ʧ�ܣ��Ѵ��ڴ˹�˾�����������룡";
											  out.println("<script>alert('"+s+"');</script>");
										      System.out.println(s);
										      };
					  };
			      }catch(Exception e){
			       System.out.println(e.getMessage());
			      };

			}else{
										    //  String s="������������ݲ���Ϊ�գ�";
											 // out.println("<script>alert('"+s+"');</script>");
										     // System.out.println(s);			
			};
%>




</body>



</html>

