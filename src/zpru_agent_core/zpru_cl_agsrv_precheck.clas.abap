CLASS zpru_cl_agsrv_precheck DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zpru_if_agent_frw .
    INTERFACES zpru_if_agsrv_precheck .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpru_cl_agsrv_precheck IMPLEMENTATION.

  METHOD zpru_if_agsrv_precheck~precheck_create_agent_service.
  ENDMETHOD.

  METHOD zpru_if_agsrv_precheck~precheck_update_agent_service.
  ENDMETHOD.

  METHOD zpru_if_agsrv_precheck~precheck_delete_agent_service.
  ENDMETHOD.

  METHOD zpru_if_agsrv_precheck~precheck_read_agent_service.
  ENDMETHOD.

ENDCLASS.
