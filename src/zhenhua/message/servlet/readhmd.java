package zhenhua.message.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.io.BufferedInputStream;  
  




import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import zhenhua.sql.SqlUtils;

public class readhmd extends HttpServlet {
	private String savePath;
	ServletContext sc;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void init(ServletConfig config) {
		savePath = config.getInitParameter("savePath");
		sc = config.getServletContext();
	}

	public String doAttachment(HttpServletRequest request)
			throws ServletException, IOException {
		File tempFile=null;
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		File file=null;
		String tt=null;
		try {
			List items = upload.parseRequest(request);
			Iterator itr = items.iterator();
			while (itr.hasNext()) {
				FileItem item = (FileItem) itr.next();
				if (item.isFormField()) {
					
				} else {
					if (item.getName() != null && !item.getName().equals("")) {
						 tempFile = new File(item.getName());
						 file = new File(sc.getRealPath("/") + savePath,
									tempFile.getName());
							System.out.print(file);
							item.write(file);
							tt=sc.getRealPath("/") + savePath+"\\"+tempFile.getName();
					}
				}
			}
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tt;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String file=doAttachment(request);
		System.out.print("生成成功"+file);
		try{
		int jieguo=readExcelToDB(file);
		if(jieguo==2){
			request.setAttribute("message","数据导入成功！");
			request.getRequestDispatcher("yonghudaoru/result.jsp").forward(request, response);
		}
		else if(jieguo==3){
			request.setAttribute("message","数据导入成功,部分数据存在错误未进行导入！");
			request.getRequestDispatcher("yonghudaoru/result.jsp").forward(request, response);			
		}
		else if(jieguo==4){
			request.setAttribute("message","数据导入失败！有数据重合发生或插入空数据。");
			request.getRequestDispatcher("yonghudaoru/result.jsp").forward(request, response);			
		}
		else if(jieguo==5){
			request.setAttribute("message","黑名单所有数据删除失败！");
			request.getRequestDispatcher("yonghudaoru/result.jsp").forward(request, response);			
		}else{
			request.setAttribute("message", "数据导入失败！");
			request.getRequestDispatcher("yonghudaoru/result.jsp").forward(request, response);
			}
			} catch (FileNotFoundException e) {
				request.setAttribute("message", "没有找到相关文件！");
				request.getRequestDispatcher("yonghudaoru/result.jsp").forward(request, response);
				e.printStackTrace();
			} catch (IOException e) {
				request.setAttribute("message", "发生异常，数据导入失败！");
				request.getRequestDispatcher("yonghudaoru/result.jsp").forward(request, response);
				e.printStackTrace();
			}
	}
	
	

	public static int readExcelToDB(String file){
        // 读取Excel文件字节流  
        //BufferedInputStream in;  
		XSSFWorkbook xwb1=null;
		XSSFSheet sheet1 =null;
		boolean flag=false,flagte=true,flagcha=false;
		int flag1=0,flag2=0;
		int jieguo=0;//结果判断
		
		try{
			String sqlcha="select personname from personheimingdan";
			SqlUtils sqlUtilscha=new SqlUtils();
			flagcha=sqlUtilscha.queryjieguo(sqlcha);
			System.out.print(flagcha+"查询情况\n");
				if(flagcha==true){
				String sqlte="delete from personheimingdan";
				SqlUtils sqlUtilste=new SqlUtils();
				flagte=sqlUtilste.trucate(sqlte);
				};
				System.out.print(flagte+"删除情况\n");	
		} catch (Exception e) {
			e.printStackTrace();
		};
		
		
		try {
			//in = new BufferedInputStream(new FileInputStream(file));
			   // 构造 XSSFWorkbook 对象，strPath 传入文件路径
			System.out.print("刚刚开始");
			  xwb1 = new XSSFWorkbook(file);
			 
			   // 读取第一章表格内容
			  //sheet = xwb.getSheetAt(0);
			  sheet1 = xwb1.getSheet("hmd");
			   // 定义 row、cell
			   XSSFRow row1=null;
			   String cell=null;		
		int rowNum;
		rowNum=sheet1.getLastRowNum();
		System.out.print(rowNum);
		if(flagte){
			for(int i=1;i<=rowNum;i++){
				// System.out.print("成功读取1");
				row1=sheet1.getRow(i);
				//cellNum=row.getLastCellNum();
				// System.out.print("成功读取2");
				cell=row1.getCell(0).toString();
				// System.out.print("成功读取3");
				String gonghao=cell.trim();
				// System.out.print("成功读取4");
				cell=row1.getCell(1).toString();
				// System.out.print("成功读取5");
				String name=cell.trim();
				System.out.print(gonghao+"情况"+name);	
				String sql="insert into personheimingdan (personIDcard,personname) values(?,?)";
				String [] param={gonghao,name};
				SqlUtils sqlUtils=new SqlUtils();
				flag=sqlUtils.update(sql, param);
					if(flag==true)
					{
						flag1=2;
					};
					if(flag==false)
					{
						flag2=3;
					};
			}
		}else{
			jieguo=5;//删除不成功
		}
			
			if(flag1==0&&flag2==0) jieguo=1;//数据导入失败
			if(flag1==0&&flag2==3) jieguo=4;//全部失败
			if(flag1==2&&flag2==0) jieguo=2;//全部成功
			if(flag1==2&&flag2==3) jieguo=3;//一部分成功一部分失败
			System.out.print(jieguo);
        // 关闭字节流  
        //in.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return jieguo;
	}

	


	
}
