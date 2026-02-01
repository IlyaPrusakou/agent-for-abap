CLASS zpru_cl_mmsg_service DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zpru_if_agent_frw.
    INTERFACES zpru_if_mmsg_service.
ENDCLASS.

CLASS zpru_cl_mmsg_service IMPLEMENTATION.
  METHOD zpru_if_mmsg_service~query_mmsg.
  ENDMETHOD.

  METHOD zpru_if_mmsg_service~read_mmsg.
  ENDMETHOD.

  METHOD zpru_if_mmsg_service~create_mmsg.
  ENDMETHOD.

  METHOD zpru_if_mmsg_service~update_mmsg.
  ENDMETHOD.

  METHOD zpru_if_mmsg_service~delete_mmsg.
  ENDMETHOD.

  METHOD zpru_if_mmsg_service~determine.
  ENDMETHOD.

  METHOD zpru_if_mmsg_service~validate.
  ENDMETHOD.

  METHOD zpru_if_mmsg_service~clean_up.
  ENDMETHOD.

  METHOD zpru_if_mmsg_service~do_save.
  ENDMETHOD.
ENDCLASS.
