CLASS lhc_zr_prod_log_hd DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_prod_log_hd RESULT result.
    METHODS postproductionorder FOR MODIFY
      IMPORTING keys FOR ACTION zr_prod_log_hd~postproductionorder RESULT result.

ENDCLASS.

CLASS lhc_zr_prod_log_hd IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD postProductionOrder.

   READ ENTITIES OF ZR_PROD_LOG_HD
      IN LOCAL MODE
      ENTITY zr_prod_log_hd
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_header_data)
      FAILED DATA(lit_failed).
      if lit_header_data is not initial.
        data(lfs_header) = value #(  lit_header_data[ 1 ]  optional ).

          MODIFY ENTITY I_ProductionOrderTP
                    CREATE FIELDS (
                     product
                     productionplant
                     productionversion
                     productionordertype
                     orderplannedtotalqty
                     productionunit
                     basicschedulingtype
                     )
                    AUTO FILL CID WITH VALUE #(
                     (
                     %data-product =  'DANA136021ZP01'
                     %data-productionplant =  'MHU2'
                     %data-productionversion = '0001'
                     %data-productionordertype = 'ZMTS'
                     %data-orderplannedtotalqty = 1000
                     %data-productionunit = 'NOS'
                     %data-basicschedulingtype = '4'
                     )
                     )
                    FAILED data(lft_failed)
                    REPORTED DATA(lft_reported)
                    MAPPED DATA(lft_mapped).

                  IF failed IS INITIAL.


                     IF sy-subrc = 0 .
*****                         CONVERT KEY OF i_productionordertp
*****                         FROM TEMPORARY VALUE #( %pid = lft_mapped-productionorder[ 1 ]-%pid
*****                         %tmp = lft_mapped-productionorder[ 1 ]-%key )
*****                         TO FINAL(ls_finalkey).
*****                         lfs_final-productionorder =  ls_finalkey-ProductionOrder.
*****                         lfs_zqm_prod_ord_log-productionorder = ls_finalkey-ProductionOrder.
*****                         lfs_zqm_prod_ord_log-msg = 'S'.
*****                         lfs_zqm_prod_ord_log-msgdesc = lfs_final-productionorder && | | && 'is created'.
*****
*****                         append lfs_final to lft_final.

                         ENDIF.
****                         COMMIT ENTITIES END.

                     " Number of created Order: ls_finalkey-productionorder

                    ELSE.
*****                         ROLLBACK ENTITIES.


****      IF sy-subrc = 0 AND reported-productionorder IS not INITIAL.
****
****      loop at reported-productionorder into data(lfs_error).
****       DATA(lo_msg) = CAST if_message( lfs_error-%msg ).
****       if lo_msg is bound.
****       lfs_final-error_message  = lo_msg->get_text( ).
****       lfs_zqm_prod_ord_log-msgdesc = lfs_final-error_message.
****       endif.
****        clear :lfs_error.
****      ENDLOOP.
****      ELSE.
****        lfs_final-error_message = 'Unknown error occurred during creation'.
****        lfs_zqm_prod_ord_log-msgdesc = lfs_final-error_message.
      ENDIF.

      endif.


  ENDMETHOD.

ENDCLASS.
