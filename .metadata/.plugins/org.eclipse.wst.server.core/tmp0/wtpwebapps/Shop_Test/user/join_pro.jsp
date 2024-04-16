<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>

<%
    String id = request.getParameter("id");		
    String password = request.getParameter("pw");		
    String name = request.getParameter("name");		
    String gender = request.getParameter("gender");		
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String day = request.getParameter("day");
    String birth = year + "-" + month + "-" + day;
    String mail = request.getParameter("email1") + "@" + request.getParameter("email2");
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
    if (result > 0) {
        response.sendRedirect(root + "/user/complete.jsp?msg=1");
    }
    // 회원가입 실패
    else {
        response.sendRedirect("join.jsp?msg=0");
    }
%>
