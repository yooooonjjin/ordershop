<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<header id="header">   

        <!-- nav 영역 -->
        <nav class="top_nav center">
            <ul>
             <%
             String session_userid = (String)session.getAttribute("SESSION_USERID");
             
         %>
            <% if(session_userid == null || session_userid.equals("") || session_userid.equals("null")) { %>
             <li><a href="/joinAgree">회원가입</a></li>
         <% } else { %>
           
         <% } %>
              
          
         
         <% if(session_userid == null || session_userid.equals("") || session_userid.equals("null")) { %>
             <li><a href="/login">로그인</a></li>
         <% } else { %>
             <li><a href="javascript:fn_logout();">로그아웃</a></li>
         <% } %>

            </ul>
        </nav>
        <!-- nav 영역 -->

        <div class="h_inner">
            <div class="menu_bar center">
                 <!-- header 로고 영역 -->
                <a href="/main">
                    <h1 class="tit_h1">
                        <span class="blind">logo</span>
                    </h1>
                </a>
                <!-- header 로고 영역 -->

                <!-- header snb 영역 -->
                <ul class="snb">
          
            <% if(session_userid == null || session_userid.equals("") || session_userid.equals("null")) { %>
             <li><a href="/login">마이페이지</a></li>
         <% } else { %>
           			<li>
                        <a href="/userDelivery">마이페이지</a>
                    </li>
         <% } %>
              
              <% if(session_userid == null || session_userid.equals("") || session_userid.equals("null")) { %>
             <li><a href="/login">장바구니</a></li>
         <% } else { %>
           			<li>
                        <a href="/userCart">장바구니</a>
                    </li>
         <% } %>
         
            <% if(session_userid == null || session_userid.equals("") || session_userid.equals("null")) { %>
             <li><a href="/login">주문/배송</a></li>
         <% } else { %>
           			<li>
                        <a href="/userDelivery">주문/배송</a>
                    </li>
         <% } %>   
        
                </ul>
                <!-- header snb 영역 -->
            </div>
        </div>
    </header>
    
    
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
function fn_logout(){
    $.ajax({
        url: "/logout",
        type: "post",
        success: function(data) {
            if(data === "success") {
                alert("로그아웃되었습니다");
                location.href = "/main";
            } else {
                alert("로그아웃에 실패했습니다.");
            }
        },
        error: function() {
            alert("서버 오류로 로그아웃에 실패했습니다.");
        }
    });
}
</script>
