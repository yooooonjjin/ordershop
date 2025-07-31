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
  <title>사용자(상품 상세 화면)</title>
  <link rel="stylesheet" href="/css/total.css" />
  <link rel="stylesheet" href="/css/user.css" />
  <script src="../js/jquery.min.js"></script>
  <script src="../js/jquery-3.7.1.min.js"></script>
  <script src="../js/jquery-ui.js"></script>
  <script src="../js/main.js"></script>
</head>

<script>

$(function() {
	const price = parseInt("${dto.product_final_price}".replace(/[^0-9]/g,''));	//숫자만 추출
	let quantity = 1;	// 상품 수량 기본값 1
	
	function updatePrice() {
		$('#quantity_cnt').text(quantity);		// 상품 수량 표시
		$('#quantity_hidden').val(quantity);	// 상품 수량 동기화
		$('#order_cnt').val(quantity);
		
		$('#final_price').text((price*quantity).toLocaleString());	// 천 단위 콤마 표시
		
		// 수량이 1일 때 마이너스 버튼 비활성화
		if ( quantity <= 1 ) {
			$('#btnMinus').prop('disabled', true);
		} else {
			$('#btnMinus').prop('disabled', false);
		}
	}
	// + 버튼 수량 증가
	$("#btnPlus").click(function(){
		quantity++;
    	updatePrice();
	});
	
	// - 버튼 수량 감소
	$("#btnMinus").click(function(){
		if (quantity > 1) {
            quantity--;
            updatePrice();
        }
	});

	$('#cartBtn').click(function(){
		
		let cartData = $("#Frm").serialize();

		$.ajax({
			type : "POST",
		    data : cartData,
			url  : "/userCartInsert",
			dataType : "text",
			success  : function() {
				location = "/userCart";
			},
			error   : function() {
				alert("오류 발생!")
			} 
		});
	});
	
	$('#paymentBtn').click(function(){
	    // 폼 action 변경
	    $('#Frm').attr('action', '/userPayment');
	    $('#Frm').attr('method', 'post');
	    $('#Frm').submit();
	});

});

</script>


<body>

	<!-- user_header S -->
	<%@ include file ="/include/user_header.jsp" %>
	<!-- user_header E -->
	
    <section id="content_wrap">
        <div class="con_inner center">
            <div class="con_title">
                <p>상품 상세</p>
            </div>

			<form id="Frm" method="post">
				<input type="hidden" id="product_no" name="product_no" value="${dto.product_no }">
				<input type="hidden" id="product_name" name="product_name" value="${dto.product_name }">
				<input type="hidden" id="product_description" name="product_description" value="${dto.product_description }">
				<input type="hidden" id="product_price" name="product_price" value="${dto.product_price}">
				<input type="hidden" id="price_snapshot" name="price_snapshot" value="${dto.product_final_price}">
				<input type="hidden" id="sale_snapshot" name="sale_snapshot" value="${dto.product_sale}">
				<input type="hidden" id="filepath" name="filepath" value="${dto.filepath}">
				<input type="hidden" id="product_img" name="product_img" value="${dto.product_img}">
				<input type="hidden" id="order_cnt" name="order_cnt" id="quantity_hidden" value="1">
								
				<div id="PD_wrap" class="con_wrap">
	                <div class="PD_img">
	                    <img src="${dto.filepath }${dto.product_img}" alt="상품이미지">
	                </div>
	                <div class="border"></div>
	                <div class="PD_info">
	                    <div class="P_text">
	                        <div class="P_title">
	                            <p class="P_name">${dto.product_name }</p>
	                            <p>${dto.product_description }</p>
	                        </div>
	                        <div class="S_price">
	                            <P>
		                            <c:if test="${dto.product_sale != 0 }">
										${dto.product_sale }% 
									</c:if>
									<span>
										<fmt:formatNumber value="${dto.product_final_price }" type="number"/>원
									</span>
	                            </P>
	                            	
	                        </div>
	                        <div class="P_price">
	                        	<c:if test="${dto.product_sale != 0 }">
									<p>
										<fmt:formatNumber value="${dto.product_price }" type="number"/>원
									</p>
								</c:if>
	                        </div>
	                    </div>
	                    <div class="delivery_wrap">
	                        <div class="delivery_box">
	                            <label>배송방법</label>
	                            <P>${dto.delivery_mth }</P>
	                        </div>
	                        <div class="delivery_box">
	                            <label>배송비</label>
	                            <P>${dto.delivery_fee }</P>
	                        </div>
	                    </div>
	                    <div class="purchase_wrap">
	                        <div class="cnt_price">
	                            <div class="cnt">
	                                <button type="button" id="btnMinus">-</button>
	                                <p id="quantity_cnt">1</p>
	                                <button type="button" id="btnPlus">+</button>
	                            </div>
	                            <div class="T_price">
	                            
	                                <p>총 상품금액
		                                <span id="final_price">
		                                	<fmt:formatNumber value="${dto.product_final_price }" type="number"/>
		                                </span>원
	                                </p>
	                            </div>
	                        </div>
	                        <div class="btn_wrap">
	                            <button type="button" id="cartBtn" name="cartBtn" class="blue_border_btn">장바구니</button>
	                            <button type="button" id="paymentBtn" name="paymentBtn" class="blue_btn">결제하기</button>
	                        </div>
	                    </div>
	                </div>
	            </div>
			</form>
        </div>
    </section>

</body>
</html>
