CLASS zcl_salesorder_header DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit.
    INTERFACES if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SALESORDER_HEADER IMPLEMENTATION.


    METHOD if_sadl_exit_calc_element_read~calculate.

        "--------------------------------------------------
        " 1. Only run if FILECONTENT is requested
        "--------------------------------------------------
        DATA(lv_filecontent_requested) = abap_false.

        LOOP AT it_requested_calc_elements INTO DATA(lv_req).
          IF lv_req = 'FILECONTENT'.
            lv_filecontent_requested = abap_true.
            EXIT.
          ENDIF.
        ENDLOOP.

        IF lv_filecontent_requested = abap_false.
          RETURN.
        ENDIF.

        "--------------------------------------------------
        " 2. Loop original data
        "--------------------------------------------------
        LOOP AT it_original_data ASSIGNING FIELD-SYMBOL(<original>).

          DATA(ls_original) = CORRESPONDING zc_salesorder_header( <original> ).

          READ TABLE ct_calculated_data ASSIGNING FIELD-SYMBOL(<calculated>) INDEX sy-tabix.
          IF sy-subrc <> 0.
            CONTINUE.
          ENDIF.

          "--------------------------------------------------
          " 3. Assign fields
          "--------------------------------------------------
          ASSIGN COMPONENT 'FILECONTENT' OF STRUCTURE <calculated> TO FIELD-SYMBOL(<content>).
          ASSIGN COMPONENT 'MIMETYPE'   OF STRUCTURE <calculated> TO FIELD-SYMBOL(<mime>).
          ASSIGN COMPONENT 'FILENAME'   OF STRUCTURE <calculated> TO FIELD-SYMBOL(<fname>).

          "--------------------------------------------------
          " 4. Set static fields
          "--------------------------------------------------
          IF <mime> IS ASSIGNED.
            <mime> = 'application/pdf'.
          ENDIF.

          IF <fname> IS ASSIGNED.
            <fname> = |SalesOrder_{ ls_original-SalesOrder }.pdf|.
          ENDIF.

          " IMPORTANT: Do NOT generate PDF here
*          IF <content> IS ASSIGNED.
*            CLEAR <content>.  " keep empty
*          ENDIF.

          "--------------------------------------------------
          " 5. Generate PDF ONLY if needed
          "--------------------------------------------------
          IF <content> IS ASSIGNED AND <content> IS INITIAL.

            TRY.

                "-----------------------------
                " ADS: Get Layout
                "-----------------------------
                DATA(lo_reader) = cl_fp_form_reader=>create_form_reader( 'ZF_SALESORDER_ITEMS' ).
                DATA(lv_xdp_layout) = lo_reader->get_layout( ).

                "-----------------------------
                " FDP Service
                "-----------------------------
                DATA(lo_fdp_util) = cl_fp_fdp_services=>get_instance(
                     iv_service_definition = 'ZUI_SALESORDER_HEADER'
                     iv_root_node          = 'ZC_SALESORDER_HEADER_ADS'
                ).

                "-----------------------------
                " Prepare Key
                "-----------------------------
                DATA lv_so_key TYPE string.
                lv_so_key = |{ ls_original-SalesOrder }|.

                DATA lt_keys TYPE if_fp_fdp_api=>tt_select_keys.

                lt_keys = VALUE #(
                  ( name      = 'SALESORDER'
                    value     = lv_so_key
                    data_type = 'VBELN'
                  )
                ).

                "-----------------------------
                " Get XML
                "-----------------------------
                DATA(lv_xml_data) = lo_fdp_util->read_to_xml_v2( lt_keys ).
                DATA lv_xml_string TYPE string.
                lv_xml_string = cl_abap_conv_codepage=>create_in( )->convert( lv_xml_data ).

                IF lv_xml_data IS INITIAL.
                  CONTINUE.
                ENDIF.

                "-----------------------------
                " Render PDF
                "-----------------------------
                cl_fp_ads_util=>render_pdf(
                  EXPORTING
                    iv_xml_data   = lv_xml_data
                    iv_xdp_layout = lv_xdp_layout
                    iv_locale     = 'en_US'
                  IMPORTING
                    ev_pdf        = DATA(lv_pdf)
                ).

                "-----------------------------
                " Assign PDF
                "-----------------------------
                <content> = lv_pdf.

                CATCH cx_fp_fdp_error INTO DATA(lx_fdp).
                  DATA(lv_msg) = lx_fdp->get_text( ).

                CATCH cx_root INTO DATA(lx_root).
                  DATA(lv_msg2) = lx_root->get_text( ).
                  CONTINUE.
            ENDTRY.

          ENDIF.

        ENDLOOP.

      ENDMETHOD.


    METHOD if_sadl_exit_calc_element_read~get_calculation_info.        " It is used to fetch the required data for calculation

        "Loop over all virtual fields requested by UI (like fileContent, fileName, etc.)
        LOOP AT it_requested_calc_elements REFERENCE INTO DATA(lr_element).

            CASE lr_element->*.
                " If any of these virtual fields are requested

               WHEN 'FILECONTENT' OR 'MIMETYPE' OR 'FILENAME'.
                " Tell CDS/SADL:
                " "I need SalesOrder field from DB to calculate these virtual fields"
                " Without this, SalesOrder will be EMPTY in calculate method
                DATA lv_field TYPE string.
                lv_field = 'SALESORDER'.

                INSERT lv_field INTO TABLE et_requested_orig_elements.

            ENDCASE.

      ENDLOOP.
    ENDMETHOD.
ENDCLASS.
