<%@page import="shop.dao.OrderRepository"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.UUID"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Order"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>   
<%
	String loginId = (String) session.getAttribute("loginId");
	List<Product> cartList = (List<Product>) session.getAttribute("cartList");
	
	Order orderPro = (Order) session.getAttribute("order");
	String orderPw = request.getParameter("orderpw");
	int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
	String userId = request.getParameter("loginId");

	
	// OrderRepository를 이용하여 최근 주문번호를 가져옴
	OrderRepository orderDAO = new OrderRepository();
	int lastOrderNo = orderDAO.lastOrderNo();
	
	Order order = new Order();
	order.setUserId(userId);
	order.setOrderPw(orderPw);
	order.setTotalPrice(totalPrice);
	order.setShipName(orderPro.getShipName());
    order.setDate(orderPro.getDate());
    order.setCountry(orderPro.getCountry());
    order.setZipCode(orderPro.getZipCode());
    order.setAddress(orderPro.getAddress());
    order.setPhone(orderPro.getPhone());
	// 최근 주문번호 설정
	order.setOrderNo(lastOrderNo + 1);
	
	// 새로운 주문 정보를 데이터베이스에 추가
	int result = orderDAO.insert(order);
	String root = request.getContextPath();
	
	// 주문 완료 후 장바구니 비우기
	session.removeAttribute("cartList");
%>
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">주문 완료</h1>
	</div>
	
	
	<div class="container order mb-5 p-5">
		
		<h2 class="text-center">주문이 완료되었습니다.</h2>
		<!-- 주문정보 -->
		<div class="ship-box">
			<table class="table ">
				<tbody><tr>
					<td>주문번호 :</td>
					<td><%= order.getOrderNo() %></td>
				</tr>
				<tr>
					<td>배송지 :</td>
					<td><%= order.getAddress() %></td>
				</tr>
			</tbody></table>
			
			<div class="btn-box d-flex justify-content-center">
				<a href="<%= root %>/user/order.jsp" class="btn btn-primary btn-lg px-4 gap-3">주문내역</a>
			</div>
		</div>
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
</body>
</html>
