package dao;

import java.util.*;
import java.sql.*;
import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	// 마지막 페이지 구하기
	public int selectNoticeCount() {
		int count = 0;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		
		try { //실행할거
			conn = dbUtil.getConnection();
			sql = "SELECT COUNT(*) count FROM notice";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count");
			}
		} catch(Exception e) { //예외발생한다면 에러메시지표시
			e.printStackTrace();
		} finally { //예외발생해도 무조건 실행
			try {
				dbUtil.close(rs, stmt, conn);
	
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return count;
	}

	
	// loginForm.jsp 공지 목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) {
		ArrayList<Notice> list = new ArrayList<Notice>();	
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try { //실행할거
			conn = dbUtil.getConnection();
			String sql = "SELECT notice_no noticeNo"
					+ " , notice_memo noticeMemo"
					+ "	, createdate"
					+ " FROM notice"
					+ " ORDER BY createdate DESC"
					+ " LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rs.getInt("noticeNo"));
				n.setNoticeMemo(rs.getString("noticeMemo"));
				n.setCreatedate(rs.getString("createdate"));
				list.add(n);
			}
		} catch(Exception e) { //예외발생한다면 에러메시지표시
			e.printStackTrace();
		} finally { //예외발생해도 무조건 실행
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}	
		return list;
	}
	
	// INSERT : noticeList.jsp
	public int insertNotice(Notice notice) {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try { //실행할거
			conn = dbUtil.getConnection();
			String sql = null;
			stmt = null;
			sql = "INSERT notice(notice_memo, updatedate, createdate) VALUES(?, NOW(), NOW())";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeMemo());
			row = stmt.executeUpdate();
		
		} catch(Exception e) { //예외발생한다면 에러메시지표시
			e.printStackTrace();
		} finally { //예외발생해도 무조건 실행
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}	
			
		return row;		
	}
	
	// UPDATE 
	public int updateNotice(Notice notice) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil();
		try { //실행할거
			conn = dbUtil.getConnection();
			String sql = null;
			stmt = null;
			sql = "UPDATE notice SET notice_memo = ? WHERE notice_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeMemo());
			stmt.setInt(2, notice.getNoticeNo());
			row = stmt.executeUpdate();
		} catch(Exception e) { //예외발생한다면 에러메시지표시
			e.printStackTrace();
		} finally { //예외발생해도 무조건 실행
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
			
		return row;		
	}
	
	// DELETE :	noticeList.jsp
	public int deleteNotice(Notice notice) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = null;
		PreparedStatement stmt = null;
		sql = "DELETE FROM notice WHERE notice_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;		
	}
	// SELECT : updateNoticeForm.jsp 공지 정보 조회
	public Notice selectNotice(Notice notice)throws Exception{
		Notice n = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, updatedate, createdate"
					+ " FROM notice"
					+ " WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setUpdatedate(rs.getString("updatedate"));
			n.setCreatedate(rs.getString("createdate"));
		}
		
		dbUtil.close(rs, stmt, conn);
		return n;
	}

}
