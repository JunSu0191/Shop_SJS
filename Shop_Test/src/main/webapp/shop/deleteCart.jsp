<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>


<%
    String productId = request.getParameter("product_id");
    ProductRepository productDAO = new ProductRepository();
    
    // 상품 삭제
    int result = productDAO.delete(productId);
    
    if (result > 0) {
        response.sendRedirect("cart.jsp");
    } else {
        response.sendRedirect("cart.jsp?msg=0");
    }
%>