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
<meta charset="UTP-8">
<title>상품 편집 목록</title>
<jsp:include page="/layout/meta.jsp" />
<jsp:include page="/layout/link.jsp" />
</head>
<body>  
    <!-- 헤더 -->
    <jsp:include page="/layout/header.jsp" />
	
	<div class="container">
        <div class="inner_Container p-5">
            <h1 class="text-center">상품 편집</h1>
            <p class="text-center">쇼핑몰 상품 목록 입니다.</p>
            <div class="d-flex justify-content-center gap-2">
                <a href="add.jsp" class="btn btn-primary">상품 등록</a> 
                <a href="products.jsp" class="btn btn-success">상품 목록</a> 
            </div>
        </div>
		
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
                                </div>
                                <p class="d-flex justify-content-end">
								<!-- [NEW] 수정 버튼으로 변경 -->
								<a href="update.jsp?productId=<%= product.getProductId() %>" class="btn btn-primary mx-2">수정</a>
								<!-- [NEW] 삭제 버튼 추가 -->

								<a href="delete_pro.jsp?product_id=<%= product.getProductId() %>" class="btn btn-danger mx-2" onclick="deleteProduct()">삭제</a>

							</p>
                            </div>
                        </div>
				<% } %>
			</div>
		</div>
	</div>
	<!-- 푸터 -->
    <jsp:include page="/layout/footer.jsp" />
    <jsp:include page="/layout/script.jsp" />
    
    <script>
    		// 
		function deleteProduct() {

			let form = document.updateForm

			let check = confirm('정말 삭제하시겠습니까?')

			if( check ) {
				form.action = 'delete_pro.jsp'
				form.submit()
			}

		}
	
	</script>
</body>
</html>