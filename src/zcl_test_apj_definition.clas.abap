CLASS zcl_test_apj_definition DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_apj_dt_exec_object.
    INTERFACES if_apj_rt_exec_object.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_test_apj_definition IMPLEMENTATION.

  METHOD if_apj_dt_exec_object~get_parameters.

    " Return the supported selection parameters here
    et_parameter_def = VALUE #(
      ( selname = 'S_ID'    kind = if_apj_dt_exec_object=>select_option datatype = 'C' length = 10 param_text = 'My ID'                                      changeable_ind = abap_true )
      ( selname = 'P_DESCR' kind = if_apj_dt_exec_object=>parameter     datatype = 'C' length = 80 param_text = 'My Description'   lowercase_ind = abap_true changeable_ind = abap_true )
      ( selname = 'P_COUNT' kind = if_apj_dt_exec_object=>parameter     datatype = 'I' length = 10 param_text = 'My Count'                                   changeable_ind = abap_true )
      ( selname = 'P_SIMUL' kind = if_apj_dt_exec_object=>parameter     datatype = 'C' length =  1 param_text = 'My Simulate Only' checkbox_ind = abap_true  changeable_ind = abap_true )
    ).

    " Return the default parameters values here
    et_parameter_val = VALUE #(
      ( selname = 'S_ID'    kind = if_apj_dt_exec_object=>select_option sign = 'I' option = 'EQ' low = '4711' )
      ( selname = 'P_DESCR' kind = if_apj_dt_exec_object=>parameter     sign = 'I' option = 'EQ' low = 'My Default Description' )
      ( selname = 'P_COUNT' kind = if_apj_dt_exec_object=>parameter     sign = 'I' option = 'EQ' low = '200' )
      ( selname = 'P_SIMUL' kind = if_apj_dt_exec_object=>parameter     sign = 'I' option = 'EQ' low = abap_true )
    ).

  ENDMETHOD.

  METHOD if_apj_rt_exec_object~execute.

    TYPES ty_id TYPE c LENGTH 10.

    DATA s_id    TYPE RANGE OF ty_id.
    DATA p_descr TYPE c LENGTH 80.
    DATA p_count TYPE i.
    DATA p_simul TYPE abap_boolean.
    data(lv_content)      = |<p>Hi Recipient</p>| &
          |<p> Job executed with ZCL_TEST_APJ_SIMPLE in X08 on { cl_abap_context_info=>get_system_date( ) } at { cl_abap_context_info=>get_system_time( ) } </p>| &
          |<p> With parameters:  </p>|.
    " Getting the actual parameter values
    LOOP AT it_parameters INTO DATA(ls_parameter).
*      CASE ls_parameter-selname.
*        WHEN 'S_ID'.
*          APPEND VALUE #( sign   = ls_parameter-sign
*                          option = ls_parameter-option
*                          low    = ls_parameter-low
*                          high   = ls_parameter-high ) TO s_id.
*        WHEN 'P_DESCR'. p_descr = ls_parameter-low.
*        WHEN 'P_COUNT'. p_count = ls_parameter-low.
*        WHEN 'P_SIMUL'. p_simul = ls_parameter-low.
*      ENDCASE.


*    DATA(lv_time) =  cl_abap_context_info=>get_system_time( ) + 120.
*    WHILE ( cl_abap_context_info=>get_system_time( ) LE lv_time ).
*    ENDWHILE.
        lv_content = lv_content && |<p> Name: { ls_parameter-selname }  Value: { ls_parameter-low } </p>| .

        ENDLOOP.
        TRY.
    " Implement the job execution
        data(lo_mail) = cl_bcs_mail_message=>create_instance( ).
*        lo_mail->add_attachment( cl_bcs_mail_textpart=>create_instance(
*          iv_content      = |This is your bonus: { i_bonus_calculation-ActualRevenueAmount_V } { i_bonus_calculation-ActualRevenueAmount_C }|
*          iv_content_type = 'text/plain'
*          iv_filename     = 'Text_Attachment.txt'
*        ) ).
*    DATA(lv_sender) = iv_sender.
*    lo_mail->set_sender( CONV #( lv_sender ) ).
            lo_mail->set_sender( 'noreply+itapc@sap.com' ).


*        LOOP AT it_receivers INTO DATA(lv_email_address).

          lo_mail->add_recipient( 'mani.p.s@sap.com' ).
*          lo_mail->add_recipient( 'sachin.b@sap.com' ).
*          lo_mail->add_recipient( 'ingo.braeuninger@sap.com' ).

*        ENDLOOP.

        lo_mail->set_subject( 'Test application job' ).

        lo_mail->set_main( cl_bcs_mail_textpart=>create_instance(
          iv_content = lv_content
          iv_content_type = 'text/html'
        ) ).
        lo_mail->send( IMPORTING et_status = DATA(lt_status) ).
      CATCH cx_bcs_mail INTO DATA(lx_mailer).
        DATA(lx_mailer_data) = lx_mailer->get_longtext( ).
*        rv_success = abap_false.
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
