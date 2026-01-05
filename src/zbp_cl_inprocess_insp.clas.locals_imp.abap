CLASS lhc_ZQM_BA_InprocessInspection DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS createinsplot FOR DETERMINE ON SAVE
      IMPORTING keys FOR ZQM_BA_InprocessInspection_H~createinsplot.

ENDCLASS.

CLASS lhc_ZQM_BA_InprocessInspection IMPLEMENTATION.

  METHOD createinsplot.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZQM_BA_InprocessInspecti_1 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS createitem FOR DETERMINE ON SAVE
      IMPORTING keys FOR ZQM_BA_InprocessInspection_I~createitem.

ENDCLASS.

CLASS lhc_ZQM_BA_InprocessInspecti_1 IMPLEMENTATION.

  METHOD createitem.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZQM_BA_INPROCESSINSPECTION DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZQM_BA_INPROCESSINSPECTION IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
