<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//1

	// 로그인x -> 접근 불가
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	
	// 현재 로그인한 회원
	Member loginMember = (Member)session.getAttribute("loginMember");
	int memberNo = loginMember.getMemberNo();
	String memberId = loginMember.getMemberId();
	
	
	// 방어 코드 - 입력되지 않으면 폼으로
	if(request.getParameter("currentPw") == null || request.getParameter("currentPw").equals("")
		|| request.getParameter("updatePw") == null || request.getParameter("updatePw").equals("")
		||request.getParameter("updatePwCheck") == null || request.getParameter("updatePwCheck").equals("") ){
		response.sendRedirect(request.getContextPath()+"/member/updateMemberPwForm.jsp");
		return;
	}
	
	String currentPw = request.getParameter("currentPw");
	String updatePw = request.getParameter("updatePw");
	String updatePwCheck = request.getParameter("updatePwCheck");
	
	MemberDao memberDao = new MemberDao();
	
	
	// 기존 비밀번호 일치 확인
	int checkCurrentPw = memberDao.selectMemberPw(memberId, currentPw);
	if(checkCurrentPw == 0){	//일치하지 않는다면
		String msgCurrentPw = URLEncoder.encode("비밀번호를 정확하게 입력해 주세요.", "UTF-8");
		response.sendRedirect(request.getContextPath()+"/member/updateMemberPwForm.jsp?msgCurrentPw="+msgCurrentPw);
		return;
	}
	
	// 새 비밀번호, 비밀번호 확인 일치 확인
	if(!updatePw.equals(updatePwCheck)){
		String msgUpdatePw = URLEncoder.encode("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath()+"/member/updateMemberPwForm.jsp?msgUpdatePw="+msgUpdatePw);
		return;
	}
	
	// 비밀번호 변경 수행
	int checkUpdate = memberDao.updateMemberPw(updatePw, memberId);
	if(checkUpdate == 1){
		System.out.println("비밀번호 변경 성공");
	}else {
		System.out.println("비밀번호 변경 실패");
	}
	
	response.sendRedirect(request.getContextPath()+"/member/memberPage.jsp");
%>
