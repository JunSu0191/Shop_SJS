<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.ProductRepository" %>
<%@ page import="shop.dto.Product" %>

<%
    // 요청으로부터 상품 정보를 받아옴
    String productId = request.getParameter("productId");
	System.out.print("프로덕트 아이디입니다" + request.getParameter("productId"));
    String name = request.getParameter("name");
	System.out.print("프로덕트 아이디입니다" + request.getParameter("name"));
    String description = request.getParameter("description");
	System.out.print("프로덕트 아이디입니다" + request.getParameter("description"));
    String manufacturer = request.getParameter("manufacturer");
    String category = request.getParameter("category");
    String condition = request.getParameter("condition");
    int unitPrice = Integer.parseInt(request.getParameter("unitPrice"));
    long unitsInStock = Long.parseLong(request.getParameter("unitsInStock"))
		// 파일 업로드 처리
		Part filePart = request.getPart("file");
		String fileName = "";
		if (filePart != null) {
		    // 파일 이름 가져오기
		    fileName = filePart.getSubmittedFileName();
		    
		    // 파일 저장하기 (원하는 디렉토리로 경로 설정 필요)
		    String savePath = getServletContext().getRealPath("/uploads");
		    File fileSaveDir = new File(savePath);
		    if (!fileSaveDir.exists()) {
		        fileSaveDir.mkdir();
		    }
		    filePart.write(savePath + File.separator + fileName);
		};
    
    
	
    // Product 객체 생성
    Product product = new Product();
    product.setProductId(productId);
    product.setName(name);
    product.setUnitPrice(unitPrice);
    product.setDescription(description);
    product.setManufacturer(manufacturer);
    product.setCategory(category);
    product.setUnitsInStock(unitsInStock);
    product.setCondition(condition);
    
    // 데이터베이스에 상품 등록
    ProductRepository productRepository = new ProductRepository();
    int result = productRepository.insert(product);
    String root = request.getContextPath();
    if (result > 0) {
        // 등록 성공 시 메시지 출력
        response.sendRedirect(root + "/products.jsp");
    } else {
        // 등록 실패 시 메시지 출력
        response.sendRedirect("add.jsp?msg=0");
        
    }
%>
