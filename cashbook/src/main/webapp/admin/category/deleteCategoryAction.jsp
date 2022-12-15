<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*"%>

<%
	//인코딩
	request.setCharacterEncoding("UTF-8");
	//c
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){ // 세션 정보가 없거나, 세션에 저장된 멤버 레베이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.deleteCategory(categoryNo);
	if(row == 1){
		System.out.println("deleteCategoryList:삭제성공");	
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/category/categoryList.jsp");
%>
