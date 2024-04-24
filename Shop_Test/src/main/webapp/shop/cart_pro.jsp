<%@page import="java.security.ProtectionDomain"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 pro</title>
</head>
<body>
<%
	String totalPrice = request.getParameter("totalPrice");
	ProductRepository productRepository = new ProductRepository();
	String productId = request.getParameter("id");
	Product product = productRepository.getProductById(productId);
	pageContext.setAttribute("product", product);
	
	
	
	List<Product> cartList = (List<Product>) session.getAttribute("cartList");
 	if( cartList == null ) {
		cartList = new ArrayList<Product>();
 	}
 	
 	// 조건 기존 productId가 있는지?
 	boolean duplicated = false;
	
 	for(int i = 0 ; i < cartList.size() ; i++ ) {
 		Product cart = cartList.get(i);
 		String cartProductId = cart.getProductId();
 		
 		if( productId.equals(cartProductId) ) {
 			duplicated = true;
 			int count = cart.getQuantity();
 			cart.setQuantity(++count);
 			break;
 		}
 	}
 	
	if( !duplicated ) {
		product.setQuantity(1);
 		cartList.add(product);
	}
 	
	
	session.setAttribute("cartList", cartList);
 	response.sendRedirect("products.jsp");
%>



</body>
</html>