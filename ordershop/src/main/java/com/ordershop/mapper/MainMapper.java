package com.ordershop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ordershop.dto.MemberDto;
import com.ordershop.dto.UCartDto;
import com.ordershop.dto.UInfoDto;
import com.ordershop.dto.UOrderDto;
import com.ordershop.dto.UPaymentDto;
import com.ordershop.dto.UProductDto;

@Mapper
public interface MainMapper {

	int selectListTotal(UProductDto dto);

	List<?> selectuserProductList(UProductDto dto);

	int selectLoginCheck(MemberDto memberdto);

	int selectMemberUserid(String userid);

	int selectMemberUser_id(String user_id);

	int insertMember(MemberDto dto);

	void updateProductListViewCnt(String product_no);

	UProductDto selectUserProductDetail(String product_no);

	int countCartList(UCartDto cartDto);

	void updateCartList(UCartDto cartDto);

	void insertCartList(UCartDto cartDto);

	int selectCartListTotalCnt(UCartDto cartDto);

	List<?> selectCartList(UCartDto cartDto);

	int getUserNoByUserId(String user_id);

	MemberDto selectMemberInfoByUserId(String user_id);

	void deleteCartList(UCartDto cartDto);

	int cartDeleteEach(String datas);

	UInfoDto selectUserInfo(UInfoDto userInfoDto);

	String selectOrderId();

	void insertOrder(UOrderDto orderDto);

	void insertPayment(UPaymentDto paymentDto);

	List<?> selectUserDelivery(UOrderDto uorderDto);

	int selectUserDeliveryCount(UOrderDto uorderDto);

	UOrderDto selectOrderDetail(int order_id);



}
