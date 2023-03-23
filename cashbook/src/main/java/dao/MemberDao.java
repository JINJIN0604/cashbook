	package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.*;
import util.DBUtil;

public class MemberDao {
	
	
	// 로그인
	public Member login(Member paramMember) {		
		Member resultMember = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		/*
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
		--> DB를 연결하는 코드(명령들)가 Dao 메서드들 거의 공통으로 중복된다.
		--> 중복되는 코드를 하나의 이름(메서드)으로 만들자
		--> 입력값과 반환값 결정해야 한다
		--> 입력값X, 반환값은 Connection타입의 결과값이 남아야 한다.
		*/
		try { 
			DBUtil dbutil = new DBUtil();
			conn = dbutil.getConnection();		
			String sql = "SELECT member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			rs = stmt.executeQuery();
			if(rs.next()) {
				// 로그인 성공
				resultMember = new Member();
				resultMember.setMemberId(rs.getString("memberId"));
				resultMember.setMemberLevel(rs.getInt("memberLevel"));
				resultMember.setMemberName(rs.getString("memberName"));
			}
		} catch(Exception e) { //예외발생한다면 에러메시지표시
			e.printStackTrace();
		} finally { //예외발생해도 무조건 실행
			try {
				rs.close();
				stmt.close();
				conn.close();	
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return resultMember;
	}
	

	// 관리자 : 멤버정보가져오기 updateMemberLevelForm.jsp
	public Member selectMemberByAdmin(String memberId) {
		Member member = new Member();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try { //실행할거tjrpw
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT * FROM member WHERE member_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				member.setMemberId(rs.getString("member_id"));
				member.setMemberName(rs.getString("member_name"));
				member.setMemberNo(rs.getInt("member_no"));
				member.setMemberLevel(rs.getInt("member_level"));
			}
		} catch(Exception e) { //예외발생한다면 에러메시지표시
			e.printStackTrace();
		} finally { //예외발생해도 무조건 실행
			try {
				rs.close();
				stmt.close();
				conn.close();	
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return member;
	}


	// 관리자 : 회원레벨수정
	public int updateMemberLevel(Member paramMember)  {
		int row = 0;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try { //실행할거
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			sql = "UPDATE member SET member_level = ?, updatedate = CURDATE() WHERE member_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramMember.getMemberLevel());
			stmt.setInt(2, paramMember.getMemberNo());
			row = stmt.executeUpdate();
		} catch(Exception e) { //예외발생한다면 에러메시지표시
			e.printStackTrace();
		} finally { //예외발생해도 무조건 실행
			try {
				stmt.close();
				conn.close();	
			} catch(Exception e) {
				e.printStackTrace();
			}
		}	
		return row;
	}

	// 관리자 : 멤버수
	public int selectMemberCount() {
		int count = 0;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DBUtil dbUtil = new DBUtil();
		
		try { //실행할거
			conn = dbUtil.getConnection();
			sql = "SELECT COUNT(*) count FROM member";
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

	// 관리자 멤버 리스트
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) {
		ArrayList<Member> list = new ArrayList<Member>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		
		try { //실행할거
			conn = dbUtil.getConnection();
			String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate"
						+ " FROM member ORDER BY createdate DESC"
						+ " LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Member m = new Member();
				m.setMemberNo(rs.getInt("memberNo"));
				m.setMemberId(rs.getString("memberId"));
				m.setMemberLevel(rs.getInt("memberLevel"));
				m.setMemberName(rs.getString("memberName"));
				m.setUpdatedate(rs.getString("Updatedate"));
				m.setCreatedate(rs.getString("Createdate"));
				list.add(m);
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
	
	// 관리자 : 멤버 강퇴
	public int deleteMemberByAdmin(Member member)  {
		int row = 0;
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		DBUtil dbUtil = new DBUtil();
		try { //실행할거
			conn = dbUtil.getConnection();
			sql = "DELETE FROM member WHERE member_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, member.getMemberNo());
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


	
	// 회원탈퇴
	public int deleteMember(Member member) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil();
		
		try { //실행할거
			conn = dbUtil.getConnection();
			String sql = null;
			stmt = null;
			sql = "DELETE FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, member.getMemberId());
			stmt.setString(2, member.getMemberPw());
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

	
	// 회원가입 1) id중복확인 2) 회원가입
	// 반환값 t:이미존재 , f:사용가능
	// 1)
	public int memberIdCheck(String memberId) throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		
		ResultSet rs = stmt.executeQuery();
		
		if(!rs.next()){	//중복되는 아이디가 없다면
			row = 1;
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return row;
	}
	
	// 회원가입
	public int signUpMember(Member paramMember) throws Exception{
		int resultRow = 0;
		
		// 공통 코드 메서드로 분리
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql ="INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?, PASSWORD(?), ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberName());
		
		resultRow = stmt.executeUpdate();
		return resultRow;	// 성공하면 1
	}


	//비밀번호 일치 확인
	public int selectMemberPw(String memberId, String memberPw) throws Exception{
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT * FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, memberPw);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {	//비밀번호가 일치한다면
			row = 1;
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return row;
	}

	// 비밀번호 수정
	public int updateMemberPw(String updatePw, String memberId) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil();
		
		try { //실행할거
			conn = dbUtil.getConnection();
			String sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, updatePw);
			stmt.setString(2, memberId);
			// 성공하면 row == 1
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
	}
