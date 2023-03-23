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
	
	// 현재 로그인한 사람
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();

	// 방어코드 - 일자 안 눌렀으면 오늘 날짜가 있는 가계부로
	if(request.getParameter("year") == null || request.getParameter("year").equals("")
		|| request.getParameter("month") == null || request.getParameter("month").equals("")
		|| request.getParameter("date") == null || request.getParameter("date").equals("")){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	System.out.println("중간 확인");
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	System.out.println(year+"View 전 년");
	System.out.println(month+"View 전 월");
	System.out.println(date+"View 전 일");
	
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList(); // 2
	
	for(Category c : categoryList){
		System.out.println(c.getCategoryKind() + " <--- 확인");
	}
	
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao. selectCashListByMonth(loginMember.getMemberId(), year, month); // 2
	
	// 3
%>
<!DOCTYPE html>
<html>
<head>
	<!-- 페이지 정보 -->
	<meta charset="utf-8">
	<title>가계부 작성</title>

	<!-- Site favicon -->
	<link rel="apple-touch-icon" sizes="180x180" href="../resources/vendors/images/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="../resources/vendors/images/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="../resources/vendors/images/favicon-16x16.png">
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
	
	<!--  카테고리 -->
	<div class="left-side-bar">
		<div class="brand-logo">
			<a href="<%=request.getContextPath()%>/index.jsp">
				<img src="../resources/vendors/images/deskapp-logo-white.svg" alt="" class="light-logo">
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
	<div class="main-container">
		<div class="pd-ltr-20 xs-pd-20-10">
			<div class="min-height-200px">
				<div class="page-header">
					<div class="row">
						<div class="col-md-6 col-sm-12">
							<div class="title">
								<h4>가계부작성</h4>
							</div>
							<nav aria-label="breadcrumb" role="navigation">
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
									<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/cash/cashList.jsp">가계부</a></li>
									<li class="breadcrumb-item active" aria-current="page">가계부작성</li>
								</ol>
							</nav>
						</div>
					</div>
				</div>
				<div class="pd-20 card-box mb-30">
					<div class="clearfix">
						<div class="pull-left">
							<h4 class="text-blue h4"><%=year%>년 <%=month%>월 <%=date%>일</h4>
						</div>
					</div>
					<br>
					<div>
						<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
							<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
							<input type="hidden" name="year" value="<%=year%>">
							<input type="hidden" name="month" value="<%=month%>">
							<input type="hidden" name="date" value="<%=date%>">
							<div class="form-group">
								<label>날짜</label>
								<input class="form-control" type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
							</div>	
							<div class="form-group">
								<label>분류</label>
									<select name="categoryNo" class="form-control">
									<%
										for(Category c : categoryList){
									%>
											<option value="<%=c.getCategoryNo()%>">
												<%=c.getCategoryKind()%>
												&nbsp;
												<%=c.getCategoryName()%>
											</option>
									<%
										}
									%>
									</select>
							</div>			
							<div class="form-group">
								<label>금액</label>
								<input class="form-control" type="number" name="cashPrice">
							</div>			
							<div class="form-group">
								<label>내용</label>
								<textarea class="form-control" name="cashMemo"></textarea>
							</div>
							<div style="text-align : center;">		
								<button type="submit" class="btn btn-outline-primary">등록</button>
							</div>
						</form>
					</div>	
				</div>
				<div class="pd-20 card-box mb-30">
					<div>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th scope="col">수입/지출</th>
									<th>분류</th>
									<th>금액</th>
									<th>내용</th>
									<th>수정</th>
									<th>삭제</th>
								</tr>
								<%
									for(HashMap<String, Object> m : list){
										String cashDate = (String)(m.get("cashDate"));
										// 디버깅 
										System.out.println(cashDate.substring(0, 4));
										System.out.println(cashDate.substring(5, 7));
										//if(cashDate.substring(0, 7).equals(year+"-"+month) && Integer.parseInt(cashDate.substring(8)) == date){ ----- 월에도 0 붙고 안 붙고 있음
										if(Integer.parseInt(cashDate.substring(0, 4)) == year && Integer.parseInt(cashDate.substring(5, 7)) == month && Integer.parseInt(cashDate.substring(8)) == date){
											%>
											<tr>
												<td>[<%=(String)m.get("categoryKind")%>]</td>
												<td><%=(String)m.get("categoryName")%></td>
												<td><%=(Long)m.get("cashPrice")%>원</td>
												<td><%=(String)m.get("cashMemo")%></td>
												<% 
													int cashNo = (Integer)m.get("cashNo");
													System.out.println(cashNo + "<--캐시번호");
												%>
												<td>
													<a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month%>&date=<%=date%>" class="btn btn-success">수정</a>
												</td>
												<td>
													<a href="<%=request.getContextPath()%>/cash/deleteCash.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month%>&date=<%=date%>" class="btn btn-danger">삭제</a>
												</td>
											<tr>
						
											<%
										}
									}
							%>
						</table>
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
