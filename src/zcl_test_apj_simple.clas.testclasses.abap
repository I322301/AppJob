*"* use this source file for your ABAP unit test classes

class zcl_test_apj_simple_tester definition for testing
duration medium
risk level harmless.

  public section.

  private section.

*    types tty_dq_rules type standard table of i_mdqualitybusinessruletp with default key.
*    types tty_imports type standard table of i_mdqualityruleimporttp with default key.
*    types tty_usages type standard table of i_mdqltybusinessruleusagetp with default key.
*    types tty_imported_rules type standard table of i_mdqualityimportedruletp with default key.
*    types tty_mdq_scoreruleres type standard table of mdq_scoreruleres with default key.
*
*    aliases lc_rule_import_uuid for lif_test_data~lc_rule_import_uuid.
*    aliases lc_rule_uuids for lif_test_data~lc_rule_uuids.
*
*    class-data mo_osql_test_environment type ref to if_osql_test_environment.

    data f_cut type ref to zcl_test_apj_simple.

    class-methods class_setup.
    class-methods class_teardown.

    methods setup.
    methods teardown.

*    methods gen_rul_from_scratch for testing.
*    methods gen_rul_a_sec_time for testing.
*    methods gen_rul_a_sec_time_no_rul for testing.
*    methods gen_rul_validation_exc for testing.
*    methods get_rules for testing.
*    methods enable_rules for testing.
*
**    methods delete_rules_not_present for testing.
**    methods delete_rules_present for testing.
*    methods delete_rules_no_rules_present for testing.
*    methods delete_rules_approved for testing.
*    methods delete_rules_new for testing.
*    methods delete_rules_mix for testing.
*    methods delete_rules_error for testing.
*
*    methods delete_evaluation_data for testing.
*
*    methods get_log_messages for testing.
*    methods get_log_handler for testing.
*    methods schedule_evaluation_job for testing raising cx_static_check.
*    methods schedule_evaluation_job_fail for testing raising cx_static_check.

*    methods job_exec_del_suc_gen_suc for testing.
*    methods job_exec_del_suc_gen_fail for testing.
    methods job_exec_del_fail_gen_suc for testing.
*    methods job_exec_del_fail_gen_fail for testing.

endclass.

class zcl_test_apj_simple_tester implementation.

  method class_setup.

  endmethod.

  method class_teardown.
*    mo_osql_test_environment->destroy( ).
  endmethod.

  method setup.
    f_cut = new ZCL_TEST_APJ_SIMPLE( ).
  endmethod.

  method teardown.
*    mo_osql_test_environment->clear_doubles( ).
    clear f_cut.
  endmethod.

  method job_exec_del_fail_gen_suc.

*    f_cut->execute( ).

*    cl_abap_unit_assert=>assert_subrc( 0 ).

  endmethod.


endclass.
