<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 1
	request.setCharacterEncoding("UTF-8");	//한글 인코딩
	
	// 로그인 x -> 로그인 창으로
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 현재 로그인
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();
	
	// 방어 코드 - 입력되지 않으면 폼으로 돌려보냄
	if(request.getParameter("memberName") == null || request.getParameter("memberName").equals("")
		|| request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")){
		response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp");
		return;
	}
		
	
	// 넘어온 정보 확인
	String memberId = request.getParameter("memberId");
	String memberName = request.getParameter("memberName");
	String memberPw = request.getParameter("memberPw");
	
	// 비밀번호 일치 매개 변수 / 수정한 session에 넣을 값이라 다 설정해줘야 함
	Member paramMember = new Member();
	paramMember.setMemberNo(loginMember.getMemberNo());
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	paramMember.setMemberName(memberName);
	paramMember.setMemberLevel(loginMember.getMemberLevel());
	paramMember.setUpdatedate(loginMember.getUpdatedate());
	paramMember.setCreatedate(loginMember.getCreatedate());
	
	
	MemberDao memberDao = new MemberDao();

	// 비밀번호 일치 확인
	int checkPw = memberDao.selectMemberPw(memberId, memberPw);   
	if(checkPw == 0){	// 비밀번호가 틀렸다면
		String msg = URLEncoder.encode("비밀번호를 정확하게 입력해 주세요.", "UTF-8");
		response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp?msg="+msg);
		return;
	}
	
	System.out.println("비밀번호 일치 확인 완료");
	
	System.out.println(paramMember.getMemberNo()+"번호 확인");
	System.out.println(paramMember.getMemberId()+"아이디 확인");
	System.out.println(paramMember.getMemberName()+"이름 확인");
	System.out.println(paramMember.getMemberPw()+"비밀번호 확인");
	
	// 정보 수정 수행
	int check = memberDao.selectMemberPw(memberId, memberPw);
	if(check == 1){
		System.out.println("회원정보 변경 성공");
		// 수정 성공 -> ★★★★★★★session에 저장된 값 바꾸기★★★★★★★
		session.setAttribute("loginMember", paramMember);
	}else {
		System.out.println("회원정보 변경 실패");
		String msg = URLEncoder.encode("회원 정보 변경에 실패하였습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp?msg="+msg);
		return;
	}

%>
<!DOCTYPE html>
<html>
<head>
	<!-- Basic Page Info -->
	<meta charset="utf-8">
	<title>마이페이지</title>

	<!-- Site favicon -->
	<link rel="apple-touch-icon" sizes="180x180" href="../resources/vendors/images/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="../resources/vendors/images/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="../resources/vendors/images/favicon-16x16.png">

	<!-- Mobile Specific Metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
	<!-- CSS -->
	<link rel="stylesheet" type="text/css" href="../resources/vendors/styles/core.css">
	<link rel="stylesheet" type="text/css" href="../resources/vendors/styles/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="../resources/vendors/styles/style.css">
</head>
<body>
	<div class="header">
		<div class="header-left">
			<div class="menu-icon dw dw-menu"></div>
			<div class="search-toggle-icon dw dw-search2" data-toggle="header_search"></div>
			<div class="header-search">
				<form>
					<div class="form-group mb-0">
						<i class="dw dw-search2 search-icon"></i>
						<input type="text" class="form-control search-input" placeholder="Search Here">
					</div>
				</form>
			</div>
		</div>
		<div class="header-right">

			<div class="user-info-dropdown">
				<div class="dropdown">
					<a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown">
						<span class="user-icon">
							<img src="../resources/vendors/images/photo4.jpg" alt="">
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
				<a href="https://github.com/dropways/deskapp" target="_blank"><img src="../resources/vendors/images/github.svg" alt=""></a>
			</div>
		</div>
	</div>
	<!--  회원이름 클릭시 나오는 목차 -->
	<div class="left-side-bar">
		<div class="brand-logo">
			<a href="<%=request.getContextPath()%>/index.jsp">
				<img src="../resources/vendors/images/deskapp-logo-white.svg" alt="" class="light-logo">
			</a>
			<div class="close-sidebar" data-toggle="left-sidebar-close">
				<i class="ion-close-round"></i>
			</div>
		</div>	
		<!--  카테고리 시작 -->
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
					<li>
						<%
							if(loginMember.getMemberLevel() > 0) {
						%>
								<a href="<%=request.getContextPath()%>/admin/adminMain.jsp" class="dropdown-toggle no-arrow">
									<span class="micon dw dw-user1"></span><span class="mtext">관리자페이지</span>
								</a>
						<%	
							}
						%>
					</li>				
				</ul>
			</div>
		</div>
	</div>
	<div class="mobile-menu-overlay"></div>
	<!--  메인 페이지 시작 -->
	<div class="main-container">
		<div class="pd-ltr-20 xs-pd-20-10">
			<div class="min-height-200px">
				<div class="page-header">
					<div class="row">
						<div class="col-md-6 col-sm-12">
							<div class="title">
								<!--  메인페이지 목차 -->
								<h4>마이페이지</h4>
							</div>
							<nav aria-label="breadcrumb" role="navigation">
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
									<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/member/memberPage.jsp">마이페이지</a></li>
									<li class="breadcrumb-item active" aria-current="page">닉네임변경</li>
								</ol>
							</nav>
						</div>
					</div>
				</div>
				<!--  메인페이지 상세내용 -->
				<div class="pd-20 card-box mb-30">
					<span>내 정보 변경에 성공했습니다.</span>
					<div>
						<a href="<%=request.getContextPath()%>/member/memberPage.jsp">내 정보로 돌아가기</a>
					</div>
				</div>
			</div>
				
			<!--  부트스트랩 디자이너 링크 -->
			<div class="footer-wrap pd-20 mb-20 card-box">
				DeskApp - Bootstrap 4 Admin Template By <a href="https://github.com/dropways" target="_blank">Ankit Hingarajiya</a>
			</div>
		</div>
	</div>
	<!-- js -->
	<script src="../resources/vendors/scripts/core.js"></script>
	<script src="../resources/vendors/scripts/script.min.js"></script>
	<script src="../resources/vendors/scripts/process.js"></script>
	<script src="../resources/vendors/scripts/layout-settings.js"></script>
</body>
</html>