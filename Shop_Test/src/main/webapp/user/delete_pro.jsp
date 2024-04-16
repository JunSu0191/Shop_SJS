<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String id = request.getParameter("id");
	UserRepository userDAO = new UserRepository();

 	// 세션 무효화
  	session.invalidate();	
	
	// 회원 탈퇴
	int result = userDAO.delete(id);
	if (result > 0) {
		response.sendRedirect("complete.jsp?msg=3");
	} else {
		response.sendRedirect("update.jsp");
	}
%>
