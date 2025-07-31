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

  <link rel="stylesheet" href="css/join.css">
  <script src="../js/jquery-3.7.1.js"></script>
  <script src="../js/jquery-ui.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  
  
  
  
  
</head>

    
    <body>
        <div id="joinBox" class="login_center">
            <div class="join_header">
                <a href="#none" class="logo font01"></a>
            </div>
            <div class="join_wrap">
                <div class="join_title">
                    <p>이용 및 약관에 동의</p>
                    <p>서비스 가입을 위해 아래 약관에 동의가 필요해요.</p>
                </div>
                
                 <form method="post" id="frm" action="/joinForm">
              <!-- 전체 선택 -->
              <div class="agree-all">
             
                <input type="checkbox" id="checkAll" class="custom-checkbox" />
               <label for="checkAll" class="checkbox-label">약관 전체 동의</label>
                
              </div>
            
              <!-- 개별 약관 -->
              <div class="agree-list">
                <label class="checkbox over14">
                 <input type="checkbox" name="over14" required class="required-checkbox chk" /> 만 14세 이상 회원입니다. <span style="color:red">(필수)</span>
               </label>
               
               <label class="checkbox terms">
                 <input type="checkbox" name="terms" required class="required-checkbox chk" /> 이용약관 동의 <span style="color:red">(필수)</span>
               </label>
               
               <label class="checkbox privacy">
                 <input type="checkbox" name="privacy" required class="required-checkbox privacy-basic chk" /> 개인정보 수집 및 이용 동의 <span style="color:red">(필수)</span>
               </label>
               
               <label class="checkbox privacy location">
                 <input type="checkbox" name="privacy_location" required class="required-checkbox privacy-location chk" /> 위치기반서비스 이용약관 동의  <span style="color:red">(필수)</span>
               </label>
               
               <label class="checkbox sensitive">
                 <input type="checkbox" name="sensitive" required class="required-checkbox sensitive-info chk" /> 민감정보 수집 및 이용 동의 <span style="color:red">(필수)</span>
               </label>
               
               <label class="checkbox third-party">
                 <input type="checkbox" name="thirdParty" required class="required-checkbox third-party-info chk" /> 개인정보 제3자 제공 동의 <span style="color:red">(필수)</span>
               </label>
               
               <label class="checkbox marketing">
                 <input type="checkbox" name="marketing" class="optional-checkbox marketing-collect chk" /> 개인정보 수집 및 이용 동의  <span style="color:gray">(선택)</span>
               </label>
               
               <label class="checkbox marketing">
                 <input type="checkbox" name="marketing_receive" class="optional-checkbox marketing-receive chk" /> 마케팅 정보 수신 동의  <span style="color:gray">(선택)</span>
               </label>
              
              
              </div>
            
              <!-- 다음 버튼 -->
              <div class="join_Submenu">
                <button type="submit" class="submit_btn">다음</button>

                
              </div>
            </form>
                 
              
            </div>
        </div>

        
    </body>
    

  <script>
  $(function () {
     // 전체 선택 클릭 시
      $("#checkAll").click(function(){
        let bool = $(this).is(":checked");
        $(".chk").prop("checked", bool);
      });


     // 폼 제출 시 필수 체크박스 검증
     $('#frm').submit(function (e) {
       let allRequiredChecked = true;

       $('.required-checkbox').each(function () {
         if (!$(this).prop('checked')) {
           allRequiredChecked = false;
           return false; // 반복문 종료
         }
       });

       if (!allRequiredChecked) {
         e.preventDefault(); // 제출 막기
         alert('필수 항목에 모두 동의해주세요.');
       }
     });
   });

  
  
  
  
  
</script>

</html>
