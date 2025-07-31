package com.ordershop.dto;

import lombok.Data;

@Data
public class ProductDto {

		String product_no;
		String product_name;
		int product_price;
		String product_description;
		int product_sale;
		String product_img;
		String delivery_mth;
		String delivery_fee;
		String registration_date;
		int sales_cnt;
		int view_cnt;
		String product_status;
		String admin_id;
		String product_url;
		int product_final_price;
		String updated_date;
		String filepath;
		
		public String getFilepath() {
			return filepath;
		}
		public void setFilepath(String filepath) {
			this.filepath = filepath;
		}
		public String getUpdated_date() {
			return updated_date;
		}
		public void setUpdated_date(String updated_date) {
			this.updated_date = updated_date;
		}
		public String getProduct_url() {
			return product_url;
		}
		public int getProduct_final_price() {
			return product_final_price;
		}
		public void setProduct_final_price(int product_final_price) {
			this.product_final_price = product_final_price;
		}
		public void setProduct_url(String product_url) {
			this.product_url = product_url;
		}
		public String getProduct_no() {
			return product_no;
		}
		public void setProduct_no(String product_no) {
			this.product_no = product_no;
		}
		public String getProduct_name() {
			return product_name;
		}
		public void setProduct_name(String product_name) {
			this.product_name = product_name;
		}
		public int getProduct_price() {
			return product_price;
		}
		public void setProduct_price(int product_price) {
			this.product_price = product_price;
		}
		public String getProduct_description() {
			return product_description;
		}
		public void setProduct_description(String product_description) {
			this.product_description = product_description;
		}
		public int getProduct_sale() {
			return product_sale;
		}
		public void setProduct_sale(int product_sale) {
			this.product_sale = product_sale;
		}
		public String getProduct_img() {
			return product_img;
		}
		public void setProduct_img(String product_img) {
			this.product_img = product_img;
		}
		public String getDelivery_mth() {
			return delivery_mth;
		}
		public void setDelivery_mth(String delivery_mth) {
			this.delivery_mth = delivery_mth;
		}
		public String getDelivery_fee() {
			return delivery_fee;
		}
		public void setDelivery_fee(String delivery_fee) {
			this.delivery_fee = delivery_fee;
		}
		public String getRegistration_date() {
			return registration_date;
		}
		public void setRegistration_date(String registration_date) {
			this.registration_date = registration_date;
		}
		public int getSales_cnt() {
			return sales_cnt;
		}
		public void setSales_cnt(int sales_cnt) {
			this.sales_cnt = sales_cnt;
		}
		public int getView_cnt() {
			return view_cnt;
		}
		public void setView_cnt(int view_cnt) {
			this.view_cnt = view_cnt;
		}
		public String getProduct_status() {
			return product_status;
		}
		public void setProduct_status(String product_status) {
			this.product_status = product_status;
		}
		public String getAdmin_id() {
			return admin_id;
		}
		public void setAdmin_id(String admin_id) {
			this.admin_id = admin_id;
		}
	
}
