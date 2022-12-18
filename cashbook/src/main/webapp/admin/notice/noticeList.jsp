<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import ="dao.*" %>
<%@ page import ="java.util.*" %>
<%

request.setCharacterEncoding("UTF-8");
	//c
	/*
		1. 로그인 유효성 검사(회원 레벨 확인)
		2. 페이징(페이지 값 있다면 바꿔주기)
		3. 모델 출력
	*/
	// 세션값 받고 아이디 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	
	// 현재 로그인한 사람
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();	
	

	 // Model : notice list
	 //최근공지 5개, 최근멤버 5명
	 int currentPage = 1;
	 if(request.getParameter("currentPage") != null){
		 currentPage = Integer.parseInt(request.getParameter("currentPage"));
	 }
	 int rowPerPage = 5;
	 int beginRow = (currentPage-1)*rowPerPage;
	 
	
	 NoticeDao noticeDao = new NoticeDao();
	 int cnt = noticeDao.selectNoticeCount();
	 int lastPage = (int)Math.ceil(noticeDao.selectNoticeCount()/(double)rowPerPage);
	 ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	 
	 
	 /*
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(0, 0);
	 int noticeCount = noticeDao.selectNoticeCount(); //-> lastPage
	*/ 
	
	//v


%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>관리자-공지페이지</title>
</head>
<body>

	<div>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/category/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/member/memberList.jsp">맴버관리(목록, 레벨수정, 강제탈퇴)</a></li>
	
	</ul>
	<div>
		<!-- noticeList contents -->
		<h1>공지</h1>
		<a href="<%=request.getContextPath()%>/admin/notice/insertNoticeForm.jsp">공지입력</a>
			<table border="1">
				<tr>
					<th>공지내용</th>
					<th>공지날짜</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
				<%
					for(Notice n : list) {
				%>
						<tr>
							<td><%=n.getNoticeMemo()%></td>
							<td><%=n.getCreatedate() %></td>
							<td><a href="<%=request.getContextPath()%>/admin/notice/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>">수정</a></td>
							<td><a href="<%=request.getContextPath()%>/admin/notice/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a></td>
						</tr>
				<%
					}
				%>
			</table>
		</div>
	</div>
</body>
</html>