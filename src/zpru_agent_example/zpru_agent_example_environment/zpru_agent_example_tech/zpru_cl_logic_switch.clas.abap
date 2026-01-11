CLASS zpru_cl_logic_switch DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    CLASS-METHODS set_logic
      IMPORTING iv_dummy_logic TYPE abap_boolean.

    CLASS-METHODS get_logic
      RETURNING VALUE(rv_dummy_logic) TYPE abap_boolean.

  PROTECTED SECTION.
    CLASS-DATA sv_dummy_logic TYPE abap_boolean VALUE abap_true.
ENDCLASS.


CLASS zpru_cl_logic_switch IMPLEMENTATION.
  METHOD get_logic.
    rv_dummy_logic = sv_dummy_logic.
  ENDMETHOD.

  METHOD set_logic.
    sv_dummy_logic = iv_dummy_logic.
  ENDMETHOD.
ENDCLASS.
