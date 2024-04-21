<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String root = request.getContextPath();
    ProductRepository productDAO = new ProductRepository();
    String keyword = request.getParameter("keyword");
    keyword = keyword == null ? "" : keyword;
    List<Product> productList = productDAO.list(keyword);
    if (productList == null) {
        productList = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<jsp:include page="/layout/meta.jsp" />
<jsp:include page="/layout/link.jsp" />
</head>
<body>
    <!-- 헤더 -->
    <jsp:include page="/layout/header.jsp" />

    <div class="container">
        <div class="inner_Container p-5">
            <h1 class="text-center">상품 목록</h1>
            <p class="text-center">쇼핑몰 상품 목록 입니다.</p>
            <div class="d-flex justify-content-center gap-2">
                <a href="add.jsp" class="btn btn-primary">상품 등록</a> 
                <a href="editProducts.jsp" class="btn btn-success">상품 편집</a> 
                <a href="" class="btn btn-warning">장바구니</a>
            </div>
        </div>

        <!-- 카드뷰 -->
        <div class="product_Container">
                    <div class="row">
                        <% for (Product product : productList) { %>
                        <div class="col-12 col-md-6 col-xl-4 col-xxl-3 pb-3">
                            <div class="card">
                                <div class="img-content">
                                    <img class="p-3" alt="" src="<%= root %>/shop/img?id=<%= product.getProductId() %>">
                                </div>
                                <div class="content">
                                    <h3 class="text-center"><%=product.getName()%></h3>
                                    <p class="text-center"><%=product.getDescription()%></p>
                                    <p class="price text-end" style="padding: 10px">
                                        ₩<%=product.getUnitPrice()%>
                                    </p>
                                    <div class="d-flex justify-content-between px-3 mb-5">
                                        <a href="<%= root %>/shop/cart_pro.jsp?id=" class="btn btn-outline-primary">
                                        <i class="material-symbols-outlined">shopping_bag</i></a>
                                        <a href="<%= root %>/shop/product.jsp?id=<%= product.getProductId() %>" class="btn btn-outline-primary">상세정보</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
		        </div>
		    </div>
    <!-- 푸터 -->
    <jsp:include page="/layout/footer.jsp" />
</body>
</html>
