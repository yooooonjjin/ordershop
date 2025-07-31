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

function showConfirm(cancelNum, cancelStatus, spanElement) {
    if (cancelStatus === 'N') { // '취소요청' 상태일 때만 동작
        // confirm 창 띄우기
        const isConfirmed = confirm("취소 요청을 처리하시겠습니까?");
        
        if (isConfirmed) {
            // '확인'을 클릭했을 때 AJAX 요청을 보내서 cancel_status를 'Y'로 변경
            updateCancelStatus(cancelNum, spanElement);
        }
    }
}

function updateCancelStatus(cancelNum, spanElement) {
    // 취소 번호를 데이터로 서버에 전송
    const datas = cancelNum;

    // AJAX 요청
    $.ajax({
        data: "datas=" + JSON.stringify(datas), // 데이터를 문자열로 전달
        type: "POST",
        url: "/updateCancelStatus", // 컨트롤러 URL
        dataType: "text",
        success: function(response) {
            if (response === "ok") {
                // 상태가 Y로 변경되면, 화면의 텍스트 변경
                spanElement.innerHTML = '<span style="color:blue;">취소완료</span>';
                alert("취소 완료");
            } else {
                alert("상태 변경 실패");
            }
        },
        error: function() {
            alert("상태 업데이트 중 오류 발생");
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
             
                     <h2><a href="/adimCancelOrderList">취소 관리</a></h2>
                   <h3>⦁ 취소 목록</h3>
                  
                   
                   <!--top_menu -->
                   <div class="top_menu">
                      <div class="delete_selection">

                      </div>
                      <!-- search_menu -->
                      
                      <form method="get" action="adimCancelOrderList">
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
                      <col style="width: 10%">
                      <col style="width: 10%">
                      <col style="width: *%">
                      <col style="width: 10%">
                      <col style="width: 10%">
                      <col style="width: 10%">
                  </colgroup>
                  <tr>
                     <th>번호</th>
                     <th>회원아이디</th>
                     <th>상품명</th>
                     <th>주문(결제)번호</th>
                     <th>취소 사유</th>
                     <th>취소날짜</th>
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
                       <td>${result.ORDER_ID }</td>
                       <td>${result.CANCEL_REASON }</td>
                       <td>${result.CANCEL_DATE }</td>
                       <td>${result.REFUND_PRICE }</td>
                       <td>${result.ORDER_CNT }</td>
                       <td>
						    <c:choose>
						        <c:when test="${result.CANCEL_STATUS == 'Y'}">
						            <span style="color:blue;">취소완료</span>
						        </c:when>
						        <c:when test="${result.CANCEL_STATUS == 'N'}">
						            <span style="color:red; cursor:pointer;" onclick="showConfirm(${result.CANCEL_NUM}, '${result.CANCEL_STATUS}', this)">취소요청</span>
						        </c:when>
						    </c:choose>
						</td>
                   </tr>
               </c:forEach>

          </table>
          
          <div id="cancelModal" class="cancelmodal" style="display:none;">
			  <div class="cancelmodal-content">
			    <p>취소 요청을 어떻게 처리하시겠습니까?</p>
			    <button onclick="updateCancelStatus(this, '취소거부')">취소거부</button>
			    <button onclick="updateCancelStatus(this, '취소확인')">취소확인</button>
			  </div>
			</div>
          

                    <!-- 페이징 -->
 <div class="div_page">
<a href="/adimCancelOrderList?pageIndex=1&value=${param.value}" class="page_arrow">«</a>
<c:choose>
    <c:when test="${currentPage > 1}">
        <a href="/adimCancelOrderList?pageIndex=${currentPage - 1}&value=${param.value}" class="page_arrow">‹</a>
    </c:when>
    <c:otherwise>
        <a href="javascript:void(0);" class="page_arrow disabled">‹</a>
    </c:otherwise>
</c:choose>

<c:forEach var="p" begin="1" end="${totalPage}">
<c:if test="${p == currentPage}">
<a href="/adimCancelOrderList?pageIndex=${p}&value=${param.value}" class="active">${p}</a>
</c:if>
<c:if test="${p != currentPage}">
<a href="/adimCancelOrderList?pageIndex=${p}&value=${param.value}">${p}</a>
</c:if>
</c:forEach>

<c:choose>
    <c:when test="${currentPage < totalPage}">
        <a href="/adimCancelOrderList?pageIndex=${currentPage + 1}&value=${param.value}" class="page_arrow">›</a>
    </c:when>
    <c:otherwise>
        <a href="javascript:void(0);" class="page_arrow disabled">›</a>
    </c:otherwise>
</c:choose>
<a href="/adimCancelOrderList?pageIndex=${totalPage}&value=${param.value}" class="page_arrow">»</a>
</div>
                </section>
            </div>
        </section>
    </section>
</body>
</html>
 
 
