CLASS zcl_qm_prod_order_auto DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.   "To make it runnable from ADT
    INTERFACES:
      if_apj_dt_exec_object,
      if_apj_rt_exec_object.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_QM_PROD_ORDER_AUTO IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA lfs_zqm_prod_ord_log TYPE zqm_prod_ord_log.
    DATA lft_zqm_prod_ord_log TYPE TABLE OF zqm_prod_ord_log.
    TYPES: BEGIN OF ty_final,
             productionorder TYPE i_productionorderoperation_2-productionorder,
             error_message   TYPE string,
           END OF ty_final.

    DATA lfs_final TYPE ty_final.
    DATA lft_final TYPE TABLE OF ty_final.
    DATA lv_order TYPE i_productionorderoperation_2-productionorder.

*    lv_order =  '001100000330'.
*SELECT SINGLE * FROM i_productionorder INTO @DATA(LFS_CHECK).
*LFS_CHECK-YY1_PP_Customer_Name_ORD
    SELECT productionorder,
    productionordertype ,
               YY1_PP_BATCH01_ORD,
YY1_PP_Cat_Code_ORD,
YY1_PP_Colour_Code_ORD,
YY1_PP_Customer_Name_ORD,
YY1_PP_Dist_Channel_ORD,
YY1_PP_Finish_Weight_ORD,
YY1_PP_GR_NO_ORD,
YY1_PP_Hardness_Spec_ORD,
YY1_PP_No_Box_Pallet_ORD,
YY1_PP_No_of_Polybag_ORD,
YY1_PP_Pack_Box_Qty_ORD,
YY1_PP_Pack_Box_Type_ORD,
YY1_PP_Packaging_Type_ORD,
YY1_PP_Pallet_Type_ORD,
YY1_PP_Polybag_Qty_ORD,
YY1_PP_Polybag_Type_ORD,
YY1_PP_Finish_Weight_ORDu,
YY1_PP_Polybag_Qty_ORDU,
YY1_PP_Pack_Box_Qty_ORDU,
YY1_PP_Supp_Heat_Code_Ord,
YY1_PP_is_Child_Prod_ORD,

salesorder,
salesorderitem
 FROM i_productionorder
    WHERE productionordertype = 'ZMTO' AND creationdate = @sy-datum
    INTO TABLE @DATA(lft_prod_ord).
    " New Version
    IF SY-sysid = 'TMM'.
        DELETE lft_prod_ord WHERE productionorder < '001100000246'.
    ELSEIF SY-sysid = 'A7D'.
        DELETE lft_prod_ord WHERE productionorder < '001100000332'.
    ENDIF.
    LOOP AT lft_prod_ord INTO DATA(lfs_prod_ord).

      SELECT SINGLE productionorder FROM zqm_prod_ord_log
      WHERE ref_productionorder = @lfs_prod_ord-productionorder
      and productionorder is not INITIAL INTO @DATA(lv_prod_log).
      IF sy-subrc <> 0.

        SELECT  a~productionorder,
                a~plant,
                a~orderinternalid,
               a~orderoperationinternalid,
               a~productionorderoperationtext
               FROM i_productionorderoperation_2 AS a WHERE a~productionorder =  @lfs_prod_ord-productionorder
               INTO TABLE @DATA(lft_operation).

        IF sy-subrc = 0.
          SORT lft_operation BY OrderOperationInternalID ASCENDING.

          LOOP AT lft_operation INTO DATA(lfs_operation).

            lfs_zqm_prod_ord_log-zdate = sy-datum.
            lfs_zqm_prod_ord_log-ztime = sy-uzeit.
            lfs_zqm_prod_ord_log-zuser = sy-uname.
            lfs_zqm_prod_ord_log-orderinternalid = lfs_operation-orderinternalid.
            lfs_zqm_prod_ord_log-orderoperationinternalid = lfs_operation-orderoperationinternalid.
            lfs_zqm_prod_ord_log-ref_productionorder = lfs_prod_ord-productionorder.
            lfs_zqm_prod_ord_log-operationtext = lfs_operation-productionorderoperationtext.

            SELECT SINGLE   a~orderinternalid,
                           a~orderoperationinternalid,
                           a~material,
                           a~requiredquantity,
                           a~baseunit

                       FROM i_productionordercomponent AS a WHERE a~orderinternalid = @lfs_operation-orderinternalid
                       AND a~orderoperationinternalid = @lfs_operation-orderoperationinternalid
                       INTO @DATA(lfs_component).

            lfs_zqm_prod_ord_log-material = lfs_component-material.

            select single ProductName from  I_ProductText  where product = @lfs_component-material
            into @lfs_zqm_prod_ord_log-material_desc.

            MODIFY ENTITY i_productionordertp
                        CREATE FIELDS (
                         product
                         productionplant
                         planningplant
                         productionversion
                         productionordertype
                         orderplannedtotalqty
                         productionunit
                         basicschedulingtype
                         YY1_PP_Par_Prod_Order_ORD
               YY1_PP_BATCH01_ORD
YY1_PP_Cat_Code_ORD
YY1_PP_Colour_Code_ORD
YY1_PP_Customer_Name_ORD
YY1_PP_Dist_Channel_ORD
YY1_PP_Finish_Weight_ORD
"YY1_PP_GR_NO_ORD
YY1_PP_Hardness_Spec_ORD
YY1_PP_No_Box_Pallet_ORD
YY1_PP_No_of_Polybag_ORD
YY1_PP_Pack_Box_Qty_ORD
YY1_PP_Pack_Box_Type_ORD
YY1_PP_Packaging_Type_ORD
YY1_PP_Pallet_Type_ORD
YY1_PP_Polybag_Qty_ORD
YY1_PP_Polybag_Type_ORD
YY1_PP_Supp_Heat_Code_Ord
"YY1_PP_Finish_Weight_ORDu
YY1_PP_Polybag_Qty_ORDU
YY1_PP_Pack_Box_Qty_ORDU
YY1_PP_is_Child_Prod_ORD

salesorder
salesorderitem

*                         ReferenceOrder
                         )
                        AUTO FILL CID WITH VALUE #(
                         (
                         %data-product = lfs_component-material " 'DANA136021ZP01'
                         %data-productionplant = lfs_operation-plant " 'MHU2'
                         %data-PlanningPlant = lfs_operation-plant
                         %data-productionversion = '0001'
                         %data-productionordertype = 'ZMTS'
                         %data-orderplannedtotalqty = lfs_component-requiredquantity " 1000
                         %data-productionunit = lfs_component-baseunit "'NOS'
                         %data-basicschedulingtype = '4'
                         %data-YY1_PP_Par_Prod_Order_ORD = lfs_prod_ord-productionorder
                        %data-YY1_PP_BATCH01_ORD         = lfs_prod_ord-YY1_PP_BATCH01_ORD
                        %data-YY1_PP_Cat_Code_ORD        = lfs_prod_ord-YY1_PP_Cat_Code_ORD
                        %data-YY1_PP_Colour_Code_ORD     = lfs_prod_ord-YY1_PP_Colour_Code_ORD
                        %data-YY1_PP_Customer_Name_ORD   = lfs_prod_ord-YY1_PP_Customer_Name_ORD
                        %data-YY1_PP_Dist_Channel_ORD    = lfs_prod_ord-YY1_PP_Dist_Channel_ORD
 "                       %data-YY1_PP_Finish_Weight_ORD   = lfs_prod_ord-YY1_PP_Finish_Weight_ORD
                        %data-YY1_PP_GR_NO_ORD           = lfs_prod_ord-YY1_PP_GR_NO_ORD
                        %data-YY1_PP_Hardness_Spec_ORD   = lfs_prod_ord-YY1_PP_Hardness_Spec_ORD
                        %data-YY1_PP_No_Box_Pallet_ORD   = lfs_prod_ord-YY1_PP_No_Box_Pallet_ORD
                        %data-YY1_PP_No_of_Polybag_ORD   = lfs_prod_ord-YY1_PP_No_of_Polybag_ORD
                        %data-YY1_PP_Pack_Box_Qty_ORD    = lfs_prod_ord-YY1_PP_Pack_Box_Qty_ORD
                        %data-YY1_PP_Pack_Box_Type_ORD   = lfs_prod_ord-YY1_PP_Pack_Box_Type_ORD
                        %data-YY1_PP_Packaging_Type_ORD  = lfs_prod_ord-YY1_PP_Packaging_Type_ORD
                        %data-YY1_PP_Pallet_Type_ORD     = lfs_prod_ord-YY1_PP_Pallet_Type_ORD
                        %data-YY1_PP_Polybag_Qty_ORD     = lfs_prod_ord-YY1_PP_Polybag_Qty_ORD
                        %data-YY1_PP_Polybag_Type_ORD    = lfs_prod_ord-YY1_PP_Polybag_Type_ORD
                        %data-YY1_PP_Supp_Heat_Code_Ord = lfs_prod_ord-YY1_PP_Supp_Heat_Code_Ord
  "                      %data-YY1_PP_Finish_Weight_ORDu = lfs_prod_ord-YY1_PP_Finish_Weight_ORDu

                        %data-YY1_PP_Polybag_Qty_ORDU  = lfs_prod_ord-YY1_PP_Polybag_Qty_ORDU
                        %data-YY1_PP_Pack_Box_Qty_ORDU = lfs_prod_ord-YY1_PP_Pack_Box_Qty_ORDU

                        %data-salesorder                = lfs_prod_ord-salesorder
                        %data-salesorderitem            = lfs_prod_ord-salesorderitem



                        %data-YY1_PP_is_Child_Prod_ORD = 'X'



*                         %data-ReferenceOrder = lfs_prod_ord-productionorder
                         )
                         )
                        FAILED DATA(failed)
                        REPORTED DATA(reported)
                        MAPPED DATA(mapped).

            IF failed IS INITIAL.
              COMMIT ENTITIES BEGIN
              RESPONSES
              FAILED DATA(failed_commit)
              REPORTED DATA(reported_commit).

              IF sy-subrc = 0 AND failed_commit IS INITIAL.
                CONVERT KEY OF i_productionordertp
                FROM TEMPORARY VALUE #( %pid = mapped-productionorder[ 1 ]-%pid
                %tmp = mapped-productionorder[ 1 ]-%key )
                TO FINAL(ls_finalkey).
                lfs_final-productionorder =  ls_finalkey-productionorder.
                lfs_zqm_prod_ord_log-productionorder = ls_finalkey-productionorder.
                lfs_zqm_prod_ord_log-msg = 'S'.
                lfs_zqm_prod_ord_log-msgdesc = lfs_final-productionorder && | | && 'is created'.

                APPEND lfs_final TO lft_final.

              ENDIF.
              COMMIT ENTITIES END.

              " Number of created Order: ls_finalkey-productionorder

            ELSE.
              ROLLBACK ENTITIES.


              IF sy-subrc = 0 AND reported-productionorder IS NOT INITIAL.

                LOOP AT reported-productionorder INTO DATA(lfs_error).
                  DATA(lo_msg) = CAST if_message( lfs_error-%msg ).
                  IF lo_msg IS BOUND.
                    lfs_final-error_message  = lo_msg->get_text( ).
                    lfs_zqm_prod_ord_log-msgdesc = lfs_final-error_message.
                  ENDIF.
                  CLEAR :lfs_error.
                ENDLOOP.
              ELSE.
                lfs_final-error_message = 'Unknown error occurred during creation'.
                lfs_zqm_prod_ord_log-msgdesc = lfs_final-error_message.
              ENDIF.


              lfs_zqm_prod_ord_log-msg = 'E'.


              APPEND lfs_final TO lft_final.

              CLEAR lfs_final.
            ENDIF.
            CLEAR :lfs_operation.

            WAIT UP TO 4 SECONDS.

            APPEND lfs_zqm_prod_ord_log TO lft_zqm_prod_ord_log.
            CLEAR :lfs_zqm_prod_ord_log.
          ENDLOOP.


        ENDIF.


        MODIFY zqm_prod_ord_log FROM TABLE @lft_zqm_prod_ord_log.
        IF sy-subrc = 0.
          COMMIT WORK AND WAIT.
        ELSE.
          ROLLBACK WORK.
        ENDIF.

      ENDIF.
      CLEAR :lfs_prod_ord.
    ENDLOOP.

    DATA(lv_error) = abap_true.



  ENDMETHOD.


  METHOD if_apj_rt_exec_object~execute.

    DATA lfs_zqm_prod_ord_log TYPE zqm_prod_ord_log.
    DATA lft_zqm_prod_ord_log TYPE TABLE OF zqm_prod_ord_log.
    TYPES: BEGIN OF ty_final,
             productionorder TYPE i_productionorderoperation_2-productionorder,
             error_message   TYPE string,
           END OF ty_final.

    DATA lfs_final TYPE ty_final.
    DATA lft_final TYPE TABLE OF ty_final.
    DATA lv_order TYPE i_productionorderoperation_2-productionorder.

    lv_order = ''.

    SELECT productionorder,
    productionordertype ,
               YY1_PP_BATCH01_ORD,
YY1_PP_Cat_Code_ORD,
YY1_PP_Colour_Code_ORD,
YY1_PP_Customer_Name_ORD,
YY1_PP_Dist_Channel_ORD,
YY1_PP_Finish_Weight_ORD,
YY1_PP_Finish_Weight_ORDu ,
YY1_PP_GR_NO_ORD,
YY1_PP_Hardness_Spec_ORD,
YY1_PP_No_Box_Pallet_ORD,
YY1_PP_No_of_Polybag_ORD,
YY1_PP_Pack_Box_Qty_ORD,
YY1_PP_Pack_Box_Type_ORD,
YY1_PP_Packaging_Type_ORD,
YY1_PP_Pallet_Type_ORD,
YY1_PP_Polybag_Qty_ORD,
YY1_PP_Polybag_Qty_ORDU ,
YY1_PP_Pack_Box_Qty_ORDU,
YY1_PP_Polybag_Type_ORD,
YY1_PP_Supp_Heat_Code_Ord,
YY1_PP_is_Child_Prod_ORD,

salesorder,
salesorderitem


 FROM i_productionorder
    WHERE productionordertype = 'ZMTO' AND creationdate = @sy-datum
    INTO TABLE @DATA(lft_prod_ord).
    " New Version
    IF SY-sysid = 'TMM'.
        DELETE lft_prod_ord WHERE productionorder < '001100000246'.
    ELSEIF SY-sysid = 'A7D'.
        DELETE lft_prod_ord WHERE productionorder < '001100000332'.
    ENDIF.
    LOOP AT lft_prod_ord INTO DATA(lfs_prod_ord).

      SELECT SINGLE productionorder FROM zqm_prod_ord_log
      WHERE ref_productionorder = @lfs_prod_ord-productionorder and productionorder is not INITIAL INTO @DATA(lv_prod_log).
      IF sy-subrc <> 0.


        SELECT  a~productionorder,
                a~plant,
                a~orderinternalid,
               a~orderoperationinternalid,
               a~productionorderoperationtext
               FROM i_productionorderoperation_2 AS a WHERE a~productionorder =  @lfs_prod_ord-productionorder
               INTO TABLE @DATA(lft_operation).

        IF sy-subrc = 0.
          SORT lft_operation BY OrderOperationInternalID ASCENDING.

          LOOP AT lft_operation INTO DATA(lfs_operation).

            lfs_zqm_prod_ord_log-zdate = sy-datum.
            lfs_zqm_prod_ord_log-ztime = sy-uzeit.
            lfs_zqm_prod_ord_log-zuser = sy-uname.
            lfs_zqm_prod_ord_log-orderinternalid = lfs_operation-orderinternalid.
            lfs_zqm_prod_ord_log-orderoperationinternalid = lfs_operation-orderoperationinternalid.
            lfs_zqm_prod_ord_log-ref_productionorder = lfs_prod_ord-productionorder.
            lfs_zqm_prod_ord_log-operationtext = lfs_operation-productionorderoperationtext.

            SELECT SINGLE   a~orderinternalid,
                           a~orderoperationinternalid,
                           a~material,
                           a~requiredquantity,
                           a~baseunit

                       FROM i_productionordercomponent AS a WHERE a~orderinternalid = @lfs_operation-orderinternalid
                       AND a~orderoperationinternalid = @lfs_operation-orderoperationinternalid
                       INTO @DATA(lfs_component).

        lfs_zqm_prod_ord_log-material = lfs_component-material.

            select single ProductName from  I_ProductText  where product = @lfs_component-material
            into @lfs_zqm_prod_ord_log-material_desc.

            MODIFY ENTITY i_productionordertp
                        CREATE FIELDS (
                         product
                         productionplant
                         planningplant
                         productionversion
                         productionordertype
                         orderplannedtotalqty
                         productionunit
                         basicschedulingtype
                         YY1_PP_Par_Prod_Order_ORD
                                    YY1_PP_BATCH01_ORD
YY1_PP_Cat_Code_ORD
YY1_PP_Colour_Code_ORD
YY1_PP_Customer_Name_ORD
YY1_PP_Dist_Channel_ORD
"YY1_PP_Finish_Weight_ORD
YY1_PP_GR_NO_ORD
YY1_PP_Hardness_Spec_ORD
YY1_PP_No_Box_Pallet_ORD
YY1_PP_No_of_Polybag_ORD
YY1_PP_Pack_Box_Qty_ORD
YY1_PP_Pack_Box_Type_ORD
YY1_PP_Packaging_Type_ORD
YY1_PP_Pallet_Type_ORD
YY1_PP_Polybag_Qty_ORD
YY1_PP_Polybag_Type_ORD
YY1_PP_Supp_Heat_Code_Ord
"YY1_PP_Finish_Weight_ORDu
YY1_PP_Polybag_Qty_ORDU
YY1_PP_Pack_Box_Qty_ORDU

salesorder
salesorderitem

YY1_PP_is_Child_Prod_ORD
*                         ReferenceOrder
                         )
                        AUTO FILL CID WITH VALUE #(
                         (
                         %data-product = lfs_component-material " 'DANA136021ZP01'
                         %data-productionplant = lfs_operation-plant " 'MHU2'
                         %data-PlanningPlant = lfs_operation-plant
                         %data-productionversion = '0001'
                         %data-productionordertype = 'ZMTS'
                         %data-orderplannedtotalqty = lfs_component-requiredquantity " 1000
                         %data-productionunit = lfs_component-baseunit "'NOS'
                         %data-basicschedulingtype = '4'
                         %data-YY1_PP_Par_Prod_Order_ORD = lfs_prod_ord-productionorder
                              %data-YY1_PP_BATCH01_ORD         = lfs_prod_ord-YY1_PP_BATCH01_ORD
                        %data-YY1_PP_Cat_Code_ORD        = lfs_prod_ord-YY1_PP_Cat_Code_ORD
                        %data-YY1_PP_Colour_Code_ORD     = lfs_prod_ord-YY1_PP_Colour_Code_ORD
                        %data-YY1_PP_Customer_Name_ORD   = lfs_prod_ord-YY1_PP_Customer_Name_ORD
                        %data-YY1_PP_Dist_Channel_ORD    = lfs_prod_ord-YY1_PP_Dist_Channel_ORD
 "                       %data-YY1_PP_Finish_Weight_ORD   = lfs_prod_ord-YY1_PP_Finish_Weight_ORD
                        %data-YY1_PP_GR_NO_ORD           = lfs_prod_ord-YY1_PP_GR_NO_ORD
                        %data-YY1_PP_Hardness_Spec_ORD   = lfs_prod_ord-YY1_PP_Hardness_Spec_ORD
                        %data-YY1_PP_No_Box_Pallet_ORD   = lfs_prod_ord-YY1_PP_No_Box_Pallet_ORD
                        %data-YY1_PP_No_of_Polybag_ORD   = lfs_prod_ord-YY1_PP_No_of_Polybag_ORD
                        %data-YY1_PP_Pack_Box_Qty_ORD    = lfs_prod_ord-YY1_PP_Pack_Box_Qty_ORD
                        %data-YY1_PP_Pack_Box_Type_ORD   = lfs_prod_ord-YY1_PP_Pack_Box_Type_ORD
                        %data-YY1_PP_Packaging_Type_ORD  = lfs_prod_ord-YY1_PP_Packaging_Type_ORD
                        %data-YY1_PP_Pallet_Type_ORD     = lfs_prod_ord-YY1_PP_Pallet_Type_ORD
                        %data-YY1_PP_Polybag_Qty_ORD     = lfs_prod_ord-YY1_PP_Polybag_Qty_ORD
                        %data-YY1_PP_Polybag_Type_ORD    = lfs_prod_ord-YY1_PP_Polybag_Type_ORD
                         %data-YY1_PP_Supp_Heat_Code_Ord = lfs_prod_ord-YY1_PP_Supp_Heat_Code_Ord
  "                        %data-YY1_PP_Finish_Weight_ORDu = lfs_prod_ord-YY1_PP_Finish_Weight_ORDu
%data-YY1_PP_Polybag_Qty_ORDU  = lfs_prod_ord-YY1_PP_Polybag_Qty_ORDU
%data-YY1_PP_Pack_Box_Qty_ORDU = lfs_prod_ord-YY1_PP_Pack_Box_Qty_ORDU
%data-YY1_PP_is_Child_Prod_ORD = 'X'

  %data-salesorder                = lfs_prod_ord-salesorder
  %data-salesorderitem            = lfs_prod_ord-salesorderitem


*                         %data-ReferenceOrder = lfs_prod_ord-productionorder
                         )
                         )
                        FAILED DATA(failed)
                        REPORTED DATA(reported)
                        MAPPED DATA(mapped).

            IF failed IS INITIAL.
              COMMIT ENTITIES BEGIN
              RESPONSES
              FAILED DATA(failed_commit)
              REPORTED DATA(reported_commit).

              IF sy-subrc = 0 AND failed_commit IS INITIAL.
                CONVERT KEY OF i_productionordertp
                FROM TEMPORARY VALUE #( %pid = mapped-productionorder[ 1 ]-%pid
                %tmp = mapped-productionorder[ 1 ]-%key )
                TO FINAL(ls_finalkey).
                lfs_final-productionorder =  ls_finalkey-productionorder.
                lfs_zqm_prod_ord_log-productionorder = ls_finalkey-productionorder.
                lfs_zqm_prod_ord_log-msg = 'S'.
                lfs_zqm_prod_ord_log-msgdesc = lfs_final-productionorder && | | && 'is created'.

                APPEND lfs_final TO lft_final.

              ENDIF.
              COMMIT ENTITIES END.

              " Number of created Order: ls_finalkey-productionorder

            ELSE.
              ROLLBACK ENTITIES.


              IF sy-subrc = 0 AND reported-productionorder IS NOT INITIAL.

                LOOP AT reported-productionorder INTO DATA(lfs_error).
                  DATA(lo_msg) = CAST if_message( lfs_error-%msg ).
                  IF lo_msg IS BOUND.
                    lfs_final-error_message  = lo_msg->get_text( ).
                    lfs_zqm_prod_ord_log-msgdesc = lfs_final-error_message.
                  ENDIF.
                  CLEAR :lfs_error.
                ENDLOOP.
              ELSE.
                lfs_final-error_message = 'Unknown error occurred during creation'.
                lfs_zqm_prod_ord_log-msgdesc = lfs_final-error_message.
              ENDIF.


              lfs_zqm_prod_ord_log-msg = 'E'.


              APPEND lfs_final TO lft_final.

              CLEAR lfs_final.
            ENDIF.
            CLEAR :lfs_operation.

            WAIT UP TO 4 SECONDS.

            APPEND lfs_zqm_prod_ord_log TO lft_zqm_prod_ord_log.
            CLEAR :lfs_zqm_prod_ord_log.
          ENDLOOP.


        ENDIF.


        MODIFY zqm_prod_ord_log FROM TABLE @lft_zqm_prod_ord_log.
        IF sy-subrc = 0.
          COMMIT WORK AND WAIT.
        ELSE.
          ROLLBACK WORK.
        ENDIF.
      ENDIF.
      CLEAR :lfs_prod_ord.
    ENDLOOP.

    DATA(lv_error) = abap_true.

  ENDMETHOD.


  METHOD if_apj_dt_exec_object~get_parameters.

  ENDMETHOD.
ENDCLASS.
