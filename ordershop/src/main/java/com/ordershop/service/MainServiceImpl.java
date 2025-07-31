package com.ordershop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ordershop.dto.MemberDto;
import com.ordershop.dto.UCartDto;
import com.ordershop.dto.UInfoDto;
import com.ordershop.dto.UOrderDto;
import com.ordershop.dto.UPaymentDto;
import com.ordershop.dto.UProductDto;
import com.ordershop.mapper.MainMapper;

@Service
public class MainServiceImpl implements MainService{
	
	@Autowired
	MainMapper mapper;

	@Override
	public int selectListTotal(UProductDto dto) throws Exception{
		return mapper.selectListTotal(dto);
	}

	@Override
	public List<?> selectuserProductList(UProductDto dto) throws Exception{
		return mapper.selectuserProductList(dto);
	}

	@Override
	public int selectLoginCheck(MemberDto memberdto) throws Exception {
		return mapper.selectLoginCheck(memberdto);
	}

	@Override
	public int selectMemberUserid(String userid) throws Exception {
		return mapper.selectMemberUserid(userid);
	}

	@Override
	public int selectMemberUser_id(String user_id) throws Exception {
		return mapper.selectMemberUser_id(user_id);
	}

	@Override
	public int insertMember(MemberDto dto) throws Exception {
		return mapper.insertMember(dto);
	}

	@Override
	public void updateProductListViewCnt(String product_no) throws Exception {
		mapper.updateProductListViewCnt(product_no);
	}

	@Override
	public UProductDto selectUserProductDetail(String product_no) throws Exception {
		return mapper.selectUserProductDetail(product_no);
	}

	@Override
	public int countCartList(UCartDto cartDto) throws Exception {
		return mapper.countCartList(cartDto);
	}

	@Override
	public void updateCartList(UCartDto cartDto) throws Exception {
		mapper.updateCartList(cartDto);
	}

	@Override
	public void insertCartList(UCartDto cartDto) throws Exception {
		mapper.insertCartList(cartDto);
	}

	@Override
	public int selectCartListTotalCnt(UCartDto cartDto) throws Exception {
		return mapper.selectCartListTotalCnt(cartDto);
	}

	@Override
	public List<?> selectCartList(UCartDto cartDto) throws Exception {
		return mapper.selectCartList(cartDto);
	}

	@Override
	public MemberDto selectMemberInfoByUserId(String user_id) throws Exception {
		return mapper.selectMemberInfoByUserId(user_id);
	}

	@Override
	public void deleteCartList(UCartDto cartDto) throws Exception {
		mapper.deleteCartList(cartDto);
	}

	@Override
	public int cartDeleteEach(String datas) throws Exception {
		return mapper.cartDeleteEach(datas);
	}

	@Override
	public UInfoDto selectUserInfo(UInfoDto userInfoDto) throws Exception {
		return mapper.selectUserInfo(userInfoDto);
	}

	@Override
	public String selectOrderId() throws Exception {
		return mapper.selectOrderId();
	}

	@Override
	public void insertOrder(UOrderDto orderDto) throws Exception {
		mapper.insertOrder(orderDto);
	}

	@Override
	public void insertPayment(UPaymentDto paymentDto) throws Exception {
		mapper.insertPayment(paymentDto);
	}

	@Override
	public List<?> selectUserDelivery(UOrderDto uorderDto) throws Exception {
		return mapper.selectUserDelivery(uorderDto);
	}

	@Override
	public int selectUserDeliveryCount(UOrderDto uorderDto) throws Exception {
		return mapper.selectUserDeliveryCount(uorderDto);
	}

	@Override
	public UOrderDto selectOrderDetail(int order_id) throws Exception {
		return mapper.selectOrderDetail(order_id);
	}



}
