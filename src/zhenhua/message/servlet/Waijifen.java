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

public class Waijifen extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
    	response.setHeader("content-type", "text/html;charset=UTF-8");  
    	response.setCharacterEncoding("UTF-8");  
    	request.setCharacterEncoding("UTF-8"); 
        PrintWriter out = response.getWriter(); 
    	String wainame=request.getParameter("wainame");
    	String waido=request.getParameter("waido");
    	String fenstring=request.getParameter("waifen");
    	int fenshucheck=Integer.parseInt(request.getParameter("fenshucheck"));//
    	int erjicheck=Integer.parseInt(request.getParameter("erjicheck"));//���������ʶ
    	System.out.println(wainame+"//");
    	System.out.println(fenstring+"//");
    	float huansuanbili=(float)1.2;//��ְ��̼Ʒְ�100���Ƽ���
    	float waifen=Float.parseFloat(fenstring);
    	float waifenshu=Float.parseFloat(request.getParameter("waifenshu"));
    	Date waidotime=new Date();
        Calendar cal = Calendar.getInstance();
        int waidoyear = cal.get(Calendar.YEAR);//��ȡ���
        int waidomonth=cal.get(Calendar.MONTH)+1;//��ȡ�·�
        int waidoday=cal.get(Calendar.DATE);//��ȡ��
        boolean flag=false;
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//���Է�����޸����ڸ�ʽ
    	String hehewaidotime = dateFormat.format(waidotime);//ת����ʾ���ڸ�ʽ
    	System.out.println(hehewaidotime+"����");
    	System.out.println(wainame+"����");
    	System.out.println(fenshucheck+"����");
    	/////////////////////////////////////////////////////
    	try{
		String sql="insert into waidorecord (wainame,waido,waifen,waidocheck,waidoerjicheck,waidotime,waidoyear,waidomonth,waidoday) values (?,?,?,?,?,?,?,?,?)";
		String [] param={wainame,waido,String.valueOf(waifen),Integer.toString(fenshucheck),Integer.toString(erjicheck),hehewaidotime, Integer.toString(waidoyear), Integer.toString(waidomonth), Integer.toString(waidoday)};
		SqlUtils sqlUtils=new SqlUtils();
		flag=sqlUtils.update(sql, param);
		System.out.println(sql+"////");
			if(flag){
					System.out.println("�Ʒֳɹ�");
					out.println("�Ʒֳɹ�!<br>"+wainame+"<br>��Ϊ"+waido+"<br>��"+String.valueOf(waifen)+"��<br>���µ÷�Ϊ"+String.valueOf(waifenshu)+"�֡�<br><a href='javascript:window.history.go(-2)'>����</a>");
					//////////////////////////��־��¼//////////////////////////////////
					String rizhi=wainame.trim()+"����Ϊ"+waido.trim()+"����"+String.valueOf(waifen).trim()+"��";
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
