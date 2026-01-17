CLASS zpru_cl_agent_service_mngr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zpru_if_agent_frw.
    CLASS-METHODS get_service
      IMPORTING
                iv_service        TYPE zpru_de_seoclname
                iv_context        TYPE char100
      RETURNING
                VALUE(ro_service) TYPE REF TO zpru_if_agent_frw
      RAISING   zpru_cx_agent_core.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpru_cl_agent_service_mngr IMPLEMENTATION.

  METHOD get_service.

    SELECT SINGLE * FROM zpru_agent_serv
    WHERE service = @iv_service AND
    context = @iv_context
    INTO @DATA(ls_service).
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW zpru_cx_agent_core( ).
    ENDIF.

    CREATE OBJECT ro_service TYPE (ls_service-class).
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW zpru_cx_agent_core( ).
    ENDIF.

  ENDMETHOD.


ENDCLASS.
