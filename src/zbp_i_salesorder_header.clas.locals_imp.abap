CLASS lhc_ZI_SALESORDER_HEADER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_salesorder_header RESULT result.

    METHODS read FOR READ
      IMPORTING keys FOR READ zi_salesorder_header RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zi_salesorder_header.

    METHODS rba_Item FOR READ
      IMPORTING keys_rba FOR READ zi_salesorder_header\_Item FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_ZI_SALESORDER_HEADER IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Item.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZI_SALESORDER_ITEMS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS read FOR READ
      IMPORTING keys FOR READ zi_salesorder_items RESULT result.

    METHODS rba_Header FOR READ
      IMPORTING keys_rba FOR READ zi_salesorder_items\_Header FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_ZI_SALESORDER_ITEMS IMPLEMENTATION.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Header.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_SALESORDER_HEADER DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_SALESORDER_HEADER IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
