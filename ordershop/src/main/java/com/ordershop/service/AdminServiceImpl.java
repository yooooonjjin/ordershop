package com.ordershop.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ordershop.dto.AdminDto;
import com.ordershop.dto.BlockDto;
import com.ordershop.dto.DefaultDto;
import com.ordershop.dto.DeleteDto;
import com.ordershop.dto.ProductDto;
import com.ordershop.mapper.AdminMapper;

@Service
public class AdminServiceImpl implements AdminService{

	@Autowired
	AdminMapper mapper;
	
	@Override
	public List<?> selectadminProductList(DefaultDto defaultDto) throws Exception {
		return mapper.selectadminProductList(defaultDto);
	}

	@Override
	public int selectAdminProductTotal(DefaultDto defaultDto) throws Exception {
		return mapper.selectAdminProductTotal(defaultDto);
	}

	@Override
	public ProductDto selectDetailProduct(int product_no) throws Exception {
		return mapper.selectDetailProduct(product_no);
	}

	@Override
	public List<?> selectSerachProduct(String value) throws Exception {
		return mapper.selectSerachProduct(value);
	}

	@Override
	public int selectSearchProductCount(String value) throws Exception{
		return mapper.selectSearchProductCount(value);
	}

	@Override
	public void deleteProducts(List<Long> productIds) throws Exception{
		mapper.deleteProducts(productIds);
	}

	@Override
	public Integer selectBeforeDetailList(int product_no) throws Exception{
		return mapper.selectBeforeDetailList(product_no);
	}

	@Override
	public Integer selectNextDetailList(int product_no) throws Exception{
		return mapper.selectNextDetailList(product_no);
	}

	@Override
	public List<?> selectadminProductListMain() throws Exception {
		return mapper.selectadminProductListMain();
	}

	@Override
	public int insertProduct(ProductDto dto) throws Exception {
		return mapper.insertProduct(dto);
	}

	@Override
	public int updateProductFprice(ProductDto dto) throws Exception {
		return mapper.updateProductFprice(dto);
	}

	@Override
	public int updatetProduct(ProductDto dto) throws Exception {
		return mapper.updatetProduct(dto);
	}

	@Override
	public int adminDetailDelete(ProductDto dto) throws Exception {
		return mapper.adminDetailDelete(dto);
	}

	@Override
	public List<?> selectSerachOrder(String value) throws Exception {
		return mapper.selectSerachOrder(value);
	}

	@Override
	public int selectAdminOrderTotal(DefaultDto defaultDto) throws Exception {
		return mapper.selectAdminOrderTotal(defaultDto);
	}

	@Override
	public List<?> adimOrderItemList(DefaultDto defaultDto) throws Exception {
		return mapper.adimOrderItemList(defaultDto);
	}

	@Override
	public List<?> selectSerachCancelOrder(String value) throws Exception {
		return mapper.selectSerachCancelOrder(value);
	}

	@Override
	public int selectAdminCancelOrderTotal(DefaultDto defaultDto) throws Exception {
		return mapper.selectAdminCancelOrderTotal(defaultDto);
	}

	@Override
	public List<?> adimCancelOrderItemList(DefaultDto defaultDto) throws Exception {
		return mapper.adimCancelOrderItemList(defaultDto);
	}

	@Override
	public int updateCancelStatus(String datas) throws Exception {
		return mapper.updateCancelStatus(datas);
	}

	@Override
	public int selectAdminMemberListTotal(AdminDto admindto) throws Exception {
		return mapper.selectAdminMemberListTotal(admindto);
	}

	@Override
	public List<?> selectAdminMemberList(AdminDto admindto) throws Exception {
		return mapper.selectAdminMemberList(admindto);
	}

	   //검색 회원리스트 총인원
	   @Override
	   public int selectSearchMemberTotal(String key, String value) throws Exception {
	       Map<String, Object> paramMap = new HashMap<>();
	       paramMap.put("key", key);
	       paramMap.put("value", value);
	       return mapper.selectSearchMemberTotal(paramMap);
	   }



	   //검색회원리스트
	   @Override
	   public List<?> selectSearchMember(String key, String value, AdminDto admindto) throws Exception {
	       Map<String, Object> paramMap = new HashMap<>();
	       paramMap.put("key", key);
	       paramMap.put("value", value);
	       paramMap.put("firstIndex", admindto.getFirstIndex());
	       paramMap.put("lastIndex", admindto.getLastIndex());
	       return mapper.selectSearchMember(paramMap);
	   }

	@Override
	public AdminDto selectadminMemberListDetail(int user_no) throws Exception {
		return mapper.selectadminMemberListDetail(user_no);
	}


	   
	   //삭제회원조회
	   @Override
	   public AdminDto getMemberByUserNo(int user_no) throws Exception {
	   
	       AdminDto admindto = mapper.getMemberByUserNo(user_no);
	       return admindto;
	   }

	   

	   //삭제회원목록저장
	   @Override
	   public int saveDeletedMember(DeleteDto deletedto) throws Exception{
	      return mapper.saveDeletedMember(deletedto);
	   }
	   

	   

	    //원본 테이블에서 실제 삭제 대신 논리 삭제
	   public int setMemberAsDeleted(int user_no) throws Exception {
	       int result = mapper.setMemberAsDeleted(user_no);
	       return result;
	   }


	   //삭제목록리스트 총인원
	   @Override
	   public int selectDeleteMemberListTotal(DeleteDto deletedto) throws Exception {
	      
	      return mapper.selectDeleteMemberListTotal(deletedto);
	   }



	   //삭제회원 리스트
	   @Override
	   public List<?> selectDeleteMemberList(DeleteDto deletedto) throws Exception {
	      return mapper.selectDeleteMemberList(deletedto);
	   }
	   //삭제회원 검색 리스트
	   @Override
	   public int selectSearchDeleteMemberTotal(String key, String value) throws Exception {
	      return mapper.selectSearchDeleteMemberTotal(key,value) ;
	   }

	   //삭제목록리스트검색 총인원
	   @Override
	   public List<?> selectSearchDeleteMember(String key, String value, DeleteDto deletedto) throws Exception {
	      
	      Map<String, Object> paramMap = new HashMap<>();
	       paramMap.put("key", key);
	       paramMap.put("value", value);
	       paramMap.put("firstIndex", deletedto.getFirstIndex());
	       paramMap.put("lastIndex", deletedto.getLastIndex());
	      
	      return mapper.selectSearchDeleteMember(paramMap);
	   }
	   
	 //차단 테이블에 저장 
	   @Override
	   public int saveBlockedMember(BlockDto blockdto) throws Exception {

	      return mapper.saveBlockedMember(blockdto);
	   }

	    //원본 테이블에서 실제 차단 대신 논리 차단
	   @Override
	   public int setMemberAsBlocked(int user_no) {
	        int result = mapper.setMemberAsDeleted(user_no);
	        return result;
	   }


	   //차단목록리스트 총인원
	   @Override
	   public int selectBlockMemberListTotal(BlockDto blockdto) throws Exception {
	      return mapper.selectBlockMemberListTotal(blockdto);
	   }

	   //차단회원목록리스트 서비스
	   @Override
	   public List<?> selectBlockMemberList(BlockDto blockdto) throws Exception {
	      return mapper.selectBlockMemberList(blockdto);
	   }

	   //차단회원 검색 리스트
	   @Override
	   public int selectSearchBlockMemberTotal(String key, String value) throws Exception {
	   
	      return mapper.selectSearchBlockMemberTotal(key,value);
	   }

	   //차단회원 검색 총인원
	   @Override
	   public List<?> selectSearchBlockMember(String key, String value, BlockDto blockdto) throws Exception {
	      Map<String, Object> paramMap = new HashMap<>();
	       paramMap.put("key", key);
	       paramMap.put("value", value);
	       paramMap.put("firstIndex", blockdto.getFirstIndex());
	       paramMap.put("lastIndex", blockdto.getLastIndex());
	      
	      return mapper.selectSearchBlockMember(paramMap);
	   }

	@Override
	public void logicDeleteUser(Integer userNo, String reason) throws Exception {
		mapper.logicDeleteUser(userNo,reason);
	}

	@Override
	public int selectAdminCheck(AdminDto adminDto) throws Exception {
		return mapper.selectAdminCheck(adminDto);
	}




}
