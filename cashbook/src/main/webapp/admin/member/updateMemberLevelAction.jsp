<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	//c
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	int memberLevel =Integer.parseInt(request.getParameter("memberLevel"));
	System.out.println(memberLevel+"수정될 레벨");
	
	if(request.getParameter("memberNo") == null || request.getParameter("memberNo").equals("")
		|| request.getParameter("memberId") == null || request.getParameter("memberId").equals("")
		|| request.getParameter("memberLevel") == null || request.getParameter("memberLevel").equals("")){
		response.sendRedirect(request.getContextPath()+"/admin/member/memberList.jsp");
	}
		
	//
	Member member = new Member();
	
	member.setMemberNo(Integer.parseInt(request.getParameter("memberNo")));
	member.setMemberId(request.getParameter("memberId"));
	member.setMemberLevel(Integer.parseInt(request.getParameter("memberLevel")));
	
	
	// 
	MemberDao memberDao = new MemberDao();
	
	int row = memberDao.updateMemberLevel(member);
	if(row == 0) {
		System.out.println("레벨수정 실패");
		response.sendRedirect(request.getContextPath()+"/admin/member/updateMemberLevelForm.jsp?memberId="+member.getMemberId());
	} else{
		System.out.println("레벨수정 완료");
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/member/memberList.jsp");
	return;
%>