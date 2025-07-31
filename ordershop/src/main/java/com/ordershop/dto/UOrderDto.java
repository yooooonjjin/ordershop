package com.ordershop.dto;

import lombok.Data;

@Data
public class UOrderDto extends UdefaultDto {
	
	private String order_id;
	private String product_no;
	private int order_cnt;
	private String order_rdate;
	private String delivery_method;
	private String delivery_fee;
	private String delivery_cate;
	private int user_no;
	private String order_status;
	private String pay_id;
	private String cancel_num;
	private String admin_id;
	private String recipient_name;
	private String recipient_address;
	private String product_name;
	private int total_price;
	private String delivery_request;
	private String product_description;
	private int product_price;
	private String pay_status;
	private int product_sale;	
    private int product_final_price;
    private String user_phone;
	private String user_name;
	private String pay_method;
	String product_img;
	String filepath;
	
	public String getProduct_img() {
		return product_img;
	}
	public void setProduct_img(String product_img) {
		this.product_img = product_img;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public String getPay_method() {
		return pay_method;
	}
	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getProduct_sale() {
		return product_sale;
	}
	public void setProduct_sale(int product_sale) {
		this.product_sale = product_sale;
	}
	public int getProduct_final_price() {
		return product_final_price;
	}
	public void setProduct_final_price(int product_final_price) {
		this.product_final_price = product_final_price;
	}
	public String getPay_status() {
		return pay_status;
	}
	public void setPay_status(String pay_status) {
		this.pay_status = pay_status;
	}
	public String getProduct_description() {
		return product_description;
	}
	public void setProduct_description(String product_description) {
		this.product_description = product_description;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public int getTotal_Price() {
		return total_Price;
	}
	public void setTotal_Price(int total_Price) {
		this.total_Price = total_Price;
	}
	private int total_Price;
	
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getProduct_no() {
		return product_no;
	}
	public void setProduct_no(String product_no) {
		this.product_no = product_no;
	}
	public int getOrder_cnt() {
		return order_cnt;
	}
	public void setOrder_cnt(int order_cnt) {
		this.order_cnt = order_cnt;
	}
	public String getOrder_rdate() {
		return order_rdate;
	}
	public void setOrder_rdate(String order_rdate) {
		this.order_rdate = order_rdate;
	}
	public String getDelivery_method() {
		return delivery_method;
	}
	public void setDelivery_method(String delivery_method) {
		this.delivery_method = delivery_method;
	}
	public String getDelivery_fee() {
		return delivery_fee;
	}
	public void setDelivery_fee(String delivery_fee) {
		this.delivery_fee = delivery_fee;
	}
	public String getDelivery_cate() {
		return delivery_cate;
	}
	public void setDelivery_cate(String delivery_cate) {
		this.delivery_cate = delivery_cate;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getOrder_status() {
		return order_status;
	}
	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}
	public String getPay_id() {
		return pay_id;
	}
	public void setPay_id(String pay_id) {
		this.pay_id = pay_id;
	}
	public String getCancel_num() {
		return cancel_num;
	}
	public void setCancel_num(String cancel_num) {
		this.cancel_num = cancel_num;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	public String getRecipient_name() {
		return recipient_name;
	}
	public void setRecipient_name(String recipient_name) {
		this.recipient_name = recipient_name;
	}
	public String getRecipient_address() {
		return recipient_address;
	}
	public void setRecipient_address(String recipient_address) {
		this.recipient_address = recipient_address;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public String getDelivery_request() {
		return delivery_request;
	}
	public void setDelivery_request(String delivery_request) {
		this.delivery_request = delivery_request;
	}
	
	
	
	
}
