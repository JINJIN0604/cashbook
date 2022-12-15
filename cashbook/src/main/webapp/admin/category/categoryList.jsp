<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>


<%
	//c
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}


	 //m
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> list = categoryDao.selectCategoryListByAdmin();

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/category/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/member/memberList.jsp">맴버관리(목록, 레벨수정, 강제탈퇴)</a></li>
	
	</ul>
	<div>
		<!--categoryList content  -->
		<h1>카테고리 목록</h1>
		<a href="<%=request.getContextPath()%>/admin/category/insertCategoryForm.jsp">카테고리 추가</a>
		<table>
			<tr>
				<th>번호</th>
				<th>수입/지출</th>	
				<th>이름</th>
				<th>마지막 수정 날짜</th>
				<th>생성 날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<!-- 모델 데이터 categoryList 출력 -->
			<%
				for(Category c : list){
			%>
				<tr>
					<td><%=c.getCategoryNo()%></td>
					<td><%=c.getCategoryKind()%></td>
					<td><%=c.getCategoryName()%></td>
					<td><%=c.getUpdatedate()%></td>
					<td><%=c.getCreatedate()%></td>
					<td><a href="<%=request.getContextPath()%>/admin/category/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/admin/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a></td>
				</tr>
			<%
				}
			%>
		</table>
	</div>
</body>
</html>