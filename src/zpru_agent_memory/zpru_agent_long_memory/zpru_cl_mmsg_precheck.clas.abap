CLASS zpru_cl_mmsg_precheck DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zpru_if_agent_frw.
    INTERFACES zpru_if_mmsg_precheck.
ENDCLASS.

CLASS zpru_cl_mmsg_precheck IMPLEMENTATION.
  METHOD zpru_if_mmsg_precheck~precheck_create_mmsg.
  ENDMETHOD.

  METHOD zpru_if_mmsg_precheck~precheck_update_mmsg.
  ENDMETHOD.

  METHOD zpru_if_mmsg_precheck~precheck_delete_mmsg.
  ENDMETHOD.

  METHOD zpru_if_mmsg_precheck~precheck_read_mmsg.
  ENDMETHOD.
ENDCLASS.
