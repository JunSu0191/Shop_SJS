<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.ProductRepository" %>
<%@ page import="shop.dto.Product" %>
<%@ page import="java.io.File" %>

<%
    // 파일 업로드 관련 설정
	String realFolder = "C:\\upload"; // 파일이 업로드될 실제 폴더 경로
	int maxSize = 5 * 1024 * 1024; // 최대 업로드 파일 크기 (5MB)
	String enType = "UTF-8"; // 인코딩 타입

	try {
	    // MultipartRequest 객체를 사용하여 파일 업로드 처리
	    MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, enType, new DefaultFileRenamePolicy());
	    
	    // 상품 정보 받아오기
        String productId = multi.getParameter("productId");
        String name = multi.getParameter("name");
        String description = multi.getParameter("description");
        String manufacturer = multi.getParameter("manufacturer");
        String category = multi.getParameter("category");
        String condition = multi.getParameter("condition");
        int unitPrice = Integer.parseInt(multi.getParameter("unitPrice"));
        long unitsInStock = Long.parseLong(multi.getParameter("unitsInStock"));
        String fileName = multi.getFilesystemName("file"); // 업로드된 파일 이름
        
        // 업로드된 파일이 있는지 확인
        if (fileName != null) {
            // 파일 경로 설정
            String filePath = realFolder + File.separator + fileName;
            
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
            product.setFile(filePath); // 파일 경로 설정
            
            // 데이터베이스에 상품 등록
            ProductRepository productRepository = new ProductRepository();
            int result = productRepository.insert(product);
            String root = request.getContextPath();
            
            if (result > 0) {
                // 등록 성공 시 메시지 출력
                response.sendRedirect(root + "/shop/products.jsp");
            } else {
                // 등록 실패 시 메시지 출력
                response.sendRedirect("add.jsp?msg=0");
            }
        } else {
            // 파일 업로드 실패 시 처리
            response.sendRedirect("add.jsp?msg=1");
        }
    } catch (Exception e) {
        // 예외 처리
        e.printStackTrace();
        response.sendRedirect("add.jsp?msg=2");
    }
%>
