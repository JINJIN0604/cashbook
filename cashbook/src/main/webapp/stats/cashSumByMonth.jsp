<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@page import="java.util.*"%>
<%
Member loginMember= (Member)session.getAttribute("loginMember");
String memberId= loginMember.getMemberId();

int year=0;
if(request.getParameter("year")==null){
	Calendar c= Calendar.getInstance();
	year=c.get(Calendar.YEAR);
}else{
	year=Integer.parseInt(request.getParameter("year"));
}
String category=request.getParameter("category");

CashDao cashDao= new CashDao();
ArrayList<HashMap<String,Object>> list= cashDao.selectCashSumByMonth(memberId, year);

HashMap<String, Object> map=cashDao.selectMaxMinYear(memberId);
int minYear=(Integer)(map.get("minYear"));
int maxYear=(Integer)(map.get("maxYear"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=year%>년 월별 <%=category %> 합계</h1>
	<table>
		<tr>
			<td>월</td>
			<td>카운트</td>
			<td><%=category %> 합계
			/<%=category %> 평균</td>
		</tr>
		<%
			for(HashMap<String,Object> m:list){
		%>		
				<tr>
					<td><%=m.get("month")%></td>
					<td>
						<%
							if(category.equals("수입")){
						%>	
							<%=m.get("importCashCount") %>
						<%	
						} else{
						%>	
							<%=m.get("exportCashCount") %>
						<%	
						}
						%>
					</td>
					<td>
						<%
							if(category.equals("수입")){
						%>		
								<%=m.get("importCashSum") %>
								/ <%=m.get("importCashAvg") %>
									
						<%		
							}else{
						%>		
								<%=m.get("exportCashSum") %>
								/ <%=m.get("exportCashAvg") %>
						<%		
							}
						%>
					</td>
				</tr>	
		<%		
			}
		%>
	
	</table>
	<%
		if(year>minYear){
	%>
		<a href="<%=request.getContextPath()%>/cashSumByMonth.jsp?category=<%=category%>&year=<%=year-1%>"> 이전</a>
	<%	
		}
			
	%>
	<%
		if(year<maxYear){
	%>
		<a href="<%=request.getContextPath()%>/cashSumByMonth.jsp?category=<%=category%>&year=<%=year+1%>"> 다음</a>
	<%	
		}
			
	%>


</body>
</html>
