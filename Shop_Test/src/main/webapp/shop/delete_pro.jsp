<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String id = request.getParameter("product_id");
	System.out.println(id);
	ProductRepository productDAO = new ProductRepository();
	
	// 상품 삭제
	int result = productDAO.delete(id);
	
	if( result > 0 ) {
		response.sendRedirect("editProducts.jsp?msg=0");
		System.out.println("삭제 성공");
	} else {
		response.sendRedirect("editProducts.jsp?msg=1");
		System.out.println("삭제 실패");
	}
%>