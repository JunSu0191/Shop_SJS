<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>장바구니</title>
<jsp:include page="/layout/meta.jsp" />
<jsp:include page="/layout/link.jsp" />
</head>
<%   
   String root = request.getContextPath();
   
   List<Product> cartList = (List<Product>) session.getAttribute("cartList");
   
   // 카트가 null인지 확인
   if (cartList == null) {
      session.setAttribute("cartList", cartList);
       cartList = new ArrayList<>(); // 새로운 카트 생성
   }
   
   int sum = 0;
   
%>

<body>
   <!-- 헤더 -->
   <jsp:include page="/layout/header.jsp" />

   <div class="px-4 py-5 my-5 text-center">
      <h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
      <div class="col-lg-6 mx-auto">
         <p class="lead mb-4">장바구니 목록 입니다.</p>
      </div>
   </div>
   
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
            if (cartList == null || cartList.isEmpty()) {
            %>
         
         
         <tfoot>
            <tr>
               <td colspan="5">추가된 상품이 없습니다.</td>
            </tr>
         </tfoot>
         <%
         } else {
         for (Product product : cartList) {
            
            sum += product.getQuantity() * product.getUnitPrice();
         %>
         <tr>
            <td><%=product.getName()%></td>
            <td>₩ <%=product.getUnitPrice()%></td>
            <td><%=product.getQuantity()%></td>
            <td>₩ <%=product.getQuantity() * product.getUnitPrice()%></td>
            <td><a href="deleteCart.jsp?id=<%=product.getProductId()%>"
               class="btn btn-danger">삭제</a></td>
         </tr>
         <%
         }
         %>
         </tbody>
         <%
         }
         if (!(cartList == null || cartList.isEmpty())) {
         %>
         <tfoot>
            <tr>
               <td></td>
               <td></td>
               <td>총액</td>
               <td id="sum"><%=sum%></td>
               <td></td>
            </tr>
         </tfoot>
         <%
         }
         %>
     </table>
   
      <!-- 버튼 영역 -->
      <div class="d-flex justify-content-between align-items-center p-3">
         <a href="deleteCart.jsp?deleteAll=true" class="btn btn-danger">전체 삭제</a>
         <form action="<%= root %>/shop/ship.jsp" onsubmit="return order()" method="post">
                     <button type="submit" class="btn btn-primary btn-lg">주문하기</button>
        </form>
      </div>
   </div>
   
   <jsp:include page="/layout/footer.jsp" />
   <jsp:include page="/layout/script.jsp" />
   
   <script>

   let cartCount = <%= cartList != null ? cartList.size() : 0 %>;
   let cartSum = <%= sum %>; // 총 주문금액 가져오기

   function order() {
       if (cartCount === 0) {
           alert('장바구니에 담긴 상품이 없습니다.');
           return false; // 주문하지 않음
       }

       let msg = '총 ' + cartCount + '개의 상품을 주문합니다. \n총 주문금액 : ' + cartSum;
       let check = confirm(msg);
       return check; // 확인 버튼을 누르면 true, 취소 버튼을 누르면 false 반환
   }
        
      
   </script>
</body>
</html>