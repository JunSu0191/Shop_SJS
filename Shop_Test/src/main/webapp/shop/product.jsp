<%@page import="shop.dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>


<%
    String productId = request.getParameter("id");
    ProductRepository productDAO = new ProductRepository();
    Product product = productDAO.getProductById(productId);
    String root = request.getContextPath();
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
<script>
    function addToorder() {
        if (confirm("장바구니에 추가하시겠습니까?")) {
            // AJAX를 사용하여 장바구니에 제품 추가
            var productId = '<%= product.getProductId() %>';
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "./addCart.jsp", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    // AJAX 요청이 성공하면 product.jsp로 리디렉션
                    window.location.href = "./product.jsp?id=" + productId;
                }
            };
            xhr.send("id=" + productId);
        }
    }
</script>


</head>
<body>  
	

<jsp:include page="/layout/header.jsp" />

	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">상품 정보</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
				<a href="./products.jsp" class="btn btn-primary btn-lg px-4 gap-3">상품목록</a>
			</div>
		</div>
	</div>
	
	<!-- 상품 정보 영역 -->
	
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<!-- [NEW] 썸네일 이미지 요청하기 추가 -->
				<img src="<%= root %>/shop/img?id=<%= product.getProductId() %>" class="w-100 p-2">
			</div>
			<div class="col-md-6">
				<h3 class="mb-5"><%= product.getName() %></h3>
			 	<table class="table">
			 		<colgroup>
			 			<col width="120px">
			 			<col>
			 		</colgroup>
			 		<tbody><tr>
			 			<td>상품ID :</td>
			 			<td><%=product.getProductId() %></td>
			 		</tr>
			 		<tr>
			 			<td>제조사 :</td>
			 			<td><%= product.getManufacturer() %></td>
			 		</tr>
			 		<tr>
			 			<td>분류 :</td>
			 			<td><%= product.getCategory() %></td>
			 		</tr>
			 		<tr>
			 			<td>상태 :</td>
			 			<td><%= product.getCondition() %></td>
			 		</tr>
			 		<tr>
			 			<td>재고 수 :</td>
			 			<td><%= product.getUnitsInStock() %></td>
			 		</tr>
			 		<tr>
			 			<td>가격 :</td>
			 			<td><%= product.getUnitPrice() %></td>
			 		</tr>
				</tbody></table>
				<div class="mt-4">
					<form name="addForm" action="./addCart.jsp" method="post">
						<input type="hidden" name="id" value="P000000">
						<div class="btn-box d-flex justify-content-end ">
							<!-- [NEW] 장바구니 버튼 추가 -->
							<a href="./cart.jsp" class="btn btn-lg btn-warning mx-3" onclick="addToCart()">장바구니</a>
							<a href="./cart_pro.jsp?id=<%= product.getProductId() %>" class="btn btn-lg btn-success mx-3" onclick="addToorder()">주문하기</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	

	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />



</body>
</html>