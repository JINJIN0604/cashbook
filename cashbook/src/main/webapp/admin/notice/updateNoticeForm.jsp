<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import ="dao.*" %>
<%@ page import ="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	
	
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/admin/notice/noticeList.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	NoticeDao noticeDao = new NoticeDao();
	Notice notice = noticeDao.selectNoticeByNo(noticeNo);

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>마이페이지</title>
</head>
<body>
	<div>
		<h1>공지사항수정</h1>
			<form action="<%=request.getContextPath()%>/admin/notice/updateNoticeAction.jsp">
				<table>
					<tr>
						<th>공지사항수정</th>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea name="noticeMemo" cols="50" rows="20"><%=notice.getNoticeMemo()%></textarea></td>
					</tr>
				</table>
				<input type="hidden" name="noticeNo" value="<%=notice.getNoticeNo()%>">
				<button type="submit">수정</button>
			</form>
		<div>
			<a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp">뒤로가기</a>
		</div>
	</div>
</body>
</html>