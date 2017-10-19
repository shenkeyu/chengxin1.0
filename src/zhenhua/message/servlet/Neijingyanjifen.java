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

public class Neijingyanjifen extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
    	response.setHeader("content-type", "text/html;charset=UTF-8");  
    	response.setCharacterEncoding("UTF-8");  
    	request.setCharacterEncoding("UTF-8"); 
        PrintWriter out = response.getWriter(); 
    	String neiname=request.getParameter("neiname");
    	String neido=request.getParameter("neido");
    	String fenstring=request.getParameter("neifen");
    	int erjicheck=Integer.parseInt(request.getParameter("erjicheck"));//��Ϊ�Ʒֶ��������ʶ
    	System.out.println(neiname+"//");
    	System.out.println(fenstring+"//");
    	float xingweibili=(float)0.1;
    	float koufenxishu=(float)1.0;//�۷�ϵ��
    	float neifen=Float.parseFloat(fenstring);
    	float neifenshu=Float.parseFloat(request.getParameter("neifenshu"));
    	int neidocheck=4;
    	Date neidotime=new Date();
        Calendar cal = Calendar.getInstance();
        int neidoyear = cal.get(Calendar.YEAR);//��ȡ���
        int neidomonth=cal.get(Calendar.MONTH)+1;//��ȡ�·�
        int neidoday=cal.get(Calendar.DATE);//��ȡ��
        boolean flag=false;
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//���Է�����޸����ڸ�ʽ
    	String heheneidotime = dateFormat.format(neidotime);//ת����ʾ���ڸ�ʽ
    	System.out.println(heheneidotime+"����");
    	System.out.println(neiname+"����");
    	neiname=neiname.trim();
    	try{
		String sql="insert into neidorecord (neiname,neido,neifen,neidocheck,neidoerjicheck,neidotime,neidoyear,neidomonth,neidoday) values (?,?,?,?,?,?,?,?,?)";
		String [] param={neiname,neido, String.valueOf(neifen), Integer.toString(neidocheck),Integer.toString(erjicheck),heheneidotime, Integer.toString(neidoyear), Integer.toString(neidomonth), Integer.toString(neidoday)};
		SqlUtils sqlUtils=new SqlUtils();
		flag=sqlUtils.update(sql, param);
		System.out.println(sql+"////");
			if(flag){
				//String sql1="update nei set neifenshu=? WHERE neiIDcard=?";
				//String [] param1={String.valueOf(neifenshu),neiIDcard};
				//System.out.println(param1+"////");
				//SqlUtils sqlUtils1=new SqlUtils();
				//boolean flag2=sqlUtils1.update(sql1, param1);
				//if(flag2){
					System.out.println("�Ʒֳɹ�");
					out.println("�Ʒֳɹ�!<br>"+neiname+"<br>��Ϊ"+neido+"<br>��"+String.valueOf(neifen)+"��<br>���µ÷�Ϊ"+String.valueOf(neifenshu)+"�֡�<br><a href='javascript:window.history.go(-2)'>����</a>");
					//////////////////////////��־��¼//////////////////////////////////
					String rizhi=neiname.trim()+"����Ϊ"+neido.trim()+"����"+String.valueOf(neifen).trim()+"��";
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
				//}
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
