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
  <link rel="stylesheet" href="css/total.css" />
  <link rel="stylesheet" href="css/user.css" />
  <script src="../js/jquery.min.js"></script>
  <script src="../js/jquery-3.7.1.min.js"></script>
  <script src="../js/jquery-ui.js"></script>
  <script src="../js/main.js"></script>
</head>


<body>

        <!-- user_header S -->
   <%@ include file ="/include/user_header.jsp" %>
   <!-- user_header E -->

    <section id="content_wrap">
        <div class="con_inner center">
            <div class="con_title">
                <p>상품 목록</p>
            </div>
            <div id="PL_wrap" class="con_wrap">
                <div class="p_title">
                    <p>상품목록</p>
                </div>

                <!-- 검색창 -->
                <div class="p_search">
                   <form method="get" action="/userProductList">
                 <input type="text" name="searchWord" value="${param.searchWord}" placeholder="검색어를 입력해주세요.">
                 <button type="submit" class="blue_btn">검색</button>
               </form>
                </div>
                <!-- 검색창 -->

                <div class="P_list_wrap">
                    <!-- total / 정렬 -->
                    <div class="P_list_top">
                        <div class="total">
                            <p>총 <span><c:out value="${listTotal }"/></span>건</p>
                        </div>
                        <ul class="sort_wrap">
                            <li>
                                <a href="/userProductList?sortType=recent&searchWord=${param.searchWord}" class="<c:if test='${param.sortType == "recent" || empty param.sortType}'>sort_active</c:if>">최신순</a>
                            </li>
                            <li>
                               <a href="/userProductList?sortType=price&searchWord=${param.searchWord}" class="<c:if test='${param.sortType == "price"}'>sort_active</c:if>">가격순</a>
                            </li>
                            <li>
                               <a href="/userProductList?sortType=salesCnt&searchWord=${param.searchWord}" class="<c:if test='${param.sortType == "salesCnt"}'>sort_active</c:if>">판매순</a>
                            </li>
                        </ul>
                    </div>
                    <!-- total / 정렬 -->
                    <!-- 상품 list -->
                    <div id="ProductList_wrap">
                       <div class="P_list_content">
                     <c:forEach var="list" items="${productList}">
                        <a href="/userProductDetail/${list.PRODUCT_NO }" class="P_con">
                           <img src="${list.FILEPATH }${list.PRODUCT_IMG}" alt="상품이미지">
                           <div class="P_info">
                              <div class="P_title">
                                 <p class="P_name">${list.PRODUCT_NAME}</p>
                                 <p>${list.PRODUCT_DESCRIPTION}</p>
                              </div>
                              <div class="P_hits">
                                 <p>${list.VIEW_CNT}</p>
                              </div>
                              <div class="S_price">
                                  <P>
                                     <c:if test="${list.PRODUCT_SALE != 0}">
                                       ${list.PRODUCT_SALE}%
                                    </c:if>
                                    <span>
                                       <fmt:formatNumber value="${list.PRODUCT_FINAL_PRICE}" type="number"/>원
                                    </span>
                                 </P>
                              </div>
                              <div class="P_price">
                                 <c:if test="${list.PRODUCT_SALE != 0}">
                                    <p>
                                       <fmt:formatNumber value="${list.PRODUCT_PRICE}" type="number"/>원
                                    </p>
                                 </c:if>
                              </div>
                           </div>
                        </a>
                     </c:forEach>
                  </div>
                    </div>
                    <!-- 상품 list -->
                    <div class="div_page">
                   <!-- 처음 버튼 -->
                   <a href="/userProductList?pageIndex=1&searchWord=${param.searchWord}&sortType=${param.sortType}"
                      class="page_icon <c:if test='${dto.pageIndex == 1}'>disabled</c:if>"
                      <c:if test='${dto.pageIndex == 1}'>tabindex="-1" aria-disabled="true" onclick="return false;"</c:if>>
                       <img src="images/page_first.svg" alt="처음 버튼">
                   </a>
                   <!-- 이전 버튼 -->
                   <a href="/userProductList?pageIndex=${dto.pageIndex-1}&searchWord=${param.searchWord}&sortType=${param.sortType}"
                      class="page_icon <c:if test='${dto.pageIndex == 1}'>disabled</c:if>"
                      <c:if test='${dto.pageIndex == 1}'>tabindex="-1" aria-disabled="true" onclick="return false;"</c:if>>
                       <img src="images/page_prev.svg" alt="이전 버튼">
                   </a>
                   
                   <!-- 페이지 번호 -->
                   <c:forEach var="p" begin="1" end="${dto.totalPage}">
                       <a href="/userProductList?pageIndex=${p}&searchWord=${param.searchWord}&sortType=${param.sortType}"
                          class="page_num <c:if test='${p == dto.pageIndex}'>current_page</c:if>">
                           ${p}
                       </a>
                   </c:forEach>
                   
                   <!-- 다음 버튼 -->
                   <a href="/userProductList?pageIndex=${dto.pageIndex+1}&searchWord=${param.searchWord}&sortType=${param.sortType}"
                      class="page_icon <c:if test='${dto.pageIndex == dto.totalPage || dto.totalPage == 0}'>disabled</c:if>"
                      <c:if test='${dto.pageIndex == dto.totalPage || dto.totalPage == 0}'>tabindex="-1" aria-disabled="true" onclick="return false;"</c:if>>
                       <img src="images/page_next.svg" alt="다음 버튼">
                   </a>
                   <!-- 끝 버튼 -->
                   <a href="/userProductList?pageIndex=${dto.totalPage}&searchWord=${param.searchWord}&sortType=${param.sortType}"
                      class="page_icon <c:if test='${dto.pageIndex == dto.totalPage || dto.totalPage == 0}'>disabled</c:if>"
                      <c:if test='${dto.pageIndex == dto.totalPage || dto.totalPage == 0}'>tabindex="-1" aria-disabled="true" onclick="return false;"</c:if>>
                       <img src="images/page_last.svg" alt="끝 버튼">
                   </a>
               </div>
                </div>
            </div>
        </div>
    </section>


    








</body>

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


</html>
