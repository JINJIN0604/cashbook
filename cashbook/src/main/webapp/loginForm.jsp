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
%>
<!DOCTYPE html>
<html>
<head>
	<!-- Basic Page Info -->
	<meta charset="utf-8">
	<title>로그인</title>

	<!-- 상단 네비메뉴 -->
	<jsp:include page="/inc/css.jsp"></jsp:include>
	
	<!--
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>		
	<script>
		$(document).ready(function(){
			$('#submitBtn').click(function(){
				if($('#loginId').val().length==0){
					alert('아이디를 입력해주세요.');
					$('#loginId').focus();
					return;
				}
				if($('#loginPw').val().length==0){
					alert('비밀번호를 입력해주세요.');
					$('#loginPw').focus();
					return;
				}
				$('#login').submit();
			});
		})
	</script> -->
</head>
<body class="login-page">
	<div class="login-header box-shadow">
		<div class="container-fluid d-flex justify-content-between align-items-center">
			<div class="brand-logo">
				<a href="login.html">
					<img src="resources/vendors/images/deskapp-logo.svg" alt="">
				</a>
			</div>
		</div>
	</div>
	<div class="login-wrap d-flex align-items-center flex-wrap justify-content-center">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-md-6 col-lg-7">
					<img src="resources/vendors/images/login-page-img.png" alt="">
				</div>
				<div class="col-md-6 col-lg-5">
					<div class="login-box bg-white box-shadow border-radius-10">
						<div class="login-title">
							<h2 class="text-center text-primary">CashBook</h2>
						</div>
						<div>
							<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post" id="login">
								<div class="select-role">
									<div class="btn-group btn-group-toggle" data-toggle="buttons">
										<label class="btn active">
											<input type="radio" name="options" id="admin">
											<div class="icon"><img src="resources/vendors/images/briefcase.svg" class="svg" alt=""></div>
											<span>I'm</span>
											 admin
										</label>
										<label class="btn">
											<input type="radio" name="options" id="user">
											<div class="icon"><img src="resources/vendors/images/person.svg" class="svg" alt=""></div>
											<span>I'm</span>
											customer
										</label>
									</div>
								</div>
								<div class="input-group custom">
									<input type="text" id="memberId" name="memberId" class="form-control form-control-lg" placeholder="아이디" >
									<div class="input-group-append custom">
										<span class="input-group-text"><i class="icon-copy dw dw-user1"></i></span>
									</div>
								</div>
								<div class="input-group custom">
									<input type="password" id="memberPw" name="memberPw" class="form-control form-control-lg" placeholder="비밀번호" >
									<div class="input-group-append custom">
										<span class="input-group-text"><i class="dw dw-padlock1"></i></span>
									</div>
								</div>
	
								<div class="row">
									<div class="col-sm-12">
										<div class="input-group mb-0">
											<button class="btn btn-primary btn-lg btn-block" type="submit" id="submitBtn">로그인</button>
										</div>
										<div class="font-16 weight-600 pt-10 pb-10 text-center" data-color="#707373">OR</div>
										<div class="input-group mb-0">
											<a class="btn btn-outline-primary btn-lg btn-block" href="<%=request.getContextPath()%>/member/signUpForm.jsp">회원가입</a>
										</div>	
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- js -->
		<jsp:include page="/inc/js.jsp"></jsp:include>
	</div>
</body>
</html>