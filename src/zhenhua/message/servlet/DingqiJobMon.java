package zhenhua.message.servlet;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import zhenhua.sql.SqlUtils;


public class DingqiJobMon implements Job
{
    @Override
    public void execute(JobExecutionContext jec) throws JobExecutionException 
    {
        Calendar cal = Calendar.getInstance();
        int persondoyear = cal.get(Calendar.YEAR);//获取年份
        int persondomonth=cal.get(Calendar.MONTH);//获取月份
        int persondoday=cal.get(Calendar.DATE);//获取日
        float xingweibili=(float)0.2;//行为规范所占比例
        float zhiliangbili=(float)0.4;//质量规范所占比例
        float anquanbili=(float)0.4;//安全规范所占比例
        System.out.println("每月执行的任务开始了！");     //定时器，tomcat运行后，每月的最后一天的23:20执行
        ///////////个人分数/////////////////////////////////////////////////////////////////////////////
        ///////////////月度最终处理//////////////
		Connection conn = null;
	    Statement stmt=null;
	    ResultSet rs=null;
    	    try {
        	String sql1="select * from personMonview";//查看月度求和view
        	SqlUtils sqlUtils1=new SqlUtils();
        	conn = sqlUtils1.getConnection();
    		stmt= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);	
    		rs=stmt.executeQuery(sql1);
	    		while(rs.next())
	    		{
	    			String personIDcard=rs.getString("personIDcard");
	    			String personname=rs.getString("personname");
	    	        float personfenshu=rs.getFloat("personfenshu");	    			
	    			float personXWGF=0;
	    			float personZLXY=0;
	    			float personAQXY=0;
	    			if(rs.getString("xingweifen")!=null){
	    			personXWGF=rs.getFloat("xingweifen");
	    			};
	    			if(rs.getString("zhiliangfen")!=null){
		    		personZLXY=rs.getFloat("zhiliangfen");
	    			};
	    			if(rs.getString("anquanfen")!=null){
		    		personAQXY=rs.getFloat("anquanfen");
	    			};
	    			////////////行为规范评价////////////////////
	    	        int xingwei2yuejiafen=0;//连续2个月内没有违反行为规范的，可一次加2分
	    	        if(persondomonth>2)  //判断是否是3月以后的月份
	    	        {
	    	        	try{
	    	        		String sql="select * from persondorecord where persondocheck=1 and personfen<0 and (persondomonth="+Integer.toString(persondomonth-1)+" or persondomonth="+Integer.toString(persondomonth-2)+") and personIDcard='"+personIDcard+"' and persondoyear="+Integer.toString(persondoyear);
	    	        		SqlUtils sqlUtils=new SqlUtils();
	    	        		Boolean flag1=sqlUtils.queryjieguo(sql);
	    	        		if(flag1)
	    	        		{
		    	        		System.out.println(personIDcard+"行为规范犯规，不加分");	    	        			
	    	        		}else{
	    	        			xingwei2yuejiafen=2;
		    	        		System.out.println(personIDcard+"无行为规范犯规，加2分");		    	        			
	    	        		}
	    	        	}catch(Exception e){
	    	        		System.out.println(personIDcard+"行为规范加2分失败");
	    	        	};        	
	    	        }  
	    	        personXWGF=personXWGF+xingwei2yuejiafen;
	    	        //////////////////////////////////////
	    	        ///////////质量诚信评价///////////////////
	    	        //无单独需要操作项目//// 	    	        
	    	        ////////////////////////////////////
	    	        ///////////安全诚信评价/////////////////
	    	      /////安全信用综合分数=安全承诺分数*0.2+不良信用记录分数*0.4+黑名单*0.4+其他奖励加分（0-10）分
	    	        //此处特别需要注意加分上限为10分，所以月度分，不是涵盖了所有计分动作；年度计分，也不是简单的把所有计分动作求和;已经平移到日常计分中去计算，此处不再考虑
	    	        /////////安全诚信等级为甲级，基准分为100分/////
    	        	try{
    	        		String sql="select * from persondengji where personIDcard='"+personIDcard;
    	        		SqlUtils sqlUtils=new SqlUtils();
    	        		Connection conn1 = null;
    	        	    Statement stmt1=null;
    	        	    ResultSet rs1=null;
    	            	conn1 = sqlUtils.getConnection();
    	        		stmt1= conn1.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);	
    	        		rs1=stmt1.executeQuery(sql);
    	        		String persondengji=rs1.getString("persondengji");
    	        		if(persondengji=="甲级")
    	        		{
	    	        		System.out.println(personIDcard+"此人为甲级，基准分不变");	
	    	        	}else if(persondengji=="乙级"){
    	        			System.out.println(personIDcard+"此人为乙级，基准分-10分");	
    	        			personAQXY=personAQXY-(float)(10*0.4);
    	        		}else if(persondengji=="丙级"){
    	        			System.out.println(personIDcard+"此人为丙级，基准分-20分");
    	        			personAQXY=personAQXY-(float)(20*0.4);
    	        		}
    	        	}catch(Exception e){
    	        		System.out.println(personIDcard+"等级判断失败");
    	        	}; 
	    	        //////在黑名单内基准分为80分，否则为100分///////
    	        	try{
    	        		String sql="select * from personheimingdan where personIDcard='"+personIDcard;
    	        		SqlUtils sqlUtils=new SqlUtils();
    	        		Boolean flag1=sqlUtils.queryjieguo(sql);
    	        		if(flag1)
    	        		{
	    	        		System.out.println(personIDcard+"此人在黑名单中，-20分");	
	    	        		personAQXY=personAQXY-(float)(20*0.4);
    	        		}else{
    	        			System.out.println(personIDcard+"此人不在黑名单中，分数不变");		    	        			
    	        		}
    	        	}catch(Exception e){
    	        		System.out.println(personIDcard+"黑名单判断失败");
    	        	}; 	    	        
	    	        /////////////////////////////////////
	    	        System.out.println(personfenshu+"计分");
	    			personfenshu=personfenshu+xingweibili*personXWGF+zhiliangbili*personZLXY+anquanbili*personAQXY;	//按比例计算个人分
	    			System.out.println(personfenshu+"计分");
	    			personXWGF=120+personXWGF;
	    			personZLXY=120+personZLXY;
	    			personAQXY=120+personAQXY;
	    			/////////////////////////////写入月度表，更新总表中个人的分数//////////////////////////////////////
	    	    	try{
	    	    		String sql2="insert into personMonthScore (personname,personIDcard,personfenshu,personXWGF,personZLXY,personAQXY) values (?,?,?,?,?,?)";
	    	    		String [] param={personname,personIDcard,String.valueOf(personfenshu),String.valueOf(personXWGF),String.valueOf(personZLXY),String.valueOf(personAQXY)};
	    	    		SqlUtils sqlUtils2=new SqlUtils();
	    	    		Boolean flag2=sqlUtils2.update(sql2, param);
	    	    			if(flag2){//更新总表
	    	    				String sql3="update person set personfenshu=? WHERE personIDcard=?";
	    	    				String [] param1={String.valueOf(personfenshu),personIDcard};
	    	    				SqlUtils sqlUtils3=new SqlUtils();
	    	    				boolean flag3=sqlUtils3.update(sql3, param1);
	    	    					if(flag3){
	    	    					System.out.println(personIDcard+"月度计分成功");
	    	    					}else{
	    	    					System.out.println(personIDcard+"月度计分未成功");
	    	    					}
	    	    				}
	    	        	}catch(Exception e){
	    	        		System.out.println(personIDcard+"月度计分未操作未成功");
	    	        	}; 
	    	        ////////////////////////////////////////////////////////////////////////////
	    		}
    		}catch (SQLException e){
    			e.printStackTrace();
    		}finally{
    			try {
    				rs.close();
    				stmt.close();
    				conn.close();
    				}catch (SQLException e) {
    				e.printStackTrace();
    				};
    		}   
        ////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        
        
        
        
        ///////////内分包商/////////////////////////////////////////////////////////////////////////////
        ////////////行为规范评价////////////////////
        
        
        //////////////////////////////////////
        ///////////质量诚信评价///////////////////
        
        
        ////////////////////////////////////
        ///////////安全诚信评价/////////////////
        
        /////////////////////////////////////
        ///////////////月度最终处理//////////////
        
        ////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        
        
        
        
        
        ///////////外分包商/////////////////////////////////////////////////////////////////////////////
            ///////////////月度最终处理//////////////
    		Connection connwai = null;
    	    Statement stmtwai=null;
    	    ResultSet rswai=null;
        	    try {
            	String sqlwai="select * from waiMonview";//查看月度求和view
            	SqlUtils sqlUtilswai=new SqlUtils();
            	connwai = sqlUtilswai.getConnection();
        		stmtwai= connwai.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);	
        		rswai=stmtwai.executeQuery(sqlwai);
        		
    	    		while(rswai.next())
    	    		{
    	    			float waifenshu=0;
    	    			String wainame=rswai.getString("name");
    	    	        waifenshu=rswai.getFloat("fenshu");//上月的分数值
    	    	        float waiZLPJ,waiJHPJ,waiFWPJ=0;
    	    	        waiZLPJ=rswai.getFloat("waizhiliangfen");
    	    	        waiJHPJ=rswai.getFloat("waijiaohuoqifen");
    	    	        waiFWPJ=rswai.getFloat("waifuwufen");
    	    	        /////////////////////////////////////
    	    	        /////////////////////////////////////
    	    	        //System.out.println(waifenshu+"计分");
    	    	        System.out.println("100分计分");
    	    			waifenshu=100+(float)(0.45*waiZLPJ+0.45*waiJHPJ+0.1*waiFWPJ);	//每月100分制时采用，暂时未利用上月的分数值
    	    			System.out.println(waifenshu+"计分");
    	    	        waiZLPJ=100+rswai.getFloat("waiZLPJ");
    	    	        waiJHPJ=100+rswai.getFloat("waiJHPJ");
    	    	        waiFWPJ=100+rswai.getFloat("waiFWPJ");
    	    			/////////////////////////////写入月度表，更新总表中个人的分数//////////////////////////////////////
    	    	    	try{
    	    	    		String sql2="insert into waiMonthScore (wainame,waifenshu,waiZLPJ,waiJHPJ,waiFWPJ) values (?,?,?,?,?)";
    	    	    		String [] param={wainame,String.valueOf(waifenshu),String.valueOf(waiZLPJ),String.valueOf(waiJHPJ),String.valueOf(waiFWPJ)};
    	    	    		SqlUtils sqlUtils2=new SqlUtils();
    	    	    		Boolean flag2=sqlUtils2.update(sql2, param);
    	    	    			if(flag2){//更新总表
    	    	    				String sql3="update wai set fenshu=? WHERE name=?";
    	    	    				String [] param1={String.valueOf(waifenshu),wainame};
    	    	    				SqlUtils sqlUtils3=new SqlUtils();
    	    	    				boolean flag3=sqlUtils3.update(sql3, param1);
    	    	    					if(flag3){
    	    	    					System.out.println(wainame+"月度计分成功");
    	    	    					}else{
    	    	    					System.out.println(wainame+"月度计分未成功");
    	    	    					}
    	    	    				}
    	    	        	}catch(Exception e){
    	    	        		System.out.println(wainame+"月度计分未操作未成功");
    	    	        	}; 
    	    	        ////////////////////////////////////////////////////////////////////////////
    	    		}
        		}catch (SQLException e){
        			e.printStackTrace();
        		}finally{
        			try {
        				rswai.close();
        				stmtwai.close();
        				connwai.close();
        				}catch (SQLException e) {
        				e.printStackTrace();
        				};
        		}   
            ////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        
        
        
        
        
        
        
        //////////供应商/////////////////////////////////////////////////////////////////////////////
                ///////////////月度最终处理//////////////
        		Connection conngong = null;
        	    Statement stmtgong=null;
        	    ResultSet rsgong=null;
            	    try {
                	String sqlgong="select * from gongMonview";//查看月度求和view
                	SqlUtils sqlUtilsgong=new SqlUtils();
                	conngong = sqlUtilsgong.getConnection();
            		stmtgong= conngong.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);	
            		rsgong=stmtgong.executeQuery(sqlgong);
            		
        	    		while(rsgong.next())
        	    		{
        	    			float gongfenshu=0;
        	    			String gongname=rsgong.getString("name");
        	    	        gongfenshu=rsgong.getFloat("fenshu");//上月的分数值
        	    	        float gongPZ,gongJQ,gongJG,gongFW,gongQT=0;
        	    	        gongPZ=rsgong.getFloat("gongPZ");
        	    	        gongJQ=rsgong.getFloat("gongJQ");
        	    	        gongJG=rsgong.getFloat("gongJG");
        	    	        gongFW=rsgong.getFloat("gongFW");
        	    	        gongQT=rsgong.getFloat("gongQT");        	    	     
        	    	        /////////////////////////////////////
        	    	        /////////////////////////////////////
        	    	        //System.out.println(gongfenshu+"计分");
        	    	        System.out.println("100分计分");
        	    			gongfenshu=100+(float)(0.3*gongPZ+0.25*gongJQ+0.25*gongJG+0.15*gongFW+0.05*gongQT);	//每月100分制时采用，暂时未利用上月的分数值
        	    			System.out.println(gongfenshu+"计分");
        	    	        gongPZ=100+rsgong.getFloat("gongPZ");
        	    	        gongJQ=100+rsgong.getFloat("gongJQ");
        	    	        gongJG=100+rsgong.getFloat("gongJG");
        	    	        gongFW=100+rsgong.getFloat("gongFW");
        	    	        gongQT=100+rsgong.getFloat("gongQT"); 
        	    			/////////////////////////////写入月度表，更新总表中个人的分数//////////////////////////////////////
        	    	    	try{
        	    	    		String sql2="insert into gongMonthScore (gongname,gongfenshu,gongPZ,gongJQ,gongJG,gongFW,gongQT) values (?,?,?,?,?,?,?)";
        	    	    		String [] param={gongname,String.valueOf(gongfenshu),String.valueOf(gongPZ),String.valueOf(gongJQ),String.valueOf(gongJG),String.valueOf(gongFW),String.valueOf(gongQT)};
        	    	    		SqlUtils sqlUtils2=new SqlUtils();
        	    	    		Boolean flag2=sqlUtils2.update(sql2, param);
        	    	    			if(flag2){//更新总表
        	    	    				String sql3="update gong set fenshu=? WHERE name=?";
        	    	    				String [] param1={String.valueOf(gongfenshu),gongname};
        	    	    				SqlUtils sqlUtils3=new SqlUtils();
        	    	    				boolean flag3=sqlUtils3.update(sql3, param1);
        	    	    					if(flag3){
        	    	    					System.out.println(gongname+"月度计分成功");
        	    	    					}else{
        	    	    					System.out.println(gongname+"月度计分未成功");
        	    	    					}
        	    	    				}
        	    	        	}catch(Exception e){
        	    	        		System.out.println(gongname+"月度计分未操作未成功");
        	    	        	}; 
        	    	        ////////////////////////////////////////////////////////////////////////////
        	    		}
            		}catch (SQLException e){
            			e.printStackTrace();
            		}finally{
            			try {
            				rsgong.close();
            				stmtgong.close();
            				conngong.close();
            				}catch (SQLException e) {
            				e.printStackTrace();
            				};
            		}   
                ////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        
        System.out.println("每月执行的任务结束了！"); 
    }
}
