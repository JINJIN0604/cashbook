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


	//m
	NoticeDao noticeDao = new NoticeDao();
	MemberDao memberDao = new MemberDao();
	int beginRow = 0;
	int rowPerPage = 5;
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage); // 최근 공지 5개
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage); // 최근 추가 멤버 5개씩
	 

	
	//v


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
		<li><a href="<%=request.getContextPath()%>/help/heplList.jsp">고객센터관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/category/categoryList.jsp">카테고리관리</a></li><!-- 페이징x -->
		<li><a href="<%=request.getContextPath()%>/admin/member/memberList.jsp">회원관리(목록, 레벨수정, 강제탈퇴)</a></li>
	</ul>
		<!-- admin contents -->
		<!-- 최근 공지 5개 -->
		<div>
			<h3><strong>공지사항</strong></h3>
			<table border="1">
				<tr>
					<th>내용</th>
					<th>날짜</th>
				</tr>
				<%
					for(Notice n : noticeList){
				%>
						<tr>
							<td><%=n.getNoticeMemo()%></td>
							<td><%=n.getCreatedate()%></td>
						</tr>
				<%
					}
				%>
			</table>
		</div>
		<!-- 최근 추가 멤버 5개 -->
		<div>
			<h3><strong>최근 생성된 회원</strong></h3>
			<table border="1">
				<tr>
					<th>회원번호</th>
					<th>아이디</th>
					<th>회원레벨</th>
					<th>이름</th>
					<th>수정일</th>
					<th>회원 생성일</th>
				</tr>
				<%
					for(Member m : memberList){
				%>
						<tr>
							<td><%=m.getMemberNo()%></td>
							<td><%=m.getMemberId()%></td>
							<td><%=m.getMemberLevel()%></td>
							<td><%=m.getMemberName()%></td>
							<td><%=m.getUpdatedate()%></td>
							<td><%=m.getCreatedate()%></td>
						</tr>
				<%
					}
				%>
			</table>
		</div>
	</body>
</html>