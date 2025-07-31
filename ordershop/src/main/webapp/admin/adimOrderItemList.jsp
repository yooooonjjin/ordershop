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

<script>

	//전체 선택/해제 기능
	 // 전체 선택/해제 기능
    function toggleSelectAll() {
        // 전체 선택 체크박스 상태 확인
        const isChecked = document.getElementById('selectAll').checked;
        
        // 모든 체크박스들 선택
        const checkboxes = document.getElementsByName('selectedProducts'); // name이 'selectedProducts'인 체크박스들
        checkboxes.forEach(function(checkbox) {
            checkbox.checked = isChecked; // 전체 선택/해제
        });
    }
	
	// 선택된 상품만 삭제하기
	function deleteSelected(){
	    const selectedProducts = [];

	    document.querySelectorAll('input[name="selectedProducts"]:checked').forEach(function (checkbox) {
	        selectedProducts.push(checkbox.value);
	    });

	    if (selectedProducts.length === 0) {
	        alert("삭제할 상품을 선택해주세요.");
	        return false;
	    }

	    $.ajax({
	        url: '/adminProductDelete',
	        type: 'POST',
	        contentType: 'application/json',  // JSON 전송
	        data: JSON.stringify(selectedProducts),  // 배열 전송
	        success: function (response) {
	            alert(response);  // 성공 메시지
	            location.reload();  // 페이지 새로고침
	        },
	        error: function () {
	            alert("삭제 중 오류가 발생했습니다.");
	        }
	    });
	
	}

</script>


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
             
                     <h2><a href="/adimOrderItemList">주문 관리</a></h2>
                   <h3>⦁ 주문 목록</h3>
                  
                   
                   <!--top_menu -->
                   <div class="top_menu">
                      <div class="delete_selection">
                     
                      </div>
                      <!-- search_menu -->
                      
                      <form method="get" action="adimOrderItemList">
					  		<div class="search_menu">
						      <select id="searchKey">
						          <option value="member_no">상품명</option>
						      </select>
						      <input type="text" id="value" name="value" placeholder="검색어를 입력해주세요." value="${param.value}">
						        <input type="submit" class="search_button" value="검색">
					    	</div>
					</form>					
                      
                   </div>
                    
                        
         
               <!-- membertable 목록 -->
               <!-- 총 회원인원 -->
               <div class="member_total">총:<span class="member_tatal_point">${total}</span> 개 </div>   
               <table class="membertable">
                  <colgroup>
                      <col style="width: 5%">
                      <col style="width: 15%">
                      <col style="width: 15%">
                      <col style="width: 15%">
                      <col style="width: *%">
                      <col style="width: 10%">
                      <col style="width: 10%">
                      <col style="width: 10%">
                  </colgroup>
                  <tr>
                     <th>번호</th>
                     <th>회원아이디</th>
                     <th>상품명</th>
                     <th>상품코드</th>
                     <th>주문날짜</th>
                     <th>가격</th>
                     <th>수량</th>
                     <th>상태</th>
                  </tr>
                
                
               
			
			    <!-- 상품 리스트 출력 -->
			    
               <c:forEach var="result" items="${list}" varStatus="status">
                   <tr>
                       <td>${pageRownum - status.index}</td>
                       <td>${result.USER_NO }</td>
                       <td>${result.PRODUCT_NAME }</td>  
                       <td>${result.PRODUCT_NO }</td>
                       <td>${result.ORDER_RDATE }</td>
                       <td>${result.TOTAL_PRICE }</td>
                       <td>${result.ORDER_CNT }</td>
                       <td>
						    <c:if test="${result.ORDER_STATUS == 'Y'}">
						        <span style="color:blue;">입금완료</span>
						    </c:if>
						    <c:if test="${result.ORDER_STATUS == 'N'}">
						        <span style="color:red;">입금전</span>
						    </c:if>
						</td>
                   </tr>
               </c:forEach>

          </table>
         

                    <!-- 페이징 -->
 <div class="div_page">
<a href="/adimOrderItemList?pageIndex=1&value=${param.value}" class="page_arrow">«</a>
<c:choose>
    <c:when test="${currentPage > 1}">
        <a href="/adimOrderItemList?pageIndex=${currentPage - 1}&value=${param.value}" class="page_arrow">‹</a>
    </c:when>
    <c:otherwise>
        <a href="javascript:void(0);" class="page_arrow disabled">‹</a>
    </c:otherwise>
</c:choose>

<c:forEach var="p" begin="1" end="${totalPage}">
<c:if test="${p == currentPage}">
<a href="/adimOrderItemList?pageIndex=${p}&value=${param.value}" class="active">${p}</a>
</c:if>
<c:if test="${p != currentPage}">
<a href="/adimOrderItemList?pageIndex=${p}&value=${param.value}">${p}</a>
</c:if>
</c:forEach>

<c:choose>
    <c:when test="${currentPage < totalPage}">
        <a href="/adimOrderItemList?pageIndex=${currentPage + 1}&value=${param.value}" class="page_arrow">›</a>
    </c:when>
    <c:otherwise>
        <a href="javascript:void(0);" class="page_arrow disabled">›</a>
    </c:otherwise>
</c:choose>
<a href="/adimOrderItemList?pageIndex=${totalPage}&value=${param.value}" class="page_arrow">»</a>
</div>
                </section>
            </div>
        </section>
    </section>
</body>
</html>
 
 
