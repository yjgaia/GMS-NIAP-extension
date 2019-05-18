package ${YYAndroidPackageName};

import android.app.Activity;
import android.support.annotation.Nullable;
import android.util.Log;

import com.android.billingclient.api.BillingClient;
import com.android.billingclient.api.BillingClientStateListener;
import com.android.billingclient.api.BillingFlowParams;
import com.android.billingclient.api.ConsumeResponseListener;
import com.android.billingclient.api.Purchase;
import com.android.billingclient.api.PurchaseHistoryResponseListener;
import com.android.billingclient.api.PurchasesUpdatedListener;
import com.android.billingclient.api.SkuDetails;
import com.android.billingclient.api.SkuDetailsParams;
import com.android.billingclient.api.SkuDetailsResponseListener;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yoyogames.runner.RunnerJNILib;

public class BillingController {

    private static final int EVENT_OTHER_SOCIAL = 70;

    private Activity activity;
    private BillingClient billingClient;

    public boolean isServiceConnected;

    private Map<String, String> purchaseTokenMap = new HashMap<>();

    private void executeServiceRequest(Runnable runnable) {

        if (isServiceConnected == true) {
            if (runnable != null) {
                runnable.run();
            }
        } else {

            billingClient.startConnection(new BillingClientStateListener() {
                @Override
                public void onBillingSetupFinished(@BillingClient.BillingResponse int billingResponseCode) {
                    isServiceConnected = true;

                    Purchase.PurchasesResult purchasesResult = billingClient.queryPurchases(BillingClient.SkuType.INAPP);
                    if (purchasesResult != null) {
                        List<Purchase> purchasesList = purchasesResult.getPurchasesList();
                        if (purchasesList != null) {
                            
                            for (Purchase purchase : purchasesList) {

                                purchaseTokenMap.put(purchase.getSku(), purchase.getPurchaseToken());

                                int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
                                RunnerJNILib.DsMapAddString(dsMapIndex, "type", "niap_ev_purchase");
                                RunnerJNILib.DsMapAddString(dsMapIndex, "status", "niap_purchased");
                                RunnerJNILib.DsMapAddString(dsMapIndex, "product", purchase.getSku());
                                RunnerJNILib.DsMapAddString(dsMapIndex, "token", purchase.getPurchaseToken());
                                RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);
                            }
                        }
                    }
                }

                @Override
                public void onBillingServiceDisconnected() {
                    isServiceConnected = false;
                }
            });
        }
    }

    public BillingController(Activity activity) {
        this.activity = activity;

        billingClient = BillingClient.newBuilder(activity).setListener(new PurchasesUpdatedListener() {

            @Override
            public void onPurchasesUpdated(int responseCode, @Nullable List<Purchase> purchases) {

                if (responseCode == BillingClient.BillingResponse.OK && purchases != null) {
                    
                    for (Purchase purchase : purchases) {

                        purchaseTokenMap.put(purchase.getSku(), purchase.getPurchaseToken());

                        int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
                        RunnerJNILib.DsMapAddString(dsMapIndex, "type", "niap_ev_purchase");
                        RunnerJNILib.DsMapAddString(dsMapIndex, "status", "niap_purchased");
                        RunnerJNILib.DsMapAddString(dsMapIndex, "product", purchase.getSku());
                        RunnerJNILib.DsMapAddString(dsMapIndex, "token", purchase.getPurchaseToken());
                        RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);
                    }
                }

                else if (responseCode == BillingClient.BillingResponse.USER_CANCELED) {
                    int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
                    RunnerJNILib.DsMapAddString(dsMapIndex, "type", "niap_ev_purchase");
                    RunnerJNILib.DsMapAddString(dsMapIndex, "status", "niap_canceled");
                    RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);
                }

                else {
                    int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
                    RunnerJNILib.DsMapAddString(dsMapIndex, "type", "niap_ev_purchase");
                    RunnerJNILib.DsMapAddString(dsMapIndex, "status", "niap_canceled");
                    RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);
                }
            }
        }).build();

        executeServiceRequest(null);
    }

    public void purchase(final String productId) {

        executeServiceRequest(new Runnable() {
            @Override
            public void run() {

                billingClient.launchBillingFlow(activity, BillingFlowParams.newBuilder()
                        .setSku(productId)
                        .setType(BillingClient.SkuType.INAPP)
                        .build());
            }
        });
    }

    public void consumePurchase(final String productId) {
        executeServiceRequest(new Runnable() {
            @Override
            public void run() {

                billingClient.consumeAsync(purchaseTokenMap.get(productId), new ConsumeResponseListener() {
                    @Override
                    public void onConsumeResponse(int responseCode, String purchaseToken) {
                        if (responseCode == BillingClient.BillingResponse.OK) {
                            purchaseTokenMap.remove(productId);
                        }
                    }
                });
            }
        });
    }
}
