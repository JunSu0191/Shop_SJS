<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dto.Order"%>
<%@page import="shop.dao.OrderRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 정보</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
	
<body> 
	<%
	OrderRepository orderDAO = new OrderRepository();
	Order order = (Order) session.getAttribute("order");
	
	String loginId = (String) session.getAttribute("loginId");
	
	List<Product> cartList = (List<Product>) session.getAttribute("cartList");
	int sum = 0;
	%>
   <!-- 헤더 -->
   <jsp:include page="/layout/header.jsp" />  
	
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">주문 정보</h1>
	</div>
	
	<!-- 주문 확인 영역 -->
	<div class="container order mb-5">
		<form action="complete.jsp" method="post">
		<!-- 배송정보 -->
		<div class="ship-box">
			<table class="table ">
				<tr>
					<td>주문 형태 :</td>
					<td>
						<% if (loginId != null) { %>
							회원 주문
						<% } else { %>
							비회원 주문
						<% } %>
					</td>
				</tr>
				<tr>
					<td>성 명 :</td>
					<td><%= order.getShipName() %></td>
				</tr>
				<tr>
					<td>우편번호 :</td>
					<td><%= order.getZipCode() %></td>
				</tr>
				<tr>
					<td>주소 :</td>
					<td><%= order.getAddress() %></td>
				</tr>
				<tr>
					<td>배송일 :</td>
					<td><%= order.getDate() %></td>
				</tr>
				<tr>
					<td>전화번호 :</td>
					<td><%= order.getPhone() %></td>
				</tr>
				<% if (loginId == null) { %>
					<tr>
						<td>주문 비밀번호 :</td>
						<td>
							<input type="password" class="form-control" name="orderPw">
						</td>
					</tr>
				<% } %>
			</table>
		</div>
		
		<!-- 주문목록 -->
		<div class="cart-box">
			<table class="table table-striped table-hover table-bordered text-center align-middle">
				<thead>
					<tr class="table-primary">
						<th>상품</th>
						<th>가격</th>
						<th>수량</th>
						<th>소계</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(Product product : cartList) {
					%>
					<tr>
						<td><%= product.getName() %></td>			
						<td><%= product.getUnitPrice() %></td>			
						<td><%= product.getQuantity() %></td>			
						<td><%=product.getQuantity() * product.getUnitPrice()%></td>			
						<td></td>			
					</tr>
				</tbody>
				<% 
				}
				%>
			</table>
		</div>
		
		<!-- 버튼 영역 -->
		<div class="d-flex justify-content-between mt-5 mb-5">
			<div class="item">
				<a href="ship.jsp" class="btn btn-lg btn-success">이전</a>
				<!-- 취소 프로세스는 이어서... -->				
				<a href="" class="btn btn-lg btn-danger">취소</a>				
			</div>
			<div class="item">
				<input type="hidden" name="login" value="<%= loginId != null %>">
				<input type="hidden" name="totalPrice" value="50000">
				<input type="submit" class="btn btn-lg btn-primary" value="주문완료">	
			</div>
		</div>
		</form>
	</div>

   <jsp:include page="/layout/footer.jsp" />
   <jsp:include page="/layout/script.jsp" />


</body>
</html>
