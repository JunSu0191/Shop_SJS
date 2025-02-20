<!-- 로그인 처리 -->
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   
   String id = request.getParameter("id");
   String pw = request.getParameter("pw");
   
   User user = new User();
   user.setId(id);
   user.setPassword(pw);
   
   UserRepository userDAO = new UserRepository();
   User loginUser = userDAO.login(id, pw);
   List<Product> cartList = (List<Product>) session.getAttribute("cartList");
   // 로그인 실패
   if( loginUser == null ) {
      response.sendRedirect("login.jsp?error=0");
      return;
   }
   
   // 로그인 성공
   // - 세션에 아이디 등록
   String root = request.getContextPath();
   if( loginUser != null) {
      session.setAttribute("loginId", loginUser.getId() );
   }
   
   // 아이디 저장
   String rememberId = request.getParameter("remember-id");
   Cookie cookieRememberId = new Cookie("rememberId", "");
   Cookie cookieUserId = new Cookie("userId", "");
   

   // 체크 박스 체크 시, 값 : on
   if (rememberId != null && rememberId.equals("on")) {
      // 쿠키 생성
      // UTF-8 으로 인코딩하여 값을 저장해야한다.
      cookieRememberId.setValue( URLEncoder.encode( rememberId, "UTF-8" ));
      cookieUserId.setValue( URLEncoder.encode( id, "UTF-8" ));
   }
   // 체크 박스 미체크 시
   else {
      // 쿠키 삭제
      cookieRememberId.setMaxAge(0);
      cookieUserId.setMaxAge(0);
   }
   
   // 쿠키 전달
   // 쿠키 응답에 등록
   response.addCookie(cookieRememberId);
   response.addCookie(cookieUserId);
   // 아이디 저장(끝)
   
   
   // 자동 로그인
   String rememberMe = request.getParameter("remember-me");
   Cookie cookieRemeberMe = new Cookie("rememberMe", "");
   Cookie cookieToken = new Cookie("token", "");
   
   // 자동 로그인 체크 여부, 토큰 쿠키에 대한 경로 설정
   cookieRemeberMe.setPath("/");
   cookieToken.setPath("/");
   // 쿠키 유효기간 설정
   cookieRemeberMe.setMaxAge(7*60*60*24);      // 초단위 --> 7일
   cookieToken.setMaxAge(7*60*60*24);
   
   // 체크 여부에 따라 쿠키 생성 또는 삭제
   if( rememberMe != null && rememberMe.equals("on") ) {
      // 자동 로그인 체크
      // - 토큰 발행
      String tokenValue = userDAO.refreshToken(id);
      // - 쿠키 생성
      cookieRemeberMe.setValue( URLEncoder.encode( rememberMe, "UTF-8") );
      cookieToken.setValue( URLEncoder.encode( tokenValue, "UTF-8") );
   } else {
      // 자동 로그인 미체크
      // 쿠키 삭제
      cookieRemeberMe.setMaxAge(0);
      cookieToken.setMaxAge(0);
   }
   
   // 쿠키 전달
   // 응답에 쿠키 등록
   response.addCookie(cookieRemeberMe);
   response.addCookie(cookieToken);
   // 자동 로그인(끝)

   
   
   // 로그인 성공 페이지로 이동
   response.sendRedirect("complete.jsp?msg=0");    

%>





