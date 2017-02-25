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

public class readfilegong extends HttpServlet {
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
			request.setAttribute("message","数据导入成功,重合数据未进行导入！");
			request.getRequestDispatcher("yonghudaoru/result.jsp").forward(request, response);			
		}
		else if(jieguo==4){
			request.setAttribute("message","所有数据均与数据库中数据重合，以工号进行界定！");
			request.getRequestDispatcher("yonghudaoru/result.jsp").forward(request, response);			
		}
		else{
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
		XSSFWorkbook xwb=null;
		XSSFSheet sheet =null;
		boolean flag=false;
		int flag1=0;//判断是否有成功导入项,成功为2，说明有数据导入成功
		int flag2=0;//判断是否有成功导入项，失败为3，说明有数据导入不成功
		int jieguo=0;//结果判断
		try {
			//in = new BufferedInputStream(new FileInputStream(file));
			   // 构造 XSSFWorkbook 对象，strPath 传入文件路径
			//System.out.print("刚刚开始");
			  xwb = new XSSFWorkbook(file);
			 // System.out.print("成功读取");
			   // 读取第一章表格内容
			  //sheet = xwb.getSheetAt(0);
			  sheet = xwb.getSheet("qiye");
			   // 定义 row、cell
			   XSSFRow row=null;
			   String cell=null;		
		int rowNum;
		rowNum=sheet.getLastRowNum();
		System.out.print(rowNum);
	
			for(int i=1;i<=rowNum;i++){
				row=sheet.getRow(i);
				
				//cellNum=row.getLastCellNum();
				cell=row.getCell(1).toString();
				String name=cell.trim();
				cell=row.getCell(2).toString();
				String dizhi=cell.trim();
				cell=row.getCell(3).toString();
				String faren=cell.trim();
				cell=row.getCell(4).toString();
				String ziben=cell.trim();
				cell=row.getCell(5).toString();
				String chengliriqi=cell.trim();
				cell=row.getCell(6).toString();
				String yingyeriqi=cell.trim();
				String sql="insert into gong (name,dizhi,faren,ziben,chengliriqi,yingyeriqi) values (?,?,?,?,?,?)";
				String [] param={name,dizhi,faren,ziben,chengliriqi,yingyeriqi};
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
			
			System.out.print(jieguo);
			if(flag1==0&&flag2==0) jieguo=1;//数据导入失败
			if(flag1==0&&flag2==3) jieguo=4;//全部失败
			if(flag1==2&&flag2==0) jieguo=2;//全部成功
			if(flag1==2&&flag2==3) jieguo=3;//一部分成功一部分失败
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
