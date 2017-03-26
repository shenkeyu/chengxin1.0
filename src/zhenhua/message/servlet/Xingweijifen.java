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

public class Xingweijifen extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
    	response.setHeader("content-type", "text/html;charset=UTF-8");  
    	response.setCharacterEncoding("UTF-8");  
    	request.setCharacterEncoding("UTF-8"); 
        PrintWriter out = response.getWriter(); 
    	String personname=request.getParameter("personname");
    	String personIDcard=request.getParameter("personIDcard");
    	String persondo=request.getParameter("persondo");
    	String fenstring=request.getParameter("personfen");
    	System.out.println(personname+"//");
    	System.out.println(fenstring+"//");
    	float personfen=Float.parseFloat(fenstring);
    	float personfenshu=Float.parseFloat(request.getParameter("personfenshu"));
    	personfenshu=(float) (personfenshu+0.4*personfen);//�õ���ǰ�ķ���
    	int persondocheck=1;//��Ϊ�淶����
    	Date persondotime=new Date();
        Calendar cal = Calendar.getInstance();
        int persondoyear = cal.get(Calendar.YEAR);//��ȡ���
        int persondomonth=cal.get(Calendar.MONTH);//��ȡ�·�
        int persondoday=cal.get(Calendar.DATE);//��ȡ��
        boolean flag=false;
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//���Է�����޸����ڸ�ʽ
    	String hehepersondotime = dateFormat.format(persondotime);//ת����ʾ���ڸ�ʽ
    	System.out.println(hehepersondotime+"����");
    	System.out.println(personname+"����");
    	try{
		String sql="insert into persondorecord (personname,personIDcard,persondo,personfen,persondocheck,persondotime,persondoyear,persondomonth,persondoday) values (?,?,?,?,?,?,?,?,?)";
		String [] param={personname,personIDcard,persondo, String.valueOf(personfen), Integer.toString(persondocheck),hehepersondotime, Integer.toString(persondoyear), Integer.toString(persondomonth), Integer.toString(persondoday)};
		SqlUtils sqlUtils=new SqlUtils();
		flag=sqlUtils.update(sql, param);
		System.out.println(param+"////");
			if(flag){
				String sql1="update person set personfenshu=? WHERE personIDcard=?";
				String [] param1={String.valueOf(personfenshu),personIDcard};
				System.out.println(param1+"////");
				SqlUtils sqlUtils1=new SqlUtils();
				boolean flag2=sqlUtils1.update(sql1, param1);
				if(flag2){
					System.out.println("�Ʒֳɹ�");
					out.println("�Ʒֳɹ�!<br>"+personname+"<br>��Ϊ"+persondo+"<br>��"+String.valueOf(personfen)+"��<br>���ڵ÷�Ϊ"+String.valueOf(personfenshu)+"�֡�");
				}else{
					System.out.println("�Ʒ�δ�ɹ�");
					out.println("�Ʒ�δ�ɹ�");
				}
			}
    	}catch(Exception e){
    		System.out.println("�Ʒ�δ����δ�ɹ�");
    		out.println("�Ʒ�δ����δ�ɹ�");
    	};
    	
    	//out.close();
    }  
  
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
        System.out.println("doGet");  
        this.doPost(request,response);  
    }  
    

}
