package com.ordershop.service;

import java.util.List;

import com.ordershop.dto.MemberDto;
import com.ordershop.dto.UCartDto;
import com.ordershop.dto.UInfoDto;
import com.ordershop.dto.UOrderDto;
import com.ordershop.dto.UPaymentDto;
import com.ordershop.dto.UProductDto;

public interface MainService {

	/**
	 * 전체 데이터 개수 조회 (검색 / 정렬 조건 반영 O)
	 */
	int selectListTotal(UProductDto dto) throws Exception;

	/**
	 * 실제 리스트 데이터 조회 (검색 / 정렬 / 페이징 조건 모두 반영 O)
	 */
	List<?> selectuserProductList(UProductDto dto) throws Exception;

	/**
	 * 아이디 패스워드확인 작업
	 */
	int selectLoginCheck(MemberDto memberdto) throws Exception;

	/**
	 * 아이디 유효 체크
	 */
	int selectMemberUserid(String userid) throws Exception;

	/**
	 * 회원가입 중복체크
	 */
	int selectMemberUser_id(String user_id) throws Exception;

	/**
	 * 회원가입 후 회원 저장
	 */
	int insertMember(MemberDto dto) throws Exception;

	/**
	 * 사용자 상품 상세 개수
	 */
	void updateProductListViewCnt(String product_no) throws Exception;

	/**
	 * 사용자 상품 상세화면
	 */
	UProductDto selectUserProductDetail(String product_no) throws Exception;

	/**
	 * 장바구니 목록
	 */
	int countCartList(UCartDto cartDto) throws Exception;

	/**
	 * 장바구니 업데이트
	 */
	void updateCartList(UCartDto cartDto) throws Exception;

	/**
	 * 장바구니 인서트
	 */
	void insertCartList(UCartDto cartDto) throws Exception;

	/**
	 * 전체 장바구니 건수
	 */
	int selectCartListTotalCnt(UCartDto cartDto) throws Exception;

	/**
	 * 페이징 적용 장바구니 리스트
	 */
	List<?> selectCartList(UCartDto cartDto) throws Exception;

	/**
	 * 로그인하면서 회원번호 불러오기
	 */
	MemberDto selectMemberInfoByUserId(String user_id) throws Exception;

	/**
	 * 장바구니 리스트 삭제
	 */
	void deleteCartList(UCartDto cartDto) throws Exception;

	/**
	 * 장바구니 리스트 선택 삭제
	 */
	int cartDeleteEach(String datas) throws Exception;

	/**
	 * 결제하기 리스트화면
	 */
	UInfoDto selectUserInfo(UInfoDto userInfoDto) throws Exception;

	/**
	 * order_id 시퀀스 추출
	 */
	String selectOrderId()throws Exception;

	/**
	 * 주문 dto에 order_id 세팅
	 */
	void insertOrder(UOrderDto orderDto) throws Exception;

	/**
	 * 결제 정보 insert
	 */
	void insertPayment(UPaymentDto paymentDto) throws Exception;

	/**
	 * 마이페이지 - 주문 내역 리스트 
	 */
	List<?> selectUserDelivery(UOrderDto uorderDto) throws Exception;

	/**
	 * 주문 내역 페이징 및 검색
	 */
	int selectUserDeliveryCount(UOrderDto uorderDto) throws Exception;

	/**
	 * 주문 내역 상세보기
	 */
	UOrderDto selectOrderDetail(int order_id) throws Exception;







}
