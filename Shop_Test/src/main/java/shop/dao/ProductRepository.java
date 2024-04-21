package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductRepository extends JDBConnection {
	
	 /**
     * 상품 목록 조회
     * @return 상품 목록
     */
    public List<Product> list() {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM product";
        
        try {
            psmt = con.prepareStatement(sql);
            
            rs = psmt.executeQuery();
            
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getString("product_id"));
                product.setName(rs.getString("name"));
                product.setUnitPrice(rs.getInt("unit_price"));
                product.setDescription(rs.getString("description"));
                product.setManufacturer(rs.getString("manufacturer"));
                product.setCategory(rs.getString("category"));
                product.setUnitsInStock(rs.getInt("units_in_stock"));
                product.setCondition(rs.getString("condition"));
                product.setFile(rs.getString("file"));
                productList.add(product);
            }
            
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return productList;
    }
    
	/**
	 * 상품 목록 검색
	 * @param keyword
	 * @return
	 */
    public List<Product> list(String keyword) {
        List<Product> productKeyword = new ArrayList<>();
        String sql = "SELECT * FROM product "
//        		   + "WHERE name LIKE CONCAT('%', ?, '%') OR description LIKE CONCAT('%', ?, '%')";
        		   + "WHERE name LIKE ? OR description LIKE ?";

        
        try {
            psmt = con.prepareStatement(sql);
            
            // '%'를 키워드 양쪽에 붙여서 부분 일치 검색을 합니다.
            String searchKeyword = "%" + keyword + "%";
            psmt.setString(1, searchKeyword);
            psmt.setString(2, searchKeyword); // 두 번째 매개변수 설정
            
            rs = psmt.executeQuery();
            
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getString("product_id"));
                product.setName(rs.getString("name"));
                product.setUnitPrice(rs.getInt("unit_price"));
                product.setDescription(rs.getString("description"));
                product.setManufacturer(rs.getString("manufacturer"));
                product.setCategory(rs.getString("category"));
                product.setUnitsInStock(rs.getInt("units_in_stock"));
                product.setCondition(rs.getString("condition"));
                product.setFile(rs.getString("file"));
                productKeyword.add(product);
            }
            
            rs.close();
        } catch (SQLException e) {
        	System.err.println("상품 목록 검색 중 에러 발생");
            e.printStackTrace();
        }
        
        return productKeyword;
    }

	
	/**
	 * 상품 조회
	 * @param productId
	 * @return
	 */
	public Product getProductById(String productId) {
	        String sql = "SELECT * FROM product WHERE product_id = ?";
	        
	        try {
	            psmt = con.prepareStatement(sql);
	            
	            psmt.setString(1, productId);
	            
	            rs = psmt.executeQuery();
	            
	            while (rs.next()) {
	                Product product = new Product();
	                product.setProductId(rs.getString("product_id"));
	                product.setName(rs.getString("name"));
	                product.setUnitPrice(rs.getInt("unit_price"));
	                product.setDescription(rs.getString("description"));
	                product.setManufacturer(rs.getString("manufacturer"));
	                product.setCategory(rs.getString("category"));
	                product.setUnitsInStock(rs.getInt("units_in_stock"));
	                product.setCondition(rs.getString("condition"));
	                product.setFile(rs.getString("file"));

	                return product;
	            }
	            
	            rs.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return null;
	}
	
	
	/**
	 * 상품 등록
	 * @param product
	 * @return
	 */
	public int insert(Product product) throws SQLException {
		int result = 0;
	    String sql = "INSERT INTO product (product_id, name, unit_price, description, manufacturer, category, units_in_stock, `condition`, file)"
	    		   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

	    try {
	    	psmt = con.prepareStatement(sql);
	        psmt.setString(1, product.getProductId() );
	        psmt.setString(2, product.getName() );
	        psmt.setInt(3, product.getUnitPrice() );
	        psmt.setString(4, product.getDescription() );
	        psmt.setString(5, product.getManufacturer() );
	        psmt.setString(6, product.getCategory() );
	        psmt.setLong(7, product.getUnitsInStock() );
	        psmt.setString(8, product.getCondition() );
	        psmt.setString(9, product.getFile() );
	        
	        
	        result = psmt.executeUpdate();
	        
	        
	    } catch (SQLException e) {
	        System.err.println("상품 등록 시, 예외 발생");
	        e.printStackTrace();
	    }
	    return result;
	}

	
	
	/**
	 * 상품 수정
	 * @param product
	 * @return
	 */
	public int update(Product product) {
		return 0;
	}
	
	
	
	/**
	 * 상품 삭제
	 * @param product
	 * @return
	 */
	public int delete(String productId) {
		int result = 0;
		String sql = " DELETE FROM product "
				   + " WHERE product_id = ? ";
		
		try {
				psmt = con.prepareStatement(sql);
				
				psmt.setString(1, productId);
				
				result = psmt.executeUpdate();
				
				
		} catch (SQLException e) {
			System.err.println("상품 삭제시, 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

}





























