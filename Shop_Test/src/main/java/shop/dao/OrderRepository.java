package shop.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
    
    /**
     * 주문 등록
     * @param order
     * @return
     */
    public int insert(Order order) {
        int result = 0;
        String sql = "INSERT INTO order (ship_name, zip_code, country, address, date, order_pw, user_id, total_price, phone) VALUES (?, ?, ?, ?, NOW(), ?, ?, ?, ?)";
        
        try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, order.getShipName());
            psmt.setString(2, order.getZipCode());
            psmt.setString(3, order.getCountry());
            psmt.setString(4, order.getAddress());
            psmt.setString(5, order.getOrderPw());
            psmt.setString(6, order.getUserId());
            psmt.setInt(7, order.getTotalPrice());
            psmt.setString(8, order.getPhone());
            result = psmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("주문 등록 중 예외 발생");
            e.printStackTrace();
        }
        return result;
    }

    /**    
     * 최근 등록한 orderNo 
     * @return
     */
    public int lastOrderNo() {
        int lastOrderNo = 0;
        String sql = "SELECT MAX(order_no) AS lastOrderNo FROM order";
        
        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            rs = psmt.executeQuery();
            if (rs.next()) {
                lastOrderNo = rs.getInt("lastOrderNo");
            }
        } catch (SQLException e) {
            System.err.println("최근 주문번호 조회 중 예외 발생");
            e.printStackTrace();
        }
        return lastOrderNo;
    }

    
    /**
     * 주문 내역 조회 - 회원
     * @param userId
     * @return
     */
    public List<Product> list(String userId) {
        List<Product> orderList = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE user_id = ?";
        
        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            psmt.setString(1, userId);
            rs = psmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setOrderNo( rs.getInt("orderNo"));
                product.setProductId(rs.getString("product_id"));
                product.setName(rs.getString("name"));
                product.setUnitPrice(rs.getInt("unit_price"));
                orderList.add(product);	
            }
        } catch (SQLException e) {
            System.err.println("회원의 주문 내역 조회 중 예외 발생");
            e.printStackTrace();
        }
        return orderList;
    }
    
    /**
     * 주문 내역 조회 - 비회원
     * @param phone
     * @param orderPw
     * @return
     */
    public List<Product> list(String phone, String orderPw) {
        List<Product> orderList = new ArrayList<>();
        String sql = "SELECT * FROM order WHERE phone = ? AND order_pw = ?";
        
        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            psmt.setString(1, phone);
            psmt.setString(2, orderPw);
            rs = psmt.executeQuery();
            while (rs.next()) {
            	  Product product = new Product();
                  product.setOrderNo( rs.getInt("orderNo"));
                  product.setProductId(rs.getString("product_id"));
                  product.setName(rs.getString("name"));
                  product.setUnitPrice(rs.getInt("unit_price"));
                  orderList.add(product);	
            }
        } catch (SQLException e) {
            System.err.println("비회원의 주문 내역 조회 중 예외 발생");
            e.printStackTrace();
        }
        return orderList;
    }
}
