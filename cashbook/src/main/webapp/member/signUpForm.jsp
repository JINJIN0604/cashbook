<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 1. C
	// session 유효성 검증 코드 후 필요하다면 redirect!
	if(session.getAttribute("loginMember") != null){
		// 로그인이 된 상태
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<!-- Basic Page Info -->
	<meta charset="utf-8">
	<title>회원가입</title>
	<!-- 상단 네비메뉴 -->
	<jsp:include page="/inc/css2.jsp"></jsp:include></head>

<!--  페이지 상단 디자인 -->
<body class="login-page">
	<div class="login-header box-shadow">
		<div class="container-fluid d-flex justify-content-between align-items-center">
			<div class="brand-logo">
				<a href="<%=request.getContextPath()%>/index.jsp">
					<img src="../resources/vendors/images/deskapp-logo.svg" alt="">
				</a>
			</div>
			<div class="login-menu">
				<ul>
					<li><a href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a></li>
				</ul>
			</div>
		</div>
	</div>
	
	<!--  회원가입 페이지-->
	<div class="login-wrap d-flex align-items-center flex-wrap justify-content-center">
		<form method="post" action="<%=request.getContextPath()%>/member/signUpAction.jsp">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-md-6 col-lg-7">
					<img src="../resources/vendors/images/register-page-img.png" alt="">
				</div>
				<div class="col-md-6 col-lg-5">
					<div class="login-box bg-white box-shadow border-radius-10">
						<div class="login-title">
							<h2 class="text-center text-primary">CashBook</h2>
						</div>
							<div class="input-group custom">
								<input type="text" name="memberId" class="form-control form-control-lg" placeholder="아이디를 입력하세요">
								<div class="input-group-append custom">
									<span class="input-group-text"><i class="icon-copy ion-android-checkbox-outline"></i></span>
								</div>
							</div>
							<div class="input-group custom">
								<input type="text" name="memberName" class="form-control form-control-lg" placeholder="이름을 입력하세요">
								<div class="input-group-append custom">
									<span class="input-group-text"><i class="icon-copy dw dw-user1"></i></span>
								</div>
							</div>
							<div class="input-group custom">
								<input type="password" name="memberPw" class="form-control form-control-lg" placeholder="비밀번호를 입력하세요">
								<div class="input-group-append custom">
									<span class="input-group-text"><i class="dw dw-padlock1"></i></span>
								</div>
							</div>
							<div>
								<button class="btn btn-primary btn-lg btn-block" type="submit">회원가입</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>				
	<!-- js -->
	<script src="../resources/vendors/scripts/core.js"></script>
	<script src="../resources/vendors/scripts/script.min.js"></script>
	<script src="../resources/vendors/scripts/process.js"></script>
	<script src="../resources/vendors/scripts/layout-settings.js"></script>
</body>
</html>