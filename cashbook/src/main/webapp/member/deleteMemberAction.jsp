<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// c

	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//
	String msg = null;

	request.setCharacterEncoding("UTF-8");
	
	//session에 저장된 멤버(현재로그인사용자)
	Object objectMember = session.getAttribute("loginMember");
	Member loginMember = (Member)objectMember;
	
	
	//
	if(request.getParameter("memberId")==null || request.getParameter("memberId").equals("")){
		msg = URLEncoder.encode("ID값이 없습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/member/deleteMemberForm.jsp?msg="+msg);
		return;
	} else{
		String memgerId = request.getParameter("memberId");
	}
	//방어코드
	if(request.getParameter("memberPw")==null || request.getParameter("memberPw").equals("")){
		msg = URLEncoder.encode("비밀번호를 입력하세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/member/deleteMemberForm.jsp?msg="+msg);
		return;
	} else{
		String memgerPw = request.getParameter("memberPw");
	}	
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);

	
	// m
	MemberDao memberDao = new MemberDao();
	int row = 0;
	String redirecUrl = "/member/deleteMemberForm.jsp";
			
	row = memberDao.deleteMember(member);
	if(row==1){
		System.out.println("회원 탈퇴 성공");
		msg = URLEncoder.encode("회원탈퇴가 완료되었습니다", "utf-8");
		redirecUrl = "/loginForm.jsp?msg="+msg;
		session.invalidate();
	} else{
		System.out.println("회원 탈퇴 실패");
		msg = URLEncoder.encode("비밀번호가 틀렸습니다", "utf-8");
		redirecUrl = "/member/deleteMemberForm.jsp?msg="+msg;
	}
	
	response.sendRedirect(request.getContextPath()+redirecUrl);

%>	