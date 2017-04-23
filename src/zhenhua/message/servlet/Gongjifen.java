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
    	int erjicheck=Integer.parseInt(request.getParameter("erjicheck"));//二级计算标识
    	System.out.println(gongname+"//");
    	System.out.println(fenstring+"//");
    	float huansuanbili=(float)1.2;//供应商计分按100分制计算
    	float gongfen=Float.parseFloat(fenstring);
    	float gongfenshu=Float.parseFloat(request.getParameter("gongfenshu"));
    	Date gongdotime=new Date();
        Calendar cal = Calendar.getInstance();
        int gongdoyear = cal.get(Calendar.YEAR);//获取年份
        int gongdomonth=cal.get(Calendar.MONTH)+1;//获取月份
        int gongdoday=cal.get(Calendar.DATE);//获取日
        boolean flag=false;
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
    	String hehegongdotime = dateFormat.format(gongdotime);//转换显示日期格式
    	System.out.println(hehegongdotime+"看看");
    	System.out.println(gongname+"看看");
    	System.out.println(fenshucheck+"看看");
    	System.out.println(gongdo+"看看");
    	System.out.println(erjicheck+"看看");
    	System.out.println(gongfen+"看看");
    	
    	/////////////////////////////////////////////////////
    	try{
		String sql="insert into gongdorecord (gongname,gongdo,gongfen,gongdocheck,gongdoerjicheck,gongdotime,gongdoyear,gongdomonth,gongdoday) values (?,?,?,?,?,?,?,?,?)";
		String [] param={gongname,gongdo,String.valueOf(gongfen),Integer.toString(fenshucheck),Integer.toString(erjicheck),hehegongdotime,Integer.toString(gongdoyear),Integer.toString(gongdomonth),Integer.toString(gongdoday)};
		SqlUtils sqlUtilsgong=new SqlUtils();
		flag=sqlUtilsgong.update(sql,param);
		System.out.println(sql+"////");
			if(flag){
					System.out.println("计分成功");
					out.println("计分成功!<br>"+gongname+"<br>因为"+gongdo+"<br>计"+String.valueOf(gongfen)+"分<br>上月得分为"+String.valueOf(gongfenshu)+"分。");
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
