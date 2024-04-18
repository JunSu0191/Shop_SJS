<%@page import="shop.dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>��ٱ���</title>

    <script>
        let cartId = 'D5929CE716E11CEF324D0403FD8E4062';
        let cartCount = '1';
        let cartSum = document.getElementById('cart-sum');

        function order() {
            if (cartCount == 0) {
                alert('��ٱ��Ͽ� ��� ��ǰ�� �����ϴ�.');
                return;
            }
            let msg = '�� ' + cartCount + '���� ��ǰ�� �ֹ��մϴ�.\n�� �ֹ��ݾ� : ' + cartSum.textContent;
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
    <!-- ��� -->
    <jsp:include page="/layout/header.jsp" />

    <div class="px-4 py-5 my-5 text-center">
        <h1 class="display-5 fw-bold text-body-emphasis">��ٱ���</h1>
        <div class="col-lg-6 mx-auto">
            <p class="lead mb-4">��ٱ��� ����Դϴ�.</p>
        </div>
    </div>

    <!-- ��ٱ��� ���� -->
    <div class="container order">
        <!-- ��ٱ��� ��� -->
        <table class="table table-striped table-hover table-bordered text-center align-middle">
            <thead>
                <tr class="table-primary">
                    <th>��ǰ</th>
                    <th>����</th>
                    <th>����</th>
                    <th>�Ұ�</th>
                    <th>���</th>
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
                        <td><a href="deleteCart.jsp?id=<%= product.getProductId() %>" class="btn btn-danger">����</a></td>
                    </tr>
                <% } %>
                    <tr>
                    	<td></td>
                    	<td></td>
                    	<td>�Ѿ�</td>
                    	<td>54545</td>
                    	<td></td>
                    </tr>
            </tbody>
        </table>

        <!-- ��ư ���� -->
        <div class="d-flex justify-content-between align-items-center p-3">
            <a href="deleteCart.jsp?cartId=D5929CE716E11CEF324D0403FD8E4062" class="btn btn-lg btn-danger">��ü����</a>
            <a href="javascript:;" class="btn btn-lg btn-primary" onclick="order()">�ֹ��ϱ�</a>
        </div>
    </div>

    <!-- Ǫ�� -->
    <jsp:include page="/layout/footer.jsp" />
</body>
</html>
