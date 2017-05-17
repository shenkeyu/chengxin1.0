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
        System.out.println("----------------����ʼ��-------------------------------------");     //��ʱ����tomcat���к�ÿ�µ����һ���23:20ִ��

 
        ///////////////����������մ���//////////////
	    try{	    		
	    String sql2="update person set personfenshu=?";
	    	    		String [] param={"100"};
	    	    		SqlUtils sqlUtilsgaiperson=new SqlUtils();
	    	    		Boolean flag2=sqlUtilsgaiperson.update(sql2, param);
	    	    		System.out.print(flag2);
	    	        	}catch(Exception e){
	    	        		System.out.println("gaiperson��ȼƷ�δ����δ�ɹ�");
	    }; 
	    try{	    		
	    String sql2="update nei set fenshu=?";
	    	    		String [] param={"100"};
	    	    		SqlUtils sqlUtilsgainei=new SqlUtils();
	    	    		Boolean flag2=sqlUtilsgainei.update(sql2, param);
	    	        	}catch(Exception e){
	    	        		System.out.println("gainei��ȼƷ�δ����δ�ɹ�");
	    }; 
	    try{	    		
	    String sql2="update wai set fenshu=?";
	    	    		String [] param={"100"};
	    	    		SqlUtils sqlUtilsgaiwai=new SqlUtils();
	    	    		Boolean flag2=sqlUtilsgaiwai.update(sql2, param);
	    	        	}catch(Exception e){
	    	        		System.out.println("gaiwai��ȼƷ�δ����δ�ɹ�");
	    }; 
	    try{	    		
	    String sql2="update gong set fenshu=?";
	    	    		String [] param={"100"};
	    	    		SqlUtils sqlUtilsgaigong=new SqlUtils();
	    	    		Boolean flag2=sqlUtilsgaigong.update(sql2, param);
	    	        	}catch(Exception e){
	    	        		System.out.println("gaigong��ȼƷ�δ����δ�ɹ�");
	    }; 
	   ////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        
        System.out.println("----------------���������-------------------------------------"); 
    
    }
}
