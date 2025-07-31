package com.ordershop.service;

import java.util.List;

import com.ordershop.dto.AdminDto;
import com.ordershop.dto.BlockDto;
import com.ordershop.dto.DefaultDto;
import com.ordershop.dto.DeleteDto;
import com.ordershop.dto.ProductDto;

public interface AdminService {

	/**
	 * 상품 리스트 출력
	 */
	List<?> selectadminProductList(DefaultDto defaultDto) throws Exception;

	/**
	 * 상품 총 갯수
	 */
	int selectAdminProductTotal(DefaultDto defaultDto) throws Exception;

	/**
	 * 상품 상세
	 */
	ProductDto selectDetailProduct(int product_no) throws Exception;

	/**
	 * 상품 검색 리스트
	 */
	List<?> selectSerachProduct(String value) throws Exception;

	/**
	 * 상품 검색 리스트 갯수 
	 */
	int selectSearchProductCount(String value) throws Exception;

	/**
	 * 상품 (선택) 삭제
	 */
	void deleteProducts(List<Long> productIds) throws Exception;

	/**
	 * 상품 이전 상세 리스트
	 */
	Integer selectBeforeDetailList(int product_no) throws Exception;
	
	/**
	 * 상품 다음 상세 리스트
	 */
	Integer selectNextDetailList(int product_no) throws Exception;

	/**
	 * 관리자 메인 상품리스트
	 */
	List<?> selectadminProductListMain() throws Exception;

	/**
	 * 상품 등록
	 */
	int insertProduct(ProductDto dto) throws Exception;

	/**
	 * 상품 최종 가격(세일가)
	 */
	int updateProductFprice(ProductDto dto) throws Exception;

	/**
	 * 상품 수정 처리
	 */
	int updatetProduct(ProductDto dto) throws Exception;

	/**
	 * 상품디테일 삭제
	 */
	int adminDetailDelete(ProductDto dto) throws Exception;

	/**
	 * 주문 목록 검색 리스트 출력
	 */
	List<?> selectSerachOrder(String value) throws Exception;

	/**
	 * 주문 전체 개수
	 */
	int selectAdminOrderTotal(DefaultDto defaultDto) throws Exception;

	/**
	 * 주문 전체 목록 리스트
	 */
	List<?> adimOrderItemList(DefaultDto defaultDto) throws Exception;

	/**
	 * 취소 목록 검색 리스트 출력
	 */
	List<?> selectSerachCancelOrder(String value) throws Exception;

	/**
	 * 취소 전체 개수
	 */
	int selectAdminCancelOrderTotal(DefaultDto defaultDto) throws Exception;

	/**
	 * 취소 전체 목록 리스트
	 */
	List<?> adimCancelOrderItemList(DefaultDto defaultDto) throws Exception;

	/**
	 * 취소목록 취소 확인 요청 확인 버튼 클릭시 N- -> Y 로 업데이트
	 */
	int updateCancelStatus(String datas) throws Exception;

	// 다연
	/**
	 * 관리자 메인화면 멤버리스트 총명
	 */
	int selectAdminMemberListTotal(AdminDto admindto) throws Exception;

	/**
	 * 관리자 메인 멤버리스트
	 */
	List<?> selectAdminMemberList(AdminDto admindto) throws Exception;

	/**
	 * 회원목록 검색한 경우 총명
	 */
	int selectSearchMemberTotal(String key, String value) throws Exception;

	/**
	 * 회원목록 검색한 경우 리스트
	 */
	List<?> selectSearchMember(String key, String value, AdminDto admindto) throws Exception;

	/**
	 * 회원목록 상세보기
	 */
	AdminDto selectadminMemberListDetail(int user_no) throws Exception;

	/**
	 * 삭제 회원정보조회
	 */
	AdminDto getMemberByUserNo(int user_no) throws Exception;

	/**
	 * 삭제 테이블저장
	 */
	int saveDeletedMember(DeleteDto deletedto) throws Exception;

	/**
	 * 원본 테이블에서 실제 삭제 대신 논리 삭제
	 */
	int setMemberAsDeleted(int user_no) throws Exception;

	/**
	 * 회원삭제 총인원
	 */
	int selectDeleteMemberListTotal(DeleteDto deletedto) throws Exception;

	/**
	 * 삭제회원 검색 총인원
	 */
	int selectSearchDeleteMemberTotal(String key, String value) throws Exception;

	/**
	 * 삭제회원리스트
	 */
	List<?> selectDeleteMemberList(DeleteDto deletedto) throws Exception;

	/**
	 * 삭제회원 검색 리스트
	 */
	List<?> selectSearchDeleteMember(String key, String value, DeleteDto deletedto) throws Exception;

	/**
	 * 차단 테이블에 저장
	 */
	int saveBlockedMember(BlockDto blockdto) throws Exception;

	/**
	 * 원본 테이블에서 실제 차단 대신 논리 차단
	 */
	int setMemberAsBlocked(int user_no) throws Exception;

	/**
	 * 회원 차단리스트 총 인원
	 */
	int selectBlockMemberListTotal(BlockDto blockdto) throws Exception;

	/**
	 * 회원 검색 차단리스트 총 인원
	 */
	int selectSearchBlockMemberTotal(String key, String value) throws Exception;

	/**
	 * 회원 차단리스트 
	 */
	List<?> selectBlockMemberList(BlockDto blockdto) throws Exception;

	/**
	 * 회원차단검색 리스트
	 */
	List<?> selectSearchBlockMember(String key, String value, BlockDto blockdto)throws Exception;

	/**
	 * 메인화면 회원 일괄 삭제
	 */
	void logicDeleteUser(Integer userNo, String reason)throws Exception;

	
	/**
	 * 관리자 로그인
	 */
	int selectAdminCheck(AdminDto adminDto) throws Exception;







}
