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
        	String sql1="select * from personMonthview";//查看年度求和view    where month=12
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
	    	    					System.out.println(personIDcard+"年度计分成功");
	    	    					}else{
	    	    					System.out.println(personIDcard+"年度计分未成功");
	    	    					}
	    	    				}
	    	        	}catch(Exception e){
	    	        		System.out.println(personIDcard+"年度计分未操作未成功");
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
    	    			String wainame=rswai.getString("wainame");
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
    	    	    				String sql3="update wai set fenshu=? WHERE wainame=?";
    	    	    				String [] param1={String.valueOf(waifenshu),wainame};
    	    	    				SqlUtils sqlUtils3=new SqlUtils();
    	    	    				boolean flag3=sqlUtils3.update(sql3, param1);
    	    	    					if(flag3){
    	    	    					System.out.println(wainame+"年度计分成功");
    	    	    					}else{
    	    	    					System.out.println(wainame+"年度计分未成功");
    	    	    					}
    	    	    				}
    	    	        	}catch(Exception e){
    	    	        		System.out.println(wainame+"年度计分未操作未成功");
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
        ////////////行为规范评价////////////////////
        
        
        //////////////////////////////////////
        ///////////质量诚信评价///////////////////
        
        
        ////////////////////////////////////
        ///////////安全诚信评价/////////////////
        
        /////////////////////////////////////
        ///////////////月度最终处理//////////////
        
        ////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        
        System.out.println("每年执行的任务结束了！");   
        
    }
}
