<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// C
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { 
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 현재 로그인한 사람

	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();
	
	
	// 파라메터 유효성 검사
	if(request.getParameter("memberNo") == null){
		response.sendRedirect(request.getContextPath()+"/admin/member/memberList.jsp");
		return;
	}
	
	String updateMemberNo = request.getParameter("memberNo");
	String updateMemberId = request.getParameter("memberId");
	String updateMemberName = request.getParameter("memberName");


	
	// M -> 수정할 정보 가져오기
	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMemberByAdmin(updateMemberId);


	
%>

<!DOCTYPE html>
<html>
<head>
	<!-- Basic Page Info -->
	<meta charset="utf-8">
	<title>마이페이지</title>

	<!-- Site favicon -->
	<link rel="apple-touch-icon" sizes="180x180" href="../../resources/vendors/images/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="../../resources/vendors/images/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="../../resources/vendors/images/favicon-16x16.png">

	<!-- Mobile Specific Metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
	<!-- CSS -->
	<link rel="stylesheet" type="text/css" href="../../resources/vendors/styles/core.css">
	<link rel="stylesheet" type="text/css" href="../../resources/vendors/styles/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="../../resources/vendors/styles/style.css">

	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-119386393-1"></script>
	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag(){dataLayer.push(arguments);}
		gtag('js', new Date());

		gtag('config', 'UA-119386393-1');
	</script>
</head>
<body>
	<div class="header">
		<div class="header-left">
			<div class="menu-icon dw dw-menu"></div>
			<div class="search-toggle-icon dw dw-search2" data-toggle="header_search"></div>
			<div class="header-search">
			</div>
		</div>
		<div class="header-right">

			<div class="user-info-dropdown">
				<div class="dropdown">
					<a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown">
						<span class="user-icon">
							<img src="../../resources/vendors/images/photo4.jpg" alt="">
						</span>
						<!-- 로그인 정보(세션 loginMember 변수) -->
						<span><%=loginMemberName%> 님 </span>
					</a>
					<div class="dropdown-menu dropdown-menu-right dropdown-menu-icon-list">
						<a class="dropdown-item" href="<%=request.getContextPath()%>/member/memberList.jsp"><i class="dw dw-user1"></i> 마이페이지</a>
						<a class="dropdown-item" href="<%=request.getContextPath()%>/help/helpList.jsp"><i class="dw dw-question-1"></i> 고객센터</a>
						<a class="dropdown-item" href="<%=request.getContextPath()%>/logout.jsp"><i class="dw dw-logout"></i> 로그아웃</a>
					</div>
				</div>
			</div>
			<div class="github-link">
				<a href="https://github.com/dropways/deskapp" target="_blank"><img src="../../resources/vendors/images/github.svg" alt=""></a>
			</div>
		</div>
	</div>
	<!--  카테고리 -->
	<div class="left-side-bar">
		<div class="brand-logo">
			<a href="<%=request.getContextPath()%>/index.jsp">
				<img src="../../resources/vendors/images/deskapp-logo-white.svg" alt="" class="light-logo">
			</a>
			<div class="close-sidebar" data-toggle="left-sidebar-close">
				<i class="ion-close-round"></i>
			</div>
		</div>		
		<div class="menu-block customscroll">
			<div class="sidebar-menu">
				<ul id="accordion-menu">
					<li>
						<a href="<%=request.getContextPath()%>/index.jsp" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-house-1"></span><span class="mtext">홈</span>
						</a>
					</li>		
					<li>
						<a href="<%=request.getContextPath()%>/cash/cashList.jsp" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-calculator"></span><span class="mtext">가계부</span>

						</a>
					</li>
					<li>
						<a href="<%=request.getContextPath()%>/help/helpList.jsp" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-question-1"></span><span class="mtext">고객센터</span>
						</a>
					</li>
					<li>
						<a href="<%=request.getContextPath()%>/member/memberPage.jsp" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-user1"></span><span class="mtext">마이페이지</span>
						</a>
					</li>

					<li class="dropdown">
						<%
							if(loginMember.getMemberLevel() > 0) {
						%>
						<a href="javascript:;" class="dropdown-toggle">
							<span class="micon dw dw-user-13"></span><span class="mtext">관리자페이지</span>
						</a>
						<%	
							}
						%>
						<ul class="submenu">
							<li><a href="<%=request.getContextPath()%>/admin/adminMain.jsp">메인</a></li>
							<li><a href="<%=request.getContextPath()%>/admin/member/memberList.jsp">회원관리</a></li>
							<li><a href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp">공지관리</a></li>
							<li><a href="<%=request.getContextPath()%>/admin/comment/helpListAll.jsp">고객센터관리</a></li>
							<li><a href="<%=request.getContextPath()%>/admin/category/categoryList.jsp">카테고리관리</a></li>						
						</ul>
					</li>			
				</ul>
			</div>
		</div>
	</div>
	<!--  메인 페이지 시작 -->
	<div class="mobile-menu-overlay"></div>
		<div class="main-container">
		<div class="pd-ltr-20 xs-pd-20-10">
			<div class="min-height-200px">
				<div class="page-header">
					<div class="row">
						<div class="col-md-6 col-sm-12">
							<div class="title">
								<!--  관리자페이지 목차 -->
								<h4>관리자페이지</h4>
							</div>
							<nav aria-label="breadcrumb" role="navigation">
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
									<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/admin/adminMain.jsp">메인</a></li>
									<li class="breadcrumb-item active" aria-current="page">회원관리</li>
								</ol>
							</nav>
						</div>
						<div class="col-md-6 col-sm-12 text-right">
							<div class="dropdown">
								<a class="btn btn-primary dropdown-toggle" href="<%=request.getContextPath()%>/admin/adminMain.jsp" role="button" data-toggle="dropdown">
									관리자페이지
								</a>
								<div class="dropdown-menu dropdown-menu-right">
									<a class="dropdown-item" href="<%=request.getContextPath()%>/admin/adminMain.jsp">메인</a>
									<a class="dropdown-item" href="<%=request.getContextPath()%>/admin/member/memberList.jsp">회원관리</a>
									<a class="dropdown-item" href="<%=request.getContextPath()%>/admin/notice/noticeList.jsp">공지사항관리</a>
									<a class="dropdown-item" href="<%=request.getContextPath()%>/admin/comment/helpListAll.jsp">고객센터관리</a>
									<a class="dropdown-item" href="<%=request.getContextPath()%>/admin/category/categoryList.jsp">카테고리관리</a>
								</div>
							</div>
						</div>											
					</div>
				</div>		
				<div class="pd-20 card-box mb-30">
					<div class="clearfix mb-20">
						<div class="pull-left">
							<h4 class="text-blue h4">회원레벨수정</h4>
							<br>
						</div>
					</div>
					<form action="<%=request.getContextPath()%>/admin/member/updateMemberLevelAction.jsp" method="post">
						<table class="table table-bordered">
							<thead>
								<tr>
									<td>회원번호</td>
									<td>
										<input type="text" name="memberNo" value="<%=member.getMemberNo()%>" style="border:none;" readonly="readonly">
									</td>
								</tr>
								<tr>
									<td>회원 ID</td>
									<td>
										<input type="text" name="memberId" value="<%=updateMemberId%>" style="border:none;" readonly="readonly">
									</td>
								</tr>
								<tr>
									<td>회원닉네임</td>
									<td>
										<input type="text" name="memberName" value="<%=updateMemberName%>" style="border:none;" readonly="readonly">
									</td>
								</tr>
								<tr>
									<td>회원 레벨</td>
									<td>
										<%
											if(member.getMemberLevel() == 1){
										%>
												<input type="radio" name="memberLevel" value="0">일반회원
												<input type="radio" name="memberLevel" value="1" checked="checked">관리자
										<%
											} else {
										%>	
												<input type="radio" name="memberLevel" value="0" checked="checked">일반회원
												<input type="radio" name="memberLevel" value="1">관리자
										<%
											}
										%>
									</td>
								</tr>
							</thead>
						</table>	
						<div style="text-align : center;">		
							<button type="submit" class="btn btn-outline-primary">수정</button>
						</div>
					</form>
				</div>
			</div>	
			<!--  부트스트랩 디자이너 링크 -->
			<div class="footer-wrap pd-20 mb-20 card-box">
				DeskApp - Bootstrap 4 Admin Template By <a href="https://github.com/dropways" target="_blank">Ankit Hingarajiya</a>
			</div>
		</div>
	</div>
	
	<!-- js -->
	<script src="../../resources/vendors/scripts/core.js"></script>
	<script src="../../resources/vendors/scripts/script.min.js"></script>
	<script src="../../resources/vendors/scripts/process.js"></script>
	<script src="../../resources/vendors/scripts/layout-settings.js"></script>	 		
</body>
</html>