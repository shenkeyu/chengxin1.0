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
        int persondoyear = cal.get(Calendar.YEAR);//��ȡ���
        int persondomonth=cal.get(Calendar.MONTH);//��ȡ�·�
        int persondoday=cal.get(Calendar.DATE);//��ȡ��
        float xingweibili=(float)0.2;//��Ϊ�淶��ռ����
        float zhiliangbili=(float)0.4;//�����淶��ռ����
        float anquanbili=(float)0.4;//��ȫ�淶��ռ����
        System.out.println("ÿ��ִ�е�����ʼ�ˣ�");//��ʱ����tomcat���к�ÿ������һ���23:30ִ�У���Ҫ���ܱ�Ļ�׼�ֱ�Ϊ100
        ///////////���˷���/////////////////////////////////////////////////////////////////////////////
        ///////////////������մ���//////////////
		Connection conn = null;
	    Statement stmt=null;
	    ResultSet rs=null;
    	    try {
        	String sql1="select * from personMonview";//�鿴�¶����view������һ��personyearview
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
	    	        //�޵�����Ҫ������Ŀ////        
	    	        //////////////////////////////////////
	    	        ///////////������������///////////////////
	    	        //����12�����ڲ�����ϸ��ʾ��ﵽ����Ŀ���,��2��
	    	        
	    	        
	    	        //����12����δ��QHSE�����������������⳥���ģ���3��
	    	        
	    	        
	    	        //����12����δ��QHSE�����߲��ϸ�Ʒ�����ģ���5��
	    	        
	    	        
	    	        ////////////////////////////////////
	    	        ///////////��ȫ��������/////////////////
	    	      //�޵�����Ҫ������Ŀ////  
	    	        /////////////////////////////////////
	    	        /////////////////////////////////////
	    	        System.out.println(personfenshu+"�Ʒ�");
	    			personfenshu=personfenshu+xingweibili*personXWGF+zhiliangbili*personZLXY+anquanbili*personAQXY;	//������������˷�
	    			System.out.println(personfenshu+"�Ʒ�");
	    			/////////////////////////////д����ȱ������ܱ��и��˵ķ���//////////////////////////////////////
	    	    	try{
	    	    		String sql2="insert into personYearScore (personname,personIDcard,personfenshu,personXWGF,personZLXY,personAQXY) values (?,?,?,?,?,?)";
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
