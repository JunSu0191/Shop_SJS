<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
	String id = request.getParameter("product_id");
	ProductRepository productDAO = new ProductRepository();
	
	// 상품 삭제
	int reuslt = productDAO.delete(id);
	
	if( reuslt > 0) {
		response.sendRedirect("editProducts.jsp?msg=0");
		System.out.println("삭제 성공");
	} else {
		response.sendRedirect("editProducts.jsp?msg=1");
		System.out.println("삭제 실패");
	}

%>