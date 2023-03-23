<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 1. Controller
	
	// 로그인 x -> 로그인창으로 돌려보냄
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 현재 로그인한 사람
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();
	
	// request 년 + 월
	int year = 0;
	int month = 0;
	
	// 둘 중 하나라도 지정되지 않으면 오늘 날짜 출력
	if(request.getParameter("year") == null || request.getParameter("month") == null){
		Calendar today = Calendar.getInstance();	//오늘 날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);	// 0 ~ 11
	}else{
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// 이전달 클릭 -> year, month-1 / 다음달 클릭 -> year, month+1
		// month == -1 or 12 라면
		if(month == -1){	// 1월에서 이전 누르면
			month = 11;		// 12월
			year--;			// 작년
		}
		if(month == 12){	// 12월에서 다음 누르면
			month = 0;		// 1월
			year++;			// 내년
		}
	}
	
	// 출력하려는 년, 월, 월별 1일의 요일(1~7:일~월)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	// 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK);
	// 월별 마지막 날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);
	// beginBlank 개수는 firstDay - 1
	int beginBlank = firstDay-1;
	int endBlank = 0;	// 7로 나누어 떨어지게끔
	if((beginBlank + lastDate) % 7 != 0){
		endBlank = 7 - ((beginBlank + lastDate) % 7);	
	}
	
	// 전체 td 개수 : 7로 나누어 떨어져야
	int totalTd = beginBlank + lastDate + endBlank;
	
	// 2. Model 호출
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMemberId, year, month+1);	//month: 0~11
																			// loginMemberId의 정보만 가져오기 때문에 view 부분은 수정하지 않아도 된다
	
																			
	// 3. View: 달력 + 일별 cash 목록
%>
<!DOCTYPE html>
<html>
<head>
	<!-- Basic Page Info -->
	<meta charset="utf-8">
	<title>DeskApp - Bootstrap Admin Dashboard HTML Template</title>

	<!-- inc -->
	<jsp:include page="/inc/cash.jsp"></jsp:include>
	
	<style>
	
		table {
			border-collapse: collapse;
			
		}
		
		td {
			border: 1px solid gray; 
			padding: 3px; 
			width: 250px; 
			height: 150px;
			vertical-align: top;		
		}
		
		th { background-color: #dddddd; 
			border: 1px solid gray; 
			font-weight: bold; 
			height: 30px;
		}
		
		td:nth-child(1), th:nth-child(1) {color:red;}
		td:nth-last-child(1), th:nth-last-child(1) {color:blue;}
	</style>
	
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
	
	<!--  메인 페이지 시작 -->
	<div class="mobile-menu-overlay"></div>
	<div class="main-container">
		<div class="pd-ltr-20 xs-pd-20-10">
			<div class="min-height-200px">
				<div class="page-header">
					<div class="row">
						<div class="col-md-6 col-sm-12">
							<div class="title">
							
								<!--  메인페이지 목차 -->
								<h4>가계부</h4>
							</div>
							<nav aria-label="breadcrumb" role="navigation">
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
									<li class="breadcrumb-item active" aria-current="page">가계부</li>
								</ol>
							</nav>
						</div>
					</div>
				</div>
				
				<!-- 메인페이지 내용 -->
				<div class="pd-20 card-box mb-30">
				
					<div style="text-align : center;">
						<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>"><i class="icon-copy ion-chevron-left btn btn-primary"></i></a>
						<%=year%>년 <%=month+1%>월
						<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>"><i class="icon-copy ion-chevron-right btn btn-primary"></i></a>
					</div>
					<br>
					
						<!-- 달력 -->
					<div>
						<table>
							<thead>
							<tr style="text-align : center;">
								<th>일</th>
								<th>월</th>
								<th>화</th>
								<th>수</th>
								<th>목</th>
								<th>금</th>
								<th>토</th>
							</tr>
							</thead>
							<tr>
							<%
								for(int i=1; i <= totalTd; i++){
							%>
									<td>
							<%
										int date = i - beginBlank;
										if( date > 0 && date <= lastDate){
										%>
											<div>
												<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
													<span><%=date%></span>
												</a>
											</div>
											<div>
												<%
													// 해당 년월에 있는 일수를 date와 비교
													for(HashMap<String, Object> m : list){
														String cashDate = (String)(m.get("cashDate"));
														if(Integer.parseInt(cashDate.substring(8)) == date){
												%>
															<div>
															[<%=(String)m.get("categoryKind")%>]
															<%=(String)m.get("categoryName")%>
															<%=(Long)m.get("cashPrice")%>원
															</div>
												<%
														}
													}
												%>
											</div>
										<%
										}
							%>
				
									</td>
							<%
									if(i % 7 == 0 && i != totalTd){	//주마다 줄 바꾸기
								%>	
										</tr><tr>
								<%
									}
								}
							%>
							</tr>
						</table>
					</div>
				</div>
			</div>
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
	<script src="../resources/src/plugins/fullcalendar/fullcalendar.min.js"></script>
	<script src="../resources/vendors/scripts/calendar-setting.js"></script>
</body>
</html>