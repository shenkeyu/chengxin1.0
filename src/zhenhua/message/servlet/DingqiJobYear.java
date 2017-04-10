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
        	String sql1="select * from personMonview";//查看月度求和view，需做一个personyearview
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
	    	        
	    	        
	    	        //连续12个月未被QHSE部开具质量处罚或赔偿单的，加3分
	    	        
	    	        
	    	        //连续12个月未被QHSE部开具不合格品处理单的，加5分
	    	        
	    	        
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
        
        System.out.println("每年执行的任务结束了！");   
        
    }
}
