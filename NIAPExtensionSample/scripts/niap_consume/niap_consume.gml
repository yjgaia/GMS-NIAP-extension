/// @description niap_consume(product_id)
/// @param product_id

// params
var purchase_id = argument0;

if (os_type == os_ios || os_type == os_android) {
    native_iap_consume(purchase_id);
}

else {
    iap_consume(purchase_id);
}
