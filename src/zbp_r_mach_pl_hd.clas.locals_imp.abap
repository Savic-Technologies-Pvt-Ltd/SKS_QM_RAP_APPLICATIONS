CLASS lhc_zr_mach_pl_it DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS updateItem FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZR_MACH_PL_IT~updateItem.

ENDCLASS.

CLASS lhc_zr_mach_pl_it IMPLEMENTATION.

  METHOD updateItem.


  ENDMETHOD.

ENDCLASS.

CLASS lsc_zr_mach_pl_hd DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zr_mach_pl_hd IMPLEMENTATION.

  METHOD save_modified.
   if create-zr_mach_pl_hd is NOT INITIAL.
    data lfs_item type ZQM_MACH_PL_IT
.
    data lft_item type table of ZQM_MACH_PL_IT
.
    DATA(lv_itemno) = 10.
     loop at create-zr_mach_pl_hd ASSIGNING FIELD-SYMBOL(<lfs_head>).





     ENDLOOP.

    modify ZQM_MACH_PL_IT from table  @lft_item.
   endif.


  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZR_MACH_PL_HD DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_mach_pl_hd RESULT result.

    METHODS getpdf FOR MODIFY
      IMPORTING keys FOR ACTION zr_mach_pl_hd~getpdf RESULT result.

    METHODS createMachinePlan FOR DETERMINE ON SAVE
      IMPORTING keys FOR zr_mach_pl_hd~createMachinePlan.
    METHODS getItem FOR MODIFY
      IMPORTING keys FOR ACTION ZR_MACH_PL_HD~getItem.
    METHODS updateItem FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZR_MACH_PL_HD~updateItem.

ENDCLASS.

CLASS lhc_ZR_MACH_PL_HD IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD getpdf.



    data : lv_base64      TYPE string,
       lv_token       TYPE string,
           lv_message     TYPE string.
data lfs_header type ZR_MACH_PL_HD.
data lft_header type              table of ZR_MACH_PL_HD.


data lfs_item type ZR_MACH_PL_IT
.
data lft_item type table of ZR_MACH_PL_IT
.
    READ ENTITIES OF ZR_MACH_PL_HD


      IN LOCAL MODE


      ENTITY zr_mach_pl_hd
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_header_data)





      FAILED DATA(lit_failed).

data(lfs_header_run) = value #(  lit_header_data[ 1 ]  ).

select * from ZQM_MACH_PL_IT


where cuuid = @lfs_header_run-Cuuid
into TABLE @data(lft_item_db)
.



    MOVE-CORRESPONDING lit_header_data TO lft_header.
    MOVE-CORRESPONDING lft_item_db TO lft_item.

    zcl_btp_adobe_form=>get_ouath_token(
      EXPORTING
        im_oauth_url    = 'ADS_OAUTH_URL'
        im_clientid     = 'ADS_CLIENTID'
        im_clientsecret = 'ADS_CLIENTSECRET'
      IMPORTING
        ex_token        = lv_token
        ex_message      = lv_message
    ).

    zbp_r_mach_pl_hd=>get_pdf_xml(
      EXPORTING
*       im_data    = lit_data
        im_data_h  = lft_header
        im_data_i  = lft_item
      IMPORTING
        ex_base_64 = lv_base64
    ).


    data lv_form_name type string.

lv_form_name = 'ZMACHINE_PLAN/Machine_Plan_Template'.
****    CASE lfs_header-formtype.
****  WHEN 'Standard'.
****    lv_form_name = 'ZPDIR/Standard_Template'.
****    WHEN 'Boll Hoff'.
****    lv_form_name = 'ZPDIR/BollHoff_Template'.
****    WHEN 'Eastern'.
****    lv_form_name = 'ZPDIR/Eastern_Template'.
****    WHEN 'Fastnal Before'.
****    lv_form_name = 'ZPDIR/Fastnal_Template'.
****    WHEN 'JCB'.
****    lv_form_name = 'ZPDIR/JCB_Template'.
****    WHEN 'Spicer'.
****    lv_form_name = 'ZPDIR/Spicer_Template'.
****ENDCASE.




    zcl_btp_adobe_form=>get_pdf_api(
      EXPORTING
        im_url           = 'ADS_URL'
        im_url_path      = '/v1/adsRender/pdf?TraceLevel=2&templateSource=storageName'
        im_clientid      = 'ADS_CLIENTID'
        im_clientsecret  = 'ADS_CLIENTSECRET'
        im_token         = lv_token
        im_base64_encode = lv_base64
        im_xdp_template  = lv_form_name
      IMPORTING
        ex_base64_decode = DATA(lv_base64_decode)
        ex_message       = lv_message
    ).




    MODIFY ENTITIES OF ZR_MACH_PL_HD

 IN LOCAL MODE
      ENTITY zr_mach_pl_hd
      UPDATE FIELDS (  attachments filename mimetype  )
      WITH VALUE #( FOR lwa_header IN lit_header_data ( %tky        = lwa_header-%tky
                                                        Attachments = lv_base64_decode
                                                        filename    = 'Form'
                                                        mimetype    = 'application/pdf'
                    ) )
    FAILED failed
    REPORTED reported.

    READ ENTITIES OF  ZR_MACH_PL_HD

 IN LOCAL MODE

          ENTITY zr_mach_pl_hd

          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(lit_updatedheader).

    " set the action result parameter
    result = VALUE #( FOR lwa_updatedheader IN lit_updatedheader ( %tky   = lwa_updatedheader-%tky
                                                                   %param = lwa_updatedheader ) ).
  ENDMETHOD.

  METHOD createMachinePlan.


   READ ENTITIES OF ZR_MACH_PL_HD
 IN LOCAL MODE
     ENTITY zr_mach_pl_hd
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).

    IF lt_mat_data IS NOT INITIAL.

      DATA(ls_mat_data) = VALUE #( lt_mat_data[ 1 ] OPTIONAL ).



       DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.

        DATA: lv_object    TYPE CHAR10.
DATA LV_SETUP(20) TYPE C.



SELECT count( cuuid  ) FROM ZQM_MACH_PL_HD

 INTO @DATA(LV_SETUP_OLD).
LV_SETUP = LV_SETUP_OLD + 1.
SHIFT LV_SETUP LEFT DELETING LEADING SPACE.
        MODIFY ENTITIES OF ZR_MACH_PL_HD

 IN LOCAL MODE
      ENTITY zr_mach_pl_hd
      UPDATE FIELDS ( machineplanno

                       )
      WITH VALUE #( "FOR key IN keys
                    (
  %is_draft              = ls_mat_data-%is_draft
                      Cuuid                  = VALUE #( keys[ 1 ]-Cuuid OPTIONAL )
                      machineplanno          = LV_SETUP          ""mapped1-inspectionlot

 %control-machineplanno = if_abap_behv=>mk-on



                    ) )

               FAILED DATA(lt_fail)
               REPORTED DATA(lt_reported)
               MAPPED DATA(lt_mapped).

               endif.
  ENDMETHOD.

  METHOD getItem.


   MODIFY ENTITY IN LOCAL MODE ZR_MACH_PL_HD

    CREATE BY \_Item
    AUTO FILL CID
    FIELDS ( Itemno )
    WITH VALUE #(
      FOR key IN keys
        ( %is_draft = if_abap_behv=>mk-on
          %key      = key-%key          " only parent key!

          %cid_ref = key-%cid_ref
          %target =

          value #(  (  %is_draft = if_abap_behv=>mk-on
%cid = '00010' && 'C11'

            Itemno = '00010'


           )
            (  %is_draft = if_abap_behv=>mk-on
%cid = '00020' && 'C11'

            Itemno = '00020'

           )

           )
        )


)



    REPORTED reported FAILED failed MAPPED mapped.




*****   MODIFY ENTITY IN LOCAL MODE ZR_MACH_PL_HD
*****    CREATE BY \_Item
*****    AUTO FILL CID
*****    FIELDS ( Itemno )
*****    WITH VALUE #(
*****      FOR key IN keys
*****        ( %is_draft = if_abap_behv=>mk-on
*****          %key      = key-%key          " only parent key!
*****
*****          %target =
*****
*****          value #(  (  %is_draft = if_abap_behv=>mk-on
*****%cid = '00010' && 'C11'
*****
*****            Itemno = '00010'
*****
*****           )
*****            (  %is_draft = if_abap_behv=>mk-on
*****%cid = '00020' && 'C11'
*****
*****            Itemno = '00020'
*****
*****           )
*****
*****           )
*****
*****
*****
*****        )
*****    )
*****
*****
*****
*****
*****
*****
*****
*****
*****    REPORTED reported FAILED failed MAPPED mapped.


  ENDMETHOD.

  METHOD updateItem.
.
data lft_item type table of ZR_MACH_PL_IT.
  READ ENTITIES OF ZR_MACH_PL_HD
 IN LOCAL MODE
     ENTITY zr_mach_pl_hd
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).
data(lfs_mat_data) = value #(  lt_mat_data[ 1 ] OPTIONAL ).
     select ProductionOrder ,WorkCenterInternalID from

     I_ProductionOrderOperation_2  where WorkCenterInternalID = @lfs_mat_data-workcenterid
     into TABLE @data(lft_ProductionOrder).
     if sy-subrc = 0.
     sort lft_ProductionOrder by ProductionOrder ASCENDING WorkCenterInternalID ASCENDING.
     delete ADJACENT DUPLICATES FROM lft_ProductionOrder COMPARING ProductionOrder WorkCenterInternalID.

     data lv_int type int4 .

     loop at lft_ProductionOrder into data(lfs_ProductionOrder).

     select single YY1_PP_Dist_Channel_ORD,
YY1_PP_Cat_Code_ORD,
YY1_PP_Product_Desc_ORD,
YY1_PP_Customer_Name_ORD,
YY1_PP_Hardness_Spec_ORD,
Material

from I_manufacturingorder where ManufacturingOrder = @lfs_ProductionOrder-ProductionOrder into @data(lfs_I_manufacturingorder) .

select single WorkCenterText from I_WorkCenterText where WorkCenterInternalID = @lfs_ProductionOrder-WorkCenterInternalID
into @data(lv_workcenter_text).

SELECT single
a~CharcValue
  FROM i_clfnobjectcharcvalforkeydate( p_keydate = @sy-datum ) as a
  inner join I_ClfnCharacteristicForKeyDate( p_keydate = @sy-datum ) as b on b~CharcInternalID = a~CharcInternalID
  WHERE ClfnObjectID  = @lfs_I_manufacturingorder-Material and b~Characteristic = 'DRAWING_NO'
  INTO  @data(lv_drgno).

SELECT single
a~CharcValue
  FROM i_clfnobjectcharcvalforkeydate( p_keydate = @sy-datum ) as a
  inner join I_ClfnCharacteristicForKeyDate( p_keydate = @sy-datum ) as b on b~CharcInternalID = a~CharcInternalID
  WHERE ClfnObjectID  = @lfs_I_manufacturingorder-Material and b~Characteristic = 'RAW_MATERIAL_GRADE'
  INTO  @data(lv_RAW_MATERIAL_GRADE).

SELECT single
a~CharcValue
  FROM i_clfnobjectcharcvalforkeydate( p_keydate = @sy-datum ) as a
  inner join I_ClfnCharacteristicForKeyDate( p_keydate = @sy-datum ) as b on b~CharcInternalID = a~CharcInternalID
  WHERE ClfnObjectID  = @lfs_I_manufacturingorder-Material and b~Characteristic = 'TOOL_LAYOUT_NO'
  INTO  @data(lv_TOOL_LAYOUT_NO).

     add 1 to lv_int.
        append value #( itemno = lv_int
        workorder = lfs_ProductionOrder-ProductionOrder
        workcenter = lfs_ProductionOrder-WorkCenterInternalID

        workcentername = lv_workcenter_text

        DistributionChannel = lfs_I_manufacturingorder-YY1_PP_Dist_Channel_ORD

CatalogCode = lfs_I_manufacturingorder-YY1_PP_Cat_Code_ORD

Description = lfs_I_manufacturingorder-YY1_PP_Product_Desc_ORD

        Customer_Name = lfs_I_manufacturingorder-YY1_PP_Customer_Name_ORD

Hardness = lfs_I_manufacturingorder-YY1_PP_Hardness_Spec_ORD

 toollayout        = lv_TOOL_LAYOUT_NO
  sksdrgno          = lv_drgno
  rmgrade            = lv_RAW_MATERIAL_GRADE

         ) to lft_item.

        clear:lfs_ProductionOrder.
     endloop.


     endif.

   MODIFY ENTITY IN LOCAL MODE ZR_MACH_PL_HD

    CREATE BY \_Item
    AUTO FILL CID
    FIELDS ( Itemno workorder workcenter catalogcode customer_name description
    distributionchannel hardness rmgrade sksdrgno toollayout workcentername
     )
    WITH VALUE #(
      FOR key IN keys
        ( %is_draft = if_abap_behv=>mk-on
          %key      = key-%key          " only parent key!

****          %cid_ref = key-%cid_ref
          %target =

          value #(  for lfs_item in lft_item (  %is_draft = if_abap_behv=>mk-on
%cid = lfs_item-Itemno && 'C11'

            Itemno = lfs_item-Itemno
workorder = lfs_item-workorder
workcenter = lfs_item-workcenter
catalogcode = lfs_item-catalogcode
customer_name = lfs_item-customer_name
description = lfs_item-description
distributionchannel = lfs_item-distributionchannel
hardness = lfs_item-hardness
rmgrade = lfs_item-rmgrade
sksdrgno = lfs_item-sksdrgno
toollayout = lfs_item-toollayout
workcentername = lfs_item-workcentername

           )


           )
        )


)


.



  ENDMETHOD.

ENDCLASS.
