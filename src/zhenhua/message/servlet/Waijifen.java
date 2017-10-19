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
    	int erjicheck=Integer.parseInt(request.getParameter("erjicheck"));//二级计算标识
    	System.out.println(wainame+"//");
    	System.out.println(fenstring+"//");
    	float huansuanbili=(float)1.2;//外分包商计分按100分制计算
    	float waifen=Float.parseFloat(fenstring);
    	float waifenshu=Float.parseFloat(request.getParameter("waifenshu"));
    	Date waidotime=new Date();
        Calendar cal = Calendar.getInstance();
        int waidoyear = cal.get(Calendar.YEAR);//获取年份
        int waidomonth=cal.get(Calendar.MONTH)+1;//获取月份
        int waidoday=cal.get(Calendar.DATE);//获取日
        boolean flag=false;
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
    	String hehewaidotime = dateFormat.format(waidotime);//转换显示日期格式
    	System.out.println(hehewaidotime+"看看");
    	System.out.println(wainame+"看看");
    	System.out.println(fenshucheck+"看看");
    	/////////////////////////////////////////////////////
    	try{
		String sql="insert into waidorecord (wainame,waido,waifen,waidocheck,waidoerjicheck,waidotime,waidoyear,waidomonth,waidoday) values (?,?,?,?,?,?,?,?,?)";
		String [] param={wainame,waido,String.valueOf(waifen),Integer.toString(fenshucheck),Integer.toString(erjicheck),hehewaidotime, Integer.toString(waidoyear), Integer.toString(waidomonth), Integer.toString(waidoday)};
		SqlUtils sqlUtils=new SqlUtils();
		flag=sqlUtils.update(sql, param);
		System.out.println(sql+"////");
			if(flag){
					System.out.println("计分成功");
					out.println("计分成功!<br>"+wainame+"<br>因为"+waido+"<br>计"+String.valueOf(waifen)+"分<br>上月得分为"+String.valueOf(waifenshu)+"分。<br><a href='javascript:window.history.go(-2)'>返回</a>");
					//////////////////////////日志记录//////////////////////////////////
					String rizhi=wainame.trim()+"，因为"+waido.trim()+"，计"+String.valueOf(waifen).trim()+"分";
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
