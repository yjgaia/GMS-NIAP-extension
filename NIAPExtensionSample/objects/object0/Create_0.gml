/// @description Insert description here
// You can write your code in this editor

request_validate_purchase = -1;
purchasing_product_id = "";

niap_init();

var product_list = ds_list_create();

var product_data = ds_map_create();
ds_map_add(product_data, "id", "please_buy_me");
ds_list_add(product_list, product_data);

niap_activate(product_list);

ds_map_destroy(product_data);
ds_list_destroy(product_list);