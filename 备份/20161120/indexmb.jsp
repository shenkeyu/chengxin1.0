<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>�񻪳�����Ϣ����ϵͳ</title>

<link rel="stylesheet" type="text/css" href="indexkongzhi.css">
<link type="text/css" rel="stylesheet"  href="script/jqueryTreeTable/stylesheets/jquery.treetable.css">
<link type="text/css" rel="stylesheet"  href="script/jqueryTreeTable/stylesheets/jquery.treetable.theme.default.css">  

<script src="script/jqueryTreeTable/jquery.treetable.js" type="text/javascript"></script>
<script src="script/jqueryTreeTable/vendor/jquery.js" type="text/javascript"></script>

</head>


<script type="text/javascript">
$(document).ready(function() {

           $(function(){
            var option = {
                theme:"default",
                expandLevel:2,
                beforeExpand:function($treeTable, id) {
                    //�ж�id�Ƿ��Ѿ����˺��ӽڵ㣬������˾Ͳ��ټ��أ������Ϳ����𵽻��������
                    if($('.'+id,$treeTable).length) {return false;}
                    //�����html������ajax����
                    var html ='<tr data-tt-id="8" data-tt-parent-id="6"><td>5.1</td><td>������ajax������������</td></tr>'
					+'<tr data-tt-id="9" data-tt-parent-id="6"><td>5.2</td><td>��̬������</td></tr>';
                    $treeTable.addChilds(html);
                },
                onSelect:function($treeTable,id){
                    window.alert('onSelect:'+id);                    
                }
            };
           $('#treeTable1').treeTable(option);
			//$("#treeTable1").treetable({expandable:true});
        }); 

});		
</script>


<body>
<div id="Container">

    <div id="Header">
        <div id="logo">
       		 <div id="person">
     	  	 <table width="200" border="0" cellspacing="0" cellpadding="0">
  			 <tbody>
		    <tr>
 		     <td>�û�����</td>
 		     <td>&nbsp;</td>
 		     <td>ְ��</td>
   		   <td>&nbsp;</td>
  			  </tr>
 			   <tr>
		      <td>���ţ�</td>
		      <td colspan="3">&nbsp;</td>
 		     </tr>
			  </tbody>
			</table>
          	 </div>
        </div>
    </div>
    <div id="Content">
        <div id="Content-Left">
        
           <div id="Left-logo">
           <img src="image/jichuxinxi/chengxinguanlileftlogo.png" width="180" height="61" alt=""/>
           </div>
           
           <div>
                <table id="treeTable1">
                <thead>
                <tr>
                    <th>
                        ����</th>
                    <th>
                        ����</th>
                </tr>
    			</thead>
                 <tbody>
                <tr ttId="1">
                    <td>
                        <span class="indenter" controller="true">1</span></td>
                    <td>
                        ����</td>
                </tr>
                <tr ttId="2" ttParentId="1">
                    <td>
                        <span class="indenter" controller="true">2</span></td>
                    <td>����</td>
                </tr>
                <tr ttId="3" ttParentId="2">
                    <td>
                        3</td>
                    <td>
                        ����</td>
                </tr>
                <tr ttId="4" ttParentId="2">
                    <td>
                        4</td>
                    <td>
                        ����</td>
                </tr>
                <tr ttId="5" ttParentId="4">
                    <td>
                        4.1</td>
                    <td>
                        ����</td>
                </tr>
                <tr ttId="6" ttParentId="1" haschild="true">
                    <td>5</td>
                    <td>ע������ڵ��Ƕ�̬���ص�</td>
                </tr>
                <tr ttId="7">
                    <td>8</td>
                    <td>����</td>
                </tr>
                 </tbody>
            </table>

            </div>
                          
    </div>        
      <div id="Content-Main">Content-Main</div>
</div>
    <div class="Clear"></div>
    <div id="Footer">Footer</div>
</div>
<span style="color: #4083E2"></span><span style="color: #FFFFFF"></span>
</body>
</html>

