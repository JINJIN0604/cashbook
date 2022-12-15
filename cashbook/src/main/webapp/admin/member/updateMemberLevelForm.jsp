<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*"%>
<%
	// C
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { 
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
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
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	
	<body>
		<div>
			<h2>회원레벨수정</h2>
		</div>
		
		<form action="<%=request.getContextPath()%>/admin/member/updateMemberLevelAction.jsp" method="post">
			<table border="1">
				<tr>
					<th><span>회원번호</span></th>
					<td><input type="text" name="memberNo" value="<%=member.getMemberNo()%>" readonly="readonly"></td>
				</tr>
				<tr>
					<th><span>회원ID</span></th>
					<td><input type="text" name="memberId" value="<%=updateMemberId%>" readonly="readonly"></td>
				</tr>
				<tr>
					<th><span>회원닉네임</span></th>
					<td><input type="text" name="memberName" value="<%=updateMemberName%>" readonly="readonly"></td>
				</tr>
				<tr>
					<th>회원 레벨</th>
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
			</table>
			<button type="submit">전송</button>
		</form>
	</body>
	
</html>