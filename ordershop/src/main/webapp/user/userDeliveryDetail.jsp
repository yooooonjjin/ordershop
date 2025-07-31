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
					<p class="p_title">주문 내역 상세 정보</p>
				</div>
				
                <div class="ord_detailWrap">
                    <div class="ord_priInfo">
                        <div class="ord_detail_L">
                            <img src="${orderDetail.filepath}${orderDetail.product_img}" alt="상품 이미지" style="width:250px; height:250px;">
                        </div>
                        <div class="ord_detail_R">
                            <div class="ord_num">
                                <p>주문번호 ${orderDetail.order_id}</p>
                            </div>
                            <div class="ord_title">
                                <p class="ord_name">${orderDetail.product_name}</p>
                                <p>${orderDetail.product_description}</p>
                            </div>
                            <div class="ord_price">
                                <div class="ordS_price">
                                    <p>
                                        
                                       <c:if test="${orderDetail.product_sale != 0}">
											${orderDetail.product_sale}%
										</c:if>
										<span>
											<fmt:formatNumber value="${orderDetail.product_price}" type="number"/>원
										</span>
                                    </p>    
                                </div>
                                <div class="ordP_price">
                                        <p>
                                            <fmt:formatNumber value="${orderDetail.product_final_price}" type="number"/>원
                                        </p>
                                </div>
                                <div class="ord_cnt">
                                    <p>${orderDetail.total_price}원 / ${orderDetail.order_cnt}개</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="user_info">
                        <div class="t_title">
                            <p>구매자 정보</p>
                        </div>
                        <table class="table">
                            <colgroup>
                                <col width="25%">
                                <col width="*">
                            </colgroup>
                            <tbody>
                            	<tr>
	                                <th><label>구매자명</label></th>
	                                <td>
	                                    <input type="text" name="user_name" value="${orderDetail.user_name}" readonly>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th><label>연락처</label></th>
	                                <td>
	                                    <input type="text" name="user_phone" value="${orderDetail.user_phone}" readonly>
	                                </td>
	                            </tr>
                        	</tbody>
                        </table>
                    </div>

                    <div class="recipient_info">
                        <div class="t_title">
                            <p>배송지 정보</p>
                        </div>
                        <table class="table">
                            <colgroup>
                                <col width="25%">
                                <col width="*">
                            </colgroup>
                            <tbody><tr>
                                <th><label>받는분</label></th>
                                <td>
                                    <input type="text" name="user_name" value="${orderDetail.recipient_name}" readonly>
                                </td>
                            </tr>
                            <tr>
                                <th><label>배송지</label></th>
                                <td>
                                    <input type="text" name="user_phone" value="${orderDetail.recipient_address}" readonly>
                                </td>
                            </tr>
                            <tr>
                                <th><label>요청사항</label></th>
                                <td>
                                    <input type="text" name="user_phone" value="${orderDetail.delivery_request}" readonly>
                                </td>
                            </tr>
                        </tbody></table>
                    </div>

                    <div class="payment_info">
                        <div class="t_title">
                            <p>결제 정보</p>
                        </div>
                        <table class="table">
                            <colgroup>
                                <col width="25%">
                                <col width="*">
                            </colgroup>
                            <tbody><tr>
                                <th><label>결제금액</label></th>
                                <td>
                                    <input type="text" name="user_name" value="${orderDetail.pay_method}" readonly>
                                </td>
                            </tr>
                            <tr>
                                <th><label>결제수단</label></th>
                                <td>
                                	<input type="text" name="user_phone" value="<fmt:formatNumber value='${orderDetail.total_price}' type='number'/>" readonly>
                                </td>
                            </tr>
                        </tbody></table>
                    </div>
                </div>

                <div class="under_btn_wrap">
                    <button type="button" class="blue_btn" onclick="location.href='/userDelivery'">목록</button>
                </div>

            </div>
        </div>
        
    </section>
</body>
</html>
