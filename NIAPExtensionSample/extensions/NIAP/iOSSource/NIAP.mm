#import "NIAP.h"

@implementation NIAP

const int EVENT_OTHER_SOCIAL = 70;
extern int CreateDsMap( int _num, ... );
extern void CreateAsynEventWithDSMap(int dsmapindex, int event_index);

- (double) native_iap_init
{
    return (double)-1;
}

- (double) native_iap_activate:(char *)product_id
{
    // init
    if ([SKPaymentQueue canMakePayments]) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver: self];
    }
    return (double)-1;
}

- (double) native_iap_is_available
{
    if ([SKPaymentQueue canMakePayments]) {
        return (double)1;
    } else {
        return (double)0;
    }
}

// 상품을 요청합니다.
- (double) native_iap_acquire:(char *)product_id
{
    NSSet * productIdentifiers = [NSSet setWithObjects:[NSString stringWithUTF8String: product_id], nil];
    SKProductsRequest * productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
    
    return (double)-1;
}

// 상품 요청에 응답합니다.
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    for (SKProduct * product in response.products) {
        if (product != nil) {
            // 구매 가능 상품이면 결제를 요청합니다.
            SKPayment * payment = [SKPayment paymentWithProduct:product];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        }
    }
}

// 결제 요청에 응답합니다.
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction * transaction in transactions) {
        switch (transaction.transactionState) {
            
            // 결제 성공
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
                
            // 결제 복구
            case SKPaymentTransactionStateRestored:
                [self completeTransaction:transaction];
                break;
                
            // 결제 취소 혹은 실패
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
        }        
    }
}

SKPaymentTransaction * transaction;

- (void) completeTransaction:(SKPaymentTransaction *)_transaction
{
    transaction = _transaction;
    
    NSURL * receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData * receipt = [NSData dataWithContentsOfURL:receiptURL];
    NSString * encReceipt = [receipt base64EncodedStringWithOptions:0];
    
    CreateAsynEventWithDSMap(CreateDsMap(4,
        "type", 0.0, "niap_ev_purchase",
        "status", 0.0, "niap_purchased",
        "product", 0.0, [transaction.payment.productIdentifier UTF8String],
        "receipt", 0.0, [encReceipt UTF8String]
    ), EVENT_OTHER_SOCIAL);
}

- (void) failedTransaction:(SKPaymentTransaction *)transaction
{
    CreateAsynEventWithDSMap(CreateDsMap(2,
        "type", 0.0, "niap_ev_purchase",
        "status", 0.0, "niap_canceled"
    ), EVENT_OTHER_SOCIAL);
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (double) native_iap_consume:(char *)product_id
{
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];

    return (double)-1;
}

@end