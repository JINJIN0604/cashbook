<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*"%>
<%
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	//c
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//
	String msg = null;
	
	String categoryKind = null;
	String categoryName = null;
	
	Category category = new Category();
	category.setCategoryKind(categoryKind);
	category.setCategoryName(categoryName);
	
	
	//디버깅 코드
	System.out.println(categoryKind);
	System.out.println(categoryName);
	
	
	String redirectUrl = "/admin/category/cateogryList.jsp";
	
	//m
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.insertCategory(category);
	if(row == 1){
		System.out.println("카테고리 추가 성공");
		msg = URLEncoder.encode("카테고리가 추가 성공", "utf-8");
		//디버깅
		System.out.println(categoryKind + "<--insertCategoryAction.jsp");
		System.out.println(categoryName + "<--insertCategoryAction.jsp");
		redirectUrl = "/admin/category/categoryList.jsp?msg="+msg;
	}else{
		System.out.println("카테고리 추가 실패");
		msg = URLEncoder.encode("카테고리가 추가 실패", "utf-8");
		//디버깅
		System.out.println(categoryKind + "<--insertCategoryAction.jsp");
		System.out.println(categoryName + "<--insertCategoryAction.jsp");
		redirectUrl = "/admin/category/categoryList.jsp?msg="+msg;	
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl);

%>
