NIAPServer.MAIN = METHOD({

	run : (addRequestHandler) => {
		
		addRequestHandler((requestInfo, response) => {

			let uri = requestInfo.uri;
			let params = requestInfo.params;
			
			// 플레이스토어 결제 검증
			if (uri === 'api/purchasevalidate/googleplay') {
				
				UIAP.GOOGLE_PLAY_PURCHASE_VALIDATE({
					productId : params.productId,
					purchaseToken : params.purchaseToken
				}, (isValid) => {
					
					response({
						content : STRINGIFY({
							isValid : isValid
						}),
						contentType : 'application/json',
						headers : {
							'Access-Control-Allow-Origin' : '*'
						}
					});
				});
				
				return false;
			}
			
			// 앱스토어 결제 검증
			else if (uri === 'api/purchasevalidate/appstore') {
				
				UIAP.APP_STORE_PURCHASE_VALIDATE({
					productId : params.productId,
					receipt : params.purchaseReceipt
				}, (isValid) => {
					
					response({
						content : STRINGIFY({
							isValid : isValid
						}),
						contentType : 'application/json',
						headers : {
							'Access-Control-Allow-Origin' : '*'
						}
					});
				});
				
				return false;
			}
		});
	}
});
