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

	<!-- Site favicon -->
	<link rel="apple-touch-icon" sizes="180x180" href="resources/vendors/images/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="resources/vendors/images/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="resources/vendors/images/favicon-16x16.png">

	<!-- Mobile Specific Metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
	<!-- CSS -->
	<link rel="stylesheet" type="text/css" href="resources/vendors/styles/core.css">
	<link rel="stylesheet" type="text/css" href="resources/vendors/styles/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="resources/src/plugins/datatables/css/dataTables.bootstrap4.min.css">
	<link rel="stylesheet" type="text/css" href="resources/src/plugins/datatables/css/responsive.bootstrap4.min.css">
	<link rel="stylesheet" type="text/css" href="resources/vendors/styles/style.css">

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
		</div>
		<div class="header-right">

			<div class="user-info-dropdown">
				<div class="dropdown">
					<a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown">
						<span class="user-icon">
							<img src="resources/vendors/images/photo4.jpg" alt="">
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
				<a href="https://github.com/dropways/deskapp" target="_blank"><img src="resources/vendors/images/github.svg" alt=""></a>
			</div>
		</div>
	</div>
	
	<!--  카테고리 -->
	<div class="left-side-bar">
		<div class="brand-logo">
			<a href="<%=request.getContextPath()%>/index.jsp">
				<img src="resources/vendors/images/deskapp-logo-white.svg" alt="" class="light-logo">
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
	<div class="mobile-menu-overlay"></div>
		<div class="main-container">
			<div class="pd-ltr-20">
				<div class="card-box pd-20 height-100-p mb-30">
					<div class="row align-items-center">
						<div class="col-md-4">
							<img src="resources/vendors/images/banner-img.png" alt="">
						</div>
						<div class="col-md-8">
							<h4 class="font-20 weight-500 mb-10 text-capitalize">
								Welcome back <div class="weight-600 font-30 text-blue"><%=loginMemberName%> 님!</div><br>
							</h4>
							<p class="font-18 max-width-600">신입개발자 김설의 첫번째 가계부 프로젝트입니다.</p>
						</div>
					</div>
				</div>
				<div class="pd-20 card-box mb-30">
					<div class="clearfix mb-20">
						<div class="pull-left">
							<h4 class="text-blue h4">공지사항</h4>
							<br>
						</div>
					</div>
					<table class="table table-bordered">
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
						
					<!-- 문의사항 페이징 -->
					<div style="text-align : center;" >
						<a href="<%=request.getContextPath()%>/index.jsp?currentPage=1" class="btn btn-primary" style="text-align: center;">처음</a>
							<%
								if(currentPage > 1) {
							%>
									<a href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage-1%>" class="btn btn-outline-primary" style="text-align: center;"><span class="icon-copy ti-angle-left"></span></a>
							<%
								}
							%>
							<span><%=currentPage%></span>
							<%
								if(currentPage < lastPage){
							%>
									<a href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage+1%>" class="btn btn-outline-primary" style="text-align: center;"><span class="icon-copy ti-angle-right"></span></a>
							<%		
								}
							%>
						<a href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=lastPage%>" class="btn btn-primary" >마지막</a>
					</div>
				</div>	
			<!--  부트스트랩 디자이너 링크 -->
			<div class="footer-wrap pd-20 mb-20 card-box">
				DeskApp - Bootstrap 4 Admin Template By <a href="https://github.com/dropways" target="_blank">Ankit Hingarajiya</a>
			</div>
		</div>
	</div>

	<!-- js -->
	<script src="resources/vendors/scripts/core.js"></script>
	<script src="resources/vendors/scripts/script.min.js"></script>
	<script src="resources/vendors/scripts/process.js"></script>
	<script src="resources/vendors/scripts/layout-settings.js"></script>
</body>
</html>