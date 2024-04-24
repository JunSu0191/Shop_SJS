<%@page import="shop.dao.OrderRepository"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.UUID"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Order"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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

	
	
	Order order = new Order();
	order.setUserId(loginId);
	order.setOrderPw(orderPw);
	order.setTotalPrice(totalPrice);
	order.setShipName(orderPro.getShipName());
    order.setDate(orderPro.getDate());
    order.setCountry(orderPro.getCountry());
    order.setZipCode(orderPro.getZipCode());
    order.setAddress(orderPro.getAddress());
    order.setPhone(orderPro.getPhone());
	
	OrderRepository orderDAO = new OrderRepository();
	int result = orderDAO.insert(order);
	
	if( result > 0) {
		
	}
	
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
				<a href="/user/order.jsp" class="btn btn-primary btn-lg px-4 gap-3">주문내역</a>
			</div>
		</div>
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
</body>
</html>
