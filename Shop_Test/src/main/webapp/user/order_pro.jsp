<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.OrderRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String root = request.getContextPath();

	String orderPw = request.getParameter("orderPw");
	String phone = request.getParameter("phone");
	
	session.setAttribute("phone", phone);
	session.setAttribute("orderPw", orderPw);
	
	
	//주문 내역 조회
	OrderRepository orderDAO = new OrderRepository();
	List<Product> orderList = orderDAO.list(phone, orderPw);   
	
	//주문 내역이 조회되었는지 확인
	if(orderList != null && !orderList.isEmpty()) {
	 // 조회된 주문 내역을 세션에 저장
	 session.setAttribute("phone", phone);
	 session.setAttribute("orderPw", orderPw);
	 
	
	 // 주문 내역 페이지로 리다이렉트
	 response.sendRedirect(root + "/user/order.jsp");
	}
	
	else {
	 // 주문 내역이 조회되지 않은 경우
	 // 실패 메시지를 출력하고 이전 페이지로 돌아가도록 처리
	response.sendRedirect(root + "/user/order.jsp");
	 
	}
	
	
%>