package dao;

import java.sql.*;
import java.util.ArrayList;
import util.DBUtil;
import vo.Category;


public class CategoryDao {

	private DBUtil dbUtil;

	//admin -> 카테고리관리 -> 카테고리목록
	public ArrayList<Category> selectCategoryListByAdmin() {
		ArrayList<Category> list = null;
		
		// db자원(jdbc, api자원) 반납
		Connection conn = null; //null로 받는게 좋다
		PreparedStatement stmt = null;
		ResultSet rs = null; // 뷰 테이블 : SELECT의 결과물
		
		try {
		list = new ArrayList<Category>();
		
		String sql = "SELECT"
				+"  category_no categoryNo"
				+" , category_kind categoryKind"
				+" , category_name categoryName"
				+" , updatedate"
				+" , createdate"
				+" From category";
		
		DBUtil dbUtil = null;
		dbUtil = new DBUtil();
		
		
		conn = dbUtil.getConnection(); 
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();	
		while(rs.next()) {
			Category c  = new Category();
			c.setCategoryNo(rs.getInt("categoryNo")); // rs.getInt(1); 1 - 셀렉트 정의 순서
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setUpdatedate(rs.getString("updatedate")); // DB날짜 타입이지만 자바단에서 문자열 타입으로 받는다
			c.setCreatedate(rs.getString("createdate"));
			list.add(c); 
		}
		
		// db지원(jdbc api지원) 반납
		dbUtil.close(rs, stmt, conn);
		
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

	// admin -> insertCategoryAction.jsp
	public int insertCategory(Category category) {
		int row = 0;
		Connection conn = null; 
		PreparedStatement stmt = null;	
		
		try {
			String sql = "INSERT INTO category("
					+" category_kind"
					+" , category_name"
					+" , updatedate"
					+" , createdate"
					+") VALUES (?, ?, CURDATE(), CURDATE())";
			
			DBUtil dbUtil = new DBUtil();
			
			conn = dbUtil.getConnection(); 
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryKind());
			stmt.setString(2, category.getCategoryName());
			row = stmt.executeUpdate();
			dbUtil.close(null, stmt, conn);
			
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
		
	
	// 수정 : 수정폼(select)과 수정액션(update)으로 구성
	//admin - > updateCategoryAction.jsp
	public int updateCategory(Category category) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil();
		try {
			String sql = "UPDATE category SET category_name = ? category_kind = ? updatedate = CURDATE() WHERE cateogry_no = ?";
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryName());
			stmt.setInt(2, category.getCategoryNo());
			row = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally { //실행을 약속 이거먼저 실행해라?
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	
	//admin - > updateCategoryForm.jsp
	public Category selectCategoryOne(int categoryNo) {
		Category category = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT category_no categoryNo, category_name categoryName"
						+" FROM category"
						+" WHERE category_no = ?";
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			rs =  stmt.executeQuery();
			if(rs.next()) {
				category = new Category();
				category.setCategoryNo(rs.getInt("categoryNo"));
				category.setCategoryName(rs.getString("categoryName"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally { //실행을 약속 이거먼저 실행해라?
			try {
				dbUtil.close(rs, stmt, conn);
	
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return category;
	}
	
	//damin -> deleteCategory.jsp
	public int deleteCategory(int categoryNo) throws Exception {
		int row = 0;
		
		String sql = "DELETE FROM category WHERE category_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}		
				
	// cash 입력시 <select> 목록출력
	public ArrayList<Category> selectCategoryList() {
		ArrayList<Category> categoryList = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		
		try {
			// 드라이버 로딩, 연결
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			// 조회 쿼리문 작성
			String sql = "SELECT category_no categoryNo"
					+ " , category_kind categoryKind"
					+ " , category_name categoryName "
					+ " FROM category ORDER BY category_kind ASC";				
			// 쿼리 객체 생성
			stmt = conn.prepareStatement(sql);
			// 쿼리 실행
			rs = stmt.executeQuery();
			categoryList = new ArrayList<Category>();
			while(rs.next()) {
				Category c = new Category();
				c.setCategoryNo(rs.getInt("categoryNo"));
				c.setCategoryKind(rs.getString("categoryKind"));
				c.setCategoryName(rs.getString("categoryName"));
				
				categoryList.add(c);
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
		return categoryList;
	
	}
	}
