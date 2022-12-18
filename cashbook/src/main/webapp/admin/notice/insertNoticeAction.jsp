<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*"%>
<%
	//c
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){ // 세션 정보가 없거나, 세션에 저장된 멤버 레베이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	if(request.getParameter("noticeMemo") == null || request.getParameter("noticeMemo").equals("")){
		response.sendRedirect(request.getContextPath()+"/admin/notice/insertNoticeForm.jsp");
		return;
	}
	
	//m
	// 공지사항 입력
	Notice notice = new Notice();
	notice.setNoticeMemo(request.getParameter("noticeMemo"));
	
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.insertNotice(notice);
	
	if(row == 0){
		response.sendRedirect(request.getContextPath()+"/admin/notice/insertNoticeForm.jsp");
	}else{
		response.sendRedirect(request.getContextPath()+"/admin/notice/noticeList.jsp");
	}
	//v x
%>
