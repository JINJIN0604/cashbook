package vo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import util.DBUtil;

public class Cash {
	/*
	SELECT c.cash_no cashNo
		, c.cash_date cashDate
		, c.cash_price cashPrice
		, c.category_no categoryNo
		, ct.category_kind categoryKind
		, ct.category_name categoryName
	FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no 
	WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?
	ORDER BY c.cash_date;
	*/
	// 조인 사용 --> HashMap
	public ArrayList<HashMap<String, Object>> selectCashListByMonyh(int year, int month) throws Exception{
		ArrayList<HashMap<String, Object>> list = new  ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql ="SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		stmt.setInt(2, month);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			// hashMap에 데이터 넣기
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getString("cashPrice"));
			m.put("categoryNo", rs.getString("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);	// list에 데이터 넣기
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
}
