<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//1
	if(session.getAttribute("loginMember") != null) {
		// 로그인되어 있다면
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	NoticeDao noticeDao = new NoticeDao();
%>
<!DOCTYPE html>
<html>
<head>
	<!-- Basic Page Info -->
	<meta charset="utf-8">
	<title>로그인</title>
</head>
<!--  페이지 상단 디자인 -->
<body>
	<div>
		<a href="<%=request.getContextPath()%>/index.jsp"></a>
	</div>

	<!--  로그인 페이지 -->
	<div>
		<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">

							<h2 >Login</h2>
							<div>
								<input type="text" name="memberId" placeholder="아이디를 입력하세요">
							</div>
							<div>
								<input type="password" name="memberPw" placeholder="**********">
							</div>
							<div>
								<button >로그인</button>
							</div>
							<div>OR</div>
								<div>
									<a href="<%=request.getContextPath()%>/member/signUpForm.jsp">회원가입</a>
								</div>
		</form>
	</div>
</body>
</html>