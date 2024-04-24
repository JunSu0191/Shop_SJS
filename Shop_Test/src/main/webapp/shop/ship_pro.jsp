<%@page import="shop.dto.Order"%>
<%@page import="shop.dao.OrderRepository"%>
<%@page import="shop.dto.Ship"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 폼으로부터 전달된 데이터 가져오기
    String name = request.getParameter("name");
    String shippingDate = request.getParameter("shippingDate");
    String country = request.getParameter("country");
    String zipCode = request.getParameter("zipCode");
    String addressName = request.getParameter("addressName");
    String phone = request.getParameter("phone");
    
    // Ship 객체 생성 및 데이터 설정
    Order order = new Order();
    order.setShipName(name);
    order.setDate(shippingDate);
    order.setCountry(country);
    order.setZipCode(zipCode);
    order.setAddress(addressName);
    order.setPhone(phone);
    
   	
    session.setAttribute("order", order);
    response.sendRedirect("order.jsp");
%>
