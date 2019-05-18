// niap_acquire(product_id)

// params
var product_id = argument0;

if (os_type == os_ios || os_type == os_android) {
    native_iap_acquire(product_id);
}

else {
    iap_acquire(product_id, "");
}
