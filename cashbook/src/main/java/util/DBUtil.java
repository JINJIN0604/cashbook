package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtil {
	public Connection getConnection() throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook", "root", "java1234");
		return conn;
		
	}

	public void close(ResultSet rs, PreparedStatement stmt, Connection conn) throws SQLException {
		
		if(rs != null) {rs.close();}
		if(stmt != null) {stmt.close();}
		if(conn != null) {conn.close();}
	}
}
