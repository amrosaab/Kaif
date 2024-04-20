// ignore_for_file: prefer_single_quotes, lines_longer_than_80_chars final
import 'common/constants/country_phone_codes.dart';

Map<String, dynamic> environment = {
  "appConfig":
      "https://raw.githubusercontent.com/kaifapp/KaifApp/main/config_ar.json",
  "serverConfig": {
    "url": "https://kaif.co",
   //  "url": "https://kaifq8.myshopify.com",
    "type": "shopify",
    "accessToken": "b8fc7e8f2fb73b49169bc3f565fd076d"
  },
  "defaultDarkTheme": false,
  "enableRemoteConfigFirebase": false,
  "enableFirebaseAnalytics": false,
  "loginSMSConstants": {
    "countryCodeDefault": "KW",
    "dialCodeDefault": "+965",
    "nameDefault": "Kuwait",
  },
  "phoneNumberConfig": {
    "enable": true,
    "enablePhoneNumberValidation": true,
    "countryCodeDefault": "KW",
    "dialCodeDefault": "+965",
    "useInternationalFormat": true,
    "selectorFlagAsPrefixIcon": true,
    "showCountryFlag": true,
    "customCountryList": countryPhoneCodes.map((e) => e['code']),
    "selectorType": "BOTTOM_SHEET",
  },
  "appRatingConfig": {
    "showOnOpen": false,
    "minLaunches": 10,
    "remindDays": 7,
    "android": "kaifq8.android.app",
    "minDays": 7,
    "ios": "1469772800",
    "remindLaunches": 10
  },
  "advanceConfig": {
    "DefaultLanguage": "en",
    "DetailedBlogLayout": "halfSizeImageType",
    "EnablePointReward": false,
    "hideOutOfStock": true,
    "HideEmptyTags": true,
    "HideEmptyCategories": true,
    "EnableRating": true,
    "hideEmptyProductListRating": true,
    "EnableCart": true,
    "ShowBottomCornerCart": true,
    "EnableSkuSearch": true,
    "showStockStatus": false,
    "GridCount": 3,
    "isCaching": false,
    "kIsResizeImage": false,
    "httpCache": true,
    "Currencies": [
      {
        "symbol": "KD",
        "decimalDigits": 2,
        "symbolBeforeTheNumber": true,
        "currency": "KWD",
        "currencyCode": "KW",
        "rate": 1,
        "smallestUnitRate": 1,
        "countryCode": "KW",
      },
      {
        "symbol": "AE",
        "decimalDigits": 2,
        "symbolBeforeTheNumber": true,
        "currency": "AED",
        "currencyCode": "AE",
        "rate": 12,
        "smallestUnitRate": 1,
        "countryCode": "AE",
      },
      {
        "symbol": "OM",
        "decimalDigits": 2,
        "symbolBeforeTheNumber": true,
        "currency": "OMR",
        "currencyCode": "OM",
        "rate": 1.3,
        "smallestUnitRate": 1,
        "countryCode": "OM",
      },
      {
        "symbol": "QA",
        "decimalDigits": 2,
        "symbolBeforeTheNumber": true,
        "currency": "QAR",
        "currencyCode": "QA",
        "rate": 12,
        "smallestUnitRate": 1,
        "countryCode": "QA",
      },
      {
        "symbol": "SAR",
        "decimalDigits": 2,
        "symbolBeforeTheNumber": true,
        "currency": "SAR",
        "currencyCode": "SA",
        "rate": 12.5,
        "smallestUnitRate": 1,
        "countryCode": "SA",
      },
      {
        "symbol": "USD",
        "decimalDigits": 2,
        "symbolBeforeTheNumber": true,
        "currency": "USD",
        "currencyCode": "US",
        "rate": 3.3,
        "smallestUnitRate": 1,
        "countryCode": "US",
      },
    ],
    "DefaultStoreViewCode": "",
    "EnableAttributesConfigurableProduct": ["color", "size"],
    "EnableAttributesLabelConfigurableProduct": ["color", "size"],
    "isMultiLanguages": true,
    "EnableApprovedReview": false,
    "EnableSyncCartFromWebsite": false,
    "EnableSyncCartToWebsite": false,
    "EnableFirebase": true,
    "RatioProductImage": 1.2,
    "EnableCouponCode": true,
    "ShowCouponList": false,
    "ShowAllCoupons": false,
    "ShowExpiredCoupons": false,
    "AlwaysShowTabBar": false,
    "PrivacyPoliciesPageUrlOrId": "https://policies.google.com/",
    "SupportPageUrl": "https://support.inspireui.com/",
    "DownloadPageUrl": "https://mstore.io/#download",
    "SocialConnectUrl": [
      {
        "name": "Facebook",
        "icon": "assets/icons/logins/facebook.png",
        "url": "https://www.facebook.com/inspireui"
      },
      {
        "name": "Instagram",
        "icon": "assets/icons/logins/instagram.png",
        "url": "https://www.instagram.com/inspireui9/"
      }
    ],
    "AutoDetectLanguage": false,
    "QueryRadiusDistance": 10,
    "MinQueryRadiusDistance": 1,
    "MaxQueryRadiusDistance": 10,
    "EnableWooCommerceWholesalePrices": false,
    "IsRequiredSiteSelection": true,
    "EnableDeliveryDateOnCheckout": false,
    "EnableNewSMSLogin": false,
    "EnableBottomAddToCart": true,
    "inAppWebView": false,
    "EnableWOOCSCurrencySwitcher": true,
    "enableProductBackdrop": false,
    "categoryImageMenu": true,
    "EnableDigitsMobileLogin": false,
    "EnableDigitsMobileFirebase": false,
    "EnableDigitsMobileWhatsApp": false,
    "WebViewScript": "",
    "versionCheck": {"enable": true, "iOSAppStoreCountry": "US"},
    "AjaxSearchURL": "",
    "AlwaysClearWebViewCache": false,
    "AlwaysClearWebViewCookie": false,
    "AlwaysRefreshBlog": false,
    "OrderNotesWithPrivateNote": true,
    "OrderNotesLinkSupport": false,
    "inAppUpdateForAndroid": {"enable": false, "typeUpdate": "flexible"},
    "categoryConfig": {"enableLargeCategories": false, "deepLevel": 3},
    "pinnedProductTags": [],
    "TimeShowToastMessage": 1500,
    "showRequestNotification": true,
    "PrivacyPoliciesPageId": null,
    "DefaultCurrency": {
      "symbol": "KD",
      "decimalDigits": 2,
      "symbolBeforeTheNumber": true,
      "currency": "KWD",
      "currencyCode": "KW",
      "smallestUnitRate": 1,
      "countryCode": "KW",
      "rate": 1,
    },
    "gdpr": {
      "confirmCaptcha": "PERMANENTLY DELETE",
      "showPrivacyPolicyFirstTime": false,
      "showDeleteAccount": true
    }
  },
  "defaultDrawer": {
    "background": null,
    "logo": "assets/images/logo.png",
    "items": [
      {"show": true, "type": "home"},
      {"show": true, "type": "blog"},
      {"show": true, "type": "categories"},
      {"show": true, "type": "cart"},
      {"show": true, "type": "profile"},
      {"show": true, "type": "login"},
      {"show": true, "type": "category"}
    ]
  },
  "defaultSettings": [
    "products",
    "wishlist",
    "notifications",
    "language",
    "currencies",
    "darkTheme",
    "order",
    "rating",
  ],
  "loginSetting": {
    "facebookAppId": "430258564493822",
    "requirePhoneNumberWhenRegister": false,
    "facebookLoginProtocolScheme": "fb430258564493822",
    "smsLoginAsDefault": false,
    "showPhoneNumberWhenRegister": false,
    "IsRequiredLogin": false,
    "isResetPasswordSupported": true,
    "appleLoginSetting": {
      "appleAccountTeamID": "S9RPAM8224",
      "iOSBundleId": "ios.app.kaifq8"
    }
  },
  "oneSignalKey": {
    "enable": true,
    "appID": "5c64f493-110f-4766-b389-7472b833b146"
  },
  "onBoardingConfig": {
    "data": [
      {
        "image": "assets/images/fogg-delivery-1.png",
        "title": "Welcome to Kaif",
        "desc": "Kaif is on the way to serve you. "
      },
      {
        "image": "assets/images/fogg-uploading-1.png",
        "title": "Connect Surrounding World",
        "desc":
            "See all things happening around you just by a click in your phone. Fast, convenient and clean."
      },
      {
        "image": "assets/images/fogg-order-completed.png",
        "title": "Let's Get Started",
        "desc": "Waiting no more, let's see what we get!"
      }
    ],
    "autoCropImageByDesign": true,
    "isOnlyShowOnFirstTime": true,
    "version": 1,
    "enableOnBoarding": false,
    "showLanguage": true
  },
  "adConfig": {
    "ads": [
      {
        "iosId": "ca-app-pub-3940256099942544/2934735716",
        "waitingTimeToDisplay": 2,
        "provider": "google",
        "showOnScreens": ["home", "search"],
        "type": "banner",
        "androidId": "ca-app-pub-3940256099942544/6300978111"
      },
      {
        "iosId": "ca-app-pub-2101182411274198/5418791562",
        "provider": "google",
        "type": "banner",
        "androidId": "ca-app-pub-2101182411274198/4052745095"
      },
      {
        "iosId": "ca-app-pub-3940256099942544/4411468910",
        "waitingTimeToDisplay": 5,
        "provider": "google",
        "showOnScreens": ["profile"],
        "type": "interstitial",
        "androidId": "ca-app-pub-3940256099942544/4411468910"
      },
      {
        "iosId": "ca-app-pub-3940256099942544/1712485313",
        "provider": "google",
        "showOnScreens": ["cart"],
        "type": "reward",
        "androidId": "ca-app-pub-3940256099942544/4411468910"
      },
      {
        "iosId": "IMG_16_9_APP_INSTALL#430258564493822_876131259906548",
        "provider": "facebook",
        "showOnScreens": ["home"],
        "type": "banner",
        "androidId": "IMG_16_9_APP_INSTALL#430258564493822_489007588618919"
      },
      {
        "iosId": "430258564493822_489092398610438",
        "provider": "facebook",
        "type": "interstitial",
        "androidId": "IMG_16_9_APP_INSTALL#430258564493822_489092398610438"
      }
    ],
    "enable": false,
    "googleTestingId": [],
    "adMobAppIdIos": "ca-app-pub-7432665165146018~2664444130",
    "facebookTestingId": "",
    "adMobAppIdAndroid": "ca-app-pub-7432665165146018~2664444130"
  },
  "firebaseDynamicLinkConfig": {
    "iOSAppStoreId": "1469772800",
    "androidPackageName": "kaifq8.android.app",
    "isEnabled": true,
    "androidAppMinimumVersion": 1,
    "link": "https://kaif.co/",
    "uriPrefix": "https://fawaah.com/",
    "shortDynamicLinkEnable": true,
    "iOSBundleId": "ios.app.kaifq8",
    "iOSAppMinimumVersion": "1.0.1"
  },
  "languagesInfo": [
    {
      "name": "Arabic",
      "icon": "assets/images/country/ar.png",
      "code": "ar",
      "text": "العربية",
      "storeViewCode": "ar"
    },
    {
      "name": "English",
      "icon": "assets/images/country/gb.png",
      "code": "en",
      "text": "English",
      "storeViewCode": ""
    }
  ],
  "paymentConfig": {
    "DefaultCountryISOCode": "KW",

    "DefaultStateISOCode": "",

    /// Enable the Shipping option from Checkout, support for the Digital Download
    "EnableShipping": true,

    /// Enable the address shipping.
    /// Set false if use for the app like Download Digial Asset which is not required the shipping feature.
    "EnableAddress": true,

    /// Allow customers to add note when order
    "EnableCustomerNote": true,

    /// Allow customers to add address location link to order note
    "EnableAddressLocationNote": false,

    /// Allow both alphabetical and numerical characters in ZIP code
    "EnableAlphanumericZipCode": false,

    /// Enable the product review option
    "EnableReview": false,

    /// Enable the Google Maps picker from Billing Address.
    "allowSearchingAddress": false,

    "GuestCheckout": true,

    /// Enable Payment option
    "EnableOnePageCheckout": false,
    "NativeOnePageCheckout": false,

    "ShowWebviewCheckoutSuccessScreen": true,

    /// This config is same with checkout page slug in the website
    "CheckoutPageSlug": {"en": "checkout"},

    /// Enable Credit card payment (only available for Fluxstore Shopify)
    "EnableCreditCard": false,

    /// Enable update order status to processing after checkout by COD on woo commerce
    "UpdateOrderStatus": true,

    /// Show order notes in order history detail.
    "ShowOrderNotes": true,

    /// Show Refund and Cancel button on Order Detail
    "EnableRefundCancel": true,

    /// If the order completed date is after this period (days), the refund button will be hidden.
    "RefundPeriod": 7,

    /// Apply the extra fee for the COD method
    /// amountStop: Amount to stop charge the extra fee
    "SmartCOD": {"enabled": true, "extraFee": 10, "amountStop": 200},

    /// List ids to hide some unnecessary payment methods
    "excludedPaymentIds": [],
  },
  "payments": {
    "expresspay_apple_pay": "assets/icons/payment/apple-pay-mark.svg",
    "tap": "assets/icons/payment/tap.png",
    "paystack": "assets/icons/payment/paystack.png",
    "stripe_v2_google_pay": "assets/icons/payment/google-pay-mark.png",
    "ppcp-gateway": "assets/icons/payment/paypal.svg",
    "midtrans": "assets/icons/payment/midtrans.png",
    "xendit_cc": "assets/icons/payment/xendit.png",
    "stripe_v2_apple_pay": "assets/icons/payment/apple-pay-mark.svg",
    "myfatoorah_v2": "assets/icons/payment/myfatoorah.png",
    "thai-promptpay-easy": "assets/icons/payment/prompt-pay.png",
    "stripe": "assets/icons/payment/stripe.svg",
    "razorpay": "assets/icons/payment/razorpay.svg",
    "paypal": "assets/icons/payment/paypal.svg"
  },
  "payTmConfig": {
    "merchantId": "your-merchant-id",
    "production": false,
    "paymentMethodId": "paytm",
    "enabled": true
  },
  "inAppPurchaseConfig": {
    "subscriptionProductIDs": ["com.inspireui.fluxstore.subscription.test"],
    "nonConsumableProductIDs": [],
    "consumableProductIDs": ["com.inspireui.fluxstore.test"],
    "enabled": false
  },
  "expressPayConfig": {
    "merchantPassword": "4a00a5fd3c63dd2b743c75746af6ffe2",
    "merchantId": "merchant.com.inspireui.mstore.flutter",
    "production": false,
    "paymentMethodId": "shahbandrpay",
    "merchantKey": "b2be2ffc-c8b9-11ed-82a9-42eb4e39c8ae",
    "enabled": true
  },
  "defaultCountryShipping": [],
  "googleApiKey": {
    "web": "AIzaSyDSNYVC-8DU9BTcyqkeN9c5pgVhwOBAvGg",
    "android": "AIzaSyDSNYVC-8DU9BTcyqkeN9c5pgVhwOBAvGg",
    "ios": "AIzaSyDSNYVC-8DU9BTcyqkeN9c5pgVhwOBAvGg"
  },
  "productDetail": {
    "height": 0.6,
    "marginTop": 0,
    "safeArea": false,
    "showVideo": true,
    "showBrand": true,
    "showThumbnailAtLeast": 1,
    "layout": "simpleType",
    "borderRadius": 3.0,

    /// Enable this to show selected image variant in the top banner.
    "ShowSelectedImageVariant": true,

    "autoPlayGallery": true,
    "SliderShowGoBackButton": true,
    "ShowImageGallery": true,

    /// "SliderIndicatorType" can be "number", "dot". Default: "number".
    "SliderIndicatorType": 'number',

    /// Enable this to add a white background to top banner for transparent product image.
    "ForceWhiteBackground": false,

    /// Auto select first attribute of variable product if there is no default attribute.
    "AutoSelectFirstAttribute": true,

    /// Enable this to show review in product description.
    "enableReview": true,
    "attributeImagesSize": 50.0,
    "showSku": true,
    "showStockQuantity": false,
    "showProductCategories": false,
    "showProductTags": false,
    "hideInvalidAttributes": true,

    /// Enable this to show a quantity selector in product list.
    "showQuantityInList": false,

    /// Enable this to show Add to cart icon in search result list.
    "showAddToCartInSearchResult": true,

    /// Increase this number if you have yellow layout overflow error in product list.
    /// Should check "RatioProductImage" before changing this number.
    "productListItemHeight": 125,

    /// Limit the time a user can make an appointment. Units are in days.
    /// If the value is not set, there will be no limit on the appointment date.
    /// For example:
    ///  Today is October 11, 2020 and limitDayBooking is 7 days.
    /// --> So users can only book appointments from October 11, 2020 to October 18, 2020
    "limitDayBooking": 14,

    // Hide or show related products in product detail screen.
    "showRelatedProductFromSameStore": true,
    "showRelatedProduct": true,
    "showRecentProduct": true,

    // Product image layout
    "productImageLayout": "page",

    "expandDescription": true,
    "expandInfors": true,
    "expandCategories": true,
    "expandTags": true,
    "expandReviews": true,
    "expandTaxonomies": true,
    "expandListingMenu": true,
    "expandMap": true,

    "fixedBuyButtonToBottom": true
  },
  "blogDetail": {
    "showAuthorInfo": true,
    "showTextAdjustment": true,
    "showRelatedBlog": true,
    "showComment": true,
    "showHeart": true,
    "showSharing": true,
    "enableAudioSupport": false
  },
  "productVariantLayout": {
    "color": "color",
    "size": "box",
    "color-image": "image",
    "height": "option"
  },
  "productAddons": {
    "allowedCustomType": ["png", "pdf", "docx"],
    "allowMultiple": false,
    "allowImageType": true,
    "allowVideoType": true,
    "allowCustomType": true,
    "fileUploadSizeLimit": 5
  },
  "cartDetail": {
    "maxAllowQuantity": 10,
    "minAllowTotalCartValue": 1,
    "style": "style01"
  },
  "productVariantLanguage": {
    "ar": {
      "color": "اللون",
      "size": "بحجم",
      "color-image": "اللون",
      "height": "ارتفاع"
    },
    "vi": {
      "color": "Màu",
      "size": "Kích thước",
      "color-image": "Màu",
      "height": "Chiều Cao"
    },
    "en": {
      "color": "Color",
      "size": "Size",
      "color-image": "Color",
      "height": "Height"
    }
  },
  "excludedCategory": "311",
  "saleOffProduct": {
    "ShowCountDown": true,
    "HideEmptySaleOffLayout": false,
    "Color": "#C7222B"
  },
  "notStrictVisibleVariant": true,
  "configChat": {
    "showOnScreens": ["profile"],
    "hideOnScreens": [],
    "enableVendorChat": false,
    "EnableSmartChat": false,
    "UseRealtimeChat": false,
    "version": "2"
  },
  "smartChat": [
    {
      "app": "firebase",
      "imageData":
          "https://trello.com/1/cards/611a38c89ebde41ec7cf10e2/attachments/611a392cceb1b534aa92a83e/previews/611a392dceb1b534aa92a84d/download",
      "description": "Realtime Chat"
    },
    {
      "app": "chatGPT",
      "imageData": "https://i.imgur.com/pp1qlPd.png",
      "description": "Chat GPT"
    },
    {
      "app": "https://wa.me/849908854",
      "description": "WhatsApp",
      "iconData": "whatsapp"
    },
    {"app": "tel:8499999999", "description": "Call Us", "iconData": "phone"},
    {"app": "sms://8499999999", "description": "Send SMS", "iconData": "sms"},
    {
      "app": "https://tawk.to/chat/5d830419c22bdd393bb69888/default",
      "description": "Tawk Chat",
      "iconData": "whatsapp"
    },
    {
      "app": "http://m.me/inspireui",
      "description": "Facebook Chat",
      "iconData": "facebookMessenger"
    },
    {
      "app":
          "https://twitter.com/messages/compose?recipient_id=821597032011931648",
      "imageData":
          "https://trello.com/1/cards/611a38c89ebde41ec7cf10e2/attachments/611a38d026894f10dc1091c8/previews/611a38d126894f10dc1091d6/download",
      "description": "Twitter Chat"
    }
  ],
  "adminEmail": "admininspireui@gmail.com",
  "adminName": "InspireUI",
  "deliveryConfig": {
    "appLogo": "assets/images/app_icon_transparent.png",
    "appName": "FluxStore Delivery",
    "dashboardName2": "Delivery",
    "dashboardName1": "FluxStore",
    "enableSystemNotes": false
  },
  "managerConfig": {
    "appLogo": "assets/images/app_icon_transparent.png",
    "appName": "Kaif Admin",
    "enableDeliveryFeature": false
  },
  "loadingIcon": {"size": 30, "type": "fadingCube"},
  "splashScreen": {
    "duration": 5000,
    "image": "assets/images/splash.gif",
    "animationName": "fluxstore",
    "backgroundColor": "#fdfdfd",
    "paddingBottom": 0,
    "enable": true,
    "paddingRight": 0,
    "boxFit": "contain",
    "paddingTop": 0,
    "type": "static",
    "paddingLeft": 0
  },
  "reviewConfig": {
    "service": "native",
    "enableReview": false,
    "enableReviewImage": false,
    "judgeConfig": {
      "domain": "https://fawaah.myshopify.com",
      "apiKey": "ebab9b75c5a987ecba21bf239c5f0450",
    }
  },
  "darkConfig": {
    "saleColor": "#E15241",
    "MainColor": "ffefefef",
    "logo":
        "https://kaif.co/cdn/shop/files/finalfinal_74cad1e7-e82f-4eda-8208-0703f0b2420b.png",
    "secondaryColor": "ffffc400"
  },
  "lightConfig": {
    "backgroundColor": "ffefefef",
    "saleColor": "#E15241",
    "MainColor": "ff5e5e5e",
    "logo":
        "https://kaif.co/cdn/shop/files/finalfinal_74cad1e7-e82f-4eda-8208-0703f0b2420b.png",
    "secondaryColor": "ffffc400"
  },
  "addressFields": [
    {
      'country': 'KW',
      'addressFields': [
        {
          'type': 'firstName',
          'visible': true,
          'position': 1,
          'editable': true,
          'required': true,
          'defaultValue': '',
        },
        {
          'type': 'lastName',
          'visible': true,
          'position': 2,
          'editable': true,
          'required': true,
          'defaultValue': '',
        },
        {
          'type': 'phoneNumber',
          'visible': true,
          'position': 3,
          'editable': true,
          'required': true,
          'defaultValue': '',
        },
        {
          'type': 'email',
          'visible': true,
          'position': 4,
          'editable': true,
          'required': true,
          'defaultValue': '',
        },
        {
          'type': 'searchAddress',
          'visible': true,
          'position': 5,
        },
        {
          'type': 'selectAddress',
          'visible': true,
          'position': 6,
        },
        {
          'type': 'country',
          'visible': true,
          'position': 7,
          'editable': false,
          'required': true,
          'defaultValue': '',
        },
        {
          'type': 'city',
          'visible': false,
          'position': 8,
          'editable': false,
          'required': true,
          'defaultValue': 'KW',
        },
        {
          'type': 'state',
          'visible': true,
          'position': 9,
        },

        {
          'type': 'province',
          'visible': true,
          'position': 10,
          'editable': true,
          'required': false,
          'defaultValue': '',
        },
        {
          'type': 'sector',
          'visible': true,
          'position': 10,
          'editable': true,
          'required': false,
          'defaultValue': '',
        },

        {
          'type': 'street',
          'visible': true,
          'position': 11,
          'editable': true,
          'required': false,
          'defaultValue': '',
        },
        {
          'type': 'block',
          'visible': true,
          'position': 12,
          'editable': true,
          'required': false,
          'defaultValue': '',
        },



        {
          'type': 'block2',
          'visible': true,
          'position': 13,
          'editable': true,
          'required': false,
          'defaultValue': '',
        },
        {
          'type': 'apartment',
          'visible': true,
          'position': 14,
          'editable': true,
          'required': false,
        }
        ,
        {
          'type': 'zipCode',
          'visible': false,
          'position': 15,
          'editable': false,
          'required': true,
          'defaultValue': '00000',
        },
      ],
      'formatAddress': ({
        String? province,
        String? province2,
        String? sector,
        String? city,
        String? street,
        String? block,
        String? block2,
        String? apartment,
        String? fullAddress,
        String? zipCode,
      }) {


        return {
          if (province != null) 'province': province,
          if (city != null) 'city': city,
          'address1': 'Country: $city, Area: $province2,Block:${sector??''}, Street: $street, Building: $block, ${(street ?? '') == '' ? '' : 'Floor: $block2, '} ${(block2 ?? '') == '' ? '' : 'Flat: $apartment'}',
          'address2': '${block!}, ${block2 ?? ''}',
        };
      },
    },
  ],
};
