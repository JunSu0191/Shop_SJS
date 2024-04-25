<%@page import="shop.dto.Order"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="shop.dto.Product" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

    String root = request.getContextPath();    

    // 세션에서 주문 내역 가져오기
    List<Product> orderList = (List<Product>) session.getAttribute("orderList");
    if (orderList == null) {
        // 주문 내역이 없는 경우 새로운 리스트 생성
        orderList = new ArrayList<>();
    }
    
    String phone = request.getParameter("phone");
    String orderPw = request.getParameter("orderPw");
    
    // 주문 정보 받아오기
    int orderNo = Integer.parseInt(request.getParameter("orderNo"));
    String productName = request.getParameter("productName");
    int unitPrice = Integer.parseInt(request.getParameter("unitPrice"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    
    Order order = new Order();
    order.getOrderPw();
    order.getPhone();
    
    // Product 객체 생성 및 정보 설정
    Product product = new Product();
    product.setOrderNo(orderNo);
    product.setName(productName);
    product.setUnitPrice(unitPrice);
    product.setQuantity(quantity);
    
    // 주문 내역에 상품 추가
    orderList.add(product);
    
    // 주문 내역 세션에 등록 처리
    session.setAttribute("orderList", orderList);
    
    // 주문 페이지로 이동
    response.sendRedirect("/user/order.jsp");

%>
