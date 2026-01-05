CLASS lsc_zr_setup_app_head DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zr_setup_app_head IMPLEMENTATION.

  METHOD save_modified.

  if create-zr_setup_app_head is NOT INITIAL.

    data lfs_item type zpp_t_setup_app2.
    data lft_item type table of zpp_t_setup_app2.
     loop at create-zr_setup_app_head ASSIGNING FIELD-SYMBOL(<lfs_head>).
   DATA(lv_itemno) = 1.


" Loop over the static data entries
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Machine Speed'
                specifications = 'As per Process Parameter Chart (Doc. No. CP/F/ANN/01).'
                mmr = 'Speed Counter' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Length adjusting sleeve distance.'
                specifications = 'Adjust length adjusting sleeve distance till to get product length of the job as specified on process drawing.'
                mmr = 'Vernier' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Length adjusting sleeve distance. (For Last Station in Trimming Method)'
                specifications = 'Adjust Gap Between Product (Piece ) and K.O. Pin From 0.5mm to 1.00mm.'
                mmr = 'Check By Hand (Rotate Sleeve Through Hand)' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Wire stopper distance. (In case of Round Head type jobs.)'
                specifications = 'Adjust wire stopper distance till to get head diameter and total length of product as specified on process drawing.'
                mmr = 'Micrometer / Vernier' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Wire stopper distance. (In case of Hex Type jobs)'
                specifications = 'Adjust wire stopper distance till to get A/F and total length of product as specified on process drawing.'
                mmr = 'Micrometer / Vernier' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Wire stopper distance. (In case of Flange / Collar type jobs)'
                specifications = 'Adjust wire stopper distance till to get Flange / collar Dia and total length of product as specified on process drawing.'
                mmr = 'Micrometer / Vernier' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Taper Wedge Distance.'
                specifications = 'Adjust taper wedge distance till to head height of job as specified on process drawing'
                mmr = 'Micrometer' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Cleaning of Chute'
                specifications = 'Clean'
                mmr = 'Visual' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Cleaning of Material Conveyor'
                specifications = 'Clean'
                mmr = 'Visual' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Cleaning of Material Conveyor Oil Tray'
                specifications = 'Clean'
                mmr = 'Visual' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Length adjusting sleeve Locking'
                specifications = 'Locked'
                mmr = 'Allen Key / Spanner' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Gap Between Punch & Die'
                specifications = 'No Hitting between Punch and Die'
                mmr = 'Paper Gap' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'K.O PAD Locking Screw / nut / Spring Washer Condition'
                specifications = 'OK and Locked'
                mmr = 'Visual/ Tight with Spanner' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Tranfer Finger Arm Holding Slot Condition'
                specifications = 'The transfer finger arm holding slots must not be loose'
                mmr = 'Transfer Finger Arm Holding Slot check By Hand' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Condition of loosen parts of machine during the part setting'
                specifications = 'Loose parts of the machine must be tightened before starting the machine'
                mmr = 'Allen Key / Spanner' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Case Depth'
                specifications = 'More Then P.K.O Stroke Length (As Per Doc.No.- PRD-F/L/05)'
                mmr = 'Vernier' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Punch block alignment adjusting screw locking condition.'
                specifications = 'Locked'
                mmr = 'Visual/ Tight with Spanner' ) TO lft_item.

lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Wire Feeding Length'
                specifications = 'Wire Feeding Checking List (As per Doc. No.PRD-F/L/11)'
                mmr = 'Vernier' ) TO lft_item.


                lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Setting pieces should be kept in Red Bin'
                ) TO lft_item.

                 lv_itemno += 1.
APPEND VALUE #( cuuid    = <lfs_head>-cuuid
                itemno   = lv_itemno
                parameters = 'Old stage pieces should be used for setting up the part'
                ) TO lft_item.
ENDLOOP.

    modify zpp_t_setup_app2 from table  @lft_item.

  endif.


  if update-zr_setup_app_item is NOT INITIAL.

         loop at update-zr_setup_app_item  ASSIGNING FIELD-SYMBOL(<lfs_item>).

            if <lfs_item>-Itemno = '20'.
                data(lv_prod_sub) = abap_true.
                update zpp_t_setup_appr
                  set submittedtoprd_time = @sy-uzeit
                  where cuuid = @<lfs_item>-Cuuid.

            endif.
    ENDLOOP..
  endif.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZR_SETUP_APP_HEAD DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_setup_app_head RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zr_setup_app_head RESULT result.
    METHODS getitem FOR MODIFY
      IMPORTING keys FOR ACTION zr_setup_app_head~getitem.
    METHODS getpdf FOR MODIFY
      IMPORTING keys FOR ACTION zr_setup_app_head~getpdf RESULT result.
    METHODS createsetupno FOR DETERMINE ON SAVE
      IMPORTING keys FOR zr_setup_app_head~createsetupno.
    METHODS updateheaderdetails FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zr_setup_app_head~updateheaderdetails.

ENDCLASS.

CLASS lhc_ZR_SETUP_APP_HEAD IMPLEMENTATION.

  METHOD get_instance_authorizations.


  ENDMETHOD.

  METHOD get_instance_features.

      READ ENTITY IN LOCAL MODE ZR_SETUP_APP_HEAD

              ALL FIELDS WITH CORRESPONDING #( keys )
              RESULT DATA(lt_header).

               result = VALUE #( FOR ls_header IN lt_header ( %tky = ls_header-%tky

        %features-%field-Batch      = COND #( WHEN ls_header-Batch IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )
      %features-%field-Manufacturingorder      = COND #( WHEN ls_header-Manufacturingorder IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )
%features-%field-Material      = COND #( WHEN ls_header-Material IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )

%features-%field-Plant      = COND #( WHEN ls_header-Plant IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )

                                                      ) ).
  ENDMETHOD.

  METHOD getItem.


         MODIFY ENTITY IN LOCAL MODE ZR_SETUP_APP_HEAD
    CREATE BY \_Item
    AUTO FILL CID
    FIELDS ( Cuuid Itemno Parameters Specifications )
    WITH VALUE #(
      FOR key IN keys
        ( %is_draft = if_abap_behv=>mk-on
          %key      = key-%key          " only parent key!
          %cid_ref = key-%cid_ref
          %target =

          value #(  (  %is_draft = if_abap_behv=>mk-on
            %cid = 'CID_10'
            %key-Cuuid =  key-%key-Cuuid
            Itemno = '10'
            Parameters = 'Parameters'
            Specifications = 'Specifications'
           )



*             (  %is_draft = if_abap_behv=>mk-on
*            %cid = 'CID_20'
*            %key-Cuuid =  key-%key-Cuuid
*            Itemno = '20'
*            Parameters = 'Parameters'
*            Specifications = 'Specifications'
*           )

           )
        )
    )


    REPORTED reported FAILED failed MAPPED mapped.

  ENDMETHOD.

  METHOD getpdf.


    data : lv_base64      TYPE string,
       lv_token       TYPE string,
           lv_message     TYPE string.
data lfs_header type ZR_SETUP_APP_HEAD.
data lft_header type table of ZR_SETUP_APP_HEAD.


data lfs_item type ZR_SETUP_APP_ITEM
.
data lft_item type table of ZR_SETUP_APP_ITEM
.
    READ ENTITIES OF ZR_SETUP_APP_HEAD

      IN LOCAL MODE


      ENTITY zr_setup_app_head
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_header_data)





      FAILED DATA(lit_failed).

data(lfs_header_run) = value #(  lit_header_data[ 1 ]  ).

select * from zpp_t_setup_app2

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

    zbp_r_setup_app_head=>get_pdf_xml(
      EXPORTING
*       im_data    = lit_data
        im_data_h  = lft_header
        im_data_i  = lft_item
      IMPORTING
        ex_base_64 = lv_base64
    ).


    data lv_form_name type string.

lv_form_name = 'ZSETUP_APPROVAL/Setup_App_Template'.
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




    MODIFY ENTITIES OF ZR_SETUP_APP_HEAD
 IN LOCAL MODE
      ENTITY zr_setup_app_head
      UPDATE FIELDS (  Attachments filename mimetype  )
      WITH VALUE #( FOR lwa_header IN lit_header_data ( %tky        = lwa_header-%tky
                                                        Attachments = lv_base64_decode
                                                        filename    = 'Form'
                                                        mimetype    = 'application/pdf'
                    ) )
    FAILED failed
    REPORTED reported.

    READ ENTITIES OF  ZR_SETUP_APP_HEAD
 IN LOCAL MODE

          ENTITY ZR_SETUP_APP_HEAD

          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(lit_updatedheader).

    " set the action result parameter
    result = VALUE #( FOR lwa_updatedheader IN lit_updatedheader ( %tky   = lwa_updatedheader-%tky
                                                                   %param = lwa_updatedheader ) ).


  ENDMETHOD.

  METHOD createSetupNo.
  READ ENTITIES OF ZR_SETUP_APP_HEAD IN LOCAL MODE
     ENTITY zr_setup_app_head
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).

    IF lt_mat_data IS NOT INITIAL.

      DATA(ls_mat_data) = VALUE #( lt_mat_data[ 1 ] OPTIONAL ).



       DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.

        DATA: lv_object    TYPE CHAR10.
DATA LV_SETUP(20) TYPE C.



SELECT count( cuuid  ) FROM zpp_t_setup_appr
 INTO @DATA(LV_SETUP_OLD).

LV_SETUP = LV_SETUP_OLD + 1.
SHIFT LV_SETUP LEFT DELETING LEADING SPACE.

*SELECT *
*  FROM i_clfnobjectcharcvalforkeydate( p_keydate = @sy-datum )
*  WHERE ClfnObjectID  = @ls_mat_data-Material
*  INTO TABLE @data(lft_char_value).
*
*
*data(lv_drgno) = value #( lft_char_value[ CharcInternalID = '0000000816' ]-CharcValue OPTIONAL  ).
*data(lv_Grade) = value #( lft_char_value[ CharcInternalID = '0000000819' ]-CharcValue OPTIONAL  ).
*data(lv_RmSpecification) = value #( lft_char_value[ CharcInternalID = '0000000823' ]-CharcValue OPTIONAL  ).
*data(lv_PartNo) = value #( lft_char_value[ CharcInternalID = '0000000812' ]-CharcValue OPTIONAL  ).
*     case when char_val.CharcInternalID = '0000000816'
*        then char_val.CharcValue else '' end as Drgno,
*        case when char_val.CharcInternalID = '0000000819'
*        then char_val.CharcValue else '' end as Grade,
*        case when char_val.CharcInternalID = '0000000823'
*        then char_val.CharcValue else '' end as RmSpecification,
*        case when char_val.CharcInternalID = '0000000812'
*        then char_val.CharcValue else '' end as PartNo,





        MODIFY ENTITIES OF ZR_SETUP_APP_HEAD
 IN LOCAL MODE
      ENTITY zr_setup_app_head
      UPDATE FIELDS ( setupapprovalno
zdate
submittedtoqa_time
*Drgno
*Grade
*RmSpecification
*PartNo
                       )
      WITH VALUE #( "FOR key IN keys
                    (
  %is_draft              = ls_mat_data-%is_draft
                      Cuuid                  = VALUE #( keys[ 1 ]-Cuuid OPTIONAL )
                      setupapprovalno          = LV_SETUP          ""mapped1-inspectionlot
zdate = sy-datum
submittedtoqa_time = sy-uzeit
*Drgno = lv_drgno
*Grade = lv_Grade
*RmSpecification = lv_RmSpecification
*PartNo = lv_PartNo
 %control-setupapprovalno = if_abap_behv=>mk-on
 %control-zdate = if_abap_behv=>mk-on
 %control-submittedtoqa_time = if_abap_behv=>mk-on

* %control-Drgno = if_abap_behv=>mk-on
* %control-Grade = if_abap_behv=>mk-on
* %control-RmSpecification = if_abap_behv=>mk-on
* %control-PartNo = if_abap_behv=>mk-on

                    ) )

               FAILED DATA(lt_fail)
               REPORTED DATA(lt_reported)
               MAPPED DATA(lt_mapped).

               endif.
  ENDMETHOD.

  METHOD updateHeaderDetails.
   READ ENTITIES OF ZR_SETUP_APP_HEAD IN LOCAL MODE
     ENTITY zr_setup_app_head
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).

    IF lt_mat_data IS NOT INITIAL.

      DATA(ls_mat_data) = VALUE #( lt_mat_data[ 1 ] OPTIONAL ).



       DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.

        DATA: lv_object    TYPE CHAR10.
DATA LV_SETUP(20) TYPE C.



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



        MODIFY ENTITIES OF ZR_SETUP_APP_HEAD
 IN LOCAL MODE
      ENTITY zr_setup_app_head
      UPDATE FIELDS (
zdate
Drgno
Grade
RmSpecification
PartNo
partdesc
rawmatspec
                       )
      WITH VALUE #( "FOR key IN keys
                    (
  %is_draft              = ls_mat_data-%is_draft
                      Cuuid                  = VALUE #( keys[ 1 ]-Cuuid OPTIONAL )

zdate = sy-datum
Drgno = lv_drgno
Grade = lv_Grade
RmSpecification = lv_RmSpecification
PartNo = lv_PartNo
partdesc = LV_PRO_LONG_TXT
rawmatspec = LV_raw_mat
 %control-setupapprovalno = if_abap_behv=>mk-on
 %control-zdate = if_abap_behv=>mk-on

 %control-Drgno = if_abap_behv=>mk-on
 %control-Grade = if_abap_behv=>mk-on
 %control-RmSpecification = if_abap_behv=>mk-on
 %control-PartNo = if_abap_behv=>mk-on
 %control-partdesc = if_abap_behv=>mk-on
 %control-rawmatspec = if_abap_behv=>mk-on

                    ) )

               FAILED DATA(lt_fail)
               REPORTED DATA(lt_reported)
               MAPPED DATA(lt_mapped).

               endif.

  ENDMETHOD.

ENDCLASS.
