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

        
        System.out.println("----------------任务结束了-------------------------------------"); 
    
    }
}
