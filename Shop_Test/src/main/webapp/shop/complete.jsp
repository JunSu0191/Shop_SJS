<%@page import="shop.dao.ProductIORepository"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.OrderRepository"%>
<%@page import="shop.dto.Order"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 완료</title>
<jsp:include page="/layout/meta.jsp" />
<jsp:include page="/layout/link.jsp" />
</head>
<body>
<%
    // 세션에서 장바구니 목록을 가져옵니다.
    List<Product> cartList = (List<Product>) session.getAttribute("cartList");

    // 세션에서 사용자 정보 가져오기 
    // 회원
    String loginId = (String) session.getAttribute("loginId");
    // 비회원
    String orderPw = request.getParameter("orderPw");
    String phone = request.getParameter("phone");
    

    // 주문 정보 받아오기
    Order order = (Order) session.getAttribute("order");
	order.setOrderPw(orderPw);
    
    OrderRepository orderDAO = new OrderRepository();

    // 주문을 디비에 저장
    int result = orderDAO.insert(order);

    // 성공적으로 주문이 처리 됐을 경우 추가 작업 수행
    int lastOrderId = orderDAO.lastOrderNo();
    if (result > 0) {
        // 주문이 성공적으로 처리되었을 때, 해당 주문의 주문번호를 가져옵니다.

        ProductIORepository productIoDAO = new ProductIORepository();

        // 장바구니에 있는 각 상품에 대해 주문 내역을 생성하고 데이터베이스에 저장합니다.
        for (Product cart : cartList) {
            // 주문한 상품 수량에 맞게 입출고량(amount)를 설정합니다.
            int amount = cart.getQuantity();

            // 상품 입출고 테이블에 출고 데이터를 추가합니다.
            Product product = new Product();
            product.setProductId(cart.getProductId());
            product.setOrderNo(lastOrderId); // 최근 주문번호를 설정합니다.
            product.setQuantity(amount);

            // 회원/비회원 여부에 따라 사용자 정보를 설정합니다.
            if (loginId != null) {
                product.setUserId(loginId);
            } else {
                product.setUserId(phone);
            }

            // 상품 입출고 테이블에 데이터를 추가합니다.
            int add = productIoDAO.insert(product);

            // 오류 처리
            if (add < 0) {
                // 오류 발생 시 처리
                break;
            }
        }
    }

    // 주문 완료 후 장바구니 비우기
    if (result > 0) {
        cartList.clear();
        session.setAttribute("cartList", cartList); // 변경된 장바구니를 다시 세션에 저장
        request.setAttribute("order_no", lastOrderId); // 주문 번호를 request에 설정
    }
%>

<jsp:include page="/layout/header.jsp" />

<div class="px-4 py-5 my-5 text-center">
    <h1 class="display-5 fw-bold text-body-emphasis">주문 완료</h1>
</div>

<!-- 주문 완료 확인 -->

<div class="container order mb-5 p-5">

    <h2 class="text-center">주문이 완료되었습니다.</h2>
    <!-- 주문정보 -->
    <div class="ship-box">
        <table class="table ">
            <tbody>
                <tr>
                    <td>주문번호 :</td>
                    <td><%= request.getAttribute("order_no") %></td>
                </tr>
                <tr>
                    <td>배송지 :</td>
                    <td><%= order.getAddress() %></td>
                </tr>
            </tbody>
        </table>

        <div class="btn-box d-flex justify-content-center">
            <a href="../user/order.jsp" class="btn btn-primary btn-lg px-4 gap-3">주문내역</a>
        </div>
    </div>
</div>

<!-- 푸터 -->
<jsp:include page="/layout/footer.jsp" />
<script src="/static/js/validation.js"></script>

</body>
</html>