<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
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
    String productIdToDelete = request.getParameter("id"); // 삭제할 상품의 ID를 받아옴
    String deleteAll = request.getParameter("deleteAll"); // 액션을 받아옴 (delete 또는 deleteAll)

    List<Product> cartList = (List<Product>) session.getAttribute("cartList");
    if (cartList != null && productIdToDelete != null) {
        Iterator<Product> iterator = cartList.iterator();
        while (iterator.hasNext()) {
            Product cartProduct = iterator.next();
            if (cartProduct.getProductId().equals(productIdToDelete)) {
                iterator.remove(); // 상품을 장바구니에서 삭제
                break; // 더 이상 반복할 필요 없음
            }
        }
        session.setAttribute("cartList", cartList); // 수정된 장바구니를 세션에 저장
    }

    if (deleteAll != null && "true".equals(deleteAll)) {
        if (cartList != null) {
            cartList.clear(); // 장바구니에 있는 모든 상품 삭제
            session.setAttribute("cartList", cartList); // 수정된 장바구니를 세션에 저장
        }
    }

    response.sendRedirect("cart.jsp");
%>

</body>
</html>
