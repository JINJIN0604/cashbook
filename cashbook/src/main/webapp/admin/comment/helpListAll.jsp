<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//1. Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// 현재 로그인한 사람
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();

	
	//알림 메시지
	String msg = null;
	
	request.setCharacterEncoding("UTF-8");
	
	// 2. Model 호출
	// 공지사항 목록 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 10;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	int count = 0;
	CommentDao commentDao = new CommentDao();
	count = commentDao.selectCommentCount(); // -> lastPage
	
	int lastPage = (int)Math.ceil((double)count / (double)ROW_PER_PAGE); //마지막 페이지 번호 구하기
	
	// 공지사항 목록 출력
	ArrayList<HashMap<String, Object>> list = commentDao.selectCommentList(beginRow, ROW_PER_PAGE);
	
	// 3. View
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

	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
	<!-- CSS -->
	<link rel="stylesheet" type="text/css" href="../../resources/vendors/styles/core.css">
	<link rel="stylesheet" type="text/css" href="../../resources/vendors/styles/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="../../resources/vendors/styles/style.css">
</head>
<body>
	<div class="header">
		<div class="header-left">
			<div class="menu-icon dw dw-menu"></div>
				<div class="search-toggle-icon dw dw-search2" data-toggle="header_search"></div>
					<div class="header-search"></div>
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
											<li class="breadcrumb-item active" aria-current="page">고객센터관리</li>
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
									<h4 class="text-blue h4">고객센터</h4>
									<br>
								</div>
							</div>
							
							
							<!-- msg 파라메타값이 있으면 출력 -->
							<%
								msg = request.getParameter("msg");
								if(request.getParameter("msg") != null) {
							%>
									<div><%=msg%></div>
							<%		
								}
							%>
							<table class="table table-bordered">
								<thead>
								<tr>
									<th scope="col">번호</th>
									<th>문의내용</th>
									<th>문의ID</th>									
									<th>작성일</th>									
									<th>답변내용</th>							
									<th>답변일</th>
									<th>상태</th>
								</tr>
								</thead>
								<%
									for(HashMap<String, Object> m : list){
								%>		
								<tr>
									<td><%=(Integer)m.get("helpNo")%></td>
									<td><%=(String)m.get("helpMemo")%></td>
									<td><%=(String)m.get("helpMemberId")%></td>
									
									<td><%=(String)m.get("helpCreatedate")%></td>

									<td>
										<%
											if(m.get("commentMemo") == null){
										%>
												답변전	
										<%		
											} else {
										%>
												<%=(String)m.get("commentMemo")%>
										<%
											}
										%>
									</td>

									<td>
										<%
											if(m.get("commentCreatedate") == null){
										%>
												답변전	
										<%		
											} else {
										%>
												<%=(String)m.get("commentCreatedate")%>
										<%
											}
										%>
									</td>
									<td>
										<%
											if(m.get("commentMemo") == null){
										%>
												<a href="<%=request.getContextPath()%>/admin/comment/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>&currentPage=<%=currentPage%>" class="btn btn-outline-primary">
													입력
												</a>	
										<%		
											} else {
										%>
												<a href="<%=request.getContextPath()%>/admin/comment/updateCommentForm.jsp?helpNo=<%=m.get("helpNo")%>&commentNo=<%=m.get("commentNo")%>&currentPage=<%=currentPage%>" class="btn btn-success">
													수정
												</a>
												<br>
												<br>
												<a href="<%=request.getContextPath()%>/admin/comment/deleteCommentAction.jsp?commentNo=<%=m.get("commentNo")%>&currentPage=<%=currentPage%>" class="btn btn-danger">
													삭제
												</a>		
										<%
											}
										%>
									</td>
								</tr>
							<%
								}
							%>
					</table>
				
					<!-- 페이징 -->
					<div style="text-align : center;" >
						<a href="<%=request.getContextPath()%>/admin/comment/commentList.jsp?currentPage=1" class="btn btn-outline-primary" style="text-align: center;">처음</a>
							<%
								if(currentPage > 1) {
							%>
									<a href="<%=request.getContextPath()%>/admin/comment/commentList.jsp?currentPage=<%=currentPage-1%>" class="btn btn-primary"><span class="icon-copy ti-angle-left"></span></a>
							<%
								}
							%>
							<span><%=currentPage%></span>
							<%
								if(currentPage < lastPage){
							%>
									<a href="<%=request.getContextPath()%>/admin/comment/commentList.jsp?currentPage=<%=currentPage+1%>" class="btn btn-primary"><span class="icon-copy ti-angle-right"></span></a>
							<%		
								}
							%>
						<a href="<%=request.getContextPath()%>/admin/comment/commentList.jsp?currentPage=<%=lastPage%>" class="btn btn-outline-primary" >마지막</a>
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
	<script src="../../resources/vendors/scripts/core.js"></script>
	<script src="../../resources/vendors/scripts/script.min.js"></script>
	<script src="../../resources/vendors/scripts/process.js"></script>
	<script src="../../resources/vendors/scripts/layout-settings.js"></script>
</body>
</html>
