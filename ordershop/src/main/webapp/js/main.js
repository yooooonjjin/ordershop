$(function() {
    $(document).ready(function () {
        // .menu01 클릭 시 하위 메뉴 토글
        $('.menu01').click(function (e) {
            e.preventDefault(); // 기본 링크 이동 막기

            // 클릭한 메뉴의 하위 메뉴 토글
            const $submenu = $(this).next('.menu02');
            $submenu.slideToggle();

            // 다른 메뉴들은 닫고 active 클래스 제거
            $('.menu01').not(this).removeClass('active').next('.menu02').slideUp();

            // 클릭된 메뉴에 active 클래스 추가
            $(this).toggleClass('active');
        });
    });
});
