CLASS zpru_cl_agsrv_service DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zpru_if_agent_frw .
    INTERFACES zpru_if_agsrv_service .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpru_cl_agsrv_service IMPLEMENTATION.

  METHOD zpru_if_agsrv_service~query_agent_service.
  ENDMETHOD.

  METHOD zpru_if_agsrv_service~read_agent_service.
  ENDMETHOD.

  METHOD zpru_if_agsrv_service~create_agent_service.
  ENDMETHOD.

  METHOD zpru_if_agsrv_service~update_agent_service.
  ENDMETHOD.

  METHOD zpru_if_agsrv_service~delete_agent_service.
  ENDMETHOD.

  METHOD zpru_if_agsrv_service~determine.
  ENDMETHOD.

  METHOD zpru_if_agsrv_service~validate.
  ENDMETHOD.

  METHOD zpru_if_agsrv_service~clean_up.
  ENDMETHOD.

  METHOD zpru_if_agsrv_service~do_save.
  ENDMETHOD.

ENDCLASS.
