CLASS zpru_cl_agty_service DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zpru_if_agent_frw .
    INTERFACES zpru_if_agty_service .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpru_cl_agty_service IMPLEMENTATION.


  METHOD zpru_if_agty_service~clean_up.
  ENDMETHOD.


  METHOD zpru_if_agty_service~create_agent_type.
  ENDMETHOD.


  METHOD zpru_if_agty_service~delete_agent_type.
  ENDMETHOD.


  METHOD zpru_if_agty_service~determine.
  ENDMETHOD.


  METHOD zpru_if_agty_service~do_save.
  ENDMETHOD.


  METHOD zpru_if_agty_service~query_agent_type.
  ENDMETHOD.


  METHOD zpru_if_agty_service~read_agent_type.
  ENDMETHOD.


  METHOD zpru_if_agty_service~update_agent_type.
  ENDMETHOD.


  METHOD zpru_if_agty_service~validate.
  ENDMETHOD.
ENDCLASS.
