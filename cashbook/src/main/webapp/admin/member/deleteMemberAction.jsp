<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@page import="vo.*"%>


<%
	// C
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { 
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// 파라메터 유효성 검사
	if(request.getParameter("memberNo") == null){
		response.sendRedirect(request.getContextPath()+"/admin/member/memberList.jsp");
		return;
	}
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	//
	Member member = new Member();
	member.setMemberNo(memberNo);
	
	//m
	MemberDao memberDao = new MemberDao();
	int row = memberDao.deleteMemberByAdmin(member);
	if(row == 0) {
		System.out.println("회원 삭제실패");
	} else {
		System.out.println("회원 삭제 성공");
	}
	response.sendRedirect(request.getContextPath()+"/admin/member/memberList.jsp");
%>