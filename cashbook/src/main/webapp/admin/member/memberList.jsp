<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<%
	//c
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// 현재 로그인한 사람
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();
	
	
	 //m
	// 멤버 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 10;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	int count = 0;
	MemberDao memberDao = new MemberDao();
	count = memberDao.selectMemberCount(); // -> lastPage
	
	int lastPage = (int)Math.ceil((double)count / (double)ROW_PER_PAGE); //마지막 페이지 번호 구하기
	
	// 멤버 목록 출력
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, ROW_PER_PAGE);
	

	//v


%>


<!DOCTYPE html>
<html>
<head>
	<!-- Basic Page Info -->
	<meta charset="utf-8">
	<title>마이페이지</title>
</head>
<body>
	<div>
		<ul>
			<li><a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp">공지관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/category/categoryList.jsp">카테고리관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/member/memberList.jsp">맴버관리(목록, 레벨수정, 강제탈퇴)</a></li>
		</ul>
	</div>
	<!-- memberList content -->
	<table>
		<tr>
			<th>회원번호</th>
			<th>아이디</th>
			<th>레벨</th>
			<th>이름</th>
			<th>마지막수정일자</th>
			<th>생성일자</th>
			<th>레벨수정</th>
			<th>강제탈퇴</th>
		</tr>
		<%
			for(Member m : list){
		%>
			<tr>
				<td><%=m.getMemberNo()%></td>
				<td><%=m.getMemberId()%></td>
				<td><%=m.getMemberLevel()%></td>
				<td><%=m.getMemberName()%></td>
				<td><%=m.getUpdatedate()%></td>
				<td><%=m.getCreatedate()%></td>
				<td><a href="<%=request.getContextPath()%>/admin/member/updateMemberLevelForm.jsp?memberNo=<%=m.getMemberNo()%>&memberId=<%=m.getMemberId()%>&memberName=<%=m.getMemberName()%>">수정</a></td>
				<td><a href="<%=request.getContextPath()%>/admin/member/deleteMemberAction.jsp?memberNo=<%=m.getMemberNo()%>">삭제</a></td>
			</tr>
		<%
			} 
		%>	
	</table>
	<!-- 멤버 페이징 -->
	<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=1" style="text-decoration: none;">처음</a>
		<%
			if(currentPage > 1) {
		%>
				<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=<%=currentPage-1%>" style="text-decoration: none;">이전</a>
		<%
			}
		%>
		<span><%=currentPage%></span>
		<%
			if(currentPage < lastPage){
		%>
				<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=<%=currentPage+1%>" style="text-decoration: none;">다음</a>
		<%		
			}
		%>
	<a href="<%=request.getContextPath()%>/admin/member/memberList.jsp?currentPage=<%=lastPage%>" style="text-decoration: none;">마지막</a>
	<br>
	<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">이전</a>
</body>
</html>
