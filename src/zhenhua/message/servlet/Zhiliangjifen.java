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
    	int erjicheck=Integer.parseInt(request.getParameter("erjicheck"));//质量计分二级计算标识
    	System.out.println(personname+"//");
    	System.out.println(fenstring+"//");
    	float zhiliangbili=(float)0.4;//质量评分所占比例
    	float personfen=Float.parseFloat(fenstring);
    	float personfenshu=Float.parseFloat(request.getParameter("personfenshu"));
    	int persondocheck=2;//质量计分处理
    	Date persondotime=new Date();
        Calendar cal = Calendar.getInstance();
        int persondoyear = cal.get(Calendar.YEAR);//获取年份
        int persondomonth=cal.get(Calendar.MONTH)+1;//获取月份
        int persondoday=cal.get(Calendar.DATE);//获取日
        boolean flag=false;
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
    	String hehepersondotime = dateFormat.format(persondotime);//转换显示日期格式
    	System.out.println(hehepersondotime+"看看");
    	System.out.println(personname+"看看");
    	//////////质量目标只做一次，暂时未做限定//////////
    	//personfen=0时达到质量目标
        	try{
        		String sql="insert into persondorecord (personname,personIDcard,persondo,personfen,persondocheck,persondoerjicheck,persondotime,persondoyear,persondomonth,persondoday) values (?,?,?,?,?,?,?,?,?,?)";
        		String [] param={personname,personIDcard,persondo, String.valueOf(personfen), Integer.toString(persondocheck),Integer.toString(erjicheck),hehepersondotime, Integer.toString(persondoyear), Integer.toString(persondomonth), Integer.toString(persondoday)};
        		SqlUtils sqlUtils=new SqlUtils();
        		flag=sqlUtils.update(sql, param);
        		System.out.println(sql+"////");
        			if(flag){
        					System.out.println("计分成功");
        					out.println("计分成功!<br>"+personname+"<br>因为"+persondo+"<br>计"+String.valueOf(personfen)+"分<br>上月得分为"+String.valueOf(personfenshu)+"分。<br><a href='javascript:window.history.go(-2)'>返回</a>");
        					//////////////////////////日志记录//////////////////////////////////
        					String rizhi=personname.trim()+"，因为"+persondo.trim()+"，计"+String.valueOf(personfen).trim()+"分";
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
