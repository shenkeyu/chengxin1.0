package zhenhua.sql;

public class SqlTest {

	public static void main(String[] args) {
		SqlUtils sqlUtils =new SqlUtils();
		String sql="update person set personname=?,personpwd=? where personname ='����'";
		String [] param={"����","123111"};
		System.out.print(sqlUtils.update(sql, param));
		String sql1="select * from person";		
	}
}
