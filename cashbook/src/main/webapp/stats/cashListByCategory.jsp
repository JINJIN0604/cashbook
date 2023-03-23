<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
Member loginMember= (Member)session.getAttribute("loginMember");
String memberId= loginMember.getMemberId();
String category=request.getParameter("category");
//System.out.println(category+"<=지출/수입");
CashDao cashDao= new CashDao();
ArrayList<HashMap<String,Object>> list=cashDao.selectCashListByCategory(memberId);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="<%=request.getContextPath()%>/index.jsp">인덱스</a>
	<h1><%=category %> 합계 목록</h1>
	<table>
		<tr>
			<td>년</td>
			<td>합계</td>
			<td>1회 평균 사용 금액</td>
		</tr>
		<%
			for(HashMap<String,Object> m:list){
		%>		
			<tr>
				<td><%=m.get("year") %></td>
				<td>
					<%
						if(category.equals("수입")){
					%>		
							<span style="color: blue;"> +
							<%=m.get("importCashSum") %>
					<%		
						}else {
					%>		
							<span style="color: red;"> -
							<%=m.get("exportCashSum") %>
					<%	
						}
					%>
				</td>
				<td>
					<%
						if(category.equals("수입")){
					%>		
							<span style="color: blue;"> +
							<%=m.get("importCashAvg") %>
					<%		
						}else{
					%>		
							<span style="color: red;"> -
							<%=m.get("exportCashAvg") %>
					<%	
						}
					%>
					
				</td>
			</tr>	
		<%		
			}
		%>
		
	</table>

</body>
</html>
