<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 인코딩
	request.setCharacterEncoding("UTF-8");

	// 로그인 x -> 로그인창으로 돌려보냄
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 현재 로그인한 사람
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();
		
	// 페이징
	NoticeDao noticeDao = new NoticeDao();
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	int lastPage = (int)Math.ceil(noticeDao.selectNoticeCount()/(double)rowPerPage);
	System.out.println(lastPage);	// 디버깅
	
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);

%>
<!DOCTYPE html>
<html>
<head>
	<!-- Basic Page Info -->
	<meta charset="utf-8">
	<title>인덱스</title>

</head>
<body>
	<div>
		Welcome back <%=loginMemberName%> 님
		<p>가계부를 시작합니다</p>
	</div>				
	<!--  메인페이지  -->
	<div>
		<h4>공지사항</h4>	
		<table>
			<thead>
				<tr>
					<th>내용</th>
					<th>날짜</th>
				</tr>
				<%
					for(Notice n : list){
				%>
						<tr>
							<td><%=n.getNoticeMemo()%></td>
							<td><%=n.getCreatedate()%></td>
						</tr>
				<%
					}
				%>
			</thead>
		</table>
		
		<!--  페이징 -->
		<a href="<%=request.getContextPath()%>/index.jsp?currentPage=1"><i class="fa fa-angle-double-left"></i></a>
		<%
			if(currentPage > 1){
		%>
				<a href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
		%>
		<span><%=currentPage%></span>
		<%
			if(currentPage < lastPage){
		%>
				<a href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}
		%>
		<a  href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=lastPage%>"><i class="fa fa-angle-double-right"></i></a>
	</div>
</body>
</html>