package zhenhua.sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import java.sql.ResultSet;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.BaseResultSetHandler;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;

public class SqlUtils {

	public Connection getConnection() {
		Connection conn = null;
		String jdbcURL = "jdbc:sqlserver://localhost:1433;DatabaseName=zhenhua";
		String jdbcDriver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String username = "sa";
		String password = "sky123456";
		DbUtils.loadDriver(jdbcDriver);
		try {
			conn = DriverManager.getConnection(jdbcURL, username, password);
			//System.out.print("Á´½Ó¿ªÊ¼");
		} catch (SQLException e) {
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
