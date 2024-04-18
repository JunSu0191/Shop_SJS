<%@page import="shop.dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>장바구니</title>

    <script>
        let cartId = 'D5929CE716E11CEF324D0403FD8E4062';
        let cartCount = '1';
        let cartSum = document.getElementById('cart-sum');

        function order() {
            if (cartCount == 0) {
                alert('장바구니에 담긴 상품이 없습니다.');
                return;
            }
            let msg = '총 ' + cartCount + '개의 상품을 주문합니다.\n총 주문금액 : ' + cartSum.textContent;
            let check = confirm(msg);
            if (check) {
                location.href = 'ship.jsp?cartId=' + cartId;
            }

        }
    </script>

    <jsp:include page="/layout/meta.jsp" />
    <jsp:include page="/layout/link.jsp" />
</head>
<body>
    <!-- 헤더 -->
    <jsp:include page="/layout/header.jsp" />

    <div class="px-4 py-5 my-5 text-center">
        <h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
        <div class="col-lg-6 mx-auto">
            <p class="lead mb-4">장바구니 목록입니다.</p>
        </div>
    </div>

    <!-- 장바구니 영역 -->
    <div class="container order">
        <!-- 장바구니 목록 -->
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
                    ProductRepository productDAO = new ProductRepository();
                    List<Product> productList = productDAO.list();
                    if (productList == null) {
                        productList = new ArrayList<>();
                    }
                    for (Product product : productList) { 
                %>
                    <tr>
                        <td><%= product.getName() %></td>
                        <td><%= product.getUnitPrice() %></td>
                        <td><%= product.getUnitsInStock() %></td>
                        <td><%= product.getUnitsInStock() %></td>
                        <td><a href="deleteCart.jsp?id=<%= product.getProductId() %>" class="btn btn-danger">삭제</a></td>
                    </tr>
                <% } %>
                    <tr>
                    	<td></td>
                    	<td></td>
                    	<td>총액</td>
                    	<td>54545</td>
                    	<td></td>
                    </tr>
            </tbody>
        </table>

        <!-- 버튼 영역 -->
        <div class="d-flex justify-content-between align-items-center p-3">
            <a href="deleteCart.jsp?cartId=D5929CE716E11CEF324D0403FD8E4062" class="btn btn-lg btn-danger">전체삭제</a>
            <a href="javascript:;" class="btn btn-lg btn-primary" onclick="order()">주문하기</a>
        </div>
    </div>

    <!-- 푸터 -->
    <jsp:include page="/layout/footer.jsp" />
</body>
</html>
