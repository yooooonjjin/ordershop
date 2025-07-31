<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>사용자_장바구니 화면</title>
  <link rel="stylesheet" href="css/total.css" />
  <link rel="stylesheet" href="css/user.css" />
  <script src="../js/jquery.min.js"></script>
  <script src="../js/jquery-3.7.1.min.js"></script>
  <script src="../js/jquery-ui.js"></script>
  <script src="../js/main.js"></script>
</head>
<script>
//전체선택 체크박스 클릭 시
$(function() {
   
   // 단일 삭제
   $(".delete_btn").click(function(){

      if(confirm("선택한 상품을 삭제하시겠습니까?")) {
         let formData = $("#cartListForm").serialize();
         
         $.ajax({
            type : "POST",
            data : formData,
            url  : "/cartListDelete",
            
            dataType : "text",
            success  : function(data) {
               alert("선택한 상품이 삭제되었습니다.");   
               location.reload();
            },
            error : function() {
               
            }
         });
      } else {
         return;
      }
   });
   
   // 선택 삭제
   $("#chk_delete").click(function(){
      let datas = "";
      
      $("input[name='chk']:checked").each(function(){
         datas += "'" + $(this).val() + "',";
      })
      
      // 선택된 항목이 없을 때 예외처리
       if(datas === ""){
           alert("삭제할 상품을 선택하세요!");
           return;
       }
      
      if(confirm("선택한 상품을 삭제하시겠습니까?")) {
         $.ajax({
            data : "datas="+datas,
            type : "post",
            url  : "/cartDeleteEach",
            dataType : "text",
            success : function(data) {
               if(data == "ok") {
                  alert("선택한 상품이 삭제되었습니다.");
                  location.reload();
               } else {;
               }
            },
            error : function() {}
         });
      } else {
         return;
      }
      
   });

   
   // 체크박스 All 선택
   $("#checkAll").click(function() {
      // is() 함수 : 상태제공
      let bool = $("#checkAll").is(":checked")
      // prop() 함수 : 상태적용
      $("input[name='chk']").prop("checked",bool);
   });
   
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

            <div id="CT_wrap" class="section">
                <div class="sec_title">
                    <p>장바구니</p>
                </div>
                <div class="CT_total">
                    <p>총<span><c:out value="${cartListTotal }"/></span>건</p>
                </div>
                <div class="CT_top">
                    <div class="checkbox_wrap">
                        <input type="checkbox" id="checkAll" class="checkbox">
                        <label>전체 선택</label>
                    </div>
                    <div class="CT_delBtn">
                        <button type="button"  id="chk_delete" class="CT_delete blue_border_btn">선택 삭제</button>
                        <!-- <button type="button" class="CT_order blue_btn">선택 주문</button> -->
                    </div>
                </div>
                <c:forEach var="cart" items="${cartList}" >
                   <form id="cartListForm" class="cartListForm" method="post">
                    <input type="hidden" name="product_no" value="${cart.product_no}">
                    <input type="hidden" name="product_name" value="${cart.product_name}">
                    <input type="hidden" name="product_description" value="${cart.product_description}">
                    <input type="hidden" name="order_cnt" value="${cart.order_cnt}">
                    <input type="hidden" name="total_Price" value="${cart.total_Price}">
                    
                      <div class="CT_list">
                          <div class="checkbox_wrap">
                              <input type="checkbox" class="checkbox item_checkbox" name="chk" value="${cart.product_no}">
                          </div>
                          <div class="CT_L">
                              <div class="CT_img">
                                  <img src="${cart.filepath }${cart.product_img}" alt="상품이미지" style="width:100px; height:100px;">
                              </div>
                              <div class="CT_info">
                                  <p class="P_name">${cart.product_name }</p>
                                  <p>${cart.product_description }</p>
                              </div>
                          </div>
                          <div class="CT_R">
                              <div class="CT_cnt">
                                  <p>${cart.order_cnt}<span>개</span></p>
                              </div>
                              <div class="CT_price">
                                  <p>${cart.total_Price}<span>원</span></p>
                              </div>
                              <div class="delivery_method">
                                  <p>${cart.delivery_mth }</p>
                              </div>
                              <div class="delivery_fee">
                                  <p>${cart.delivery_fee }</p>
                              </div>
                              <div class="choice_btn">
                                  <!-- <button type="button" class="order_btn blue_border_btn">주문하기</button> -->
                                  <button type="button" class="delete_btn blue_btn">삭제하기</button>
                              </div>
                          </div>
                      </div>
                   </form>
                </c:forEach>
                <div class="div_page">
                <!-- 처음 버튼 -->
                <a href="/userCart?pageIndex=1"
                   class="page_icon <c:if test='${dto.pageIndex == 1}'>disabled</c:if>"
                   <c:if test='${dto.pageIndex == 1}'>tabindex="-1" aria-disabled="true" onclick="return false;"</c:if>>
                    <img src="images/page_first.svg" alt="처음 버튼">
                </a>
                <!-- 이전 버튼 -->
                <a href="/userCart?pageIndex=${dto.pageIndex-1}"
                   class="page_icon <c:if test='${dto.pageIndex == 1}'>disabled</c:if>"
                   <c:if test='${dto.pageIndex == 1}'>tabindex="-1" aria-disabled="true" onclick="return false;"</c:if>>
                    <img src="images/page_prev.svg" alt="이전 버튼">
                </a>
            
                <!-- 페이지 번호 -->
                <c:forEach var="p" begin="1" end="${dto.totalPage}">
                    <a href="/userCart?pageIndex=${p}"
                       class="page_num <c:if test='${p == dto.pageIndex}'>current_page</c:if>">
                        <span>
                            ${p}
                        </span>
                    </a>
                </c:forEach> 
            
                <!-- 다음 버튼 -->
                <a href="/userCart?pageIndex=${dto.pageIndex+1}"
                   class="page_icon <c:if test='${dto.pageIndex == dto.totalPage || dto.totalPage == 0}'>disabled</c:if>"
                   <c:if test='${dto.pageIndex == dto.totalPage || dto.totalPage == 0}'>tabindex="-1" aria-disabled="true" onclick="return false;"</c:if>>
                    <img src="images/page_next.svg" alt="다음 버튼">
                </a>
                <!-- 끝 버튼 -->
                <a href="/userCart?pageIndex=${dto.totalPage}"
                   class="page_icon <c:if test='${dto.pageIndex == dto.totalPage || dto.totalPage == 0}'>disabled</c:if>"
                   <c:if test='${dto.pageIndex == dto.totalPage || dto.totalPage == 0}'>tabindex="-1" aria-disabled="true" onclick="return false;"</c:if>>
                    <img src="images/page_last.svg" alt="끝 버튼">
                </a>
            </div>

            </div> 
        </div>
        
    </section>

</body>
</html>
