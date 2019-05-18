require(process.env.UPPERCASE_PATH + '/LOAD.js');

BOOT({
	CONFIG : {
		isDevMode : true,
		defaultBoxName : 'NIAPServer',
		webServerPort : 8519
	},

	NODE_CONFIG : {
		isSingleCoreMode : true,
		
		UIAP : {
			GooglePlay : {
				clientEmail : '~~~@~~~.iam.gserviceaccount.com',
				privateKey : '-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n',
				appPackageName : 'co.hanul.NIAP'
			}
		}
	}
});
