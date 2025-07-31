package com.ordershop.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ordershop.dto.AdminDto;
import com.ordershop.dto.BlockDto;
import com.ordershop.dto.DefaultDto;
import com.ordershop.dto.DeleteDto;
import com.ordershop.dto.ProductDto;

@Mapper
public interface AdminMapper {

	public List<?> selectadminProductList(DefaultDto defaultDto);

	public int selectAdminProductTotal(DefaultDto defaultDto);

	public ProductDto selectDetailProduct(int product_no);

	public List<?> selectSerachProduct(String value);

	public int selectSearchProductCount(String value);

	public void deleteProducts(List<Long> productIds);

	public Integer selectBeforeDetailList(int product_no);

	public Integer selectNextDetailList(int product_no);

	public List<?> selectadminProductListMain();

	public int insertProduct(ProductDto dto);

	public int updateProductFprice(ProductDto dto);

	public int updatetProduct(ProductDto dto);

	public int adminDetailDelete(ProductDto dto);

	public List<?> selectSerachOrder(String value);

	public int selectAdminOrderTotal(DefaultDto defaultDto);

	public List<?> adimOrderItemList(DefaultDto defaultDto);

	public List<?> selectSerachCancelOrder(String value);

	public int selectAdminCancelOrderTotal(DefaultDto defaultDto);

	public List<?> adimCancelOrderItemList(DefaultDto defaultDto);

	public int updateCancelStatus(String datas);

	// 다연
	public int selectAdminMemberListTotal(AdminDto admindto);

	public List<?> selectAdminMemberList(AdminDto admindto);

	public int selectSearchMemberTotal(Map<String, Object> paramMap);

	public List<?> selectSearchMember(Map<String, Object> paramMap);

	public AdminDto selectadminMemberListDetail(int user_no);

	public AdminDto getMemberByUserNo(int user_no);

	public int saveDeletedMember(DeleteDto deletedto);

	public int setMemberAsDeleted(int user_no);

	//삭제목록리스트 총인원
	 public  int selectDeleteMemberListTotal(DeleteDto deletedto);

	   //삭제회원 리스트
	 public List<?> selectDeleteMemberList(DeleteDto deletedto);

	   
	   //삭제회원 검색 리스트
	 public  int selectSearchDeleteMemberTotal(@Param("key") String key, 
	                                     @Param("value") String value);

	    //삭제회원 검색 총인원
	 public   List<?> selectSearchDeleteMember(Map<String, Object> paramMap);

	public int saveBlockedMember(BlockDto blockdto);

	public int selectBlockMemberListTotal(BlockDto blockdto);

	public List<?> selectBlockMemberList(BlockDto blockdto);

	public int selectSearchBlockMemberTotal(String key, String value);

	public List<?> selectSearchBlockMember(Map<String, Object> paramMap);

	public void logicDeleteUser(Integer userNo, String reason);

	public int selectAdminCheck(AdminDto adminDto);






}
