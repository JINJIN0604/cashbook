<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*"%>
<%
Member loginMember = (Member)session.getAttribute("loginMember");
if(loginMember == null || loginMember.getMemberLevel() < 1){ // 세션 정보가 없거나, 세션에 저장된 멤버 레베이 1보다 작은 경우
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
}

%>
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
							<span class="micon dw dw-user-13"></span><span class="mtext">관리자페이지</span>
						</a>
				<%	
					}
				%>
			</li>				
		</ul>
	</div>
</div>