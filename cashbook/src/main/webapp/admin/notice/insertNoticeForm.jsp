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
	// 현재 로그인한 사람
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();

%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>관리자-공지추가</title>
</head>
<body>
	<div>
	<h1>공지사항입력</h1>
		<form action="<%=request.getContextPath()%>/admin/notice/insertNoticeAction.jsp">
			<table>
				<tr>
					<th>내용</th>
					<td><textarea rows="20" cols="50" name="noticeMemo"></textarea></td>
				</tr>
			</table>
			<button type="submit">입력</button>
		</form>
		<div>
			<a href="<%=request.getContextPath()%>/admin/notice/noticeLis.jsp">뒤로가기</a>
		</div>
	</div>
</body>
</html>