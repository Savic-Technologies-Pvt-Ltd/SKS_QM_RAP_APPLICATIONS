INTERFACE zif_wrap_bapi_goods_mvt
  PUBLIC .
 "Delivery Number

  TYPES de_number             TYPE mblnr .

  "HU

 " TYPES de_hu                 TYPE BAPIHUKEY-HU_EXID.

  "Return table

  TYPES de_returns      TYPE bapirettab.
METHODS post_document

IMPORTING iv_number type de_number

RETURNING VALUE(rt_results) TYPE de_returns.
ENDINTERFACE.
