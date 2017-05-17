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

public class DingqiJob implements Job
{
    @Override
    public void execute(JobExecutionContext jec) throws JobExecutionException 
    {
        System.out.println("----------------任务开始了-------------------------------------");     //定时器，tomcat运行后，每月的最后一天的23:20执行

 
        ///////////////年度清零最终处理//////////////
	    try{	    		
	    String sql2="update person set personfenshu=?";
	    	    		String [] param={"100"};
	    	    		SqlUtils sqlUtilsgaiperson=new SqlUtils();
	    	    		Boolean flag2=sqlUtilsgaiperson.update(sql2, param);
	    	    		System.out.print(flag2);
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
        
        System.out.println("----------------任务结束了-------------------------------------"); 
    
    }
}
