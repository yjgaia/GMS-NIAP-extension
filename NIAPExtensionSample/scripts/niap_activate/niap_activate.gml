/// @description niap_activate(product_list)
/// @param product_list

// params
var product_list = argument0;

if (os_type == os_ios || os_type == os_android) {
    for (var i = 0; i < ds_list_size(product_list); i += 1) {
        native_iap_activate(ds_map_find_value(ds_list_find_value(product_list, i), "id"));
    }
}

else {
    iap_activate(argument0);
}
