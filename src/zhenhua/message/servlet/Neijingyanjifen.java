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
    	int erjicheck=Integer.parseInt(request.getParameter("erjicheck"));//行为计分二级计算标识
    	System.out.println(neiname+"//");
    	System.out.println(fenstring+"//");
    	float xingweibili=(float)0.1;
    	float koufenxishu=(float)1.0;//扣分系数
    	float neifen=Float.parseFloat(fenstring);
    	float neifenshu=Float.parseFloat(request.getParameter("neifenshu"));
    	int neidocheck=4;
    	Date neidotime=new Date();
        Calendar cal = Calendar.getInstance();
        int neidoyear = cal.get(Calendar.YEAR);//获取年份
        int neidomonth=cal.get(Calendar.MONTH)+1;//获取月份
        int neidoday=cal.get(Calendar.DATE);//获取日
        boolean flag=false;
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
    	String heheneidotime = dateFormat.format(neidotime);//转换显示日期格式
    	System.out.println(heheneidotime+"看看");
    	System.out.println(neiname+"看看");
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
					System.out.println("计分成功");
					out.println("计分成功!<br>"+neiname+"<br>因为"+neido+"<br>计"+String.valueOf(neifen)+"分<br>上月得分为"+String.valueOf(neifenshu)+"分。<br><a href='javascript:window.history.go(-2)'>返回</a>");
					//////////////////////////日志记录//////////////////////////////////
					String rizhi=neiname.trim()+"，因为"+neido.trim()+"，计"+String.valueOf(neifen).trim()+"分";
					String sqlrizhi="insert into rizhi (personname,personIDcard,personRecorddo) values (?,?,?)";
					HttpSession session=request.getSession();
					String [] paramrizhi={session.getAttribute("usernamecheck").toString(),session.getAttribute("personidcheck").toString(),rizhi};
					SqlUtils sqlUtilsrizhi=new SqlUtils();
					boolean flagrizhi=sqlUtilsrizhi.update(sqlrizhi, paramrizhi);
					if(flagrizhi){
						System.out.println("日志添加成功！");
					}else{
						System.out.println("日志添加不成功！");
					}
			//////////////////////////日志记录//////////////////////////////////
			}else{
					System.out.println("计分未成功");
					out.println("计分未成功");
				//}
				}
    	}catch(Exception e){
    		System.out.println("计分未操作未成功");
    		out.println("计分未操作未成功");
    	};
    	
    	out.close();
    }  
  
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
        System.out.println("doGet");  
        this.doPost(request,response);  
    }  
    

}
