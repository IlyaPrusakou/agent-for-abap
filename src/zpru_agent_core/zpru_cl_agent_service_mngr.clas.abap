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

    CLASS-DATA st_agent_serv TYPE STANDARD TABLE OF zpru_agent_serv WITH EMPTY KEY.

  PRIVATE SECTION.
ENDCLASS.



CLASS zpru_cl_agent_service_mngr IMPLEMENTATION.

  METHOD get_service.
    DATA ls_service TYPE zpru_agent_serv.

    ASSIGN st_agent_serv[ service = iv_service
                          context = iv_context ] TO FIELD-SYMBOL(<ls_agent_serv>).
    IF sy-subrc = 0.
      ls_service = <ls_agent_serv>.
    ELSE.
      SELECT SINGLE *
      FROM zpru_agent_serv
      WHERE service = @iv_service AND
      context = @iv_context
      INTO corRESPONDING FIELDS OF @ls_service.
      IF sy-subrc <> 0.
        RAISE EXCEPTION NEW zpru_cx_agent_core( ).
      ENDIF.

      INSERT ls_service INTO TABLE st_agent_serv.

    ENDIF.

    CREATE OBJECT ro_service TYPE (ls_service-class).
    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW zpru_cx_agent_core( ).
    ENDIF.

  ENDMETHOD.


ENDCLASS.
