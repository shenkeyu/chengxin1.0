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

        
        System.out.println("----------------���������-------------------------------------"); 
    
    }
}
