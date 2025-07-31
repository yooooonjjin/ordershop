<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib 
prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    

<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
        <title>종근당 로그인 페이지</title>
        <link rel="stylesheet" href="css/login.css">
        <script src="js/jquery-3.7.1.min.js"></script>
    </head>
    
    
    
   <script>
     // 제이쿼리 시작 
       $(function() {
     $("#btn_submit").click(function(e) {
       e.preventDefault();  // 기본 폼 제출 막기
   
       if ($("#user_id").val() == "") {
         alert("아이디를 입력하세요");
         $("#user_id").focus();
         return false;
       }
       if ($("#user_pass").val() == "") {
         alert("비밀번호를 입력하세요");
         $("#user_pass").focus();
         return false;
       }
   
       // 관리자 모드 체크 확인
       let isAdmin = $("#admin_mode").is(":checked");
   
       // 전송할 url과 데이터 셋팅
       let url = isAdmin ? "/adminConfirm" : "/loginConfirm";
   
       let data = {};
       if (isAdmin) {
         data.admin_id = $("#user_id").val();
         data.admin_pass = $("#user_pass").val();
       } else {
         data.user_id = $("#user_id").val();
         data.user_pass = $("#user_pass").val();
       }
   
       // ajax 요청
       $.ajax({
         type: "post",
         url: url,
         data: data,
         dataType: "text",
         success: function(result) {
           if (result == "1") {
             alert(isAdmin ? "관리자 로그인 성공" : $("#user_id").val() + "님 로그인 성공");
             location.href = isAdmin ? "/adminMain" : "/main";
           } else {
             alert("아이디 또는 비밀번호가 올바르지 않습니다.");
           }
         },
         error: function() {
           alert("전송 실패");
         }
       }); 
   
     });
   });
   
   
     </script>
       
    
    
    
    <body>
        <div id="loginBox" class="login_center">
            <div class="login_header">
                <a href="#none" class="logo font01"></a>
            </div>
            <div class="login_wrap">
                <div class="login_title">
                    <p>로그인</p>
                </div>
                <div class="login_container">
                    <section class="login_form">
                        <form method="post" id="frm">
                        
                        <!-- 아이디 입력 -->
                        <div class="login_input">
                            <label for="Id">아이디</label> 
                        <div class="input_box">
                               <i class="icon_id"></i>
                               <input type="text" id="user_id" name="user_id" required placeholder="아이디">
                            </div>
                        </div>
                        <!-- 비밀번호 입력 -->
                        <div class="login_input">
                   <label for="Password">비밀번호</label>
                   <div class="input_box">
                       <i class="icon_pw"></i>
                       <input type="password" id="user_pass" name="user_pass" required placeholder="비밀번호">
                   </div>
                  </div>
                        <div class="checkbox">
                            <input type="checkbox" id="admin_mode">
                            <label for="admin_mode"><p>관리자모드 전환</p></label>
                        </div>
                        
                        <div class="login_button">
                  <a href="#" id="btn_submit" class="login_btn">로그인</a>
                        </div>
                      
                    </form>
                    </section>
                   
                </div>
            </div>
        </div>

        
    </body>
</html>