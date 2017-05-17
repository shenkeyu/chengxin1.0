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

public class readfilemingqi extends HttpServlet {
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
		System.out.print("���ɳɹ�"+file);
		int jieguo=readExcelToDB(file);
		if(jieguo==2){
			request.setAttribute("message","���ݵ���ɹ���");
			request.getRequestDispatcher("yonghudaoru/result.jsp").forward(request, response);
		}
		else if(jieguo==3){
			request.setAttribute("message","���ݵ���ɹ�,�غ�����δ���е��룡");
			request.getRequestDispatcher("yonghudaoru/result.jsp").forward(request, response);			
		}
		else if(jieguo==4){
			request.setAttribute("message","�������ݾ������ݿ��������غϣ��Թ��Ž��н綨��");
			request.getRequestDispatcher("yonghudaoru/result.jsp").forward(request, response);			
		}
		else{
			request.setAttribute("message", "���ݵ���ʧ�ܣ�");
			request.getRequestDispatcher("yonghudaoru/result.jsp").forward(request, response);
			}
	}
	
	

	public static int readExcelToDB(String file){
        // ��ȡExcel�ļ��ֽ���  
        //BufferedInputStream in;  
		XSSFWorkbook xwb=null;
		XSSFSheet sheet =null;
		boolean flag=false;
		int flag1=0;//�ж��Ƿ��гɹ�������,�ɹ�Ϊ2��˵�������ݵ���ɹ�
		int flag2=0;//�ж��Ƿ��гɹ������ʧ��Ϊ3��˵�������ݵ��벻�ɹ�
		int jieguo=0;//����ж�
		try {
			//in = new BufferedInputStream(new FileInputStream(file));
			   // ���� XSSFWorkbook ����strPath �����ļ�·��
			//System.out.print("�ոտ�ʼ");
			  xwb = new XSSFWorkbook(file);
			 // System.out.print("�ɹ���ȡ");
			   // ��ȡ��һ�±������
			  //sheet = xwb.getSheetAt(0);
			  sheet = xwb.getSheet("renyuan2");
			   // ���� row��cell
			   XSSFRow row=null;
			   String cell=null;		
		int rowNum;
		rowNum=sheet.getLastRowNum();
		System.out.print(rowNum);
	
			for(int i=1;i<=rowNum;i++){
				row=sheet.getRow(i);
				
				//cellNum=row.getLastCellNum();
				cell=row.getCell(1).toString();
				String bumen1=cell.trim();
				cell=row.getCell(2).toString();
				String bumen2=cell.trim();
				cell=row.getCell(3).toString();
				String bumen3=cell.trim();
				cell=row.getCell(4).toString();
				String personname=cell.trim();
				cell=row.getCell(5).toString();
				String gongzhong=cell.trim();
				cell=row.getCell(6).toString();
				String gonghao=cell.trim();
				cell=row.getCell(7).toString();
				String yonggongxingzhi=cell.trim();
				cell=row.getCell(8).toString();
				String jinsishijian=cell.trim();
				cell=row.getCell(9).toString();
				String kahao=cell.trim();
				cell=row.getCell(10).toString();
				String jinsiriqi=cell.trim();
				cell=row.getCell(11).toString();
				String beizhu=cell.trim();
				String sql="insert into person (personname,personpwd,personIDcard,personbumen,person2bumen,person3bumen,persongongzhong,yonggongxingzhi,jinsishijian,kahao,jinsiriqi,beizhu,renyuanleixing) values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
				String [] param={personname,"123456",gonghao,bumen1,bumen2,bumen3,gongzhong,yonggongxingzhi,jinsishijian,kahao,jinsiriqi,beizhu,"2"};
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
			if(flag1==0&&flag2==0) jieguo=1;//���ݵ���ʧ��
			if(flag1==0&&flag2==3) jieguo=4;//ȫ��ʧ��
			if(flag1==2&&flag2==0) jieguo=2;//ȫ���ɹ�
			if(flag1==2&&flag2==3) jieguo=3;//һ���ֳɹ�һ����ʧ��
        // �ر��ֽ���  
        //in.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jieguo;
	}

	


	
}
