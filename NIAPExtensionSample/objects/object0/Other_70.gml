/// @description 인앱 결제 처리

if (ds_map_find_value(async_load, "type") == "niap_ev_purchase") {
    
    if (ds_map_find_value(async_load, "status") == "niap_canceled") {
		show_message_async("결제를 취소하셨습니다.");
    }
    
    else if (
    ds_map_find_value(async_load, "status") == "niap_purchased" &&
    ds_map_exists(async_load, "product") == true
    ) {
    
        purchasing_product_id = ds_map_find_value(async_load, "product");
		
        if (
        os_type == os_android &&
        ds_map_exists(async_load, "token") == true) {
			request_validate_purchase = http_get(
				"http://hanul.co:8519/api/purchasevalidate/googleplay?productId=" +
				ENCODE_URL(purchasing_product_id) +
				"&purchaseToken=" +
				ENCODE_URL(ds_map_find_value(async_load, "token"))
			);
        }
        
        if (
        os_type == os_ios &&
        ds_map_exists(async_load, "receipt") == true) {
			request_validate_purchase = http_get(
				"http://hanul.co:8519/api/purchasevalidate/appstore?productId=" +
				ENCODE_URL(purchasing_product_id) +
				"&purchaseReceipt=" +
				ENCODE_URL(ds_map_find_value(async_load, "receipt"))
			);
        }
    }
}