<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 1
	
	// 로그인x -> 접근 불가
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 현재 로그인한 사람
	Member loginMember = (Member)session.getAttribute("loginMember");

	
	String msgCurrentPw = request.getParameter("msgCurrentPw");
	String msgUpdatePw = request.getParameter("msgUpdatePw");
%>
<!DOCTYPE html>
<html>
	<meta charset="utf-8">
	<title>마이페이지 - 비밀번호 변경</title>
</head>
<body>
<body>
	<div>
		<form method="post" action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp">
			<table>
				<tr>
					<td>현재 비밀번호</td>
					<td>
						<input type="password" name="currentPw">
						<%
							if(msgCurrentPw != null){
						%>
								<span><%=msgCurrentPw%></span>
						<%
							}
						%>
					</td>
				</tr>
				<tr>
					<td>새 비밀번호</td>
					<td>
						<input type="password" name="updatePw">
					</td>
				</tr>
				<tr>
					<td>새 비밀번호 확인</td>
					<td>
						<input type="password" name="updatePwCheck">
						<%
							if(msgUpdatePw != null){
						%>
								<span><%=msgUpdatePw%></span>
						<%
							}
						%>
					</td>
				</tr>
			</table>
			<button type="submit">비밀번호 변경</button>
		</form>
	</div>
</body>
</html>
