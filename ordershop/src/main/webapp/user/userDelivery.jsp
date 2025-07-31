<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>결제시스템(사용자)</title>
  <link rel="stylesheet" href="css/total.css" />
  <link rel="stylesheet" href="css/user.css" />
  <script src="../js/jquery.min.js"></script>
  <script src="../js/jquery-3.7.1.min.js"></script>
  <script src="../js/jquery-ui.js"></script>
  <script src="../js/main.js"></script>
</head>

<script>
 $(function() {
	   const openModalBtn    = document.getElementById('openModalBtn');
	   const closeModalBtn = document.getElementById('closeModalBtn'); 
	   const cancelModalBtn = document.getElementById('cancelModalBtn');
	   
	   openModalBtn.addEventListener('click',() => {
		   deliveryCancle_modal.classList.remove('hidden');
	   })
	   
	   closeModalBtn.addEventListener('click',() => {
		   deliveryCancle_modal.classList.add('hidden');
	   })
	   
	   cancelModalBtn.addEventListener('click',() => {
		   deliveryCancle_modal.classList.add('hidden');
	   })
	});   
 </script>
 
<body>

   <!-- user_header S -->
	<%@ include file ="/include/user_header.jsp" %>
	<!-- user_header E -->

    <section id="content_wrap">
        <div class="con_inner inner_L center">
            <div class="con_title">
                <p>마이페이지</p>
            </div>
        </div>
        <div class="con_inner inner_R center">
            <div class="aside">
                <ul>
                    <li>
                        <a href="#none">주문 / 배송 조회</a>
                    </li>
                    <li>
                        <a href="#none">취소 내역</a>
                    </li>
                    <li>
                        <a href="#none">장바구니</a>
                    </li>
                    <li>
                        <a href="#none">1:1 문의</a>
                    </li>
                </ul>
            </div>
            
            
            <div class="mypage_content">
				<div class="top_con">
					<p class="p_title">주문 / 배송 조회</p>

	                <!-- 검색창 -->
	                <div class="p_search">
	                   <form method="get" action="">
	                   		<input type="hidden" name="pay_status" value="${param.pay_status}" />
						  	<input type="text" name="searchWord" value="" placeholder="검색어를 입력해주세요.">
						  	<button type="submit" class="blue_btn">검색</button>
						</form>
	                </div>
	                <!-- 검색창 -->
				</div>
				<div class="tab_wrap">
					<ul class="tab_btn">
					    <li>
					    	<a href="?pay_status=ALL&searchWord=${param.searchWord}" class="${param.pay_status == 'ALL' || empty param.pay_status ? 'active' : ''}">전체</a>
					    </li>
					    <li>
					    	<a href="?pay_status=N&searchWord=${param.searchWord}" class="${param.pay_status == 'N' ? 'active' : ''}">입금전</a>
					    </li>
					    <li>
					    	<a href="?pay_status=Y&searchWord=${param.searchWord}" class="${param.pay_status == 'Y' ? 'active' : ''}">입금완료</a>
					    </li>
					</ul>
					
					<c:forEach var="orderList" items="${orderList}">
						<div class="my_orderList">
	                    	<div class="order_L">
	                            <div class="UD_img">
	                                <img src="${orderList.FILEPATH }${orderList.PRODUCT_IMG }" alt="상품이미지" style="width:143px; height:143px;">
	                            </div>
	                            <div class="UD_info">
	                                <p class="P_name">${orderList.PRODUCT_NAME }</p>
	                                <p>${orderList.PRODUCT_DESCRIPTION }</p>
	                            </div>
	                        </div>
	                        <div class="order_R">
	                            <div class="UD_cnt">
	                                <p>${orderList.ORDER_CNT }<span>개</span></p>
	                            </div>
	                            <div class="UD_price">
	                                <p>
	                               		<fmt:formatNumber value="${orderList.TOTAL_PRICE }" type="number"/>
	                               		<span>원</span>
	                               	</p>
	                            </div>
	                            <div>
	                            	<button type="button" class="delivery_detailBtn blue_border_btn" onclick="location.href='/userDeliveryDetail?order_id=${orderList.ORDER_ID}'">주문상세</button>
	                            </div>
	                        </div>
	                    </div>
					</c:forEach>
                    <div class="div_page">
					    <!-- 처음 버튼 -->
					    <a href="/userDelivery?pageIndex=1&pay_status=${param.pay_status}"
					       class="page_icon <c:if test='${uorderDto.pageIndex == 1}'>disabled</c:if>"
					       <c:if test='${uorderDto.pageIndex == 1}'>tabindex="-1" aria-disabled="true" onclick="return false;"</c:if>>
					        <img src="images/page_first.svg" alt="처음 버튼">
					    </a>
					
					    <!-- 이전 버튼 -->
					    <a href="/userDelivery?pageIndex=${uorderDto.pageIndex - 1}&pay_status=${param.pay_status}"
					       class="page_icon <c:if test='${uorderDto.pageIndex == 1}'>disabled</c:if>"
					       <c:if test='${uorderDto.pageIndex == 1}'>tabindex="-1" aria-disabled="true" onclick="return false;"</c:if>>
					        <img src="images/page_prev.svg" alt="이전 버튼">
					    </a>
					
					    <!-- 페이지 번호 -->
					    <c:forEach var="p" begin="1" end="${uorderDto.totalPage}">
					        <a href="/userDelivery?pageIndex=${p}&pay_status=${param.pay_status}"
					           class="page_num <c:if test='${p == uorderDto.pageIndex}'>current_page</c:if>">
					            ${p}
					        </a>
					    </c:forEach>
					
					    <!-- 다음 버튼 -->
					    <a href="/userDelivery?pageIndex=${uorderDto.pageIndex + 1}&pay_status=${param.pay_status}"
					       class="page_icon <c:if test='${uorderDto.pageIndex == uorderDto.totalPage || uorderDto.totalPage == 0}'>disabled</c:if>"
					       <c:if test='${uorderDto.pageIndex == uorderDto.totalPage || uorderDto.totalPage == 0}'>tabindex="-1" aria-disabled="true" onclick="return false;"</c:if>>
					        <img src="images/page_next.svg" alt="다음 버튼">
					    </a>
					
					    <!-- 끝 버튼 -->
					    <a href="/userDelivery?pageIndex=${uorderDto.totalPage}&pay_status=${param.pay_status}"
					       class="page_icon <c:if test='${uorderDto.pageIndex == uorderDto.totalPage || uorderDto.totalPage == 0}'>disabled</c:if>"
					       <c:if test='${uorderDto.pageIndex == uorderDto.totalPage || uorderDto.totalPage == 0}'>tabindex="-1" aria-disabled="true" onclick="return false;"</c:if>>
					        <img src="images/page_last.svg" alt="끝 버튼">
					    </a>
					</div>
				</div>
            </div>
        </div>
        
    </section>
</body>
</html>
