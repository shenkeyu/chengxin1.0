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
import javax.servlet.http.HttpSession;

import zhenhua.sql.SqlUtils;

public class Zhiliangjifen extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
    	response.setHeader("content-type", "text/html;charset=UTF-8");  
    	response.setCharacterEncoding("UTF-8");  
    	request.setCharacterEncoding("UTF-8"); 
        PrintWriter out = response.getWriter(); 
    	String personname=request.getParameter("personname");
    	String personIDcard=request.getParameter("personIDcard");
    	String persondo=request.getParameter("persondo");
    	String fenstring=request.getParameter("personfen");
    	int erjicheck=Integer.parseInt(request.getParameter("erjicheck"));//�����Ʒֶ��������ʶ
    	System.out.println(personname+"//");
    	System.out.println(fenstring+"//");
    	float zhiliangbili=(float)0.4;//����������ռ����
    	float personfen=Float.parseFloat(fenstring);
    	float personfenshu=Float.parseFloat(request.getParameter("personfenshu"));
    	int persondocheck=2;//�����Ʒִ���
    	Date persondotime=new Date();
        Calendar cal = Calendar.getInstance();
        int persondoyear = cal.get(Calendar.YEAR);//��ȡ���
        int persondomonth=cal.get(Calendar.MONTH)+1;//��ȡ�·�
        int persondoday=cal.get(Calendar.DATE);//��ȡ��
        boolean flag=false;
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//���Է�����޸����ڸ�ʽ
    	String hehepersondotime = dateFormat.format(persondotime);//ת����ʾ���ڸ�ʽ
    	System.out.println(hehepersondotime+"����");
    	System.out.println(personname+"����");
    	//////////����Ŀ��ֻ��һ�Σ���ʱδ���޶�//////////
    	//personfen=0ʱ�ﵽ����Ŀ��
        	try{
        		String sql="insert into persondorecord (personname,personIDcard,persondo,personfen,persondocheck,persondoerjicheck,persondotime,persondoyear,persondomonth,persondoday) values (?,?,?,?,?,?,?,?,?,?)";
        		String [] param={personname,personIDcard,persondo, String.valueOf(personfen), Integer.toString(persondocheck),Integer.toString(erjicheck),hehepersondotime, Integer.toString(persondoyear), Integer.toString(persondomonth), Integer.toString(persondoday)};
        		SqlUtils sqlUtils=new SqlUtils();
        		flag=sqlUtils.update(sql, param);
        		System.out.println(sql+"////");
        			if(flag){
        					System.out.println("�Ʒֳɹ�");
        					out.println("�Ʒֳɹ�!<br>"+personname+"<br>��Ϊ"+persondo+"<br>��"+String.valueOf(personfen)+"��<br>���µ÷�Ϊ"+String.valueOf(personfenshu)+"�֡�<br><a href='javascript:window.history.go(-2)'>����</a>");
        					//////////////////////////��־��¼//////////////////////////////////
        					String rizhi=personname.trim()+"����Ϊ"+persondo.trim()+"����"+String.valueOf(personfen).trim()+"��";
        					String sqlrizhi="insert into rizhi (personname,personIDcard,personRecorddo) values (?,?,?)";
        					HttpSession session=request.getSession();
        					String [] paramrizhi={session.getAttribute("usernamecheck").toString(),session.getAttribute("personidcheck").toString(),rizhi};
        					SqlUtils sqlUtilsrizhi=new SqlUtils();
        					boolean flagrizhi=sqlUtilsrizhi.update(sqlrizhi, paramrizhi);
        					if(flagrizhi){
        						System.out.println("��־��ӳɹ���");
        					}else{
        						System.out.println("��־��Ӳ��ɹ���");
        					}
        			//////////////////////////��־��¼//////////////////////////////////
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
