package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Comment;

public class CommentDao {
	private DBUtil dbUtil;

	// SELECT : updateCommentForm.jsp
	public Comment selectComment(Comment comment) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		Comment c = null;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT comment_no commentNo, help_no helpNo, comment_memo commentMemo, member_id memberId, updatedate, createdate"
						+ " FROM comment"
						+ " WHERE comment_no=?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, comment.getCommentNo());
			rs = stmt.executeQuery();
			while(rs.next()) {
				c = new Comment();
				c.setCommentNo(rs.getInt("CommentNo"));
				c.setHelpNo(rs.getInt("helpNo"));
				c.setCommentMemo(rs.getString("CommentMemo"));
				c.setMemberId(rs.getString("memberId"));
				c.setUpdatedate(rs.getString("updatedate"));
				c.setCreatedate(rs.getString("createdate"));
				
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
		return c;
	}
	
	// SELECT : 관리자 
	public ArrayList<HashMap<String, Object>> selectCommentList(int beginRow, int rowPerPage) {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// SQL 쿼리 적을 때 : FROM -> WHERE -> SELECT -> ORDER BY
			String sql = "SELECT h.help_no helpNo"
					+ "			, h.help_memo helpMemo"
					+ "			, h.member_id helpMemberId"
					+ "			, h.updatedate helpUpdatedate"
					+ "			, h.createdate helpCreatedate"
					+ "			, c.comment_no commentNo"
					+ "			, c.comment_memo commentMemo"
					+ "			, c.member_id commentMemberId"
					+ "			, c.updatedate commentUpdatedate"
					+ "			, c.createdate commentCreatedate"
					+ " FROM help h LEFT JOIN COMMENT c"
					+ " ON h.help_no = c.help_no"
					+ " LIMIT ?, ?";
			
			DBUtil dbUtil = new DBUtil();
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpMemo", rs.getString("helpMemo"));
				m.put("helpMemberId", rs.getString("helpMemberId"));
				m.put("helpUpdatedate", rs.getString("helpUpdatedate"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("commentNo", rs.getInt("commentNo"));
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("commentMemberId", rs.getString("commentMemberId"));
				m.put("commentUpdatedate", rs.getString("commentUpdatedate"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));
				list.add(m);
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
		return list;
	}
	
	// 페이징
	public int selectCommentCount() {
		int count = 0;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			sql = "SELECT COUNT(*) count FROM comment";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count");
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
		return count;
	}
		
	// INSERT : insertCommentAction.jsp
	public int insertComment(Comment comment) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			String sql = "INSERT into comment(help_no, comment_memo, member_id, updatedate, createdate)"
						+ " VALUES(?, ?, ?, NOW(), NOW())";
			DBUtil dbUtil = new DBUtil();
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, comment.getHelpNo());
			stmt.setString(2, comment.getCommentMemo());
			stmt.setString(3, comment.getMemberId());
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
	
	// UPDATE : updateCommentAction.jsp
	public int updateComment(Comment comment) {
		int row = 0;
		String sql = null;
		PreparedStatement stmt = null;
		Connection conn = null;
		
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			sql = "UPDATE comment SET comment_memo = ? WHERE comment_no= ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, comment.getCommentMemo());
			stmt.setInt(2, comment.getCommentNo());
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
	
	// DELETE : deleteCommentAction.jsp
	public int deleteComment(Comment comment) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		sql = "DELETE FROM comment WHERE comment_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getCommentNo());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
}