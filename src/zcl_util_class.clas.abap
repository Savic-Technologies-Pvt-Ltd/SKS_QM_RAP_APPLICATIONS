CLASS zcl_util_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun.   "To make it runnable from ADT
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_UTIL_CLASS IMPLEMENTATION.


 METHOD if_oo_adt_classrun~main.
types: BEGIN OF ty_final,
       productionorder type I_ProductionOrderOperation_2-ProductionOrder,
       error_message type string,
       END OF ty_final.

       data lfs_final type ty_final.
       data lft_final type table of ty_final.
data lv_order type I_ProductionOrderOperation_2-ProductionOrder.

lv_order = '001100000164'.


select  a~ProductionOrder,
        a~Plant,
        a~OrderInternalID,
       a~OrderOperationInternalID
       from I_ProductionOrderOperation_2 as a where a~ProductionOrder =  @lv_order
       into table @data(lft_operation).

       if sy-subrc = 0.
        sort lft_operation by Plant ASCENDING.

        loop at lft_operation into data(lfs_operation).
            select single   a~OrderInternalID,
                           a~OrderOperationInternalID,
                           a~Material,
                           a~RequiredQuantity,
                           a~BaseUnit

                       from I_ProductionOrderComponent as a where a~OrderInternalID = @lfs_operation-OrderInternalID
                       and a~OrderOperationInternalID = @lfs_operation-OrderOperationInternalID
                       into @data(lfs_component).



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
                     %data-product = lfs_component-Material " 'DANA136021ZP01'
                     %data-productionplant = lfs_operation-Plant " 'MHU2'
                     %data-productionversion = '0001'
                     %data-productionordertype = 'ZMTS'
                     %data-orderplannedtotalqty = lfs_component-RequiredQuantity " 1000
                     %data-productionunit = lfs_component-BaseUnit "'NOS'
                     %data-basicschedulingtype = '4'
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
                         lfs_final-productionorder =  ls_finalkey-ProductionOrder.
                         append lfs_final to lft_final.
                         ENDIF.
                         COMMIT ENTITIES END.

                     " Number of created Order: ls_finalkey-productionorder

                    ELSE.
                         ROLLBACK ENTITIES.


      IF sy-subrc = 0 AND reported-productionorder IS not INITIAL.

      loop at reported-productionorder into data(lfs_error).
       DATA(lo_msg) = CAST if_message( lfs_error-%msg ).
       if lo_msg is bound.
       lfs_final-error_message  = lo_msg->get_text( ).
       endif.
        clear :lfs_error.
      ENDLOOP.
      ELSE.
        lfs_final-error_message = 'Unknown error occurred during creation'.
      ENDIF.


                         append lfs_final to lft_final.

                           CLEAR lfs_final.
                    ENDIF.
                    clear :lfs_operation.

                    wait up to 4 seconds.
        ENDLOOP.


       endif.



data(lv_error) = abap_true.



  ENDMETHOD.
ENDCLASS.
