#import <StoreKit/StoreKit.h>

@interface NIAP : NSObject<SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
}

- (double) native_iap_init;

- (double) native_iap_activate:(char *)product_id;
- (double) native_iap_is_available;

- (double) native_iap_acquire:(char *)product_id;
- (void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response;
- (void) paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;
- (void) completeTransaction:(SKPaymentTransaction*)transaction;
- (void) failedTransaction:(SKPaymentTransaction*)transaction;

- (double) native_iap_consume:(char *)product_id;

@end