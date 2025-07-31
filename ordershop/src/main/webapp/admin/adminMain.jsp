<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>결제시스템(관리자)</title>
  <link rel="stylesheet" href="css/total.css" />
  <link rel="stylesheet" href="css/admin_style.css" />
  <script src="js/jquery-3.7.1.min.js"></script>
  <script src="js/jquery.min.js"></script>
  <script src="js/main.js"></script>
</head>
<body>

    <!-- skip 네비게이션 영역 -->
    <nav id="skipToContent">
        <ul>
            <li><a href="#container">Skip to Main Content</a></li>
            <li><a href="#gnb">Skip to Main Menu</a></li>
            <li><a href="#header">Skip to Upeer Menu</a></li>
            <li><a href="#footers">Skip to Lower Menu</a></li>
        </ul>
    </nav>
    <!-- skip 네비게이션 영역 -->

    <section id="admin_wrap">
         <aside class="aside">
            <a href="/adminMain" class="tit_wrap">
                    <h1 class="tit_h1">
                        <span class="blind">logo</span>
                    </h1>
                </a>
            <ul>
                <li>
                    <a href="#none" class="menu01">회원 관리</a>
                    <ul class="menu02">
                        <li>
                            <a href="/adminMemberList">회원 목록</a>
                        </li>
                        <li>
                            <a href="/adminMemberDeleteList">삭제 회원 목록</a>
                        </li>
                        <li>
                            <a href="/adminMemberBlockList">차단 회원 목록</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#none" class="menu01">상품 관리</a>
                    <ul class="menu02">
                        <li>
                            <a href="/adminProductList">상품 목록</a>
                        </li>
                        <li>
                            <a href="/adminProductWrite">상품 등록</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#none" class="menu01">주문 관리</a>
                    <ul class="menu02">
                        <li>
                            <a href="/adimOrderItemList">주문 목록</a>
                        </li>
                        <li>
                            <a href="/adimCancelOrderList">취소 목록</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </aside>

        <section id="admin_content">
            <div class="content_wrap">
                <header id="admin_header">
                    <ul class="snb">
                 
                        <li>
                            <a href="#none">로그아웃</a>
                        </li>
                    
                    </ul>
                </header>

                <!-- 작업 공간 -->
                <section id="admin_section">
                                      <h3>⦁ 상품 목록</h3>
                   
            
                     
               <!-- product 목록 -->
               <!-- 총 상품갯수 -->
               <div class="member_total">총:<span class="member_total_point">${productTotal}</span> 개 </div>   
               <table class="membertable">
                  <colgroup>
                      <col style="width: 10%">
                      <col style="width: 10%">
                      <col style="width: 20%">
                      <col style="width: 15%">
                      <col style="width: 15%">
                      <col style="width: *%">
                  </colgroup>
                  <tr>
                     <th>상품번호</th>
                     <th>상품코드</th>
                     <th>상품명</th>
                     <th>판매가</th>
                     <th>할인가</th>
                     <th>판매URL</th>
                  </tr>  
			
			    <!-- 상품 리스트 출력 -->
			    
	                 <c:forEach var="result" items="${productList}" varStatus="status">
	                     <tr>
	                         <td>${productTotal - status.index}</td>
	                         <td>${result.PRODUCT_NO}</td>
	                         <td>${result.PRODUCT_NAME}</td>  
	                         <td>${result.PRODUCT_PRICE}원</a></td>
	                         <td>${result.PRODUCT_FINAL_PRICE}원</td>
	                         <td>${result.PRODUCT_URL}</td>
	                     </tr>
	                 </c:forEach>

             </table>
               <div class="admin_main_Detailed">
                  <a href="/adminProductList">자세히</a>
               </div>
                

               
                   <h3>⦁ 회원 목록</h3>
                   
            
                     
               <!-- membertable 목록 -->
               <!-- 총 회원인원 -->
               <div class="member_total">총:<span class="member_total_point">${total}</span> 명 </div>   
               <table class="membertable">
                  <colgroup>
               
                      <col style="width: 10%">
                      <col style="width: 10%">
                      <col style="width: 15%">
                      <col style="width: 15%">
                      <col style="width: 15%">
                      <col style="width: 5%">
                      <col style="width: 15%">
                  </colgroup>
                  <tr>
                     
                     <th>번호</th>
                     <th>회원번호</th>
                     <th>회원아이디</th>
                     <th>회원이름</th>
                     <th>연락처</th>
                     <th>성별</th>
                     <th>가입날짜</th>
                  </tr>
               <c:forEach var="member" items="${memberList}" varStatus="status">
                   <tr>
                     <td>${total - (status.index)}</td>
                       <td>${member.USER_NO}</td>
                       <td><a href="/adminMemberDetail/${member.USER_NO}">${member.USER_ID}</a></td>  
                       <td><a href="/adminMemberDetail/${member.USER_NO}">${member.USER_NAME}</a></td>
                       <td>${member.USER_PHONE}</td>
                       <td>${member.USER_GENDER}</td>
                       <td>${fn:substring(member.USER_JOIN,0,10)}</td> 

                   </tr>
               </c:forEach>
               
               </table>
               <div class="admin_main_Detailed">
                  <a href="/adminMemberList">자세히</a>
               </div>
                </section>
                <!-- 작업 공간 -->

            </div>

        </section>

    </section>
    








</body>
</html>
 
 
 
