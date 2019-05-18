package ${YYAndroidPackageName};

import android.os.Handler;
import android.os.Looper;

import com.yoyogames.runner.RunnerJNILib;

public class NIAP {
	
	private static final int EVENT_OTHER_SOCIAL = 70;

	private BillingController billingController;

	public double native_iap_init() {

		new Handler(Looper.getMainLooper()).post(new Runnable() {

			@Override
			public void run() {
				billingController = new BillingController(RunnerActivity.CurrentActivity);
			}
		});

		return -1;
	}

	public double native_iap_activate(String product_id) {
		return -1;
	}

	public double native_iap_is_available() {
	    if (billingController.isServiceConnected == true) {
	        return 1;
	    } else {
	        return 0;
	    }
	}

	public double native_iap_acquire(String product_id) {
		billingController.purchase(product_id);
		return -1;
	}

	public double native_iap_consume(String product_id) {
		billingController.consumePurchase(product_id);
		return -1;
	}
}