<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="css/indexkongzhileft.css">
<link rel="stylesheet" type="text/css" href="css/dhtmlxtree.css">
<script src="script/dhtmlxcommon.js" type="text/javascript"></script>
<script src="script/dhtmlxtree.js" type="text/javascript"></script>
<title>振华诚信信息管理系统</title>

</head>
<body id="leftbody" onload="doOnLoad()">
        <div id="Content-Left">
        	<div id="Left-logo">
       	 	<img src="image/jichuxinxi/chengxinguanlileftlogo.png" width="180" height="61" alt=""/>
        	</div> 
        
      
        	<div id="treeDiv" style="width:240px;height: 100%;font-size:40px;padding-left:20px;margin-top:10px;">
			  	</div>
        	
        	<div id="logarea" style="background-color:#d3d3d3;height:250px;width:400px; padding:3px; overflow:auto;"></div>
			<script language="JavaScript">
			var tree;
			function doOnLoad(){
			tree=new dhtmlXTreeObject('treeDiv',"100%","100%",'0');
			tree.loadXML("xml/maintree.xml");
			tree.enableDragAndDrop(false);  
            tree.enableTreeLines(false); 
			tree.setImagePath("image/dhtmltree/");
			tree.setImageArrays("plus","","","","plus.gif");  
	        tree.setImageArrays("minus","","","","minus.gif");  
	        //tree.enableMultiLineItems("300px");  //设置节点高度
	        tree.setStdImages("forlder0.gif","folderOpen.gif","folderClosed.gif");  
	        tree.setItemImage("gerenxinxi","base1.gif","base1.gif");//设置节点图片 
            //tree.setItemColor(itemId,defaultColor,selectedColor);//设置节点颜色  
			tree.enableCheckBoxes(false);
			tree.enableThreeStateCheckboxes(true);

			tree.setOnClickHandler(tonclick);			
			};
			
			function doLog(str){
			var log = document.getElementById("logarea");
			log.innerHTML = log.innerHTML+str+"<br/>";
			log.scrollTop = log.scrollHeight;
		    };
		    
			function tonclick(id){
			//dolog("Item "+tree.getItemText(id)+" was selected");
			if(tree.getItemText(id)=="beifenhuifu"){
			window.alert("Item "+tree.getItemText(id)+" was selected");
			};
		    };
 		
			</script>

        </div>         
</body>
</html>

