<!-- 
	회원 가입 처리
 -->
<%@page import="java.util.Date"%>
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String id = request.getParameter("id");		
	String password = request.getParameter("password");		
	String name = request.getParameter("name");		
	String gender = request.getParameter("gender");		
	String birth = request.getParameter("birth");		
	String mail = request.getParameter("mail");		
	String phone = request.getParameter("phone");		
	String address = request.getParameter("address");
	
	User user = new User();
	user.setId(id);
	user.setPassword(password);
	user.setName(name);
	user.setGender(gender);
	user.setBirth(birth);
	user.setMail(mail);
	user.setPhone(phone);
	user.setAddress(address);
	
	UserRepository userRepository = new UserRepository();
	int result = userRepository.insert(user);
	
	String root = request.getContextPath();
	// 회원가입 성공
	if( result > 0) {
		response.sendRedirect(root + "/user/complete.jsp");
	}
	// 회원가입 실패
	else {
		response.sendRedirect("join.jsp?msg=0");
	}
%>

    
    

    
    
    
    
    
    