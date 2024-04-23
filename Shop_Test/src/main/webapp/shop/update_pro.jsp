<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.ProductRepository" %>
<%@ page import="shop.dto.Product" %>
<%@ page import="java.io.File" %>

<%
	//파일 업로드 관련 설정
	String Folder = "C:\\upload"; // 윈도우 체제에서 사용
	int maxSize = 10 * 1024 * 1024; // 최대 업로드 파일 크기 (10MB)
	String enType = "UTF-8"; // 인코딩 타입

    try {
        // MultipartRequest 객체를 사용하여 파일 업로드 처리
        MultipartRequest multi = new MultipartRequest(request, Folder, maxSize, enType, new DefaultFileRenamePolicy());
        
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
            String filePath = Folder + File.separator + fileName;
            
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
            
            // 데이터베이스에 상품 수정
            ProductRepository productRepository = new ProductRepository();
            int result = productRepository.update(product);
            String root = request.getContextPath();
            
            if (result > 0) {
                response.sendRedirect(root + "/shop/products.jsp");

            } else {
                response.sendRedirect("update.jsp?msg=0");
            }
        } else {
            // 업로드된 파일이 없을 때 기존 파일 유지
            ProductRepository productRepository = new ProductRepository();
            Product existingProduct = productRepository.getProductById(productId);
            
            if (existingProduct != null) {
                // 기존 파일 정보를 유지한 새 Product 객체 생성
                Product product = new Product();
                product.setProductId(existingProduct.getProductId());
                product.setName(name);
                product.setUnitPrice(unitPrice);
                product.setDescription(description);
                product.setManufacturer(manufacturer);
                product.setCategory(category);
                product.setUnitsInStock(unitsInStock);
                product.setCondition(condition);
                
                // 기존 파일 정보를 유지하도록 설정
                product.setFile(existingProduct.getFile()); // 기존 파일 경로 설정

                // 데이터베이스에 상품 수정
                int result = productRepository.update(product);
                String root = request.getContextPath();

                if (result > 0) {
                    response.sendRedirect(root + "/shop/products.jsp");
                } else {
                    response.sendRedirect("update.jsp?msg=0");
                }
            } else {
                response.sendRedirect("update.jsp?msg=1");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("update.jsp?msg=2");
    }
%>
