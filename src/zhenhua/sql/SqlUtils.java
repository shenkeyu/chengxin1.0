package zhenhua.sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.BaseResultSetHandler;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.tomcat.dbcp.dbcp.ConnectionFactory;

public class SqlUtils {

	public Connection getConnection() {
		Connection conn = null;
Properties props=new Properties();
try{
props.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("db.properties"));
		String jdbcURL = props.getProperty("jdbcURL");//
		String jdbcDriver = props.getProperty("jdbcDriver");//
		String username =props.getProperty("username");//
		String password =props.getProperty("password");//
		DbUtils.loadDriver(jdbcDriver);
		try {
			conn = DriverManager.getConnection(jdbcURL, username, password);
			//System.out.print("链接开始");
		} catch (SQLException e) {
			e.printStackTrace();
		} 
} catch (Exception e) {
	e.printStackTrace();
} 
		return conn;
	}

	public List query(String sql,String [] param, Class clazz) {
		List beans = null;
		Connection conn = null;
		conn = getConnection();
		QueryRunner qr = new QueryRunner();
		try {
			//beans=(List)qr.query(conn,sql, new BeanListHandler(clazz));
			beans =(List) qr.query(conn,sql,new BeanListHandler(clazz),param);
			System.out.println(beans.get(0));
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DbUtils.closeQuietly(conn);
		}
		return beans;
	}
	
	public Map<String, ArrayList<String>> queryrs(String sql) {//返回一个结果集
		ResultSet rs = null;
		Map<String, ArrayList<String> > map = new HashMap<String, ArrayList<String>>();
		Connection conn = null;
		conn = getConnection();
	    Statement stmt=null;
		try {
		stmt= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);	
		rs=stmt.executeQuery(sql);
		ResultSetMetaData rsMeta = rs.getMetaData();
		//获取数据库中的值
				for(int i = 0; i < rsMeta.getColumnCount(); ++i){
				map.put(rsMeta.getColumnName(i+1), new ArrayList<String>());
				}
				while(rs.next()){
				for(int i = 0; i < rsMeta.getColumnCount(); ++i){
				String columnName = rsMeta.getColumnName(i+1);
				map.get(columnName).add(rs.getString(columnName));
				};
				};
			}catch (SQLException e){
			e.printStackTrace();
			}finally{
			try {
				rs.close();
				stmt.close();
				conn.close();
				}catch (SQLException e) {
				e.printStackTrace();
				};
			}
		return map;
	}
	
	public Boolean queryjieguo(String sql) {
		ResultSet rs = null;
		Connection conn = null;
		conn = getConnection();
	    Statement stmt=null;
	    Boolean flag=false;
		try {
			stmt= conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);	
		rs=stmt.executeQuery(sql);
			if(rs.getRow()>0)
			{
				flag=true;
			};	
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				rs.close();
				stmt.close();
				conn.close();
				}catch (SQLException e) {
				e.printStackTrace();
				};
			}
		return flag;
	}
	
	
	public boolean update(String sql,String [] param ){
		Connection conn = null;
		conn = getConnection();
		boolean flag=false;
		int i=0;
		QueryRunner qr = new QueryRunner();
		try {
			i=qr.update(conn,sql,param);
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(i>0)
			flag=true;		
		return flag;
	}
}
