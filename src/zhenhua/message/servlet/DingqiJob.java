package zhenhua.message.servlet;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class DingqiJob implements Job
{
    @Override
    public void execute(JobExecutionContext jec) throws JobExecutionException 
    {
      //  System.out.println("hello world"); //定时器，tomcat运行5秒后，每5秒执行一次
    }
}
