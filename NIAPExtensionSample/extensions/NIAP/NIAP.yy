{
    "id": "72c5cb75-7853-4145-83ad-58a0a89ee934",
    "modelName": "GMExtension",
    "mvc": "1.0",
    "name": "NIAP",
    "IncludedResources": [
        
    ],
    "androidPermissions": [
        "com.android.vending.BILLING"
    ],
    "androidProps": true,
    "androidactivityinject": "",
    "androidclassname": "NIAP",
    "androidinject": "",
    "androidmanifestinject": "",
    "androidsourcedir": "",
    "author": "",
    "classname": "NIAP",
    "copyToTargets": 12,
    "date": "2019-48-23 05:04:59",
    "description": "",
    "extensionName": "",
    "files": [
        {
            "id": "d536836b-c30f-4f2a-9289-7218b4b79721",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": -1,
            "filename": "NIAP.ext",
            "final": "",
            "functions": [
                {
                    "id": "5b5dd8f5-fb9c-4d45-85dc-02e8deec0b52",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "native_iap_activate",
                    "help": "native_iap_activate(product_id)",
                    "hidden": false,
                    "kind": 4,
                    "name": "native_iap_activate",
                    "returnType": 2
                },
                {
                    "id": "5816e788-5677-403d-ac05-e65086705498",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "native_iap_is_available",
                    "help": "native_iap_is_available()",
                    "hidden": false,
                    "kind": 4,
                    "name": "native_iap_is_available",
                    "returnType": 2
                },
                {
                    "id": "9dfd7276-e863-4617-ab4b-de025c04f7a4",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "native_iap_acquire",
                    "help": "native_iap_acquire(product_id)",
                    "hidden": false,
                    "kind": 4,
                    "name": "native_iap_acquire",
                    "returnType": 2
                },
                {
                    "id": "dc94b8fc-24d3-4bfa-a17f-b9205158de93",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "native_iap_consume",
                    "help": "native_iap_consume(product_id)",
                    "hidden": false,
                    "kind": 4,
                    "name": "native_iap_consume",
                    "returnType": 2
                },
                {
                    "id": "f58fc434-1165-4161-8ca1-3954f1b06c7b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "native_iap_init",
                    "help": "native_iap_init()",
                    "hidden": false,
                    "kind": 4,
                    "name": "native_iap_init",
                    "returnType": 2
                }
            ],
            "init": "",
            "kind": 4,
            "order": [
                "f58fc434-1165-4161-8ca1-3954f1b06c7b",
                "5b5dd8f5-fb9c-4d45-85dc-02e8deec0b52",
                "5816e788-5677-403d-ac05-e65086705498",
                "9dfd7276-e863-4617-ab4b-de025c04f7a4",
                "dc94b8fc-24d3-4bfa-a17f-b9205158de93"
            ],
            "origname": "",
            "uncompress": false
        }
    ],
    "gradleinject": "compile 'com.android.billingclient:billing:1.0'",
    "helpfile": "",
    "installdir": "",
    "iosProps": true,
    "iosSystemFrameworkEntries": [
        
    ],
    "iosThirdPartyFrameworkEntries": [
        
    ],
    "iosdelegatename": "",
    "iosplistinject": "",
    "license": "",
    "maccompilerflags": "",
    "maclinkerflags": "",
    "macsourcedir": "",
    "packageID": "",
    "productID": "",
    "sourcedir": "",
    "tvosProps": false,
    "tvosSystemFrameworkEntries": [
        
    ],
    "tvosThirdPartyFrameworkEntries": [
        
    ],
    "tvosclassname": "",
    "tvosdelegatename": "",
    "tvosmaccompilerflags": "",
    "tvosmaclinkerflags": "",
    "tvosplistinject": "",
    "version": "0.0.1"
}