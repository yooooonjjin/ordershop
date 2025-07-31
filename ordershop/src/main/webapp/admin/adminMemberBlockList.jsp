<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
 <!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>회원관리시스템(관리자)</title>
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
             
                     <h2>회원 관리</h2>
                   <h3>⦁ 차단회원 목록</h3>
                   <!--top_menu -->
                   <div class="top_menu">
                      <div class="delete_selection">
                      
                      </div>
                      <!-- search_menu -->
                      
                      <form method="get" action="/adminMemberBlockList">
                      <div class="search_menu" name="key">
                      <select id="searchKey" name="key">
                     <option value="member_no" <c:if test="${param.key == 'member_no'}">selected</c:if>>회원번호</option>
                    <option value="member_id" <c:if test="${param.key == 'member_id'}">selected</c:if>>아이디</option>
                          <option value="member_name" <c:if test="${param.key == 'member_name'}">selected</c:if>>이름</option>
                      </select> 
                      <input type="text"  name="value" placeholder="검색어를 입력해주세요." value="${param.value}">
                      <input type="submit" class="search_button" value="검색"  >
                      </div>
                      </form>
                      
                   </div>
            
                        
         
               <!-- membertable 목록 -->
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
                      <col style="width: 15%">
                      <col style="width: 20%">
                  </colgroup>
                  <tr>
                     
                     <th>번호</th>
                     <th>회원번호</th>
                     <th>회원아이디</th>
                     <th>회원이름</th>
                     <th>가입날짜</th>
                     <th>삭제날짜</th>
                     <th>삭제이유</th>
                  </tr>
                  
               <c:forEach var="blockmember" items="${blockmemberList}" varStatus="status">
                   <tr>
                     <td>${total - (status.index)}</td>
                       <td>${blockmember.USER_NO}</td>
                       <td>${blockmember.USER_ID}</td>  
                       <td>${blockmember.USER_NAME}</td>
                       <td>${fn:substring(blockmember.USER_JOIN,0,10)}</td> 
                       <td>${fn:substring(blockmember.BLOCK_DATE,0,10)}</td>
                       <td>${blockmember.BLOCK_REASON}vv</td>

                   </tr>
               </c:forEach>
               
               </table>
            
                     <!-- 페이징 -->
<div class="div_page">
  <a href="/adminMemberBlockList?pageIndex=1" class="page_arrow">«</a>
  <a href="/adminMemberBlockList?pageIndex=${currentPage - 1}" class="page_arrow">‹</a>                    

  <c:forEach var="p" begin="1" end="${totalPage}">
    <c:if test="${p == currentPage}">
      <a href="/adminMemberBlockList?pageIndex=${p}" class="active">${p}</a>
    </c:if>
    <c:if test="${p != currentPage}">
      <a href="/adminMemberBlockList?pageIndex=${p}">${p}</a>
    </c:if>
  </c:forEach>

  <a href="/adminMemberBlockList?pageIndex=${currentPage + 1}" class="page_arrow">›</a>
  <a href="/adminMemberBlockList?pageIndex=${totalPage}" class="page_arrow">»</a>
</div>

                                  
            
         
                    
                           
            
                </section>
                <!-- 작업 공간 -->
            

            </div>

        </section>

    </section>
    








</body>
</html>
 
 
 
