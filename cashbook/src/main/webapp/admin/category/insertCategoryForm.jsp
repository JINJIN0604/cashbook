<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import ="java.util.*" %>
<%
	//c
	Member loginMember = (Member)session.getAttribute("loginmember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- msg 파라메타값이 있으면 출력 -->
	<%
		String msg = request.getParameter("msg");
		if(request.getParameter("msg") != null){
	%>
			<div><%=msg%></div>
	<%
		}
	%>
	<h1>카테고리추가</h1>
	<form action="<%=request.getContextPath()%>/admin/category/insertCategoryAction.jsp" method="post">
		<div>
			<table>
				<tr>
					<th>수입/지출</th>		
					<td>
						<input type="radio" name="categoryKind" value="수입">수입
						<input type="radio" name="categoryKind" value="지출">수입
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="categoryName"></td>
				</tr>
			</table>
			<a href="<%=request.getContextPath()%>/admin/category/categoryList.jsp">이전</a>
			<button type="submit">추가</button>	
		</div>		
	</form>
</body>
</html>