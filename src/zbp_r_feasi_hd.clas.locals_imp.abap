CLASS lsc_zr_feasi_hd DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zr_feasi_hd IMPLEMENTATION.

  METHOD save_modified.
   if create-zr_feasi_hd is NOT INITIAL.
    data lfs_item type ZSD_FEASI_IT.
    data lft_item type table of ZSD_FEASI_IT.

     data lfs_Opr type ZSD_FEASI_OP.
    data lft_Opr type table of ZSD_FEASI_OP.

     data lfs_Risk type ZSD_FEASI_RS.
    data lft_Risk type table of ZSD_FEASI_RS.

    DATA(lv_itemno) = 1.
    DATA(lv_Opr) = 1.
    DATA(lv_Risk) = 1.

     loop at create-zr_feasi_hd ASSIGNING FIELD-SYMBOL(<lfs_head>).

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'Involvement of cross functional team for review' ) TO lft_item.
lv_itemno += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'Are product requirements adequately defined ?' ) TO lft_item.
lv_itemno += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'Can Engg. Specifications be met as written ?' ) TO lft_item.
lv_itemno += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'Can product be manufactured to tolerances specified on drawing ?' ) TO lft_item.
lv_itemno += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'Are there any product safety characteristics involved in this product?' ) TO lft_item.
lv_itemno += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'If yes, then what is that characteristic?' ) TO lft_item.
lv_itemno += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'Is statistical process control required on product?' ) TO lft_item.
lv_itemno += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'Which characteristic requires statistic process control?' ) TO lft_item.
lv_itemno += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'Is there adequate capacity to produce product ?' ) TO lft_item.
lv_itemno += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'Are there any Statutory & Regulatory requirements applicable for this product?' ) TO lft_item.
lv_itemno += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'Are there any specific storage & handling requirements?' ) TO lft_item.
lv_itemno += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'Are there any specific recycling requirements required for this product?' ) TO lft_item.
lv_itemno += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'Is there any environmental impact from the product?' ) TO lft_item.
lv_itemno += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'Is there any specific requirements for disposal of material?' ) TO lft_item.
lv_itemno += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'Are there any specific trainings required ? If yes, which trainings?' ) TO lft_item.
lv_itemno += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'Is it completely a new product category or regular product category?' ) TO lft_item.
lv_itemno += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_itemno
                remarks = 'Acceptance of Packaging Requirement' ) TO lft_item.
lv_itemno += 1.


****APPEND VALUE #( cuuid  = <lfs_head>-cuuid
****                itemno = lv_Opr
****                operation = 'Forging' ) TO lft_opr.
****lv_Opr += 1.
****
****APPEND VALUE #( cuuid  = <lfs_head>-cuuid
****                itemno = lv_Opr
****                operation = 'Serration Rolling' ) TO lft_opr.
****lv_Opr += 1.
****
****APPEND VALUE #( cuuid  = <lfs_head>-cuuid
****                itemno = lv_Opr
****                operation = 'Thread Rolling - M8x1.25-6g' ) TO lft_opr.
****lv_Opr += 1.
****
****APPEND VALUE #( cuuid  = <lfs_head>-cuuid
****                itemno = lv_Opr
****                operation = 'Heat Treatment -  39-44 HRC' ) TO lft_opr.
****lv_Opr += 1.
****
****APPEND VALUE #( cuuid  = <lfs_head>-cuuid
****                itemno = lv_Opr
****                operation = 'Surface Treatment :- ZINC PHOSPHATE & OIL' ) TO lft_opr.
****lv_Opr += 1.
****
****APPEND VALUE #( cuuid  = <lfs_head>-cuuid
****                itemno = lv_Opr
****                operation = 'BKING FOR HYDROGEN DE-EMBRITTLEMENT REQUIRE' ) TO lft_opr.
****lv_Opr += 1.


APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_Risk
                area = 'Process Risk '
                high = 'All New Process - Knowledge required '
                medium = 'Existing Process with additional new requirement'
                low = 'Existing Process'
                 ) TO lft_Risk.
lv_Risk += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_Risk
                area = 'Product category '
                high = 'Completely new '
                medium = 'Nearer to existing product group category but not completely new '
                low = 'Existing product group'
                 ) TO lft_Risk.
lv_Risk += 1.


APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_Risk
                                area = 'Measurement Risk'

                high = 'New measurement method / facility required '
                medium = 'Known inspection and measurement technique. Required to purchase '
                low = 'Measurement with existing available facility '
                 ) TO lft_Risk.
lv_Risk += 1.
APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_Risk
                area = 'Additional / Dedicated investment'

                high = 'Dedicated Investment of More than Five Lakhs '
                medium = 'Dedicated Investment of less than Five Lakhs '
                low = 'No additional / dedicated facility required '
                 ) TO lft_Risk.
lv_Risk += 1.
APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_Risk
                area = 'Tooling Investment '

                high = 'Complete new set up (Tooling cost more than One Lakh)'
                medium = 'Some new tools required (Tooling Cost between Fifty Thousand to One Lakhs)'
                low = 'Minimum Tools required (Tooling Cost less than Fifty Thousand )'
                 ) TO lft_Risk.
lv_Risk += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_Risk
                area = 'Product Compliance requirement / Liability'
                high = 'Debit value more than sale  value'
                medium = 'Debit value equal to sale  value'
                low = 'No debit requirement of customer '
                 ) TO lft_Risk.
lv_Risk += 1.

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
                itemno = lv_Risk
                area = 'Price Reduction Pressure'
                high = 'Year on Year for more than 1%'
                medium = 'Price Reduction ≤ 1%  '
                low = 'No price reduction '
                 ) TO lft_Risk.
lv_Risk += 1.
     ENDLOOP.

    modify ZSD_FEASI_IT from table  @lft_item.
****    modify ZSD_FEASI_OP from table  @lft_opr.
    modify ZSD_FEASI_RS from table  @lft_Risk.

    endif.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZR_FEASI_HD DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
  METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zr_feasi_hd RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_feasi_hd RESULT result.
    METHODS createfeasibilityno FOR DETERMINE ON SAVE
      IMPORTING keys FOR zr_feasi_hd~createfeasibilityno.
    METHODS getpdf FOR MODIFY
      IMPORTING keys FOR ACTION zr_feasi_hd~getpdf RESULT result.
    METHODS updateheaderdetails FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zr_feasi_hd~updateheaderdetails.

ENDCLASS.

CLASS lhc_ZR_FEASI_HD IMPLEMENTATION.


 METHOD get_instance_features.

    READ ENTITY IN LOCAL MODE ZR_FEASI_HD

              ALL FIELDS WITH CORRESPONDING #( keys )
              RESULT DATA(lt_header).

    SELECT * FROM ZR_FEASI_HD

    WHERE Cuuid = @( VALUE #( lt_header[ 1 ]-Cuuid ) )
    INTO TABLE @DATA(lt_item).
    IF sy-subrc = 0.
      DATA(ls_item) = VALUE #( lt_item[ 1 ] OPTIONAL ).
    ENDIF.


    result = VALUE #( FOR ls_header IN lt_header ( %tky = ls_header-%tky
        %features-%field-enquiry_no      =  if_abap_behv=>fc-f-read_only
                %features-%field-enquiryitem      =  if_abap_behv=>fc-f-read_only
                                %features-%field-part_no      =  if_abap_behv=>fc-f-read_only
                                %features-%field-part_description      =  if_abap_behv=>fc-f-read_only
                                %features-%field-grade      =  if_abap_behv=>fc-f-read_only
                                %features-%field-customer      =  if_abap_behv=>fc-f-read_only

        )
  ).


  ENDMETHOD.



  METHOD get_instance_authorizations.


  ENDMETHOD.

  METHOD createFeasibilityNo.

   READ ENTITIES OF ZR_FEASI_HD
 IN LOCAL MODE
     ENTITY zr_feasi_hd
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).

    IF lt_mat_data IS NOT INITIAL.

      DATA(ls_mat_data) = VALUE #( lt_mat_data[ 1 ] OPTIONAL ).



       DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.

        DATA: lv_object    TYPE CHAR10.
DATA LV_SETUP(20) TYPE C.



SELECT MAX( Feasibilityno  ) FROM ZSD_FEASI_HD

 INTO @DATA(LV_SETUP_OLD).
LV_SETUP = LV_SETUP_OLD + 1.
SHIFT LV_SETUP LEFT DELETING LEADING SPACE.
        MODIFY ENTITIES OF ZR_FEASI_HD


 IN LOCAL MODE
      ENTITY zr_feasi_hd
      UPDATE FIELDS ( Feasibilityno

                       )
      WITH VALUE #( "FOR key IN keys
                    (
  %is_draft              = ls_mat_data-%is_draft
                      Cuuid                  = VALUE #( keys[ 1 ]-Cuuid OPTIONAL )
                      Feasibilityno          = LV_SETUP          ""mapped1-inspectionlot

 %control-Feasibilityno = if_abap_behv=>mk-on



                    ) )

               FAILED DATA(lt_fail)
               REPORTED DATA(lt_reported)
               MAPPED DATA(lt_mapped).

               endif.
  ENDMETHOD.

  METHOD getpdf.

 data lv_form_name type string.
    data : lv_base64      TYPE string,
       lv_token       TYPE string,
           lv_message     TYPE string.
data lfs_header type ZR_FEASI_HD.
data lft_header type              table of ZR_FEASI_HD.
 data ltt_data_op TYPE TABLE OF ZR_FEASI_OP
.
  data: ltt_data_rs TYPE TABLE OF ZR_FEASI_RS.

data lfs_item type ZR_FEASI_IT.
data lft_item type table of ZR_FEASI_IT.

    READ ENTITIES OF ZR_FEASI_HD

      IN LOCAL MODE


      ENTITY zr_feasi_hd
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_header_data)
      FAILED DATA(lit_failed).

data(lfs_header_run) = value #(  lit_header_data[ 1 ]  ).

select * from ZSD_FEASI_IT

where cuuid = @lfs_header_run-Cuuid
into TABLE @data(lft_item_db)
.


select * from ZSD_FEASI_OP


where cuuid = @lfs_header_run-Cuuid
into TABLE @data(lft_ZSD_FEASI_OP_db)
.


select * from ZSD_FEASI_RS


where cuuid = @lfs_header_run-Cuuid
into TABLE @data(lft_ZSD_FEASI_RS_db)
.


    MOVE-CORRESPONDING lit_header_data TO lft_header.
    MOVE-CORRESPONDING lft_item_db TO lft_item.
    MOVE-CORRESPONDING lft_ZSD_FEASI_OP_db TO ltt_data_op.
    MOVE-CORRESPONDING lft_ZSD_FEASI_RS_db TO ltt_data_rs.

    zcl_btp_adobe_form=>get_ouath_token(
      EXPORTING
        im_oauth_url    = 'ADS_OAUTH_URL'
        im_clientid     = 'ADS_CLIENTID'
        im_clientsecret = 'ADS_CLIENTSECRET'
      IMPORTING
        ex_token        = lv_token
        ex_message      = lv_message
    ).

    zbp_r_feasi_hd=>get_pdf_xml(
      EXPORTING
*       im_data    = lit_data
        im_data_h  = lft_header
        im_data_i  = lft_item

          im_data_op  =  ltt_data_op

                im_data_rs  =  ltt_data_rs
      IMPORTING
        ex_base_64 = lv_base64
    ).




lv_form_name = 'ZFEASIBILITY_APP/Feasibility_Form'.


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




    MODIFY ENTITIES OF ZR_FEASI_HD
 IN LOCAL MODE
      ENTITY zr_feasi_hd
      UPDATE FIELDS (  attachments filename mimetype  )
      WITH VALUE #( FOR lwa_header IN lit_header_data ( %tky        = lwa_header-%tky
                                                        Attachments = lv_base64_decode
                                                        filename    = 'Form'
                                                        mimetype    = 'application/pdf'
                    ) )
    FAILED failed
    REPORTED reported.

    READ ENTITIES OF  ZR_FEASI_HD

 IN LOCAL MODE

          ENTITY zr_feasi_hd

          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(lit_updatedheader).

    " set the action result parameter
    result = VALUE #( FOR lwa_updatedheader IN lit_updatedheader ( %tky   = lwa_updatedheader-%tky
                                                                   %param = lwa_updatedheader ) ).


  ENDMETHOD.

  METHOD updateHeaderDetails.
   READ ENTITIES OF ZR_FEASI_HD
 IN LOCAL MODE
     ENTITY zr_feasi_hd
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).

    IF lt_mat_data IS NOT INITIAL.

      DATA(ls_mat_data) = VALUE #( lt_mat_data[ 1 ] OPTIONAL ).
DATA LV_ITEM TYPE I_SalesInquiryItem-SalesInquiryItem.
DATA LV_vbeln TYPE I_SalesInquiryItem-SalesInquiry.
LV_ITEM = ls_mat_data-enquiryitem.
LV_vbeln = ls_mat_data-enquiry_no.
LV_ITEM = |{  LV_ITEM ALPHA = IN }|.
LV_vbeln = |{  LV_vbeln ALPHA = IN }|.
  select single A~SalesInquiry,
  A~SOLDTOPARTY,
  B~Material,
  c~ProductName

   from I_SALESINQUIRY AS A INNER JOIN I_SalesInquiryItem AS B ON B~SalesInquiry = A~SalesInquiry
                                                                      AND B~SalesInquiryItem = @LV_ITEM
                            INNER JOIN I_ProductText AS C ON C~Product = b~Material and c~Language = 'E'
  where A~SalesInquiry = @LV_vbeln
  into @data(lfs_header).



SELECT a~ClfnObjectID,
a~CharcInternalID,
a~CharcValue,
b~Characteristic
  FROM i_clfnobjectcharcvalforkeydate( p_keydate = @sy-datum ) as a
  inner join I_ClfnCharacteristicForKeyDate( p_keydate = @sy-datum ) as b on b~CharcInternalID = a~CharcInternalID
  WHERE ClfnObjectID  = @lfs_header-Material
  INTO TABLE @data(lft_char_value).


data(lv_Grade) = value #( lft_char_value[ Characteristic = 'ITEM_GRADE' ]-CharcValue OPTIONAL  ).
data(lv_PartNo) = value #( lft_char_value[ Characteristic = 'ITEM_CODE' ]-CharcValue OPTIONAL  ).



   MODIFY ENTITIES OF ZR_FEASI_HD
 IN LOCAL MODE
      ENTITY zr_feasi_hd
      UPDATE FIELDS (
customer
part_description
part_no
grade
)


      WITH VALUE #( "FOR key IN keys
                    (
  %is_draft              = ls_mat_data-%is_draft
                      Cuuid                  = VALUE #( keys[ 1 ]-Cuuid OPTIONAL )

customer = lfs_header-SOLDTOPARTY
part_description = lfs_header-ProductName
part_no      = lv_PartNo
grade = lv_Grade

 %control-customer = if_abap_behv=>mk-on
 %control-part_description = if_abap_behv=>mk-on

 %control-part_no = if_abap_behv=>mk-on
 %control-grade = if_abap_behv=>mk-on
                    ) )

               FAILED DATA(lt_fail)
               REPORTED DATA(lt_reported)
               MAPPED DATA(lt_mapped).


  endif.
  ENDMETHOD.

ENDCLASS.
