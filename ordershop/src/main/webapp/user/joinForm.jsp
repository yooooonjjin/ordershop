<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib 
prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 등록화면</title>

  <meta charset="UTF-8">
  <title>회원 등록화면</title>

  <!-- jQuery 먼저 로드 -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <!-- 그 다음에 jQuery UI -->
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>

  <!-- 내 CSS -->
  <link rel="stylesheet" href="css/join.css">
  
  <!-- 달력 한국어 -->
  <script src="https://code.jquery.com/ui/1.13.2/i18n/jquery-ui-i18n.min.js"></script>
<script>
function validateInput(inputSelector, minLength, maxLength, emptyMsg, minMsg, maxMsg) {
  $(inputSelector).on('input', function() {
    let val = $(this).val();
    const errorTextDiv = $(this).siblings('.error_text');

    if(val.trim() === '') {
      errorTextDiv.text(emptyMsg).show();
      return;
    }

    if(val.length > maxLength) {
      val = val.substring(0, maxLength);
      $(this).val(val);
      errorTextDiv.text(maxMsg).show();
      return;
    }

    if(val.length < minLength) {
      errorTextDiv.text(minMsg).show();
      return;
    }

    errorTextDiv.hide();
  });

  // 초기 상태 체크
  $(inputSelector).each(function() {
    const errorTextDiv = $(this).siblings('.error_text');
    if($(this).val().trim() === '') {
      errorTextDiv.text(emptyMsg).show();
    } else {
      errorTextDiv.hide();
    }
  });
}

// debounce 함수 (입력 멈추면 실행)
function debounce(func, delay) {
  let timer;
  return function(...args) {
    clearTimeout(timer);
    timer = setTimeout(() => func.apply(this, args), delay);
  };
}

$(document).ready(function() {
  validateInput('#user_name', 2, 15, '필수 입력값입니다.', '2자 이상 입력해주세요.', '15자 이상 입력할 수 없습니다.');
  validateInput('#user_pass', 6, 30, '필수 입력값입니다.', '6자 이상 입력해주세요.', '30자 이상 입력할 수 없습니다.');
  validateInput('#user_id', 6, 20, '필수 입력값입니다.', '6자 이상 입력해주세요.', '20자 이상 입력할 수 없습니다.');
  validateInput('#user_pass_confirm', 6, 20, '필수 입력값입니다.', '6자 이상 입력해주세요.', '20자 이상 입력할 수 없습니다.');
  
  
  
  const checkUserId = debounce(function() {
    let val = $('#user_id').val().trim();
    const errorTextDiv = $('#user_id').siblings('.error_text');

    if(val.length >= 6 && val.length <= 20) {
      $.ajax({
        type: 'POST',
        url: '/useridCheck',
        data: { userid: val },
        success: function(data) {
          if(data == "1") {
            errorTextDiv.html('<span style="color: green;">사용 가능한 아이디입니다.</span>').show();
            $('#useridBox').val("Y");
          } else if(data == "2") {
            errorTextDiv.html('<span style="color: red;">형식에 맞지 않습니다.</span>').show();
            $('#useridBox').val("N");
          } else if(data == "3") {
            errorTextDiv.html('<span style="color: red;">이미 사용중인 아이디입니다.</span>').show();
            $('#useridBox').val("N");
          }
        },
        error: function() {
          errorTextDiv.html('<span style="color: red;">중복 체크 실패</span>').show();
          $('#useridBox').val("N");
        }
      });
    } else {
      $('#user_id').siblings('.error_text').text('6~20자 사이로 입력해주세요.').show();
      $('#useridBox').val("N");
    }
  }, 500);  // 500ms 입력 멈춤 후 실행

  // input 이벤트에 debounce된 AJAX 중복체크 붙임
  $('#user_id').on('input', checkUserId);
  
  
  //비밀번호 확인 체크
//비밀번호 확인 체크
  $('#user_pass_confirm').on('input', function () {
    const pass = $('#user_pass').val();
    const passConfirm = $(this).val();
    const errorTextDiv = $(this).siblings('.error_text');

    if (passConfirm === '') {
      errorTextDiv.text('필수 입력값입니다.').css('color', 'red').show();
      return;
    }

    if (pass !== passConfirm) {
      errorTextDiv.text('비밀번호가 일치하지 않습니다.').css('color', 'red').show();
    } else {
      errorTextDiv.text('비밀번호가 일치합니다.').css('color', 'green').show();
    }
  });

  
  $(document).ready(function () {
     // 연락처 입력
     $('#user_phone').on('input', function () {
       let val = $(this).val().replace(/[^0-9]/g, ''); // 숫자만 남기기
       const errorTextDiv = $(this).siblings('.error_text');

       // 010으로 시작 안 하면 오류
       if (!val.startsWith("010")) {
         errorTextDiv.text("010으로 시작해야 합니다.").show();
       } else if (val.length < 10 || val.length > 11) {
         errorTextDiv.text("연락처 자릿수가 맞지 않습니다.").show();
       } else {
         errorTextDiv.text("").hide();
       }

       // 하이픈 자동 입력
       if (val.length <= 10) {
         val = val.replace(/(\d{3})(\d{3,4})(\d{4})/, '$1-$2-$3');
       } else {
         val = val.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
       }

       $(this).val(val);
     });
   });
  
 //사용자가 직접 텍스트 입력해도 실시간으로 체크
  $('#user_birth').on('input', function () {
    const val = $(this).val().trim();
    const errorTextDiv = $(this).siblings('.error_text');

    if (val === '') {
      errorTextDiv.text('필수입력값 입니다.').show();
    } else {
      errorTextDiv.hide();
    }
  });

});

// 배송지입력
$(function() {
     const $addressInput = $('#sample6_address');
     const $errorDiv = $addressInput.siblings('.error_text');

     // 페이지 로드 시 체크
     if ($addressInput.val().trim() === '') {
       $errorDiv.text('필수입력값 입니다.').show();
     } else {
       $errorDiv.hide();
     }

     // 주소가 변경될 때마다 체크 (우편번호 찾기 버튼 클릭 후 주소가 입력될 때)
     $addressInput.on('input change', function() {
       if ($(this).val().trim() === '') {
         $errorDiv.text('필수입력값 입니다.').show();
       } else {
         $errorDiv.hide();
       }
     });
   });


//성별선택
$(document).ready(function() {
     const $genderSelect = $('#user_gender');
     const $errorDiv = $genderSelect.siblings('.error_text');

     // 페이지 로드 시 체크
     if ($genderSelect.val() === '') {
       $errorDiv.text('필수입력값 입니다.').show();
     } else {
       $errorDiv.hide();
     }

     // 선택 변경 시 체크
     $genderSelect.on('change', function() {
       if ($(this).val() === '') {
         $errorDiv.text('필수입력값 입니다.').show();
       } else {
         $errorDiv.hide();
       }
     });
   });
   
   


</script>



</head>


    <body> 
      <div id="joinBox" class="join_center">
            <div class="join_header">
                <a href="#none" class="logo font01"></a>
            </div>
            <div class="join_wrap">
                <div class="join_title">
                    <p>회원가입</p>
                    <p>사용하실 정보를 입력해주세요.</p>
                </div>
                <div class="join_container">
                    <section class="join_form">
                        <form method="post" id="frm" action="/memberInsert">
                         <!-- 이름 입력 -->
                        <div class="join_input">
                            <label for="user_name">이름</label> 
                        <div class="input_box">
                               <input type="text" id="user_name" name="user_name" class="input" placeholder="이름"  >
                               <div class="error_text">필수입력값 입니다.</div>
                            </div>
                        </div>
                        <!-- 아이디 입력 -->
                        <div class="join_input">
                            <label for="user_id">아이디</label> 
                        <div class="input_box">
                               <input type="text" id="user_id" name="user_id" placeholder="아이디">
                               <div class="error_text">필수입력값 입니다.</div>
                            </div>
                        </div>
                          <!-- 비밀번호 입력 -->
                        <div class="join_input">
                   <label for="user_pass">비밀번호</label>
                   <div class="input_box">  
                       <input type="password" id="user_pass" name="user_pass" required placeholder="비밀번호">
                       <div class="error_text">필수입력값 입니다.</div>
                   </div>
                  </div>
                  <!-- 비밀번호 확인 입력 -->
                        <div class="join_input">
                   <label for="user_pass_confirm">비밀번호 확인</label>
                   <div class="input_box">
                      <input type="password" id="user_pass_confirm" name="user_pass_confirm" required placeholder="비밀번호확인">
                      <div class="error_text">필수입력값 입니다.</div>
                   </div>
                  </div>
                  
                  <!-- 연락처 입력 -->
                        <div class="join_input">
                   <label for="user_phone">연락처</label>
                   <div class="input_box">
                       <input type="text" id="user_phone" name="user_phone" required placeholder="연락처">
                       <div class="error_text">필수입력값 입니다.</div>
                   </div>
                  </div>
                  
                        
                  <!-- 생년월일 입력 -->
                        <div class="join_input">
                   <label for="user_birth">생년월일</label>
                   <div class="input_box">
                    <input type="text" id="user_birth" placeholder="생년월일 선택" name="user_birth">
                     <div class="error_text">필수입력값 입니다.</div>
                       
                   </div>
                  </div>
                  
                     
                  <!-- 배송지입력 -->
                  <div class="join_input">
                   <label for="user_address">배송지</label>
                   <div class="input_box">
                         <button type="button" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
                          <br><br>
                          <input type="text" id="sample6_address" name="user_address" placeholder="주소" readonly>
                          <div class="error_text">필수입력값 입니다.</div>           
                  </div>
                  </div>

                        <!-- 성별입력 -->
                        <div class="join_input">
                   <label for="user_gender">성별</label>
                   <div class="input_box">  
                     <select id="user_gender" name="user_gender" required>
                       <option value="">-- 선택하세요 --</option>
                       <option value="남">남성</option>
                       <option value="여">여성</option>
                     </select>
                     <div class="error_text">필수입력값 입니다.</div>
                  </div>
                  </div>

                           <!-- 완료 버튼 -->
                        <div class="join_Form_button">
                  <button type="submit" id="btn_submit">완료</button>
                        </div>
                 
                    </form>
                    </section>
                   
                </div>
            </div>
        </div>
    
    </body>
    
<script>

$(document).ready(function () {
     $('#frm').on('submit', function (e) {
       e.preventDefault(); // ✅ 기본 제출 막기

       const formData = $(this).serialize(); // 폼 데이터 직렬화
       $.ajax({
         type: 'POST',
         url: '/memberInsert', // ✅ form action과 일치시켜야 함
         data: formData,
         success: function (data) {
           alert('회원가입 완료');
           window.location.href = '/login'; // 로그인 페이지로 이동
         },
         error: function () {
           alert('서버 오류. 관리자에게 문의하세요.');
         }
       });
     });
   });




$(function () {
  const $birthInput = $('#user_birth');

  $birthInput.datepicker({
    dateFormat: 'yy-mm-dd',  // jQuery UI 날짜 포맷 (4자리 연도)
    changeMonth: true,
    changeYear: true,
    yearRange: '1900:2025',
    onSelect: function () {
      const $errorDiv = $(this).closest('.input_box').find('.error_text');
      $errorDiv.hide();
    }
  });

  $birthInput.on('input', function () {
    const val = $(this).val().trim();
    const $errorDiv = $(this).closest('.input_box').find('.error_text');

    if (val === '') {
      $errorDiv.text('필수입력값 입니다.').show();
    } else {
      $errorDiv.hide();
    }
  });

  // 페이지 처음 로드시 에러 메시지 체크
  if ($birthInput.val().trim() === '') {
    $birthInput.closest('.input_box').find('.error_text').text('필수입력값 입니다.').show();
  } else {
    $birthInput.closest('.input_box').find('.error_text').hide();
  }
});
</script>

       

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function sample6_execDaumPostcode() {
     new daum.Postcode({
       oncomplete: function(data) {
         // 주소 넣기
         document.getElementById('sample6_address').value = data.address;

         // 이벤트 강제 발생 (jQuery 이벤트 강제 발생)
         $('#sample6_address').trigger('input');
       }
     }).open();
   }

</script>

        
    

</html>