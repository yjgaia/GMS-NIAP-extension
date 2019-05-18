/// @description niap_is_available

if (os_type == os_ios || os_type == os_android) {
    return native_iap_is_available();
}

else {
    if (iap_status() == iap_status_available) {
        return true;
    }
    return false;
}
