<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>��ǰ �ֹ�</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>   
	

	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">��� ����</h1>
	</div>
	
	<!-- ��� ���� �Է� -->
	<div class="container shop mb-5 p-4">
		<form action="ship_pro.jsp" class="form-horizontal" method="post">
			<input type="hidden" name="cartId" value="6ECC818112AD70366B7F55827386A3EE">
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">����</label>
				<input type="text" class="form-control col-md-10" name="name" value="">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">�����</label>
				<input type="text" class="form-control col-md-10" name="shippingDate" value="">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">������</label>
				<input type="text" class="form-control col-md-10" name="country" value="">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">�����ȣ</label>
				<input type="text" class="form-control col-md-10" name="zipCode" value="">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">�ּ�</label>
				<input type="text" class="form-control col-md-10" name="addressName" value="">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">��ȭ��ȣ</label>
				<input type="text" class="form-control col-md-10" name="phone" value="">
			</div>
			
			<!-- ��ư ���� -->
			<div class="d-flex justify-content-between mt-5 mb-5">
				<div class="item">
					<a href="cart.jsp" class="btn btn-lg btn-success">����</a>
					<!-- ��� ���μ����� �̾... -->				
					<a href="/" class="btn btn-lg btn-danger">���</a>				
				</div>
				<div class="item">
					<input type="submit" class="btn btn-lg btn-primary" value="���">
				</div>
			</div>
			
		</form>
	</div>
	
	<!-- Ǫ�� -->
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp"/>
</body>
</html>