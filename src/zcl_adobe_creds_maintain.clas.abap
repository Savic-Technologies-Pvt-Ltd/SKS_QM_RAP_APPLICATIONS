CLASS zcl_adobe_creds_maintain DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun.   "To make it runnable from ADT

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ADOBE_CREDS_MAINTAIN IMPLEMENTATION.


 METHOD if_oo_adt_classrun~main.

    DATA LFT_zta_qm_adobeform TYPE TABLE OF zta_qm_adobeform.

    APPEND VALUE #(  parameters = 'ADS_URL' value = 'https://adsrestapi-formsprocessing.cfapps.us10.hana.ondemand.com'  ) TO LFT_zta_qm_adobeform.
    APPEND VALUE #(  parameters = 'ADS_OAUTH_URL' value = 'https://qa-sksfasteners.authentication.us10.hana.ondemand.com/oauth/token?grant_type=client_credentials'  ) TO LFT_zta_qm_adobeform.
    APPEND VALUE #(  parameters = 'ADS_CLIENTSECRET' value = 'a31668bb-936b-4199-85f1-67c79734316d$3_Ga-HwWUqbYoolAlC7Btp0IVwPqVP8J2iNWNHZ8WEg='  ) TO LFT_zta_qm_adobeform.
    APPEND VALUE #(  parameters = 'ADS_CLIENTID' value = 'sb-013df124-b6d1-4d7f-bf6b-6aaf165c5794!b540694|ads-xsappname!b65488'  ) TO LFT_zta_qm_adobeform.
    MODIFY zta_qm_adobeform FROM TABLE @LFT_zta_qm_adobeform.
    COMMIT WORK.   " Persist deletion
  ENDMETHOD.
ENDCLASS.
