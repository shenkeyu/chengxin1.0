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
	    	        //�˴��ر���Ҫע��ӷ�����Ϊ10�֣������¶ȷ֣����Ǻ��������мƷֶ�������ȼƷ֣�Ҳ���Ǽ򵥵İ����мƷֶ������;�Ѿ�ƽ�Ƶ��ճ��Ʒ���ȥ���㣬�˴����ٿ���
	    	        /////////��ȫ���ŵȼ�Ϊ�׼�����׼��Ϊ100��/////
    	        	try{
    	        		String sql="select * from persondengji where personIDcard='"+personIDcard;
    	        		SqlUtils sqlUtils=new SqlUtils();
    	        		Connection conn1 = null;
    	        	    Statement stmt1=null;
    	        	    ResultSet rs1=null;
    	            	conn1 = sqlUtils.getConnection();
    	        		stmt1= conn1.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);	
    	        		rs1=stmt1.executeQuery(sql);
    	        		String persondengji=rs1.getString("persondengji");
    	        		if(persondengji=="�׼�")
    	        		{
	    	        		System.out.println(personIDcard+"����Ϊ�׼�����׼�ֲ���");	
	    	        	}else if(persondengji=="�Ҽ�"){
    	        			System.out.println(personIDcard+"����Ϊ�Ҽ�����׼��-10��");	
    	        			personAQXY=personAQXY-(float)(10*0.4);
    	        		}else if(persondengji=="����"){
    	        			System.out.println(personIDcard+"����Ϊ��������׼��-20��");
    	        			personAQXY=personAQXY-(float)(20*0.4);
    	        		}
    	        	}catch(Exception e){
    	        		System.out.println(personIDcard+"�ȼ��ж�ʧ��");
    	        	}; 
	    	        //////�ں������ڻ�׼��Ϊ80�֣�����Ϊ100��///////
    	        	try{
    	        		String sql="select * from personheimingdan where personIDcard='"+personIDcard;
    	        		SqlUtils sqlUtils=new SqlUtils();
    	        		Boolean flag1=sqlUtils.queryjieguo(sql);
    	        		if(flag1)
    	        		{
	    	        		System.out.println(personIDcard+"�����ں������У�-20��");	
	    	        		personAQXY=personAQXY-(float)(20*0.4);
    	        		}else{
    	        			System.out.println(personIDcard+"���˲��ں������У���������");		    	        			
    	        		}
    	        	}catch(Exception e){
    	        		System.out.println(personIDcard+"�������ж�ʧ��");
    	        	}; 	    	        
	    	        /////////////////////////////////////
	    	        System.out.println(personfenshu+"�Ʒ�");
	    			personfenshu=personfenshu+xingweibili*personXWGF+zhiliangbili*personZLXY+anquanbili*personAQXY;	//������������˷�
	    			System.out.println(personfenshu+"�Ʒ�");
	    			personXWGF=120+personXWGF;
	    			personZLXY=120+personZLXY;
	    			personAQXY=120+personAQXY;
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
	    	    					System.out.println(personIDcard+"�¶ȼƷֳɹ�");
	    	    					}else{
	    	    					System.out.println(personIDcard+"�¶ȼƷ�δ�ɹ�");
	    	    					}
	    	    				}
	    	        	}catch(Exception e){
	    	        		System.out.println(personIDcard+"�¶ȼƷ�δ����δ�ɹ�");
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
            ///////////////�¶����մ���//////////////
    		Connection connwai = null;
    	    Statement stmtwai=null;
    	    ResultSet rswai=null;
        	    try {
            	String sqlwai="select * from waiMonview";//�鿴�¶����view
            	SqlUtils sqlUtilswai=new SqlUtils();
            	connwai = sqlUtilswai.getConnection();
        		stmtwai= connwai.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);	
        		rswai=stmtwai.executeQuery(sqlwai);
        		
    	    		while(rswai.next())
    	    		{
    	    			float waifenshu=0;
    	    			String wainame=rswai.getString("name");
    	    	        waifenshu=rswai.getFloat("fenshu");//���µķ���ֵ
    	    	        float waiZLPJ,waiJHPJ,waiFWPJ=0;
    	    	        waiZLPJ=rswai.getFloat("waizhiliangfen");
    	    	        waiJHPJ=rswai.getFloat("waijiaohuoqifen");
    	    	        waiFWPJ=rswai.getFloat("waifuwufen");
    	    	        /////////////////////////////////////
    	    	        /////////////////////////////////////
    	    	        //System.out.println(waifenshu+"�Ʒ�");
    	    	        System.out.println("100�ּƷ�");
    	    			waifenshu=100+(float)(0.45*waiZLPJ+0.45*waiJHPJ+0.1*waiFWPJ);	//ÿ��100����ʱ���ã���ʱδ�������µķ���ֵ
    	    			System.out.println(waifenshu+"�Ʒ�");
    	    	        waiZLPJ=100+rswai.getFloat("waiZLPJ");
    	    	        waiJHPJ=100+rswai.getFloat("waiJHPJ");
    	    	        waiFWPJ=100+rswai.getFloat("waiFWPJ");
    	    			/////////////////////////////д���¶ȱ������ܱ��и��˵ķ���//////////////////////////////////////
    	    	    	try{
    	    	    		String sql2="insert into waiMonthScore (wainame,waifenshu,waiZLPJ,waiJHPJ,waiFWPJ) values (?,?,?,?,?)";
    	    	    		String [] param={wainame,String.valueOf(waifenshu),String.valueOf(waiZLPJ),String.valueOf(waiJHPJ),String.valueOf(waiFWPJ)};
    	    	    		SqlUtils sqlUtils2=new SqlUtils();
    	    	    		Boolean flag2=sqlUtils2.update(sql2, param);
    	    	    			if(flag2){//�����ܱ�
    	    	    				String sql3="update wai set fenshu=? WHERE name=?";
    	    	    				String [] param1={String.valueOf(waifenshu),wainame};
    	    	    				SqlUtils sqlUtils3=new SqlUtils();
    	    	    				boolean flag3=sqlUtils3.update(sql3, param1);
    	    	    					if(flag3){
    	    	    					System.out.println(wainame+"�¶ȼƷֳɹ�");
    	    	    					}else{
    	    	    					System.out.println(wainame+"�¶ȼƷ�δ�ɹ�");
    	    	    					}
    	    	    				}
    	    	        	}catch(Exception e){
    	    	        		System.out.println(wainame+"�¶ȼƷ�δ����δ�ɹ�");
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
                ///////////////�¶����մ���//////////////
        		Connection conngong = null;
        	    Statement stmtgong=null;
        	    ResultSet rsgong=null;
            	    try {
                	String sqlgong="select * from gongMonview";//�鿴�¶����view
                	SqlUtils sqlUtilsgong=new SqlUtils();
                	conngong = sqlUtilsgong.getConnection();
            		stmtgong= conngong.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);	
            		rsgong=stmtgong.executeQuery(sqlgong);
            		
        	    		while(rsgong.next())
        	    		{
        	    			float gongfenshu=0;
        	    			String gongname=rsgong.getString("name");
        	    	        gongfenshu=rsgong.getFloat("fenshu");//���µķ���ֵ
        	    	        float gongPZ,gongJQ,gongJG,gongFW,gongQT=0;
        	    	        gongPZ=rsgong.getFloat("gongPZ");
        	    	        gongJQ=rsgong.getFloat("gongJQ");
        	    	        gongJG=rsgong.getFloat("gongJG");
        	    	        gongFW=rsgong.getFloat("gongFW");
        	    	        gongQT=rsgong.getFloat("gongQT");        	    	     
        	    	        /////////////////////////////////////
        	    	        /////////////////////////////////////
        	    	        //System.out.println(gongfenshu+"�Ʒ�");
        	    	        System.out.println("100�ּƷ�");
        	    			gongfenshu=100+(float)(0.3*gongPZ+0.25*gongJQ+0.25*gongJG+0.15*gongFW+0.05*gongQT);	//ÿ��100����ʱ���ã���ʱδ�������µķ���ֵ
        	    			System.out.println(gongfenshu+"�Ʒ�");
        	    	        gongPZ=100+rsgong.getFloat("gongPZ");
        	    	        gongJQ=100+rsgong.getFloat("gongJQ");
        	    	        gongJG=100+rsgong.getFloat("gongJG");
        	    	        gongFW=100+rsgong.getFloat("gongFW");
        	    	        gongQT=100+rsgong.getFloat("gongQT"); 
        	    			/////////////////////////////д���¶ȱ������ܱ��и��˵ķ���//////////////////////////////////////
        	    	    	try{
        	    	    		String sql2="insert into gongMonthScore (gongname,gongfenshu,gongPZ,gongJQ,gongJG,gongFW,gongQT) values (?,?,?,?,?,?,?)";
        	    	    		String [] param={gongname,String.valueOf(gongfenshu),String.valueOf(gongPZ),String.valueOf(gongJQ),String.valueOf(gongJG),String.valueOf(gongFW),String.valueOf(gongQT)};
        	    	    		SqlUtils sqlUtils2=new SqlUtils();
        	    	    		Boolean flag2=sqlUtils2.update(sql2, param);
        	    	    			if(flag2){//�����ܱ�
        	    	    				String sql3="update gong set fenshu=? WHERE name=?";
        	    	    				String [] param1={String.valueOf(gongfenshu),gongname};
        	    	    				SqlUtils sqlUtils3=new SqlUtils();
        	    	    				boolean flag3=sqlUtils3.update(sql3, param1);
        	    	    					if(flag3){
        	    	    					System.out.println(gongname+"�¶ȼƷֳɹ�");
        	    	    					}else{
        	    	    					System.out.println(gongname+"�¶ȼƷ�δ�ɹ�");
        	    	    					}
        	    	    				}
        	    	        	}catch(Exception e){
        	    	        		System.out.println(gongname+"�¶ȼƷ�δ����δ�ɹ�");
        	    	        	}; 
        	    	        ////////////////////////////////////////////////////////////////////////////
        	    		}
            		}catch (SQLException e){
            			e.printStackTrace();
            		}finally{
            			try {
            				rsgong.close();
            				stmtgong.close();
            				conngong.close();
            				}catch (SQLException e) {
            				e.printStackTrace();
            				};
            		}   
                ////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        
        System.out.println("ÿ��ִ�е���������ˣ�"); 
    }
}
