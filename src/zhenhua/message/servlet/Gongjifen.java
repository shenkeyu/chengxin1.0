package zhenhua.message.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.io.BufferedInputStream; 
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.DateFormat;
import java.util.Calendar;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import zhenhua.sql.SqlUtils;

public class Gongjifen extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
    	response.setHeader("content-type", "text/html;charset=UTF-8");  
    	response.setCharacterEncoding("UTF-8");  
    	request.setCharacterEncoding("UTF-8"); 
        PrintWriter out = response.getWriter(); 
    	String gongname=request.getParameter("gongname");
    	String gongdo=request.getParameter("gongdo");
    	String fenstring=request.getParameter("gongfen");
    	int fenshucheck=Integer.parseInt(request.getParameter("fenshucheck"));//
    	int erjicheck=Integer.parseInt(request.getParameter("erjicheck"));//���������ʶ
    	System.out.println(gongname+"//");
    	System.out.println(fenstring+"//");
    	float huansuanbili=(float)1.2;//��Ӧ�̼Ʒְ�100���Ƽ���
    	float gongfen=Float.parseFloat(fenstring);
    	float gongfenshu=Float.parseFloat(request.getParameter("gongfenshu"));
    	Date gongdotime=new Date();
        Calendar cal = Calendar.getInstance();
        int gongdoyear = cal.get(Calendar.YEAR);//��ȡ���
        int gongdomonth=cal.get(Calendar.MONTH)+1;//��ȡ�·�
        int gongdoday=cal.get(Calendar.DATE);//��ȡ��
        boolean flag=false;
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//���Է�����޸����ڸ�ʽ
    	String hehegongdotime = dateFormat.format(gongdotime);//ת����ʾ���ڸ�ʽ
    	System.out.println(hehegongdotime+"����");
    	System.out.println(gongname+"����");
    	System.out.println(fenshucheck+"����");
    	System.out.println(gongdo+"����");
    	System.out.println(erjicheck+"����");
    	System.out.println(gongfen+"����");
    	
    	/////////////////////////////////////////////////////
    	try{
		String sql="insert into gongdorecord (gongname,gongdo,gongfen,gongdocheck,gongdoerjicheck,gongdotime,gongdoyear,gongdomonth,gongdoday) values (?,?,?,?,?,?,?,?,?)";
		String [] param={gongname,gongdo,String.valueOf(gongfen),Integer.toString(fenshucheck),Integer.toString(erjicheck),hehegongdotime,Integer.toString(gongdoyear),Integer.toString(gongdomonth),Integer.toString(gongdoday)};
		SqlUtils sqlUtilsgong=new SqlUtils();
		flag=sqlUtilsgong.update(sql,param);
		System.out.println(sql+"////");
			if(flag){
					System.out.println("�Ʒֳɹ�");
					out.println("�Ʒֳɹ�!<br>"+gongname+"<br>��Ϊ"+gongdo+"<br>��"+String.valueOf(gongfen)+"��<br>���µ÷�Ϊ"+String.valueOf(gongfenshu)+"�֡�");
				}else{
					System.out.println("�Ʒ�δ�ɹ�");
					out.println("�Ʒ�δ�ɹ�");
				}
    	}catch(Exception e){
    		System.out.println("�Ʒ�δ����δ�ɹ�");
    		out.println("�Ʒ�δ����δ�ɹ�");
    	};    	
    	out.close();
    }  
  
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
        System.out.println("doGet");  
        this.doPost(request,response);  
    }  
    

}
