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
        int persondoyear = cal.get(Calendar.YEAR);//��ȡ���
        int persondomonth=cal.get(Calendar.MONTH);//��ȡ�·�
        int persondoday=cal.get(Calendar.DATE);//��ȡ��
        float xingweibili=(float)0.2;//��Ϊ�淶��ռ����
        float zhiliangbili=(float)0.4;//�����淶��ռ����
        float anquanbili=(float)0.4;//��ȫ�淶��ռ����
        System.out.println("ÿ��ִ�е�����ʼ�ˣ�");     //��ʱ����tomcat���к�ÿ�µ����һ���23:20ִ��
        ///////////���˷���/////////////////////////////////////////////////////////////////////////////
        ///////////////�¶����մ���//////////////
		Connection conn = null;
	    Statement stmt=null;
	    ResultSet rs=null;
    	    try {
        	String sql1="select * from personMonview";//�鿴�¶����view
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
	    			////////////��Ϊ�淶����////////////////////
	    	        int xingwei2yuejiafen=0;//����2������û��Υ����Ϊ�淶�ģ���һ�μ�2��
	    	        if(persondomonth>2)  //�ж��Ƿ���3���Ժ���·�
	    	        {
	    	        	try{
	    	        		String sql="select * from persondorecord where persondocheck=1 and personfen<0 and (persondomonth="+Integer.toString(persondomonth-1)+" or persondomonth="+Integer.toString(persondomonth-2)+") and personIDcard='"+personIDcard+"' and persondoyear="+Integer.toString(persondoyear);
	    	        		SqlUtils sqlUtils=new SqlUtils();
	    	        		Boolean flag1=sqlUtils.queryjieguo(sql);
	    	        		if(flag1)
	    	        		{
		    	        		System.out.println(personIDcard+"��Ϊ�淶���棬���ӷ�");	    	        			
	    	        		}else{
	    	        			xingwei2yuejiafen=2;
		    	        		System.out.println(personIDcard+"����Ϊ�淶���棬��2��");		    	        			
	    	        		}
	    	        	}catch(Exception e){
	    	        		System.out.println(personIDcard+"��Ϊ�淶��2��ʧ��");
	    	        	};        	
	    	        }  
	    	        personXWGF=personXWGF+xingwei2yuejiafen;
	    	        //////////////////////////////////////
	    	        ///////////������������///////////////////
	    	        //�޵�����Ҫ������Ŀ//// 	    	        
	    	        ////////////////////////////////////
	    	        ///////////��ȫ��������/////////////////
	    	      /////��ȫ�����ۺϷ���=��ȫ��ŵ����*0.2+�������ü�¼����*0.4+������*0.4+���������ӷ֣�0-10����
	    	        //�˴��ر���Ҫע��ӷ�����Ϊ10�֣������¶ȷ֣����Ǻ��������мƷֶ�������ȼƷ֣�Ҳ���Ǽ򵥵İ����мƷֶ������
	    	        /////////��ȫ���ŵȼ�Ϊ�׼�����׼��Ϊ100��/////
	    	        
	    	        //////�ں������ڻ�׼��Ϊ80�֣�����Ϊ100��///////
	    	        
	    	        /////////////////////////////////////
	    	        System.out.println(personfenshu+"�Ʒ�");
	    			personfenshu=personfenshu+xingweibili*personXWGF+zhiliangbili*personZLXY+anquanbili*personAQXY;	//������������˷�
	    			System.out.println(personfenshu+"�Ʒ�");
	    			/////////////////////////////д���¶ȱ������ܱ��и��˵ķ���//////////////////////////////////////
	    	    	try{
	    	    		String sql2="insert into personMonthScore (personname,personIDcard,personfenshu,personXWGF,personZLXY,personAQXY) values (?,?,?,?,?,?)";
	    	    		String [] param={personname,personIDcard,String.valueOf(personfenshu),String.valueOf(personXWGF),String.valueOf(personZLXY),String.valueOf(personAQXY)};
	    	    		SqlUtils sqlUtils2=new SqlUtils();
	    	    		Boolean flag2=sqlUtils2.update(sql2, param);
	    	    			if(flag2){//�����ܱ�
	    	    				String sql3="update person set personfenshu=? WHERE personIDcard=?";
	    	    				String [] param1={String.valueOf(personfenshu),personIDcard};
	    	    				SqlUtils sqlUtils3=new SqlUtils();
	    	    				boolean flag3=sqlUtils3.update(sql3, param1);
	    	    					if(flag3){
	    	    					System.out.println(personIDcard+"�Ʒֳɹ�");
	    	    					}else{
	    	    					System.out.println(personIDcard+"�Ʒ�δ�ɹ�");
	    	    					}
	    	    				}
	    	        	}catch(Exception e){
	    	        		System.out.println(personIDcard+"�Ʒ�δ����δ�ɹ�");
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
        
        
        
        
        ///////////�ڷְ���/////////////////////////////////////////////////////////////////////////////
        ////////////��Ϊ�淶����////////////////////
        
        
        //////////////////////////////////////
        ///////////������������///////////////////
        
        
        ////////////////////////////////////
        ///////////��ȫ��������/////////////////
        
        /////////////////////////////////////
        ///////////////�¶����մ���//////////////
        
        ////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        
        
        
        
        
        ///////////��ְ���/////////////////////////////////////////////////////////////////////////////
        ////////////��Ϊ�淶����////////////////////
        
        
        //////////////////////////////////////
        ///////////������������///////////////////
        
        
        ////////////////////////////////////
        ///////////��ȫ��������/////////////////
        
        /////////////////////////////////////
        ///////////////�¶����մ���//////////////
        
        ////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        
        
        
        
        
        
        
        //////////��Ӧ��/////////////////////////////////////////////////////////////////////////////
        ////////////��Ϊ�淶����////////////////////
        
        
        //////////////////////////////////////
        ///////////������������///////////////////
        
        
        ////////////////////////////////////
        ///////////��ȫ��������/////////////////
        
        /////////////////////////////////////
        ///////////////�¶����մ���//////////////
        
        ////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        
        System.out.println("ÿ��ִ�е���������ˣ�"); 
    }
}
