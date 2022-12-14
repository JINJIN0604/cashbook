<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 1
	request.setCharacterEncoding("UTF-8");	//한글 인코딩
	
	// 로그인 x -> 로그인창으로 돌려보냄
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 알림 메시지
	String msg = null;

	// 현재 로그인한 사람
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();

%>
<!DOCTYPE html>
<html>
<head>

	<meta charset="utf-8">
	<title>마이페이지</title>

</head>
<body>
	<div>
		<!--  회원탈퇴시작 -->
		<div>회원탈퇴를 원하면 비밀번호를 입력하세요.</div>
			<!-- msg 파라메타값이 있으면 출력 -->
			<%
				msg = request.getParameter("msg");
				if(msg != null) {
			%>
					<div><%=msg%></div>
			<%		
				}
			%>
			<h2>회원탈퇴</h2>
			<form method="post" action="<%=request.getContextPath()%>/member/deleteMemberAction.jsp">
				<table>
					<tr>
						<td>아이디</td>
						<td><input type="text" name="memberId" value="<%=loginMember.getMemberId()%>" readonly="readonly"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="memberPw"></td>
					</tr>
				</table>
				<button type="submit">삭제</button>
			</form>
	</div>
</body>
</html>