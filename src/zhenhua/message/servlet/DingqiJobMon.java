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
	    	        //此处特别需要注意加分上限为10分，所以月度分，不是涵盖了所有计分动作；年度计分，也不是简单的把所有计分动作求和
	    	        /////////安全诚信等级为甲级，基准分为100分/////
	    	        
	    	        //////在黑名单内基准分为80分，否则为100分///////
	    	        
	    	        /////////////////////////////////////
	    	        System.out.println(personfenshu+"计分");
	    			personfenshu=personfenshu+xingweibili*personXWGF+zhiliangbili*personZLXY+anquanbili*personAQXY;	//按比例计算个人分
	    			System.out.println(personfenshu+"计分");
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
	    	    					System.out.println(personIDcard+"计分成功");
	    	    					}else{
	    	    					System.out.println(personIDcard+"计分未成功");
	    	    					}
	    	    				}
	    	        	}catch(Exception e){
	    	        		System.out.println(personIDcard+"计分未操作未成功");
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
        ////////////行为规范评价////////////////////
        
        
        //////////////////////////////////////
        ///////////质量诚信评价///////////////////
        
        
        ////////////////////////////////////
        ///////////安全诚信评价/////////////////
        
        /////////////////////////////////////
        ///////////////月度最终处理//////////////
        
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
        
        System.out.println("每月执行的任务结束了！"); 
    }
}
