<%@ page language="java" import="java.sql.*" contentType="text/html; charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>振华诚信信息管理系统</title>
</head>
<body id="rightbody">

<%request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
         
     String leixing=null;
     int qiyue=1000;
     int jieyue=1000;
     if(request.getParameter("qiyue")!=null)
     {
		qiyue=Integer.valueOf(request.getParameter("qiyue"));
     };
     if(request.getParameter("jieyue")!=null)
     {
		jieyue=Integer.valueOf(request.getParameter("jieyue"));
     };
     if(request.getParameter("leixing")!=null)
     {
		leixing=request.getParameter("leixing").toString().trim();
     };
     
     System.out.println(leixing+qiyue+jieyue);
     if(qiyue<13&&qiyue>0&&jieyue>0&&jieyue<13){
     System.out.println(leixing+qiyue+jieyue);
    	 if(leixing.equals("person")||leixing.equals("nei")||leixing.equals("wai")||leixing.equals("gong")){
    	         Connection conn=null;
			     Statement stmt=null;
			     ResultSet rs=null;
			     System.out.println(leixing+qiyue+jieyue);
     %>
     		<% if(leixing.equals("person")){%>
  
  <%
  int youxiu=0,lianghao=0,jingshi=0,buliang=0;
        try{
       Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//设置连接的数据库      
		String USER = session.getAttribute("ssYONGHU").toString();
		String PWD = session.getAttribute("ssMIMA").toString();
		conn = DriverManager.getConnection(URL, USER, PWD);
       stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
       String sql="select * from personMonthScore where year=datepart(year,getdate()) and month>="+qiyue+" and month<="+jieyue; 
       System.out.println(sql);
       rs=stmt.executeQuery(sql);
              //将指标移至最后一条记录
       rs.last(); 
              //获取记录总数       
        int RowCount=rs.getRow();
        System.out.println(RowCount);
        rs.first();
      do{
       		if(Float.valueOf(rs.getString("personfenshu"))>120.0){
       		youxiu=youxiu+1;       		
       		}else if(Float.valueOf(rs.getString("personfenshu"))<=120.0&&Float.valueOf(rs.getString("personfenshu"))>90.0){
       		lianghao=lianghao+1;
       		}else if(Float.valueOf(rs.getString("personfenshu"))<=90.0&&Float.valueOf(rs.getString("personfenshu"))>70.0){
       		jingshi=jingshi+1;
       		}else{
       		buliang=buliang+1;
       		}; 
       		RowCount=RowCount-1;   
		       if(RowCount<0)
		       { 
		        //跳出循环
		        break;
		       };    		      
       }while(rs.next());
       }catch(Exception e){
     System.out.println(e.getMessage());
    }; 
 System.out.println(youxiu+"--"+lianghao+"--"+jingshi+"--"+buliang); 
 request.setAttribute("youxiu", youxiu);
 request.setAttribute("lianghao", lianghao);
  request.setAttribute("jingshi", jingshi);
   request.setAttribute("buliang", buliang); 
   request.setAttribute("qiyue",qiyue); 
   request.setAttribute("jieyue",jieyue); 
   %>   		
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <center>
    <div id="main" style="width:50%;height:400px;"></div><div id="main1" style="width:50%;height:400px;"></div>
    </center>
    <!-- 引入echarts.js -->
    <script src="<%=basePath%>script/echarts.js "></script> 

    <script>
    var myChart = echarts.init(document.getElementById('main'));
    myChart.title = '直方图';
    option = {
        color: ['#3398DB'],
            title : {
        text: '个人情况统计',
        subtext: ${qiyue}+'月到'+${jieyue}+'月',
        x:'center'
    		},
        tooltip : {
            trigger: 'axis',
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                data : ['诚信', '良好', '警示', '不良'],
                axisTick: {
                    alignWithLabel: true
                }
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series : [
            {
                name:'个人信用情况',
                type:'bar',
                barWidth: '60%',
                          //配置样式
            itemStyle: {   
                //通常情况下：
                normal:{  //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                    color: function (params){
                        var colorList = ['rgb(0,255,0)','rgb(51,0,255)','rgb(255,255,0)','rgb(255,0,51)'];
                        return colorList[params.dataIndex];
                    }
                }
                },
                data:[${youxiu}, ${lianghao}, ${jingshi}, ${buliang}]
            }
        ]
    };
    myChart.setOption(option);
    </script>
 	
     <script>
    var myChart = echarts.init(document.getElementById('main1'));
    myChart.title = '饼图';	
 	option = {
    title : {
        text: '个人情况统计',
        subtext: ${qiyue}+'月到'+${jieyue}+'月',
        x:'center'
    },
    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
    legend: {
        orient: 'vertical',
        left: 'left',
        data: ['诚信', '良好', '警示', '不良']
    },
    series : [
        {
            name: '得分比例',
            type: 'pie',
            radius : '55%',
            center: ['50%', '60%'],
            data:[
                {value:${youxiu}, name:'诚信'},
                {value:${lianghao}, name:'良好'},
                {value:${jingshi}, name:'警示'},
                {value:${buliang}, name:'不良'}
            ],
            itemStyle: {
                emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                },
                //通常情况下：
                normal:{  //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                    color: function (params){
                        var colorList = ['rgb(0,255,0)','rgb(51,0,255)','rgb(255,255,0)','rgb(255,0,51)'];
                        return colorList[params.dataIndex];
                    }
                }

            }
        }
    ]
};
 	

 	    myChart.setOption(option);
    </script>    		   
 <% //////////////////////////////////////////////////////////////////////////////////////////////   %> 		
     		<% }else if(leixing.equals("nei")){%>
     		
   <%
  int youxiu=0,lianghao=0,jingshi=0,buliang=0;
        try{
       Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//设置连接的数据库      
		String USER = session.getAttribute("ssYONGHU").toString();
		String PWD = session.getAttribute("ssMIMA").toString();
		conn = DriverManager.getConnection(URL, USER, PWD);
       stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
       String sql="select * from neiMonthScore where year=datepart(year,getdate()) and month>="+qiyue+" and month<="+jieyue; 
       System.out.println(sql);
       rs=stmt.executeQuery(sql);
              //将指标移至最后一条记录
       rs.last(); 
              //获取记录总数       
        int RowCount=rs.getRow();
        System.out.println(RowCount);
        rs.first();
      do{
       		if(Float.valueOf(rs.getString("neifenshu"))>=90.0){
       		youxiu=youxiu+1;       		
       		}else if(Float.valueOf(rs.getString("neifenshu"))<90.0&&Float.valueOf(rs.getString("neifenshu"))>=80.0){
       		lianghao=lianghao+1;
       		}else if(Float.valueOf(rs.getString("neifenshu"))<80.0&&Float.valueOf(rs.getString("neifenshu"))>=70.0){
       		jingshi=jingshi+1;
       		}else{
       		buliang=buliang+1;
       		}; 
       		RowCount=RowCount-1;   
		       if(RowCount<0)
		       { 
		        //跳出循环
		        break;
		       };    		      
       }while(rs.next());
       }catch(Exception e){
     System.out.println(e.getMessage());
    }; 
 System.out.println(youxiu+"--"+lianghao+"--"+jingshi+"--"+buliang); 
 request.setAttribute("youxiu", youxiu);
 request.setAttribute("lianghao", lianghao);
  request.setAttribute("jingshi", jingshi);
   request.setAttribute("buliang", buliang); 
   request.setAttribute("qiyue",qiyue); 
   request.setAttribute("jieyue",jieyue); 
   %>   		
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <center>
    <div id="main2" style="width:50%;height:400px;"></div><div id="main3" style="width:50%;height:400px;"></div>
    </center>
    <!-- 引入echarts.js -->
    <script src="<%=basePath%>script/echarts.js "></script> 

    <script>
    var myChart = echarts.init(document.getElementById('main2'));
    myChart.title = '直方图';
    option = {
        color: ['#3398DB'],
            title : {
        text: '内分包商情况统计',
        subtext: ${qiyue}+'月到'+${jieyue}+'月',
        x:'center'
    		},
        tooltip : {
            trigger: 'axis',
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                data : ['诚信', '良好', '警示', '不良'],
                axisTick: {
                    alignWithLabel: true
                }
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series : [
            {
                name:'内分包商信用情况',
                type:'bar',
                barWidth: '60%',
                itemStyle: {   
                //通常情况下：
                normal:{  //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                    color: function (params){
                        var colorList = ['rgb(0,255,0)','rgb(51,0,255)','rgb(255,255,0)','rgb(255,0,51)'];
                        return colorList[params.dataIndex];
                    }
                }
				},
                data:[${youxiu}, ${lianghao}, ${jingshi}, ${buliang}]
            }
        ]
    };
    myChart.setOption(option);
    </script>
 	
     <script>
    var myChart = echarts.init(document.getElementById('main3'));
    myChart.title = '饼图';	
 	option = {
    title : {
        text: '内分包商情况统计',
        subtext: ${qiyue}+'月到'+${jieyue}+'月',
        x:'center'
    },
    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
    legend: {
        orient: 'vertical',
        left: 'left',
        data: ['诚信', '良好', '警示', '不良']
    },
    series : [
        {
            name: '得分比例',
            type: 'pie',
            radius : '55%',
            center: ['50%', '60%'],
            data:[
                {value:${youxiu}, name:'诚信'},
                {value:${lianghao}, name:'良好'},
                {value:${jingshi}, name:'警示'},
                {value:${buliang}, name:'不良'}
            ],
            itemStyle: {
                emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                },
                //通常情况下：
                normal:{  //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                    color: function (params){
                        var colorList = ['rgb(0,255,0)','rgb(51,0,255)','rgb(255,255,0)','rgb(255,0,51)'];
                        return colorList[params.dataIndex];
                    }
                    }
            }
        }
    ]
};
 	

 	    myChart.setOption(option);
    </script>       		
     		

 <% //////////////////////////////////////////////////////////////////////////////////////////////   %>      		
     		<% }else if(leixing.equals("wai")){%>
     		
    <%
  int youxiu=0,lianghao=0,jingshi=0,buliang=0;
        try{
       Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//设置连接的数据库      
		String USER = session.getAttribute("ssYONGHU").toString();
		String PWD = session.getAttribute("ssMIMA").toString();
		conn = DriverManager.getConnection(URL, USER, PWD);
       stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
       String sql="select * from waiMonthScore where year=datepart(year,getdate()) and month>="+qiyue+" and month<="+jieyue; 
       System.out.println(sql);
       rs=stmt.executeQuery(sql);
              //将指标移至最后一条记录
       rs.last(); 
              //获取记录总数       
        int RowCount=rs.getRow();
        System.out.println(RowCount);
        rs.first();
      do{
       		if(Float.valueOf(rs.getString("waifenshu"))>=90.0){
       		youxiu=youxiu+1;       		
       		}else if(Float.valueOf(rs.getString("waifenshu"))<90.0&&Float.valueOf(rs.getString("waifenshu"))>=80.0){
       		lianghao=lianghao+1;
       		}else if(Float.valueOf(rs.getString("waifenshu"))<80.0&&Float.valueOf(rs.getString("waifenshu"))>=70.0){
       		jingshi=jingshi+1;
       		}else{
       		buliang=buliang+1;
       		}; 
       		RowCount=RowCount-1;   
		       if(RowCount<0)
		       { 
		        //跳出循环
		        break;
		       };    		      
       }while(rs.next());
       }catch(Exception e){
     System.out.println(e.getMessage());
    }; 
 System.out.println(youxiu+"--"+lianghao+"--"+jingshi+"--"+buliang); 
 request.setAttribute("youxiu", youxiu);
 request.setAttribute("lianghao", lianghao);
  request.setAttribute("jingshi", jingshi);
   request.setAttribute("buliang", buliang); 
   request.setAttribute("qiyue",qiyue); 
   request.setAttribute("jieyue",jieyue); 
   %>   		
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <center>
    <div id="main4" style="width:50%;height:400px;"></div><div id="main5" style="width:50%;height:400px;"></div>
    </center>
    <!-- 引入echarts.js -->
    <script src="<%=basePath%>script/echarts.js "></script> 

    <script>
    var myChart = echarts.init(document.getElementById('main4'));
    myChart.title = '直方图';
    option = {
        color: ['#3398DB'],
            title : {
        text: '外分包商情况统计',
        subtext: ${qiyue}+'月到'+${jieyue}+'月',
        x:'center'
    		},
        tooltip : {
            trigger: 'axis',
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                data : ['诚信', '良好', '警示', '不良'],
                axisTick: {
                    alignWithLabel: true
                }
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series : [
            {
                name:'外分包商信用情况',
                type:'bar',
                barWidth: '60%',
                itemStyle: {   
                //通常情况下：
                normal:{  //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                    color: function (params){
                        var colorList = ['rgb(0,255,0)','rgb(51,0,255)','rgb(255,255,0)','rgb(255,0,51)'];
                        return colorList[params.dataIndex];
                    }
                }
				},
                data:[${youxiu}, ${lianghao}, ${jingshi}, ${buliang}]
            }
        ]
    };
    myChart.setOption(option);
    </script>
 	
     <script>
    var myChart = echarts.init(document.getElementById('main5'));
    myChart.title = '饼图';	
 	option = {
    title : {
        text: '外分包商情况统计',
        subtext: ${qiyue}+'月到'+${jieyue}+'月',
        x:'center'
    },
    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
    legend: {
        orient: 'vertical',
        left: 'left',
        data: ['诚信', '良好', '警示', '不良']
    },
    series : [
        {
            name: '得分比例',
            type: 'pie',
            radius : '55%',
            center: ['50%', '60%'],
            data:[
                {value:${youxiu}, name:'诚信'},
                {value:${lianghao}, name:'良好'},
                {value:${jingshi}, name:'警示'},
                {value:${buliang}, name:'不良'}
            ],
            itemStyle: {
                emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                },
                //通常情况下：
                normal:{  //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                    color: function (params){
                        var colorList = ['rgb(0,255,0)','rgb(51,0,255)','rgb(255,255,0)','rgb(255,0,51)'];
                        return colorList[params.dataIndex];
                    }
                    }
            }
        }
    ]
};
 	

 	    myChart.setOption(option);
    </script>    		
     		
     		

  <% //////////////////////////////////////////////////////////////////////////////////////////////   %>     		
     		<% }else if(leixing.equals("gong")){%>
     		
     <%
  int youxiu=0,lianghao=0,jingshi=0,buliang=0;
        try{
       Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");//加载JDBC驱动器类
		String URL = "jdbc:sqlserver://localhost:1433;DatabaseName="+session.getAttribute("ssURL").toString();//设置连接的数据库      
		String USER = session.getAttribute("ssYONGHU").toString();
		String PWD = session.getAttribute("ssMIMA").toString();
		conn = DriverManager.getConnection(URL, USER, PWD);
       stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
       String sql="select * from gongMonthScore where year=datepart(year,getdate()) and month>="+qiyue+" and month<="+jieyue; 
       System.out.println(sql);
       rs=stmt.executeQuery(sql);
              //将指标移至最后一条记录
       rs.last(); 
              //获取记录总数       
        int RowCount=rs.getRow();
        System.out.println(RowCount);
        rs.first();
      do{
       		if(Float.valueOf(rs.getString("gongfenshu"))>=90.0){
       		youxiu=youxiu+1;       		
       		}else if(Float.valueOf(rs.getString("gongfenshu"))<90.0&&Float.valueOf(rs.getString("gongfenshu"))>=80.0){
       		lianghao=lianghao+1;
       		}else if(Float.valueOf(rs.getString("gongfenshu"))<80.0&&Float.valueOf(rs.getString("gongfenshu"))>=70.0){
       		jingshi=jingshi+1;
       		}else{
       		buliang=buliang+1;
       		}; 
       		RowCount=RowCount-1;   
		       if(RowCount<0)
		       { 
		        //跳出循环
		        break;
		       };    		      
       }while(rs.next());
       }catch(Exception e){
     System.out.println(e.getMessage());
    }; 
 System.out.println(youxiu+"--"+lianghao+"--"+jingshi+"--"+buliang); 
 request.setAttribute("youxiu", youxiu);
 request.setAttribute("lianghao", lianghao);
  request.setAttribute("jingshi", jingshi);
   request.setAttribute("buliang", buliang); 
   request.setAttribute("qiyue",qiyue); 
   request.setAttribute("jieyue",jieyue); 
   %>   		
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <center>
    <div id="main4" style="width:50%;height:400px;"></div><div id="main5" style="width:50%;height:400px;"></div>
    </center>
    <!-- 引入echarts.js -->
    <script src="<%=basePath%>script/echarts.js "></script> 

    <script>
    var myChart = echarts.init(document.getElementById('main4'));
    myChart.title = '直方图';
    option = {
        color: ['#3398DB'],
            title : {
        text: '供应商情况统计',
        subtext: ${qiyue}+'月到'+${jieyue}+'月',
        x:'center'
    		},
        tooltip : {
            trigger: 'axis',
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis : [
            {
                type : 'category',
                data : ['A级', 'B级', 'C级', 'D级'],
                axisTick: {
                    alignWithLabel: true
                }
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series : [
            {
                name:'供应商信用情况',
                type:'bar',
                barWidth: '60%',
                itemStyle: {   
                //通常情况下：
                normal:{  //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                    color: function (params){
                        var colorList = ['rgb(0,255,0)','rgb(51,0,255)','rgb(255,255,0)','rgb(255,0,51)'];
                        return colorList[params.dataIndex];
                    }
                }
				},
                data:[${youxiu}, ${lianghao}, ${jingshi}, ${buliang}]
            }
        ]
    };
    myChart.setOption(option);
    </script>
 	
     <script>
    var myChart = echarts.init(document.getElementById('main5'));
    myChart.title = '饼图';	
 	option = {
    title : {
        text: '供应商情况统计',
        subtext: ${qiyue}+'月到'+${jieyue}+'月',
        x:'center'
    },
    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
    legend: {
        orient: 'vertical',
        left: 'left',
        data: ['A级', 'B级', 'C级', 'D级']
    },
    series : [
        {
            name: '得分比例',
            type: 'pie',
            radius : '55%',
            center: ['50%', '60%'],
            data:[
                {value:${youxiu}, name:'A级'},
                {value:${lianghao}, name:'B级'},
                {value:${jingshi}, name:'C级'},
                {value:${buliang}, name:'D级'}
            ],
            itemStyle: {
                emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                },
                //通常情况下：
                normal:{  //每个柱子的颜色即为colorList数组里的每一项，如果柱子数目多于colorList的长度，则柱子颜色循环使用该数组
                    color: function (params){
                        var colorList = ['rgb(0,255,0)','rgb(51,0,255)','rgb(255,255,0)','rgb(255,0,51)'];
                        return colorList[params.dataIndex];
                    }
                    }
            }
        }
    ]
};
 	

 	    myChart.setOption(option);
    </script>     		
     		
     		
     		

 <% //////////////////////////////////////////////////////////////////////////////////////////////   %>      		
     		<%}%>
 		 
	<%rs.close();
	stmt.close();
	conn.close();
	};
	
	}else{%> 
	<div style="font-size:35px;">	
 	<center>请选择要统计的内容，并输入相应的月份区间，确认后形成统计图表！</center>
 	</div>
 	 	 <%}%>
</body>
</html>

