CLASS zcl_test_apj_template_gen DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_test_apj_template_gen IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    CONSTANTS lc_catalog_name      TYPE cl_apj_dt_create_content=>ty_catalog_name  VALUE 'ZTEST_MY_SIMPLE_JOB'.
    CONSTANTS lc_catalog_text      TYPE cl_apj_dt_create_content=>ty_text          VALUE 'My first simple application job'.
    CONSTANTS lc_class_name        TYPE cl_apj_dt_create_content=>ty_class_name    VALUE 'ZCL_TEST_APJ_DEFINITION'.

    CONSTANTS lc_template_name     TYPE cl_apj_dt_create_content=>ty_template_name VALUE 'ZTEST_EMAIL_TEMPL'.
    CONSTANTS lc_template_text     TYPE cl_apj_dt_create_content=>ty_text          VALUE 'Test Email Template 1'.

    CONSTANTS lc_transport_request TYPE cl_apj_dt_create_content=>ty_transport_request VALUE 'X08K900084'.
    CONSTANTS lc_package           TYPE cl_apj_dt_create_content=>ty_package           VALUE 'Z_TEST_APPLICATION_JOBS'.

    DATA(lo_dt) = cl_apj_dt_create_content=>get_instance( ).

    " Create job catalog entry (corresponds to the former report incl. selection parameters)
    " Provided implementation class iv_class_name shall implement two interfaces:
    " - if_apj_dt_exec_object to provide the definition of all supported selection parameters of the job
    "   (corresponds to the former report selection parameters) and to provide the actual default values
    " - if_apj_rt_exec_object to implement the job execution
    TRY.
*        lo_dt->create_job_cat_entry(
*            iv_catalog_name       = lc_catalog_name
*            iv_class_name         = lc_class_name
*            iv_text               = lc_catalog_text
*            iv_catalog_entry_type = cl_apj_dt_create_content=>class_based
*            iv_transport_request  = lc_transport_request
*            iv_package            = lc_package
*        ).
*        out->write( |Job catalog entry created successfully| ).

        lo_dt->delete_job_cat_entry( iv_catalog_name = lc_catalog_name
                                     iv_transport_request = lc_transport_request ).
        out->write( |Job catalog entry deleted| ).

      CATCH cx_apj_dt_content INTO DATA(lx_apj_dt_content).
        out->write( |Creation of job catalog entry failed: { lx_apj_dt_content->get_text( ) }| ).
    ENDTRY.

    " Create job template (corresponds to the former system selection variant) which is mandatory
    " to select the job later on in the Fiori app to schedule the job
    DATA lt_parameters TYPE if_apj_dt_exec_object=>tt_templ_val.

    NEW zcl_test_apj_simple( )->if_apj_dt_exec_object~get_parameters(
      IMPORTING
        et_parameter_val = lt_parameters
    ).

    TRY.
*        lo_dt->create_job_template_entry(
*            iv_template_name     = lc_template_name
*            iv_catalog_name      = lc_catalog_name
*            iv_text              = lc_template_text
*            it_parameters        = lt_parameters
*            iv_transport_request = lc_transport_request
*            iv_package           = lc_package
*        ).
*        out->write( |Job template created successfully| ).
        data(is_success) = lo_dt->delete_job_template_entry(
            iv_template_name = lc_template_name
            iv_transport_request = lc_transport_request
        ).
        IF is_success EQ 'X'.
         out->write( |Job template deleted| ).
        ELSE.
          out->write( |Job template was not deleted| ).
        ENDIF.
      CATCH cx_apj_dt_content INTO lx_apj_dt_content.
        out->write( |Creation of job template failed: { lx_apj_dt_content->get_text( ) }| ).
        RETURN.
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
