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
	const openModalBtn 	= document.getElementById('openModalBtn');
	const closeModalBtn = document.getElementById('closeModalBtn'); 
	const cancelModalBtn = document.getElementById('cancelModalBtn');
	
	openModalBtn.addEventListener('click',() => {
		delivery_modal.classList.remove('hidden');
	})
	
	closeModalBtn.addEventListener('click',() => {
		delivery_modal.classList.add('hidden');
	})
	
	cancelModalBtn.addEventListener('click',() => {
		delivery_modal.classList.add('hidden');
	})
	
	// 등록 버튼 클릭 시 (submit 방지 + 화면 임시 반영)
    $('#modal_saveBtn').click(function(e) {
        e.preventDefault(); // 폼 submit 방지

        // 값 읽기
        var recipientName = $('#recipient_name').val();
        var postcode      = $('#postcode').val();
        var address       = $('#address').val();
        var extraAddress  = $('#extraAddress').val();
        var detailAddress = $('#detailAddress').val();
        var reqOptionText = $('.modal_inner select option:selected').text();

        // 주소 한 줄로 합치기
        var fullAddress = "";
        if(postcode) fullAddress += "(" + postcode + ") ";
        fullAddress += address;
        if(extraAddress) fullAddress += " " + extraAddress;
        if(detailAddress) fullAddress += " " + detailAddress;

        // === 화면에 임시 반영 ===
        // 받는분
        $('input[name="recipient_name"]').val(recipientName);
        // 배송지
        $('input[name="user_address"]').val(fullAddress);
        // 요청사항
        $('.delivery_info textarea').val(reqOptionText);

        // 모달 닫기
        $('#delivery_modal').addClass('hidden');
    });
	
	$('input[name="pay_method"]').val("현대카드");
	
	$('.pay_btnWrap button').click(function() {
        $('.pay_btnWrap button').removeClass('active');
        $(this).addClass('active');
        // 히든 input에 카드사명 입력
        $('input[name="pay_method"]').val($(this).text());
    });
	 
	// 요청사항 select에서 변경 시
	$('.modal_inner select').change(function(){
		var reqText = $(this).find('option:selected').text();
		$('input[name="delivery_request"]').val(reqText);
	});
	
	$("#ordPayBtn").click(function(){
		
		if (confirm("주문 하시겠습니까?")) {
		
			let formData = $('#ordPayInsert').serialize();
			
			$.ajax({
				type : "POST",
				data : formData,
				url : "/userOrdPayInsert",
				
				success : function(data)  {
					alert("주문 완료");
					location = "/userDelivery";
				},
				error : function() {
					alert("오류 발생!");
				}
				
			});
		} else {
			
		}
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
                <p>주문 결제</p>
            </div>
            <div id="PM_wrap" class="con_wrap">
                <form id="ordPayInsert" method="post">
                	<input type="hidden" name="order_id" value="${order_id}">
					<input type="hidden" name="product_no" value="${product_no}">
					<input type="hidden" name="product_name" value="${product_name}">
					<input type="hidden" name="product_description" value="${product_description}">
					<input type="hidden" name="order_cnt" value="${order_cnt}">
					<input type="hidden" name="user_no" value="${user.user_no}">
					<input type="hidden" name="recipient_address" value="${user.user_address}">
					<input type="hidden" name="delivery_method" value="택배">
					<input type="hidden" name="delivery_fee" value="무료">
					<input type="hidden" name="delivery_cate" value="일반">
					<input type="hidden" name="total_price" value="${final_price}">
					<input type="hidden" name="pay_method" value="">
					<input type="hidden" name="delivery_request" value="">
                
                	<div class="PM_con">
	                    <div class="PM_con_L">
	                        <div class="PM_list">
	                            <div class="p_title">
	                                <p>주문 상품</p>
	                            </div>
	                            <div class="order_list">
	                                <div class="order_L">
	                                    <div class="PM_img">
	                                        <img src="${filepath }${product_img}" alt="상품이미지">
	                                    </div>
	                                    <div class="PM_info">
	                                        <p class="P_name">${product_name}</p>
	                                        <p>${product_description}</p>
	                                    </div>
	                                </div>
	                                <div class="order_R">
	                                    <div class="PM_cnt">
	                                        <p>${order_cnt}<span>개</span></p>
	                                    </div>
	                                    <div class="PM_price">
	                                        <div class="PM_price_inner">
	                                        	<p>
	                                        		<fmt:formatNumber value="${final_price}" type="number"/>
	                                        		<span>원</span>
	                                        	</p>
	                                        	<c:if test="${product_price != price_snapshot}">
	                                        		<p class="product_price">
			                                        	<fmt:formatNumber value="${total_price}" type="number"/>
			                                        	<span>원</span>
	                                        		</p>
	                                        	</c:if>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	
	                        <div class="user_info">
	                            <div class="t_title">
	                                <p>주문자 정보</p>
	                            </div>
	                            <table class="table">
	                                <colgroup>
	                                    <col width = "25%">
	                                    <col width = "*">
	                                </colgroup>
	                                <tr>
	                                    <th><label>주문자명</label></th>
	                                    <td>
	                                        <input type="text" name="user_name" value="${user.user_name}" readonly>
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <th><label>연락처</label></th>
	                                    <td>
	                                        <input type="text" name="user_phone" value="${user.user_phone}" readonly>
	                                    </td>
	                                </tr>
	                            </table>
	                        </div>
	                        <div class="delivery_info">
	                            <div class="t_title">
	                                <p>배송지 정보</p>
	                            </div>
	                            <table class="table">
	                                <colgroup>
	                                    <col width = "25%">
	                                    <col width = "*">
	                                </colgroup>
	                                <tr>
	                                    <th><label>배송지</label></th>
	                                    <td>
	                                        <button type="button" id="openModalBtn" class="blue_border_btn">배송지 등록 / 수정</button>
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <th><label>받는분</label></th>
	                                    <td>
	                                        <input type="text" name="recipient_name" value="${user.user_name}" readonly>
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <th><label>배송지</label></th>
	                                    <td>
	                                        <input type="text" name="user_address" value="${user.user_address}" readonly>
	                                    </td>
	                                </tr>
	                                <tr>
	                                    <th><label>요청사항</label></th>
	                                    <td>
	                                        <textarea readonly></textarea>
	                                    </td>
	                                </tr>
	                            </table>
	                        </div>
	                        <div class="pay_method">
	                            <div class="t_title">
	                                <p>결제수단 선택</p>
	                            </div>
	                            <div class="pay_con">
	                                <div class="pay_title">
	                                    <p>일반 결제</p>
	                                </div>
	                                <div class="pay_btnWrap">
	                                    <button type="button" class="active">현대카드</button>
	                                    <button type="button">신한카드</button>
	                                    <button type="button">삼성카드</button>
	                                    <button type="button">농협카드</button>
	                                    <button type="button">하나카드</button>
	                                    <button type="button">우리카드</button>
	                                    <button type="button">롯데카드</button>
	                                    <button type="button">무통장입금</button>
	                                </div>
	                            </div>
	                        </div>
	
	                    </div>
	                    <div class="PM_con_R">
	                        <div class="TP_wrap">
	                            <div class="TP_title">
	                                <p>결제 예정 금액</p>
	                                <ul>
	                                    <li>
	                                        <p class="TP_p01">총 상품 금액</p>
	                                        <p>
	                                        	<fmt:formatNumber value="${total_price}" type="number"/>
	                                        	원
	                                        </p>
	                                    </li>
	                                    <li>
	                                        <p class="TP_p01">총 할인 금액</p>
	                                        <p>
		                                        <span>
		                                        	<fmt:formatNumber value="${total_price - final_price}" type="number"/>
		                                        </span>
		                                        원
	                                        </p>
	                                    </li>
	                                    <li>
	                                        <p class="TP_p01">총 배송비</p>
	                                        <p>0원</p>
	                                    </li>
	                                </ul>
	                                <ul>
	                                    <li>
	                                        <p class="TP_p02">총 결제 예정 금액</p>
	                                        <p class="TP_p03">
	                                        	<span>
	                                        		<fmt:formatNumber value="${final_price}" type="number"/>
	                                        	</span>
	                                        	원
	                                        </p>
	                                    </li>
	                                </ul>
	                                <ul>
	                                    <li>
	                                        <p class="TP_agree">
	                                            주문 내용을 확인 하였으며, 정보 제공 등에 동의합니다.
	                                        </p>
	                                    </li>
	                                </ul>
	                                <div class="TP_btn">
	                                    <button type="button" id="ordPayBtn" class="blue_btn">결제하기</button>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
                </form>
            </div>
        </div>
        
        
        <!-- modal start -->
        <div id="delivery_modal" class="modal_container hidden">
            <form id="modalFrm" method="post" action="/updateRecipientInfo">
            	<input type="hidden" id="order_id" name="order_id" value="${order_id}" />
	            <input type="hidden" id="recipient_name_hidden" name="recipient_name_hidden" />
			    <input type="hidden" id="postcode_hidden" name="postcode_hidden" />
			    <input type="hidden" id="address_hidden" name="address_hidden" />
			    <input type="hidden" id="extraAddress_hidden" name="extraAddress_hidden" />
			    <input type="hidden" id="detailAddress_hidden" name="detailAddress_hidden" />
			    
            	<div id="modal_con"class="modal_con center">
				    <div class="modal_header">
				        <h2>배송지 등록 및 수정</h2>
				        <button type="button" id="closeModalBtn">
				        	<img src="images/modalClose_btn.svg" alt="모달 닫기 버튼">
				        </button>
				    </div>
				    <div class="modal_body">
						<div class="modal_inner">
							<p>받는분</p>
							<input type="text" id="recipient_name" placeholder="받는분을 입력해주세요.">
						</div>
						<div>
							<div class="modal_inner">
								<p>배송지 주소</p>
								<div class="address_wrap">
									<input type="text" id="postcode" placeholder="우편 번호를 입력해주세요." readonly>
									<button type="button" onclick="execDaumPostcode()" class="blue_btn">주소 찾기</button>
								</div>
								<input type="text" id="address" placeholder="주소를 입력해주세요." readonly>
								<input type="text" id="detailAddress" placeholder="상세 주소를 입력해주세요.">
								<input type="text" id="extraAddress" placeholder="참고항목" readonly>
								
							</div>
						</div>
						<div class="modal_inner">
							<p>배송 요청사항(선택)</p>
							<select>
								<option value="0" selected>요청 사항을 선택해주세요.</option>
								<option value="1">직접 수령할게요.</option>
								<option value="2">부재시 경비실에 맡겨주세요.</option>
								<option value="3">문앞에 놓아주세요.</option>
								<option value="4">파손의 위험이 있는 상품이오니, 배송시 주의해주세요.</option>
								<option value="5">배송전에 연락주세요.</option>
							</select>
						</div>
				    </div>
				    <div class="modalBtn_wrap">
				    	<button type="reset" id="cancelModalBtn" class="blue_border_btn">취소</button>
				        <button type="submit" id="modal_saveBtn" class="blue_btn">등록</button>
				    </div>
				</div> 
            </form>
        </div>
        <!-- modal end -->
        
    </section>

</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>
</html>
