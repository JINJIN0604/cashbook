<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.*"%>
<%
//c
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){ // 세션 정보가 없거나, 세션에 저장된 멤버 레베이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/admin/notice/noticeList.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	//
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	
	
	// 
	NoticeDao noticeDao = new NoticeDao();
	int delteNoticeCheck = noticeDao.deleteNotice(notice);
	if(delteNoticeCheck  == 0){
		System.out.println("공지 삭제 실패");
	}else{
		System.out.println("공지 삭제 성공");
	}
		response.sendRedirect(request.getContextPath()+"/admin/notice/noticeList.jsp");
%>
