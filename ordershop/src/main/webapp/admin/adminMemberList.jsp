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
  // 전체 선택/해제 함수
  function toggleSelectAll() {
    const isChecked = document.getElementById('selectAll').checked;
    const checkboxes = document.getElementsByName('selectedMember');
    Array.from(checkboxes).forEach(function (checkbox) {
      checkbox.checked = isChecked;
    });
  }

  // 전역 변수 (한 명 삭제용)
  let selectedUserNoForDelete = null;
  let isBulkDelete = false;

//삭제 버튼 클릭 시 (1명 또는 다수 구분)
  function openDeleteModal() {
    const checkedBoxes = document.querySelectorAll('.member-check:checked');

    if (checkedBoxes.length == 0) {
      alert('삭제할 회원을 선택하세요.');
      return;
    }

    if (checkedBoxes.length == 1) {
      // 한 명 삭제
      const checked = checkedBoxes[0];
      selectedUserNoForDelete = checked.dataset.userNo;
      isBulkDelete = false;

      document.getElementById('modalUserNo').textContent = selectedUserNoForDelete;
      document.getElementById('modalUserId').textContent = checked.dataset.userId;
      document.getElementById('modalUserName').textContent = checked.dataset.userName;
    } else {
      // 여러 명 삭제
      selectedUserNoForDelete = null;
      isBulkDelete = true;

      const firstName = checkedBoxes[0].dataset.userName;
      const count = checkedBoxes.length;

      console.log(count, firstName);

      document.getElementById('modalUserNo').textContent = `일괄삭제`;
      document.getElementById('modalUserId').textContent = '일괄삭제';
      document.getElementById('modalUserName').textContent = `일괄삭제`;
    }

    showModal();
  }

  // 모달 띄우기
  function showModal() {
    document.getElementById('modal_overlay_delete').style.display = 'flex';
    document.getElementById('modal_delete').style.display = 'block';

    // 닫기 버튼
    $("#cancelDeleteModalBtn").off('click').on('click', function () {
      $("#modal_overlay_delete").hide();
      $("#modal_delete").hide();
      $('#modalReasonDelete').val('');
    });

    // 삭제 확정 버튼
    $("#confirmDeleteBtn").off('click').on('click', function () {
      const delete_reason = $.trim($("#modalReasonDelete").val());

      if (delete_reason === "") {
        alert("삭제사유를 입력해주세요.");
        $("#modalReasonDelete").focus();
        return;
      }

      if (!confirm("정말 삭제하시겠습니까?")) {
        return;
      }

      if (!isBulkDelete && selectedUserNoForDelete) {
        // 한 명 삭제
        $.ajax({
          url: '/adminDeleteMember',
          method: 'POST',
          data: {
            user_no: selectedUserNoForDelete,
            delete_reason: delete_reason
          },
          success: function () {
            alert("삭제 처리되었습니다.");
            closeModalAndReload();
          },
          error: function () {
            alert("오류가 발생했습니다.");
          }
        });
      } else {
        // 복수 삭제
        const checkedBoxes = document.querySelectorAll('.member-check:checked');
        const userNos = Array.from(checkedBoxes).map(cb => cb.dataset.userNo);
        console.log("userNos to delete:", userNos);

        $.ajax({
             url: '/adminDeleteMemberBulk',
             method: 'POST',
             traditional: true,
             data: {
               user_nos: userNos,
               delete_reason: delete_reason
             },
             success: function () {
               alert("일괄 삭제 처리되었습니다.");
               closeModalAndReload();
             },
             error: function (xhr) {
               console.log("에러 상태:", xhr.status);
               console.log("에러 응답:", xhr.responseText);
               alert("오류가 발생했습니다.");
             }
           });

      }
    });
  }

  // 모달 닫고 새로고침
  function closeModalAndReload() {
    $("#modal_overlay_delete").hide();
    $("#modal_delete").hide();
    location.reload();
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
             
                     <h2>회원 관리</h2>
                   <h3>⦁ 회원 목록</h3>
                   <!--top_menu -->
                   <div class="top_menu">
                      <div class="delete_selection">
                      <input type="button" class="delete_button"
                     value="선택삭제"
                    onclick="openDeleteModal()">
         
                      
                      </div>
                      <!-- search_menu -->
                      
                      <form method="get" action="/adminMemberList">
                      <div class="search_menu">
                      <select id="searchKey" name="key">
                        <option value="member_no" <c:if test="${param.key == 'member_no'}">selected</c:if>>회원번호</option>
                    <option value="member_id" <c:if test="${param.key == 'member_id'}">selected</c:if>>아이디</option>
                          <option value="member_name" <c:if test="${param.key == 'member_name'}">selected</c:if>>이름</option>
                      </select> 
                      <input type="text"  name="value" placeholder="검색어를 입력해주세요." value="${param.value}" >
                      <input type="submit" class="search_button" value="검색"  >
                      </div>
                      </form>
                      
                   </div>
            
                        
         
               <!-- membertable 목록 -->
               <!-- 총 회원인원 -->
               <div class="member_total">총:<span class="member_total_point">${total}</span> 명 </div>   
               <table class="membertable">
                  <colgroup>
                      <col style="width: 5%">
                      <col style="width: 10%">
                      <col style="width: 10%">
                      <col style="width: 15%">
                      <col style="width: 15%">
                      <col style="width: 15%">
                      <col style="width: 5%">
                      <col style="width: 15%">
                  </colgroup>
                  <tr>
                  
                     <th><input type="checkbox" id="selectAll" onclick="toggleSelectAll()" /></th>
                     
                     
                     
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
                       <td>
                        <input type="checkbox" 
                         class="member-check"
                         name="selectedMember"
                         value="${member.USER_NO}"
                         data-user-no="${member.USER_NO}" 
                         data-user-id="${member.USER_ID}" 
                         data-user-name="${member.USER_NAME}">
                                         
                     </td>
                     
                       <td>${pageRownum - status.index}</td>
                       <td>${member.USER_NO}</td>
                       <td><a href="/adminMemberDetail/${member.USER_NO}">${member.USER_ID}</a></td>  
                       <td><a href="/adminMemberDetail/${member.USER_NO}">${member.USER_NAME}</a></td>
                       <td>${member.USER_PHONE}</td>
                       <td>${member.USER_GENDER}</td>
                       <td>${fn:substring(member.USER_JOIN,0,10)}</td> 

                   </tr>
               </c:forEach>
               
               </table>
            
                     <!-- 페이징 -->
               <div class="div_page">
                 <a href="/adminMemberList?pageIndex=1" class="page_arrow">«</a>
                 <a href="/adminMemberList?pageIndex=${currentPage - 1}" class="page_arrow">‹</a>                    
               
                 <c:forEach var="p" begin="1" end="${totalPage}">
                   <c:if test="${p == currentPage}">
                     <a href="/adminMemberList?pageIndex=${p}" class="active">${p}</a>
                   </c:if>
                   <c:if test="${p != currentPage}">
                     <a href="/adminMemberList?pageIndex=${p}">${p}</a>
                   </c:if>
                 </c:forEach>
               
                 <a href="/adminMemberList?pageIndex=${currentPage + 1}" class="page_arrow">›</a>
                 <a href="/adminMemberList?pageIndex=${totalPage}" class="page_arrow">»</a>
               </div>

            
            
                         
               <!-- 삭제모달창 -->
               <!-- 삭제모달창 -->
               <div id="modal_overlay_delete" style="display:none;">
                 <div id="modal_delete" class="modal_delete">
                   <table>
                     <thead>
                       <tr>
                         <th colspan="2" class="modal_title">⦁ 회원 정보</th>
                       </tr>
                     </thead>
               
                     <tbody>
                       <tr>
                         <th>회원번호</th>
                         <td><span id="modalUserNo"></span></td>
                       </tr>
               
                       <tr>
                         <th>회원아이디</th>
                         <td><span id="modalUserId"></span></td>
                       </tr>
               
                       <tr>
                         <th>회원이름</th>
                         <td><span id="modalUserName"></span></td>
                       </tr>
                     </tbody>
               
                     <thead>
                       <tr>
                         <th colspan="2" class="modal_reason">⦁ 삭제 사유</th>
                       </tr>
                     </thead>
               
                     <tbody>
                       <tr class="modal_reason">
                         <td colspan="2" rowspan="3" class="modal_reason">
                           <textarea id="modalReasonDelete" placeholder="사유를 입력하세요."></textarea>
                         </td>
                       </tr>
                     </tbody>
                   </table>
               
                   <div class="modal_buttons">
                     <button type="button" id="confirmDeleteBtn">삭제</button>
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
 