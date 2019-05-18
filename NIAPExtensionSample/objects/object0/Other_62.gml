/// @description 결제 검증 결과

if (ds_map_find_value(async_load, "id") == request_validate_purchase) {
    if (ds_map_find_value(async_load, "status") == 0) {
		
        var result = json_decode(ds_map_find_value(async_load, "result"));
		
		var is_valid = ds_map_find_value(result, "isValid");
		
		if (is_valid != true) {
			show_message_async("야... 결제 하기 싫으면 하지마... 왜 불법 결제를 해...");
        }
        
        else {
			
			show_message_async("결제 완료! 상품 ID: " + purchasing_product_id);
			
			niap_consume(purchasing_product_id);
		}
    }
}

