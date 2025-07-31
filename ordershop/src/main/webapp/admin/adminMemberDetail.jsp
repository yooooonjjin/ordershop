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
 
     <link rel="stylesheet" href="/css/total.css" />
   <link rel="stylesheet" href="/css/admin_style.css" />
   <script src="/js/jquery-3.7.1.min.js"></script>
   <script src="/js/main.js"></script>
  
</head>
<script>

let selectedUserNoForBlock = null;// 차단용 전역 변수
let selectedUserNoForDelete = null;//삭제용 전역 변수

// 전역에서 호출 가능한 함수들 (인라인 onclick에서 사용 가능)
function fn_modal_block(user_no, user_id, user_name){
  selectedUserNoForBlock = user_no;
  $("#modal_overlay_block").css('display','flex');
  $("#modal_block").css('display','block');
}

function fn_modal_delete(user_no, user_id, user_name){
  selectedUserNoForDelete = user_no;
  $("#modal_overlay_delete").css('display','flex');
  $("#modal_delete").css('display','block');
}

$(function() {
  // 멤버 리스트 버튼 클릭
  $("#member_list_button").click(function(){
    location="/adminMemberList"; 
  });

  // 차단 모달 닫기
  $("#cancelBlockModalBtn").click(function() {
    $("#modal_overlay_block").hide();
    $("#modal_block").hide();
  });

  // 차단 확정 버튼 클릭
  $("#confirmBlockBtn").click(function() {
    const block_reason = $.trim($("#modalReasonBlock").val());
    if (block_reason == "") {
      alert("차단사유를 입력해주세요.");
      $("#modalReasonBlock").focus();
      return;
    }
    if (!selectedUserNoForBlock) {
      alert("차단할 사용자가 선택되지 않았습니다.");
      return;
    }
    console.log(selectedUserNoForBlock);
    if (confirm("정말 차단하시겠습니까?")) {
      $.ajax({
        url: '/adminBlockMember',
        method: 'POST',
        data: {
          user_no: selectedUserNoForBlock,
          block_reason: block_reason
        },
        success: function(response) {
          alert("차단 처리되었습니다.");
          $("#modal_overlay_block").hide();
          $("#modal_block").hide();
          location="/adminMemberBlockList"; 
        },
       
        
        
        error: function(xhr, status, error) {
             console.error("xhr:", xhr);
             console.error("status:", status);
             console.error("error:", error);
             alert("차단 처리 중 오류가 발생했습니다: " + error);
           }
      });
    }
  });

   //차단 버튼 클릭할 때
  $(".block-button").click(function() {
    let userNo = $(this).data("user-no");  // 버튼에 data-user-no="사용자번호" 이런 게 있다고 가정
    console.log("차단할 사용자 번호:", userNo);
    selectedUserNoForBlock = userNo;  // 변수에 저장
    // 모달 열기 코드
    $("#modal_overlay_block").show();
    $("#modal_block").show();
  });
  
  
  // 삭제 모달 닫기
  $("#cancelDeleteModalBtn").click(function() {
    $("#modal_overlay_delete").hide();
    $("#modal_delete").hide();
  });

  // 삭제 확정 버튼 클릭
  $("#confirmDeleteBtn").click(function() {
    const delete_reason = $.trim($("#modalReasonDelete").val());
    if (delete_reason == "") {
      alert("삭제사유를 입력해주세요.");
      $("#modalReasonDelete").focus();
      return;
    }
    
    if (!selectedUserNoForDelete) {
      alert("삭제할 사용자가 선택되지 않았습니다.");
      return;
    }
    

    if (confirm("정말 삭제하시겠습니까?")) {
      $.ajax({
        url: '/adminDeleteMember',
        method: 'POST',
        data: {
          user_no: selectedUserNoForDelete,
          delete_reason: delete_reason
        },
        success: function(response) {
          alert("삭제 처리되었습니다.");
          $("#modal_overlay_delete").hide();
          $("#modal_delete").hide();
          location="/adminMemberDeleteList"; 
        },
        error: function(error) {
           
        }
      });
    }
  });


//삭제 버튼 클릭할 때
  $(".delete-button").click(function() {
    let userNo = $(this).data("user-no");  // 버튼에 data-user-no="사용자번호" 이런 게 있다고 가정
    console.log("삭제할 사용자 번호:", userNo);
    selectedUserNoForDelete = userNo;  // 변수에 저장
    // 모달 열기 코드
    $("#modal_overlay_delete").show();
    $("#modal_delete").show();
  });

  

  
  
});
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
                
                     <h2>회원관리</h2>
                   
         
            
               <!-- membertable 디테일 회원정보자세히 -->
            
               <table class="membertable_detail">
         
                  <tr>
                        <th>회원번호</th>
                        <td>${admindto.user_no}</td>
                  </tr>
      
                  <tr>
                        <th>회원아이디</th>
                        <td>${admindto.user_id}</td>
                  </tr>
                  <tr>
                        <th>회원비밀번호</th>
                        <td>${admindto.user_pass}</td>
                  </tr>
               
                  <tr>
                        <th>회원이름</th>
                        <td>${admindto.user_name}</td>  
                  </tr>
                  <tr>
                        <th>연락처</th>
                         <td>${admindto.user_phone}</td>
                  </tr>
                  <tr>
                        <th>성별</th>
                        <td>${admindto.user_gender}</td>
                  </tr>
                  <tr>
                         <th>생년월일</th>
                         <td>${fn:substring(admindto.user_birth,0,10)}</td> 
                  </tr>
                  <tr>
                       <th>배송지</th>
                       <td>${admindto.user_address}</td> 
                  </tr>
                  <tr>
                     <th>가입날짜</th>
                       <td>${fn:substring(admindto.user_join,0,10)}</td> 
                  </tr>

            
               </table> 
                          
                   <!-- 하단버튼 메뉴 -->
               <div class="bottom_buttons">
               <input type="button" id="member_block_button" class="blue_border_btn page_arrow" value="차단" onclick="fn_modal_block(${admindto.user_no}, '${admindto.user_id}', '${admindto.user_name}')" >
               <input type="button" id="member_delete_button" class="blue_border_btn page_arrow" value="삭제" onclick="fn_modal_delete(${admindto.user_no}, '${admindto.user_id}', '${admindto.user_name}')" >
               <input type="button" id="member_list_button" value="목록"  >
               </div>
                          
                
               <!-- 차단모달창 -->
               <div id="modal_overlay_block">
                <div id="modal_block" class="modal_block">
                    <table>
                       <thead>
                       <tr>
                         <th colspan="2" class="modal_title">⦁ 회원 정보</th>
                       </tr>
                     </thead>
   
                      <tr>
                         <th>회원번호</th>
                         <td>${admindto.user_no}</td>
                      </tr>
               
                      <tr>
                         <th>회원아이디</th>
                         <td>${admindto.user_id} </td>
                      </tr>
                      <tr>
                         <th>회원이름</th>
                         <td>${admindto.user_name}</td>
                      </tr>
                      
                       <thead>
                       <tr>
                         <th colspan="2" class="modal_reson">⦁ 차단 사유</th>
                       </tr>
                     </thead>
                      
                      <tr class="modal_reason">
                       <td colspan="2" rowspan="3" class="modal_reason">
                         <textarea id="modalReasonBlock" placeholder="사유를 입력하세요."></textarea>
                       </td>
                       </tr>
                 </table>
               <div class="modal_buttons">
                    <button type="button" id="confirmBlockBtn">차단</button>
                       <button type="button" id="cancelBlockModalBtn">닫기</button>

            
               </div>    
                
                </div>       
               </div>                    
               
                            
               <!-- 삭제모달창 -->
               <div id="modal_overlay_delete">
               <div id="modal_delete" class="modal_delete">
                    <table>
                       <thead>
                       <tr>
                         <th colspan="2" class="modal_title">⦁ 회원 정보</th>
                       </tr>
                     </thead>
   
                      <tr>
                         <th>회원번호</th>
                         <td>${admindto.user_no}</td>
                      </tr>
               
                      <tr>
                         <th>회원아이디</th>
                         <td>${admindto.user_id} </td>
                      </tr>
                      <tr>
                         <th>회원이름</th>
                         <td>${admindto.user_name}</td>
                      </tr>
                      
                       <thead>
                       <tr>
                         <th colspan="2" class="modal_reson">⦁ 삭제 사유</th>
                       </tr>
                     </thead>
                      
                      <tr class="modal_reason">
                       <td colspan="2" rowspan="3" class="modal_reason">
                         <textarea id="modalReasonDelete" placeholder="사유를 입력하세요."></textarea>
                       </td>
                       </tr>
                 </table>
               <div class="modal_buttons">
                    <button type="button" id="confirmDeleteBtn" >삭제</button>
                      <button type="button" id="cancelDeleteModalBtn">닫기</button>

         
               </div>    
                
                </div>       
               </div>      
               
               
                       
                

                </section>
                <!-- 작업 공간 -->
            

            </div>

        </section>

    </section>
    



</body>
</html>
 
 
 
