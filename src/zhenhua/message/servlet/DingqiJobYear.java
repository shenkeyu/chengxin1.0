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
        	String sql1="select * from personMonthview";//�鿴������view    where month=12
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
    	        	try{
    	        		String sql="select * from persondorecord where persondocheck=2 and persondoerjicheck=1 and personfen<0 and personIDcard='"+personIDcard+"' and persondoyear="+Integer.toString(persondoyear);
    	        		SqlUtils sqlUtils=new SqlUtils();
    	        		Boolean flag1=sqlUtils.queryjieguo(sql);
    	        		if(flag1)
    	        		{
	    	        		System.out.println(personIDcard+"��δ�ﵽ����Ŀ����·�");	    	        			
    	        		}else{
	    	        		System.out.println(personIDcard+"��δ�ﵽ����Ŀ����·ݣ���2��");	
	    	        		personZLXY=personZLXY+2;
    	        		}
    	        	}catch(Exception e){
    	        		System.out.println(personIDcard+"12��������Ŀ���ж�ʧ��");
    	        	};  	    	        
	    	        //����12����δ��QHSE�����������������⳥���ģ���3��
    	        	try{
    	        		String sql="select * from persondorecord where persondocheck=2 and persondoerjicheck=2 and personfen<0 and personIDcard='"+personIDcard+"' and persondoyear="+Integer.toString(persondoyear);
    	        		SqlUtils sqlUtils=new SqlUtils();
    	        		Boolean flag1=sqlUtils.queryjieguo(sql);
    	        		if(flag1)
    	        		{
	    	        		System.out.println(personIDcard+"�п����������������⳥�����·�");	    	        			
    	        		}else{
	    	        		System.out.println(personIDcard+"�޿����������������⳥�����·ݣ���3��");	
	    	        		personZLXY=personZLXY+3;
    	        		}
    	        	}catch(Exception e){
    	        		System.out.println(personIDcard+"12���¿����������������⳥�ж�ʧ��");
    	        	}; 
	    	        //����12����δ��QHSE�����߲��ϸ�Ʒ�����ģ���5��
    	        	try{
    	        		String sql="select * from persondorecord where persondocheck=2 and persondoerjicheck=3 and personfen<0 and personIDcard='"+personIDcard+"' and persondoyear="+Integer.toString(persondoyear);
    	        		SqlUtils sqlUtils=new SqlUtils();
    	        		Boolean flag1=sqlUtils.queryjieguo(sql);
    	        		if(flag1)
    	        		{
	    	        		System.out.println(personIDcard+"�п��߲��ϸ�Ʒ�������·�");	    	        			
    	        		}else{
	    	        		System.out.println(personIDcard+"�޿��߲��ϸ�Ʒ�������·ݣ���5��");	
	    	        		personZLXY=personZLXY+5;
    	        		}
    	        	}catch(Exception e){
    	        		System.out.println(personIDcard+"12���¿��߲��ϸ�Ʒ�����ж�ʧ��");
    	        	};  
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
	    	    					System.out.println(personIDcard+"��ȼƷֳɹ�");
	    	    					}else{
	    	    					System.out.println(personIDcard+"��ȼƷ�δ�ɹ�");
	    	    					}
	    	    				}
	    	        	}catch(Exception e){
	    	        		System.out.println(personIDcard+"��ȼƷ�δ����δ�ɹ�");
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
            ///////////////������մ���//////////////
    		Connection connwai = null;
    	    Statement stmtwai=null;
    	    ResultSet rswai=null;
        	    try {
            	String sqlwai="select * from waiYearview";//�鿴�� �����view
            	SqlUtils sqlUtilswai=new SqlUtils();
            	connwai = sqlUtilswai.getConnection();
        		stmtwai= connwai.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);	
        		rswai=stmtwai.executeQuery(sqlwai);
        		
    	    		while(rswai.next())
    	    		{
    	    			float waifenshu=0;
    	    			String wainame=rswai.getString("wainame");
    	    	        waifenshu=rswai.getFloat("waifenshu")/12;//ȡ12���µ�ƽ����
    	    	        float waiZLPJ,waiJHPJ,waiFWPJ=0;
    	    	        waiZLPJ=rswai.getFloat("waiZLPJ")/12;
    	    	        waiJHPJ=rswai.getFloat("waiJHPJ")/12;
    	    	        waiFWPJ=rswai.getFloat("waiFWPJ")/12;
    	    	        /////////////////////////////////////
    	    	        /////////////////////////////////////
    	    	        //System.out.println(waifenshu+"�Ʒ�");
    	    	        System.out.println("100�ּƷ�");
    	    			//waifenshu=100+(float)(0.45*waiZLPJ+0.45*waiJHPJ+0.1*waiFWPJ);	//ÿ��100����ʱ���ã���ʱδ�������µķ���ֵ
    	    			System.out.println(waifenshu+"�Ʒ�");
    	    			/////////////////////////////д���¶ȱ������ܱ��и��˵ķ���//////////////////////////////////////
    	    	    	try{
    	    	    		String sql2="insert into waiYearScore (wainame,waifenshu,waiZLPJ,waiJHPJ,waiFWPJ) values (?,?,?,?,?)";
    	    	    		String [] param={wainame,String.valueOf(waifenshu),String.valueOf(waiZLPJ),String.valueOf(waiJHPJ),String.valueOf(waiFWPJ)};
    	    	    		SqlUtils sqlUtils2=new SqlUtils();
    	    	    		Boolean flag2=sqlUtils2.update(sql2, param);
    	    	    			if(flag2){//�����ܱ�
    	    	    				String sql3="update wai set fenshu=? WHERE wainame=?";
    	    	    				String [] param1={String.valueOf(waifenshu),wainame};
    	    	    				SqlUtils sqlUtils3=new SqlUtils();
    	    	    				boolean flag3=sqlUtils3.update(sql3, param1);
    	    	    					if(flag3){
    	    	    					System.out.println(wainame+"��ȼƷֳɹ�");
    	    	    					}else{
    	    	    					System.out.println(wainame+"��ȼƷ�δ�ɹ�");
    	    	    					}
    	    	    				}
    	    	        	}catch(Exception e){
    	    	        		System.out.println(wainame+"��ȼƷ�δ����δ�ɹ�");
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
