<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<jsp:include page="/layout/meta.jsp" />
<jsp:include page="/layout/link.jsp" />
<%
	ProductRepository productRepository = new ProductRepository();
	List<Product> cartList = (List<Product>) session.getAttribute("cartList");
	int sum = 0;
%>
<script>

    let cartCount = <%= cartList != null ? cartList.size() : 0 %>; // 장바구니에 담긴 상품 개수 가져오기
    let cartSum = <%= sum %>; // 총 주문금액 가져오기
    
    function order() {
        if (cartCount === 0) {
            alert('장바구니에 담긴 상품이 없습니다.');
            return;
        }
        let msg = '총 ' + cartCount + '개의 상품을 주문합니다.\n총 주문금액: ₩' + cartSum;
        let check = confirm(msg);
        if (check) {
            location.href = 'ship.jsp?cartId=' + cartId;
        }
    }

</script>

</head>
<body>
	
	<!-- 헤더 -->
	<jsp:include page="/layout/header.jsp" />

	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">장바구니 목록 입니다.</p>
		</div>
	</div>


	<div class="container order">
		<!-- 장바구니 목록 -->

		<table
			class="table table-striped table-hover table-bordered text-center align-middle">
				<tr class="table-primary">
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
			<%
			if (cartList != null) {
				for (Product product : cartList) {
					int quantity = product.getQuantity();
					sum += quantity * product.getUnitPrice();
			%>
				<tr>
					<td><%=product.getName()%></td>
					<td>₩ <%=product.getUnitPrice()%></td>
					<td><%=quantity%></td>
					<td>₩ <%=quantity * product.getUnitPrice()%></td>
					<td><a href="deleteCart.jsp?product_id=<%=product.getProductId()%>"
						class="btn btn-danger">삭제</a></td>
				</tr>
				<%
				}
				%>
				<tr>
					<td></td>
					<td></td>
					<td>총액</td>
					<td id="cart-sum"><%=sum%></td>
					<td></td>
				</tr>
			<%
			}
			if (cartList == null) {
			%>

				<tr>
					<td colspan="5">추가된 상품이 없습니다.</td>
				</tr>
			<%
			}
			%>

		</table>
		<!-- 버튼 영역 -->
		<div class="d-flex justify-content-between align-items-center p-3">
			<a href="deleteCart.jsp?cartId=35B4B7BC4ED46167E3E05CE27579D73D"
				class="btn btn-lg btn-danger ">전체삭제</a>
			<a href="ship.jsp" class="btn btn-lg btn-primary" onclick="order()">주문하기</a>
		</div>
	</div>
	




	<!-- 푸터 -->
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp"/>
</body>
</html>