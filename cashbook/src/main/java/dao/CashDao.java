package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import util.DBUtil;

public class CashDao {
	// 조인 사용 --> HashMap
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) {
		ArrayList<HashMap<String, Object>> list = new  ArrayList<HashMap<String, Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql ="SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.category_no categoryNo, c.cash_memo cashMemo, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC;";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<>();
				// hashMap에 데이터 넣기
				m.put("cashNo", rs.getInt("cashNo"));
				m.put("cashDate", rs.getString("cashDate"));
				m.put("cashPrice", rs.getLong("cashPrice"));	// String으로
				m.put("categoryNo", rs.getInt("categoryNo"));	// 받았었음
				m.put("cashMemo", rs.getString("cashMemo"));
				m.put("categoryKind", rs.getString("categoryKind"));
				m.put("categoryName", rs.getString("categoryName"));
				list.add(m);	// list에 데이터 넣기
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally { //실행을 약속 이거먼저 실행해라?
			try {
				rs.close();
				stmt.close();
				conn.close();	
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list;
		
		
	}


	// insertCashList
	public int insertCashList(String loginMemberId, int categoryNo, long cashPrice, String cashDate, String cashMemo) throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO cash(member_id, category_no, cash_price, cash_date, cash_memo, updatedate, createdate) VALUES (?, ?, ?, ?, ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, loginMemberId);
		stmt.setInt(2, categoryNo);
		stmt.setLong(3, cashPrice);
		stmt.setString(4, cashDate);
		stmt.setString(5, cashMemo);
		
		int row = stmt.executeUpdate();
		// 성공하면 1 실패하면 0
		if(row == 1) {
			return 1;
		}else {
			return 0;
		}
	}
		// 해당 캐시번호 자료 보기
		public HashMap<String, Object> selectCashListByCashNo(int cashNo) {
			HashMap<String, Object> map = new HashMap<>();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				DBUtil dbUtil = new DBUtil();
				conn = dbUtil.getConnection();
				String sql = "SELECT cash_no cashNo, cash_date cashDate, cash_price cashPrice, category_no categoryNo, cash_memo cashMemo \r\n"
						+ "FROM cash\r\n"
						+ "WHERE cash_no = ?";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, cashNo);
				
				rs = stmt.executeQuery();
				if(rs.next()) {
					map.put("cashNo", cashNo);
					map.put("cashDate", rs.getString("cashDate"));
					map.put("cashPrice", rs.getLong("cashPrice"));
					map.put("categoryNo", rs.getInt("categoryNo"));
					map.put("cashMemo", rs.getString("cashMemo"));
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					rs.close();
					stmt.close();
						conn.close();	
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			
			return map;
		}
		
		// 수정
		public int updateCashList(int categoryNo, long cashPrice, String cashMemo, int cashNo, String memberId) {
			Connection conn = null;
			PreparedStatement stmt = null;
			
			int row = 0; 
			
			try {
				DBUtil dbUtil = new DBUtil();
				conn = dbUtil.getConnection();
				
				String sql = "UPDATE cash"
						+ "SET category_no = ?"
						+ "	, cash_price = ?"
						+ "	, cash_memo = ?"
						+ "	, updatedate = CURDATE()"
						+ "WHERE cash_no = ? AND member_id = ?";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, categoryNo);
				stmt.setLong(2, cashPrice);
				stmt.setString(3, cashMemo);
				stmt.setInt(4, cashNo);
				stmt.setString(5, memberId);
				// 성공하면 row = 1
				row = stmt.executeUpdate();
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
				
					stmt.close();
					conn.close();	
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			return row;
			}
		
		//삭제
		public int deleteCash(int cashNo) throws Exception{
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM cash WHERE cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		
		// 성공하면 row = 1
		row = stmt.executeUpdate();
		return row;
	}
	
}





