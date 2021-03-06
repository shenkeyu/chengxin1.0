package zhenhua.message.servlet;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;









import zhenhua.sql.SqlUtils;

public class DingqiJobYear implements Job
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
        System.out.println("每年执行的任务开始了！");//定时器，tomcat运行后，每年的最后一天的23:30执行，需要对总表的基准分变为100
        ///////////个人分数/////////////////////////////////////////////////////////////////////////////
        ///////////////年度最终处理//////////////
		Connection conn = null;
	    Statement stmt=null;
	    ResultSet rs=null;
    	    try {
        	String sql1="select * from personMonview";//查看年度求和view    where month=12
        	SqlUtils sqlUtils1=new SqlUtils();
        	conn = sqlUtils1.getConnection();
    		stmt= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);	
    		rs=stmt.executeQuery(sql1);
	    		while(rs.next())
	    		{
	    			String personIDcard=rs.getString("personIDcard");
	    			String personname=rs.getString("personname").trim();
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
	    	        //无单独需要操作项目////        
	    	        //////////////////////////////////////
	    	        ///////////质量诚信评价///////////////////
	    	        //连续12个月内部报验合格率均达到质量目标的,加2分
    	        	try{
    	        		String sql="select * from persondorecord where persondocheck=2 and persondoerjicheck=1 and personfen<0 and personIDcard='"+personIDcard+"' and persondoyear="+Integer.toString(persondoyear);
    	        		SqlUtils sqlUtils=new SqlUtils();
    	        		Boolean flag1=sqlUtils.queryjieguo(sql);
    	        		if(flag1)
    	        		{
	    	        		System.out.println(personIDcard+"有未达到质量目标的月份");	    	        			
    	        		}else{
	    	        		System.out.println(personIDcard+"无未达到质量目标的月份，加2分");	
	    	        		personZLXY=personZLXY+2;
    	        		}
    	        	}catch(Exception e){
    	        		System.out.println(personIDcard+"12个月质量目标判断失败");
    	        	};  	    	        
	    	        //连续12个月未被QHSE部开具质量处罚或赔偿单的，加3分
    	        	try{
    	        		String sql="select * from persondorecord where persondocheck=2 and persondoerjicheck=2 and personfen<0 and personIDcard='"+personIDcard+"' and persondoyear="+Integer.toString(persondoyear);
    	        		SqlUtils sqlUtils=new SqlUtils();
    	        		Boolean flag1=sqlUtils.queryjieguo(sql);
    	        		if(flag1)
    	        		{
	    	        		System.out.println(personIDcard+"有开具质量处罚单或赔偿单的月份");	    	        			
    	        		}else{
	    	        		System.out.println(personIDcard+"无开具质量处罚单或赔偿单的月份，加3分");	
	    	        		personZLXY=personZLXY+3;
    	        		}
    	        	}catch(Exception e){
    	        		System.out.println(personIDcard+"12个月开具质量处罚单或赔偿判断失败");
    	        	}; 
	    	        //连续12个月未被QHSE部开具不合格品处理单的，加5分
    	        	try{
    	        		String sql="select * from persondorecord where persondocheck=2 and persondoerjicheck=3 and personfen<0 and personIDcard='"+personIDcard+"' and persondoyear="+Integer.toString(persondoyear);
    	        		SqlUtils sqlUtils=new SqlUtils();
    	        		Boolean flag1=sqlUtils.queryjieguo(sql);
    	        		if(flag1)
    	        		{
	    	        		System.out.println(personIDcard+"有开具不合格品处理单的月份");	    	        			
    	        		}else{
	    	        		System.out.println(personIDcard+"无开具不合格品处理单的月份，加5分");	
	    	        		personZLXY=personZLXY+5;
    	        		}
    	        	}catch(Exception e){
    	        		System.out.println(personIDcard+"12个月开具不合格品处理单判断失败");
    	        	};  
	    	        ////////////////////////////////////
	    	        ///////////安全诚信评价/////////////////
	    	      //无单独需要操作项目////  
	    	        /////////////////////////////////////
	    	        /////////////////////////////////////
	    	        System.out.println(personfenshu+"计分");
	    			personfenshu=personfenshu+xingweibili*personXWGF+zhiliangbili*personZLXY+anquanbili*personAQXY;	//按比例计算个人分
	    			System.out.println(personfenshu+"计分");
	    			personXWGF=120+personXWGF;
	    			personZLXY=120+personZLXY;
	    			personAQXY=120+personAQXY;
	    			/////////////////////////////写入年度表，更新总表中个人的分数//////////////////////////////////////
	    	    	try{
	    	    		String sql2="insert into personYearScore (personname,personIDcard,personfenshu,personXWGF,personZLXY,personAQXY) values (?,?,?,?,?,?)";
	    	    		String [] param={personname,personIDcard,String.valueOf(personfenshu),String.valueOf(personXWGF),String.valueOf(personZLXY),String.valueOf(personAQXY)};
	    	    		SqlUtils sqlUtils2=new SqlUtils();
	    	    		Boolean flag2=sqlUtils2.update(sql2, param);
	    	    			if(flag2){//更新总表
	    	    				String sql3="update person set personfenshu=? WHERE personIDcard=?";
	    	    				String [] param1={String.valueOf(personfenshu),personIDcard};
	    	    				SqlUtils sqlUtils3=new SqlUtils();
	    	    				boolean flag3=sqlUtils3.update(sql3, param1);
	    	    					if(flag3){
	    	    					System.out.println(personIDcard+"person年度计分成功");
	    	    					}else{
	    	    					System.out.println(personIDcard+"person年度计分未成功");
	    	    					}
	    	    				}
	    	        	}catch(Exception e){
	    	        		System.out.println(personIDcard+"person年度计分未操作未成功");
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
            ///////////////年度最终处理//////////////
    		Connection connnei = null;
    	    Statement stmtnei=null;
    	    ResultSet rsnei=null;
        	    try {
            	String sqlnei="select * from neiYearview";//查看年 度求和view
            	SqlUtils sqlUtilsnei=new SqlUtils();
            	connnei = sqlUtilsnei.getConnection();
        		stmtnei= connnei.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);	
        		rsnei=stmtnei.executeQuery(sqlnei);
        		
    	    		while(rsnei.next())
    	    		{
    	    			float neifenshu=0;
    	    			String neiname=rsnei.getString("neiname").trim();
    	    	        neifenshu=rsnei.getFloat("neifenshu")/12;//取12个月的平均分
    	    	        float neiSC=0,neiZL=0,neiAQ=0,neiJY=0,neiGY=0,neiZH=0;
    	    	        neiSC=rsnei.getFloat("neiSC")/12;
    	    	        neiZL=rsnei.getFloat("neiZL")/12;
    	    	        neiAQ=rsnei.getFloat("neiAQ")/12;
    	    	        neiJY=rsnei.getFloat("neiJY")/12;
    	    	        neiGY=rsnei.getFloat("neiGY")/12;
    	    	        neiZH=rsnei.getFloat("neiZH")/12;
    	    	        /////////////////////////////////////
    	    	        /////////////////////////////////////
    	    	        //System.out.println(neifenshu+"计分");
    	    	        System.out.println("100分计分");
    	    			//neifenshu=100+(float)(0.45*neiZLPJ+0.45*neiJHPJ+0.1*neiFWPJ);	//每月100分制时采用，暂时未利用上月的分数值
    	    			System.out.println(neifenshu+"计分");
    	    			/////////////////////////////写入月度表，更新总表中个人的分数//////////////////////////////////////
    	    	    	try{
    	    	    		String sql2="insert into neiYearScore (neiname,neifenshu,neiSC,neiZL,neiAQ,neiJY,neiGY,neiZH) values (?,?,?,?,?,?,?,?)";
    	    	    		String [] param={neiname,String.valueOf(neifenshu),String.valueOf(neiSC),String.valueOf(neiZL),String.valueOf(neiAQ),String.valueOf(neiJY),String.valueOf(neiGY),String.valueOf(neiZH)};
    	    	    		SqlUtils sqlUtils2=new SqlUtils();
    	    	    		Boolean flag2=sqlUtils2.update(sql2, param);
    	    	    			if(flag2){//更新总表
    	    	    				String sql3="update nei set fenshu=? WHERE name=?";
    	    	    				String [] param1={String.valueOf(neifenshu),neiname};
    	    	    				SqlUtils sqlUtils3=new SqlUtils();
    	    	    				boolean flag3=sqlUtils3.update(sql3, param1);
    	    	    					if(flag3){
    	    	    					System.out.println(neiname+"nei年度计分成功");
    	    	    					}else{
    	    	    					System.out.println(neiname+"nei年度计分未成功");
    	    	    					}
    	    	    				}
    	    	        	}catch(Exception e){
    	    	        		System.out.println(neiname+"nei年度计分未操作未成功");
    	    	        	}; 
    	    	        ////////////////////////////////////////////////////////////////////////////
    	    		}
        		}catch (SQLException e){
        			e.printStackTrace();
        		}finally{
        			try {
        				rsnei.close();
        				stmtnei.close();
        				connnei.close();
        				}catch (SQLException e) {
        				e.printStackTrace();
        				};
        		}   
            ////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        
        
        
        
        
        ///////////外分包商/////////////////////////////////////////////////////////////////////////////
            ///////////////年度最终处理//////////////
    		Connection connwai = null;
    	    Statement stmtwai=null;
    	    ResultSet rswai=null;
        	    try {
            	String sqlwai="select * from waiYearview";//查看年 度求和view
            	SqlUtils sqlUtilswai=new SqlUtils();
            	connwai = sqlUtilswai.getConnection();
        		stmtwai= connwai.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);	
        		rswai=stmtwai.executeQuery(sqlwai);
        		
    	    		while(rswai.next())
    	    		{
    	    			float waifenshu=0;
    	    			String wainame=rswai.getString("wainame").trim();
    	    	        waifenshu=rswai.getFloat("waifenshu")/12;//取12个月的平均分
    	    	        float waiZLPJ,waiJHPJ,waiFWPJ=0;
    	    	        waiZLPJ=rswai.getFloat("waiZLPJ")/12;
    	    	        waiJHPJ=rswai.getFloat("waiJHPJ")/12;
    	    	        waiFWPJ=rswai.getFloat("waiFWPJ")/12;
    	    	        /////////////////////////////////////
    	    	        /////////////////////////////////////
    	    	        //System.out.println(waifenshu+"计分");
    	    	        System.out.println("100分计分");
    	    			//waifenshu=100+(float)(0.45*waiZLPJ+0.45*waiJHPJ+0.1*waiFWPJ);	//每月100分制时采用，暂时未利用上月的分数值
    	    			System.out.println(waifenshu+"计分");
    	    			/////////////////////////////写入月度表，更新总表中个人的分数//////////////////////////////////////
    	    	    	try{
    	    	    		String sql2="insert into waiYearScore (wainame,waifenshu,waiZLPJ,waiJHPJ,waiFWPJ) values (?,?,?,?,?)";
    	    	    		String [] param={wainame,String.valueOf(waifenshu),String.valueOf(waiZLPJ),String.valueOf(waiJHPJ),String.valueOf(waiFWPJ)};
    	    	    		SqlUtils sqlUtils2=new SqlUtils();
    	    	    		Boolean flag2=sqlUtils2.update(sql2, param);
    	    	    			if(flag2){//更新总表
    	    	    				String sql3="update wai set fenshu=? WHERE name=?";
    	    	    				String [] param1={String.valueOf(waifenshu),wainame};
    	    	    				SqlUtils sqlUtils3=new SqlUtils();
    	    	    				boolean flag3=sqlUtils3.update(sql3, param1);
    	    	    					if(flag3){
    	    	    					System.out.println(wainame+"wai年度计分成功");
    	    	    					}else{
    	    	    					System.out.println(wainame+"wai年度计分未成功");
    	    	    					}
    	    	    				}
    	    	        	}catch(Exception e){
    	    	        		System.out.println(wainame+"wai年度计分未操作未成功");
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
                ///////////////年度最终处理//////////////
        		Connection conngong = null;
        	    Statement stmtgong=null;
        	    ResultSet rsgong=null;
            	    try {
                	String sqlgong="select * from gongYearview";//查看年 度求和view
                	SqlUtils sqlUtilsgong=new SqlUtils();
                	conngong = sqlUtilsgong.getConnection();
            		stmtgong= conngong.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);	
            		rsgong=stmtgong.executeQuery(sqlgong);
            		
        	    		while(rsgong.next())
        	    		{
        	    			float gongfenshu=0;
        	    			String gongname=rsgong.getString("gongname").trim();
        	    	        gongfenshu=rsgong.getFloat("gongfenshu")/12;//取12个月的平均分
        	    	        float gongPZ,gongJQ,gongJG,gongFW,gongQT=0;
        	    	        gongPZ=rsgong.getFloat("gongPZ")/12;
        	    	        gongJQ=rsgong.getFloat("gongJQ")/12;
        	    	        gongJG=rsgong.getFloat("gongJG")/12;
        	    	        gongFW=rsgong.getFloat("gongFW")/12;
        	    	        gongQT=rsgong.getFloat("gongQT")/12; 
        	    	        /////////////////////////////////////
        	    	        /////////////////////////////////////
        	    	        //System.out.println(gongfenshu+"计分");
        	    	        System.out.println("100分计分");
        	    			//gongfenshu=100+(float)(0.45*gongZLPJ+0.45*gongJHPJ+0.1*gongFWPJ);	//每月100分制时采用，暂时未利用上月的分数值
        	    			System.out.println(gongfenshu+"计分");
        	    			/////////////////////////////写入月度表，更新总表中个人的分数//////////////////////////////////////
        	    	    	try{
        	    	    		String sql2="insert into gongYearScore (gongname,gongfenshu,gongPZ,gongJQ,gongJG,gongFW,gongQT) values (?,?,?,?,?,?,?)";
        	    	    		String [] param={gongname,String.valueOf(gongfenshu),String.valueOf(gongPZ),String.valueOf(gongJQ),String.valueOf(gongJG),String.valueOf(gongFW),String.valueOf(gongQT)};
        	    	    		SqlUtils sqlUtils2=new SqlUtils();
        	    	    		Boolean flag2=sqlUtils2.update(sql2, param);
        	    	    			if(flag2){//更新总表
        	    	    				String sql3="update gong set fenshu=? WHERE name=?";
        	    	    				String [] param1={String.valueOf(gongfenshu),gongname};
        	    	    				SqlUtils sqlUtils3=new SqlUtils();
        	    	    				boolean flag3=sqlUtils3.update(sql3, param1);
        	    	    					if(flag3){
        	    	    					System.out.println(gongname+"gong年度计分成功");
        	    	    					}else{
        	    	    					System.out.println(gongname+"gong年度计分未成功");
        	    	    					}
        	    	    				}
        	    	        	}catch(Exception e){
        	    	        		System.out.println(gongname+"gong年度计分未操作未成功");
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
            	    
            	    
                    ///////////////年度清零最终处理//////////////
            	    try{	    		
            	    String sql2="update person set personfenshu=?";
            	    	    		String [] param={"100"};
            	    	    		SqlUtils sqlUtilsgaiperson=new SqlUtils();
            	    	    		Boolean flag2=sqlUtilsgaiperson.update(sql2, param);
            	    	        	}catch(Exception e){
            	    	        		System.out.println("gaiperson年度计分未操作未成功");
            	    }; 
            	    try{	    		
            	    String sql2="update nei set fenshu=?";
            	    	    		String [] param={"100"};
            	    	    		SqlUtils sqlUtilsgainei=new SqlUtils();
            	    	    		Boolean flag2=sqlUtilsgainei.update(sql2, param);
            	    	        	}catch(Exception e){
            	    	        		System.out.println("gainei年度计分未操作未成功");
            	    }; 
            	    try{	    		
            	    String sql2="update wai set fenshu=?";
            	    	    		String [] param={"100"};
            	    	    		SqlUtils sqlUtilsgaiwai=new SqlUtils();
            	    	    		Boolean flag2=sqlUtilsgaiwai.update(sql2, param);
            	    	        	}catch(Exception e){
            	    	        		System.out.println("gaiwai年度计分未操作未成功");
            	    }; 
            	    try{	    		
            	    String sql2="update gong set fenshu=?";
            	    	    		String [] param={"100"};
            	    	    		SqlUtils sqlUtilsgaigong=new SqlUtils();
            	    	    		Boolean flag2=sqlUtilsgaigong.update(sql2, param);
            	    	        	}catch(Exception e){
            	    	        		System.out.println("gaigong年度计分未操作未成功");
            	    }; 
            	   ////////////////////////////////////////////////////////////////////////////

            	    
            	    
            	    
            	    
            	    
        ///////////////////////////////////////////////////////////////////////////////////////////////
        
        System.out.println("每年执行的任务结束了！");   
        
    }
}
