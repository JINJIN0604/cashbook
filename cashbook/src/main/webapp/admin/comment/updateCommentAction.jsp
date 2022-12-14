<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	//1. Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//알림 메시지
	String msg = null;
	
	request.setCharacterEncoding("UTF-8");
	
	int helpNo = 0;
	int commentNo = 0;
	String commentMemo = null;
	
	int currentPage = 0;
	
	// 방어코드
	if(request.getParameter("currentPage")== null || request.getParameter("currentPage").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/comment/updateCommentForm.jsp?helpNo="+helpNo+"&commentNo="+commentNo+"&msg="+msg+"&currentPage="+currentPage);
		return;
	} else {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	if(request.getParameter("helpNo")== null || request.getParameter("helpNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/comment/updateCommentForm.jsp?helpNo="+helpNo+"&commentNo="+commentNo+"&msg="+msg+"&currentPage="+currentPage);
		return;
	} else {
		helpNo = Integer.parseInt(request.getParameter("helpNo"));
	}
	if(request.getParameter("commentNo")== null || request.getParameter("commentNo").equals("")){
		msg = URLEncoder.encode("오류입니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/comment/updateCommentForm.jsp?helpNo="+helpNo+"&commentNo="+commentNo+"&msg="+msg+"&currentPage="+currentPage);
		return;
	} else {
		commentNo = Integer.parseInt(request.getParameter("commentNo"));
	}
	if(request.getParameter("commentMemo")== null || request.getParameter("commentMemo").equals("")){
		msg = URLEncoder.encode("답변을 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/comment/updateCommentForm.jsp?helpNo="+helpNo+"&commentNo="+commentNo+"&msg="+msg+"&currentPage="+currentPage);
		return;
	} else {
		commentMemo = request.getParameter("commentMemo");
	}
	
	Comment comment = new Comment();
	comment.setCommentNo(commentNo);
	comment.setCommentMemo(commentMemo);
	
	String redirectUrl = "/admin/comment/commentList.jsp";
	
	// 2. Model 호출
	CommentDao commentDao = new CommentDao();
	int row = commentDao.updateComment(comment);
	// 디버깅 코드
	if(row == 1){
		System.out.println("수정성공");
		msg = URLEncoder.encode("답변이 수정되었습니다.", "utf-8");
		redirectUrl = "/admin/comment/commentList.jsp?msg="+msg+"&currentPage="+currentPage;
	} else {
		System.out.println("수정실패");
		msg = URLEncoder.encode("답변 수정에 실패하였습니다.", "utf-8");
		redirectUrl = "/admin/comment/commentList.jsp?msg="+msg+"&currentPage="+currentPage;
	}
	System.out.println("입력된 데이터 값: "+ commentNo + " " + commentMemo + "<--- updateCommentAction.jsp");
	
	// 3. View
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>