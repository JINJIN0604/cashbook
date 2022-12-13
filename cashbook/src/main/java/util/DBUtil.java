package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBUtil {
	public Connection getConnection() throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook", "root", "java1234");
		return conn;
	}

	public void close(ResultSet rs, PreparedStatement stmt, Connection conn) {
		// TODO Auto-generated method stub
		
	}
}
