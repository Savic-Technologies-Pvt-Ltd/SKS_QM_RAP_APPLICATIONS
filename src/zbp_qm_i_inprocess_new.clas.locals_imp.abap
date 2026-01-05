CLASS lhc_zqm_i_inprocess_new DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zqm_i_inprocess_new RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zqm_i_inprocess_new RESULT result.

    METHODS getpdf FOR MODIFY
      IMPORTING keys FOR ACTION zqm_i_inprocess_new~getpdf RESULT result.

    METHODS updateheaderdetails FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zqm_i_inprocess_new~updateheaderdetails.

    METHODS createinsplot FOR DETERMINE ON SAVE
      IMPORTING keys FOR zqm_i_inprocess_new~createinsplot.

ENDCLASS.

CLASS lhc_zqm_i_inprocess_new IMPLEMENTATION.

  METHOD get_instance_features.

   READ ENTITY IN LOCAL MODE ZQM_I_Inprocess_NEW

              ALL FIELDS WITH CORRESPONDING #( keys )
              RESULT DATA(lt_header).

    SELECT * FROM zqm_t_inpr_HD


    WHERE Cuuid = @( VALUE #( lt_header[ 1 ]-Cuuid ) )
    INTO TABLE @DATA(lt_item).
    IF sy-subrc = 0.
      DATA(ls_item) = VALUE #( lt_item[ 1 ] OPTIONAL ).
    ENDIF.


    result = VALUE #( FOR ls_header IN lt_header ( %tky = ls_header-%tky
        %features-%field-inspectionlot      =
                                                           if_abap_behv=>fc-f-read_only

        %features-%field-manufacturingorder = COND #( WHEN ls_header-manufacturingorder IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Material           = COND #( WHEN ls_header-Material IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Plant              = COND #( WHEN ls_header-Plant IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Batch              = COND #( WHEN ls_header-Batch IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )
         %features-%field-MaterialDescription              = if_abap_behv=>fc-f-read_only

                   %features-%field-materiallongtxt              = if_abap_behv=>fc-f-read_only



                                                      ) ).

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD getpdf.

  DATA: lit_create TYPE TABLE FOR CREATE ZQM_I_Inprocess_NEW
,
          lwa_create LIKE LINE OF lit_create.

    DATA : lit_data       TYPE TABLE OF ZQM_I_Inprocess_NEW
,
           lwa_data       TYPE ZQM_I_Inprocess_NEW
,
           lit_data_i     TYPE TABLE OF ZQM_I_Inprocess_item_NEW
,
  lit_data_c     TYPE TABLE OF ZQM_i_Inprocess_cHEM_NEW

,
           lv_base64      TYPE string,
           lit_header_upd TYPE TABLE FOR UPDATE ZQM_I_Inprocess_NEW
,
           lwa_header_upd LIKE LINE OF lit_header_upd,
           lv_token       TYPE string,
           lv_message     TYPE string,

           lit_itemdata   TYPE TABLE OF ZQM_I_Inprocess_item_NEW
,
           lwa_itemdata   TYPE ZQM_I_Inprocess_item_NEW
.


    READ ENTITIES OF ZQM_I_Inprocess_NEW

      IN LOCAL MODE


      ENTITY ZQM_I_Inprocess_NEW
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_header_data)


      ENTITY ZQM_I_Inprocess_NEW by \_Item
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_item_data_OPR)



      FAILED DATA(lit_failed).

data(lfs_lit_item_data_OPR) = value #(  lit_item_data_OPR[ 1 ]  ).
data(lfs_header) = value #(  lit_header_data[ 1 ]  ).

select Inspectionlotitem,BOOCharacteristicVersion from zqm_t_inpr_IT

where cuuid = @lfs_lit_item_data_OPR-Cuuid
into TABLE @data(lft_zqm_t_pdir_spcd)
.


** READ ENTITY IN LOCAL MODE ZQM_I_Inprocess_item_NEW
**
**    ALL FIELDS WITH value #(
**    for lfs_zqm_t_pdir_spcd in lft_zqm_t_pdir_spcd
**
**    (   %key-Cuuid = lfs_lit_item_data_OPR-Cuuid
**    %key-Inspectionlot = lfs_lit_item_data_OPR-Inspectionlot
**    %key-InspectionPlanGroup = lfs_lit_item_data_OPR-InspectionPlanGroup
**    %key-BOOOperationInternalID = lfs_lit_item_data_OPR-BOOOperationInternalID
** %key-Inspectionlotitem =  lfs_zqm_t_pdir_spcd-Inspectionlotitem " '0010'
** %key-BOOCharacteristicVersion = lfs_zqm_t_pdir_spcd-BOOCharacteristicVersion
**    )
**     )
**    RESULT DATA(lit_item_data).



select * from zqm_t_inpr_IT
where Cuuid = @lfs_header-Cuuid

 into TABLE @data(lit_item_data).


select * from zqm_t_inpr_CH

where Cuuid = @lfs_header-Cuuid

 into TABLE @data(lit_item_data_c).



 READ ENTITY IN LOCAL MODE ZQM_I_Inprocess_item_NEW


    ALL FIELDS WITH value #(
    for lfs_zqm_t_pdir_spcd in lit_item_data

    (   %key-Cuuid = lfs_lit_item_data_OPR-Cuuid
    %key-Inspectionlot = lfs_lit_item_data_OPR-Inspectionlot
    %key-InspectionPlanGroup = lfs_lit_item_data_OPR-InspectionPlanGroup
    %key-BOOOperationInternalID = lfs_lit_item_data_OPR-BOOOperationInternalID
 %key-InspectionLotItem =  lfs_zqm_t_pdir_spcd-inspectionlotitem " '0010'
 %key-BOOCharacteristicVersion = lfs_zqm_t_pdir_spcd-boocharacteristicversion " '00000032'
    )
     )
    RESULT DATA(lit_item_data_final).

    MOVE-CORRESPONDING lit_header_data TO lit_data.
    MOVE-CORRESPONDING lit_item_data_final TO lit_data_i.
        MOVE-CORRESPONDING lit_item_data_c TO lit_data_c.


    zcl_btp_adobe_form=>get_ouath_token(
      EXPORTING
        im_oauth_url    = 'ADS_OAUTH_URL'
        im_clientid     = 'ADS_CLIENTID'
        im_clientsecret = 'ADS_CLIENTSECRET'
      IMPORTING
        ex_token        = lv_token
        ex_message      = lv_message
    ).

    zbp_qm_i_inprocess_new=>get_pdf_xml(
      EXPORTING
*       im_data    = lit_data
        im_data_h  = lit_data
        im_data_i  = lit_data_i
        im_data_c  = lit_data_c

      IMPORTING
        ex_base_64 = lv_base64
    ).


    data lv_form_name type string.

    CASE lfs_header-formtype.
  WHEN 'Cust 1'.
    lv_form_name = 'ZINPROCESS_INSPECTION/QC_Cust1_Template'.
  WHEN 'Cust 2'.
    lv_form_name = 'ZINPROCESS_INSPECTION/QC_Cust2_Template'.
  WHEN 'Default'.
    lv_form_name = 'ZINPROCESS_INSPECTION/QC_Default_Template'.
  WHEN 'Earnest'.
    lv_form_name = 'ZINPROCESS_INSPECTION/Earnest_Template'.
  WHEN 'Fastenal'.
    lv_form_name = 'ZINPROCESS_INSPECTION/Fastenal_Template'.
  WHEN 'JD'.
    lv_form_name = 'ZINPROCESS_INSPECTION/JD_TEMPLATE'.
  WHEN 'Meritor'.
    lv_form_name = 'ZINPROCESS_INSPECTION/Meritor_Template'.
  WHEN 'Optimus'.
    lv_form_name = 'ZINPROCESS_INSPECTION/Optimus_Template'.
  WHEN 'WLOT'.
    lv_form_name = 'ZINPROCESS_INSPECTION/WLOT_Template'.
ENDCASE.




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


****    DATA(lwa_data1) = VALUE #( lit_item_data[ 1 ] OPTIONAL ).

    MODIFY ENTITIES OF ZQM_I_Inprocess_NEW
 IN LOCAL MODE
      ENTITY ZQM_I_Inprocess_NEW
      UPDATE FIELDS (  Attachments filename mimetype  )
      WITH VALUE #( FOR lwa_header IN lit_header_data ( %tky        = lwa_header-%tky
                                                        Attachments = lv_base64_decode
                                                        filename    = 'Form'
                                                        mimetype    = 'application/pdf'
                    ) )
    FAILED failed
    REPORTED reported.
*****
    READ ENTITIES OF  ZQM_I_Inprocess_NEW
 IN LOCAL MODE
****          ENTITY zqm_pdir_specification_list
****          ALL FIELDS WITH CORRESPONDING #( keys )
****          RESULT DATA(lit_updateditem)
          ENTITY ZQM_I_Inprocess_NEW
          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(lit_updatedheader).

    " set the action result parameter
    result = VALUE #( FOR lwa_updatedheader IN lit_updatedheader ( %tky   = lwa_updatedheader-%tky
                                                                   %param = lwa_updatedheader ) ).
  ENDMETHOD.

  METHOD updateheaderdetails.


    READ ENTITIES OF ZQM_I_Inprocess_NEW

 IN LOCAL MODE
     ENTITY ZQM_I_Inprocess_NEW
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).

data(ls_mat_data) = value #( lt_mat_data[ 1 ] OPTIONAL ).
        DATA(lv_ins_lot) = VALUE #( lt_mat_data[ 1 ]-manufacturingorder OPTIONAL ).


      SELECT SINGLE SalesOrder , BillOfOperationsMaterial,ProductionPlant FROM I_ProductionOrder
      WHERE ProductionOrder = @lv_ins_lot
      INTO  (  @DATA(LV_SALESORDER) , @data(lv_Material) , @data(lv_ProductionPlant) ) .

      SELECT SINGLE SoldToParty FROM I_SalesOrder
      WHERE SalesOrder = @LV_SALESORDER
      INTO @DATA(LV_SoldToParty) .


      SELECT SINGLE CustomerName FROM I_Customer
      WHERE Customer = @LV_SoldToParty
      INTO @DATA(LV_CustomerName) .



SELECT SINGLE YY1_PP_Product_Desc_ORD FROM I_ProductionOrder WHERE ProductionOrder = @ls_mat_data-Manufacturingorder

INTO @DATA(LV_PRO_LONG_TXT).

SELECT SINGLE Material FROM I_productionordercomponent WHERE ProductionOrder = @ls_mat_data-Manufacturingorder

INTO @DATA(LV_raw_mat).



SELECT a~ClfnObjectID,
a~CharcInternalID,
a~CharcValue,
b~Characteristic
  FROM i_clfnobjectcharcvalforkeydate( p_keydate = @sy-datum ) as a
  inner join I_ClfnCharacteristicForKeyDate( p_keydate = @sy-datum ) as b on b~CharcInternalID = a~CharcInternalID
  WHERE ClfnObjectID  = @ls_mat_data-Material
  INTO TABLE @data(lft_char_value).


data(lv_drgno) = value #( lft_char_value[ Characteristic = 'DRAWING_NO' ]-CharcValue OPTIONAL  ).
data(lv_Grade) = value #( lft_char_value[ Characteristic = 'ITEM_GRADE' ]-CharcValue OPTIONAL  ).
data(lv_RmSpecification) = value #( lft_char_value[ Characteristic = '0000000823' ]-CharcValue OPTIONAL  ).
data(lv_PartNo) = value #( lft_char_value[ Characteristic = 'ITEM_CODE' ]-CharcValue OPTIONAL  ).



       loop at lt_mat_data into data(lfs_data).
       MODIFY ENTITIES OF ZQM_I_Inprocess_NEW
        IN LOCAL MODE
    ENTITY ZQM_I_Inprocess_NEW
    UPDATE
    FIELDS (

    salesorder
    customer
    CustomerName
    materiallongtxt
    drgno
    partno
    Material
    Plant


    ) WITH VALUE #( (  %tky =  lfs_data-%tky
                                 %is_draft = LFS_DATA-%is_draft
                                 salesorder             = LV_SALESORDER
                                 customer               = LV_SoldToParty
                                 CustomerName = LV_CustomerName
                                 materiallongtxt = LV_PRO_LONG_TXT
                                 drgno = lv_drgno
                                 partno = lv_PartNo
                                 Material = lv_Material
                                 Plant = lv_ProductionPlant
     ) )
    REPORTED DATA(LFT_REPORTED).

ENDLOOP.
*    reported = CORRESPONDING #( DEEP  LFT_REPORTED ).
  ENDMETHOD.

  METHOD createinsplot.


    READ ENTITIES OF ZQM_I_Inprocess_NEW

 IN LOCAL MODE
     ENTITY ZQM_I_Inprocess_NEW

     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).

    IF lt_mat_data IS NOT INITIAL.

      DATA(ls_mat_data) = VALUE #( lt_mat_data[ 1 ] OPTIONAL ).



      MODIFY ENTITIES OF I_InspectionLotTP_2 PRIVILEGED "IN LOCAL MODE
      ENTITY InspectionLot
          CREATE FIELDS ( Material Plant InspectionLotType InspectionLotQuantity  )
              WITH VALUE #( (
                            %cid                  = 'CID_001'
                            Material              = ls_mat_data-Material
                            Plant                 = ls_mat_data-Plant
                            InspectionLotType     = '89'
                            InspectionLotQuantity = 1
*                            ManufacturingOrder    = ls_mat_data-Manufacturingorder
                            ) )
          MAPPED DATA(mapped1)
          REPORTED DATA(reported1)
          FAILED DATA(failed).

      DATA(lv_ins_lot) = VALUE #( mapped1-inspectionlot[ 1 ]-InspectionLot OPTIONAL ).
      DATA(lv_mat) = ls_mat_data-material .

zbp_qm_i_inprocess_new=>gv_ins_lot = VALUE #( mapped1-inspectionlot[ 1 ]-InspectionLot OPTIONAL ).
*      SELECT * FROM I_InspectionLot
*      WHERE InspectionLot = @lv_ins_lot
*      INTO TABLE @DATA(lt_inspection).

      READ ENTITIES OF I_InspectionLotTP_2 PRIVILEGED
      ENTITY InspectionOperation
      ALL FIELDS WITH VALUE #( ( InspectionLot = lv_ins_lot ) )
      RESULT DATA(lt_insp_result).


     READ ENTITIES OF I_ProductTP_2 PRIVILEGED
      ENTITY ProductBasicText
      ALL FIELDS WITH VALUE #( ( %key-Product        = lv_mat
                                 %key-TextObjectType = 'GRUN'
                                 %key-Language       = 'E' ) )

      RESULT DATA(lit_prodtext)
      REPORTED DATA(lit_reported).
    DATA(lwa_prodtext) = VALUE #( lit_prodtext[ 1 ] OPTIONAL ).


*      SELECT SINGLE SalesOrder FROM I_ProductionOrder
*      WHERE ProductionOrder = @ls_mat_data-manufacturingorder
*      INTO @DATA(LV_SALESORDER) .
*
*      SELECT SINGLE SoldToParty FROM I_SalesOrder
*      WHERE SalesOrder = @LV_SALESORDER
*      INTO @DATA(LV_SoldToParty) .

      MODIFY ENTITIES OF ZQM_I_Inprocess_NEW

 IN LOCAL MODE
      ENTITY ZQM_I_Inprocess_NEW

      UPDATE FIELDS ( InspectionLot
                      Material
                      Plant
                      ManufacturingOrder
                      salesorder
                      customer
                      materiallongtxt
                       )
      WITH VALUE #( "FOR key IN keys
                    ( %cid_ref               = ''
                      %is_draft              = ls_mat_data-%is_draft
                      Cuuid                  = VALUE #( keys[ 1 ]-cuuid OPTIONAL )
                      InspectionLot          = lv_ins_lot          ""mapped1-inspectionlot
                      Material               = ls_mat_data-Material
                      Plant                  = ls_mat_data-Plant
                      ManufacturingOrder     = ls_mat_data-ManufacturingOrder
                      materiallongtxt       = lwa_prodtext-ProductLongText
*                      salesorder             = LV_SALESORDER
*                      customer               = LV_SoldToParty
                      %control-InspectionLot = if_abap_behv=>mk-on
                      %control-Material      = if_abap_behv=>mk-on
                      %control-Plant         = if_abap_behv=>mk-on
*                      %control-ManufacturingOrder = if_abap_behv=>mk-on
                    ) )

               FAILED DATA(lt_fail)
               REPORTED DATA(lt_reported)
               MAPPED DATA(lt_mapped).

    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zqm_i_inprocess_new DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zqm_i_inprocess_new IMPLEMENTATION.

  METHOD save_modified.
    DATA : lt_item_ins TYPE STANDARD TABLE OF zqm_t_inpr_IT
, ls_item_upd TYPE  zqm_t_inpr_IT,

           lt_item_upd TYPE STANDARD TABLE OF zqm_t_inpr_IT,
     lt_item_chm TYPE STANDARD TABLE OF zqm_t_inpr_CH,
          ls_item_chm TYPE  zqm_t_inpr_CH,

           lt_item_del TYPE STANDARD TABLE OF zqm_t_inpr_IT

.


if update-zqm_i_inprocess_chem_new is not INITIAL.
 loop at update-zqm_i_inprocess_chem_new into data(lfs_item_db_chem).
        select single * from zqm_t_inpr_CH


         where cuuid = @lfs_item_db_chem-cuuid
      AND itemno = @lfs_item_db_chem-Itemno
      into CORRESPONDING FIELDS OF @ls_item_chm.

      if sy-subrc <> 0.
        MOVE-CORRESPONDING lfs_item_db_chem to ls_item_chm.
      endif.



       IF lfs_item_db_chem-%control-Actual = '01'.
          ls_item_chm-Actual = lfs_item_db_chem-Actual.
        ENDIF.


 MODIFY zqm_t_inpr_CH

 FROM  @ls_item_chm.
        clear :ls_item_chm.

      ENDLOOP..
endif.

if create-zqm_i_inprocess_new is not INITIAL.



*Select  material from i_batch where  Batch = @( create-zqm_i_inprocess_new[ 1 ]-Batch )
*into table @data(lft_materials).
*if sy-subrc = 0.
*select a~material,
*b~ProductType from @lft_materials as a inner join I_product as b on b~product = a~material and b~ProductType in ( 'SR', 'RM' )
*into TABLE @data(lft_final_product).
*
*select a~material,
*a~producttype,
*b~InspectionPlanGroup,
*b~InspectionPlan,
*b~InspPlanMatlAssignment,
*b~InspPlanMatlAssgmtIntVersion from @lft_final_product as a inner join I_INSPPLNMATLASSGMTVERSION_2 as b  on b~Material = a~Material
*and b~Plant = 'MHU2'
*into table @data(lft_tasklist_group).
*
*
*select a~material,
*b~InspectionPlan,
*b~InspectionPlanGroup,
*b~InspectionSpecification,
*b~InspSpecUpperLimit,
*b~InspSpecLowerLimit
*
*from @lft_tasklist_group as a inner join I_InspPlanOpCharcVersion_2 as b on b~InspectionPlan = a~InspectionPlan
*and b~InspectionPlanGroup = a~InspectionPlanGroup
*into table @data(lft_final).


*endif.




 lt_item_chm = value #( ( cuuid = create-zqm_i_inprocess_new[ 1 ]-Cuuid  itemno = '10' element = 'C%'

* min_value = value #( lft_final[ InspectionSpecification = 'C%' ]-InspSpecLowerLimit OPTIONAL )
* max_value = value #( lft_final[ InspectionSpecification = 'C%' ]-InspSpecUpperLimit OPTIONAL )
 )
 ( cuuid = create-zqm_i_inprocess_new[ 1 ]-Cuuid  itemno = '20'  element = 'S%'

* min_value = value #( lft_final[ InspectionSpecification = 'S%' ]-InspSpecLowerLimit OPTIONAL )
* max_value = value #( lft_final[ InspectionSpecification = 'S%' ]-InspSpecUpperLimit OPTIONAL )
 )
 ( cuuid = create-zqm_i_inprocess_new[ 1 ]-Cuuid itemno = '30'  element = 'B%'

* min_value = value #( lft_final[ InspectionSpecification = 'B%' ]-InspSpecLowerLimit OPTIONAL )
* max_value = value #( lft_final[ InspectionSpecification = 'B%' ]-InspSpecUpperLimit OPTIONAL )
 )
 ( cuuid = create-zqm_i_inprocess_new[ 1 ]-Cuuid itemno = '40'  element = 'P%'

* min_value = value #( lft_final[ InspectionSpecification = 'P%' ]-InspSpecLowerLimit OPTIONAL )
* max_value = value #( lft_final[ InspectionSpecification = 'P%' ]-InspSpecUpperLimit OPTIONAL ) )
)
  ).

      INSERT zqm_t_inpr_CH


 FROM TABLE @lt_item_chm.

endif.
 IF create-zqm_i_inprocess_item_new IS NOT INITIAL.


data(lv_cuidd) = value #( create-zqm_i_inprocess_item_new[ 1 ]-Cuuid OPTIONAL ).

select single inspectionlot from zqm_t_inpr_HD  where cuuid = @lv_cuidd into @data(lv_insplot).

if lv_insplot is initial.
    lv_insplot = zbp_qm_i_inprocess_new=>gv_ins_lot.
endif.
      lt_item_ins = CORRESPONDING #( create-zqm_i_inprocess_item_new
              MAPPING
cuuid = cuuid
boooperationinternalid = boooperationinternalid
inspectionlotitem = inspectionlotitem
inspectionlot = inspectionlot

boocharacteristicversion = boocharacteristicversion
inspectionplangroup = inspectionplangroup
specification = Specification

*InspSpecTargetValue = InspSpecTargetValue
*InspSpecLowerLimit = InspSpecLowerLimit
*InspSpecUpperLimit = InspSpecTargetValue
*observed

samples = samples
            ).

      LOOP AT lt_item_ins ASSIGNING FIELD-SYMBOL(<ls_item>).
        IF lv_insplot is not INITIAL.
          <ls_item>-inspectionlot = lv_insplot.
        ENDIF.
      ENDLOOP.

      INSERT zqm_t_inpr_IT

 FROM TABLE @lt_item_ins.






    ENDIF.



   IF update-zqm_i_inprocess_item_new IS NOT INITIAL.

      loop at update-zqm_i_inprocess_item_new into data(lfs_item_db).
        select single * from zqm_t_inpr_IT

         where cuuid = @lfs_item_db-cuuid
      AND boooperationinternalid = @lfs_item_db-boooperationinternalid
      AND inspectionlotitem = @lfs_item_db-inspectionlotitem
      into CORRESPONDING FIELDS OF @ls_item_upd.

      if sy-subrc <> 0.
        MOVE-CORRESPONDING lfs_item_db to ls_item_upd.
      endif.



       IF lfs_item_db-%control-samples = '01'.
          ls_item_upd-samples = lfs_item_db-samples.
        ENDIF.


 MODIFY zqm_t_inpr_IT
 FROM  @ls_item_upd.
        clear :lfs_item_db.

      ENDLOOP..

    ENDIF.


  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
