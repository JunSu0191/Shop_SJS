<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String id = request.getParameter("id");
	UserRepository userDAO = new UserRepository();

	
	// 회원 탈퇴
	int result = userDAO.delete(id);
	if (result > 0) {
	   Cookie cookieRememberMe = new Cookie("rememberId", "");
	   Cookie cookieToken = new Cookie("token", "");
	   cookieRememberMe.setPath("/");
	   cookieToken.setPath("/");
	   cookieRememberMe.setMaxAge(0);
	   cookieToken.setMaxAge(0);
	   
	 	// 세션 무효화
	  	session.invalidate();	
	 	
	   	// 쿠키 전달
	   	response.addCookie(cookieRememberMe);
	   	response.addCookie(cookieToken);
		response.sendRedirect("complete.jsp?msg=3");
	} else {
		response.sendRedirect("update.jsp");
	}
%>
