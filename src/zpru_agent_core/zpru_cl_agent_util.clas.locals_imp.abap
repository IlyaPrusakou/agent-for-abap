*CLASS zpru_cl_json_validation DEFINITION
*  PUBLIC FINAL
*  CREATE PUBLIC.
*
*  PUBLIC SECTION.
*    INTERFACES if_oo_adt_classrun.
*
*    TYPES: BEGIN OF ty_node_info,
*             path  TYPE string, " e.g., /root/user/name
*             value TYPE string,
*             type  TYPE string, " str, num, bool, null
*           END OF ty_node_info,
*           tt_node_info TYPE HASHED TABLE OF ty_node_info WITH UNIQUE KEY path.
*
*    TYPES: BEGIN OF ty_stack_item,
*             name        TYPE string,
*             is_array    TYPE abap_bool,
*             array_index TYPE i,
*           END OF ty_stack_item.
*
*    TYPES tt_stack_item TYPE TABLE OF ty_stack_item WITH EMPTY KEY.
*
*    TYPES: BEGIN OF ts_node_info,
*             node_type   TYPE string,
*             name        TYPE string,
*             value       TYPE string,
*             path_tab    TYPE if_sxml_named=>path,
*             string_path TYPE string,
*           END OF ts_node_info,
*           tt_nodes_tab TYPE STANDARD TABLE OF ts_node_info WITH EMPTY KEY.
*
*    METHODS build_path_string
*      CHANGING cs_node TYPE ts_node_info.
*
*    METHODS test
*      IMPORTING io_type             TYPE REF TO cl_abap_datadescr
*                iv_json_to_validate TYPE string
*      RETURNING VALUE(rv_matches)   TYPE abap_bool.
*
*    METHODS generate_stream
*      IMPORTING iv_json             TYPE string
*
*      RETURNING VALUE(rt_nodes_tab) TYPE tt_nodes_tab.
*ENDCLASS.
*
*
*CLASS zpru_cl_json_validation IMPLEMENTATION.
*  METHOD generate_stream.
*    TYPES tt_pathes TYPE STANDARD TABLE OF if_sxml_named=>pathnode WITH EMPTY KEY.
*
*    TYPES: BEGIN OF ts_xpath,
*             pathes TYPE tt_pathes,
*           END OF ts_xpath.
*
*    TYPES tt_xpath TYPE STANDARD TABLE OF ts_xpath WITH EMPTY KEY.
*
*    TYPES: BEGIN OF path_str,
*             path_qname_name      TYPE string,
*             path_qname_namespace TYPE string,
*             path_prefix          TYPE string,
*             path_child_position  TYPE i,
*           END OF path_str.
*
*    TYPES path_tab TYPE STANDARD TABLE OF path_str WITH EMPTY KEY.
*
*    DATA node_info TYPE ts_node_info.
*    DATA nodes_tab TYPE tt_nodes_tab.
*
*    DATA(lv_json) = iv_json.
*    TRY.
*        DATA(lv_xml_to_parse) = cl_abap_conv_codepage=>create_out( )->convert( lv_json ).
*      CATCH cx_sy_conversion_codepage.
*        RETURN.
*    ENDTRY.
*
*    DATA(lo_reader) = cl_sxml_string_reader=>create( lv_xml_to_parse ).
*
*    TRY.
*        DO.
*          CLEAR node_info.
*          lo_reader->next_node( ).
*
*          IF lo_reader->node_type = if_sxml_node=>co_nt_final.
*            EXIT.
*          ENDIF.
*
*          node_info-node_type = SWITCH #( lo_reader->node_type
*                                          WHEN if_sxml_node=>co_nt_initial       THEN `CO_NT_INITIAL`
*                                          WHEN if_sxml_node=>co_nt_element_open  THEN `CO_NT_ELEMENT_OPEN`
*                                          WHEN if_sxml_node=>co_nt_element_close THEN `CO_NT_ELEMENT_CLOSE`
*                                          WHEN if_sxml_node=>co_nt_value         THEN `CO_NT_VALUE`
*                                          WHEN if_sxml_node=>co_nt_attribute     THEN `CO_NT_ATTRIBUTE`
*                                          ELSE                                        `Error` ).
*          node_info-name      = lo_reader->name.
*          node_info-value     = COND #( WHEN lo_reader->node_type = if_sxml_node=>co_nt_value THEN lo_reader->value ).
*          node_info-path_tab  = lo_reader->get_path( ).
*          APPEND node_info TO nodes_tab.
*
*          IF lo_reader->node_type = if_sxml_node=>co_nt_element_open.
*            DO.
*              lo_reader->next_attribute( ).
*              IF lo_reader->node_type <> if_sxml_node=>co_nt_attribute.
*                EXIT.
*              ENDIF.
*              APPEND VALUE #( node_type = `CO_NT_ATTRIBUTE`
*                              name      = lo_reader->name
*                              value     = lo_reader->value
*                              path_tab  = lo_reader->get_path( ) ) TO nodes_tab.
*            ENDDO.
*          ENDIF.
*        ENDDO.
*      CATCH cx_sxml_parse_error.
*        RETURN.
*    ENDTRY.
*
*    " TODO: variable is assigned but never used (ABAP cleaner)
*    DATA(lv_structure_json) = /ui2/cl_json=>serialize( data = nodes_tab ).
*
*    rt_nodes_tab = nodes_tab.
*  ENDMETHOD.
*
*  METHOD test.
*
*    TYPES: BEGIN OF ty_process_item,
*             json_string TYPE string,
*             target_tab  TYPE REF TO tt_nodes_tab, " tt_nodes_tab is your table of node_info
*           END OF ty_process_item,
*           tt_process_tab TYPE STANDARD TABLE OF ty_process_item WITH EMPTY KEY.
*
*    DATA lt_template_nodes TYPE tt_nodes_tab.
*    DATA lt_input_nodes    TYPE tt_nodes_tab.
*    DATA lr_data           TYPE REF TO data.
*
*    " 1. Create instance of the type and serialize to get the 'Schema JSON'
*    CREATE DATA lr_data TYPE HANDLE io_type.
*
*    " We use /ui2/cl_json to generate the expected JSON structure from the type
*    DATA(lv_template_json) = /ui2/cl_json=>serialize( data = lr_data->* ).
*
**    lt_template_nodes = generate_stream( lv_template_json ).
**    lt_input_nodes = generate_stream( iv_json_to_validate ).
*
*    " 2. Local Helper Logic (Internal table to process both JSON strings)
*    DATA(lt_process) = VALUE tt_process_tab( ( json_string = lv_template_json target_tab = REF #( lt_template_nodes ) )
*                                             ( json_string = iv_json_to_validate target_tab = REF #( lt_input_nodes ) ) ).
*
*    LOOP AT lt_process ASSIGNING FIELD-SYMBOL(<proc>).
*
*      TRY.
*          DATA(lv_xml_to_parse) = cl_abap_conv_codepage=>create_out( )->convert( <proc>-json_string ).
*        CATCH cx_sy_conversion_codepage.
*          RETURN.
*      ENDTRY.
*
*      DATA(lo_reader) = cl_sxml_string_reader=>create( lv_xml_to_parse ).
*      TRY.
*          DO.
*            lo_reader->next_node( ).
*            IF lo_reader->node_type = if_sxml_node=>co_nt_final.
*              EXIT.
*            ENDIF.
*
*            APPEND VALUE #(
*                node_type = SWITCH #( lo_reader->node_type
*                                      WHEN if_sxml_node=>co_nt_element_open  THEN `CO_NT_ELEMENT_OPEN`
*                                      WHEN if_sxml_node=>co_nt_element_close THEN `CO_NT_ELEMENT_CLOSE`
*                                      WHEN if_sxml_node=>co_nt_value         THEN `CO_NT_VALUE`
*                                      WHEN if_sxml_node=>co_nt_attribute     THEN `CO_NT_ATTRIBUTE` )
*                name      = lo_reader->name
*                value     = COND #( WHEN lo_reader->node_type = if_sxml_node=>co_nt_value THEN lo_reader->value )
*                path_tab  = lo_reader->get_path( ) )
*                   TO <proc>-target_tab->*.
*
*            IF lo_reader->node_type = if_sxml_node=>co_nt_element_open.
*              DO.
*                lo_reader->next_attribute( ).
*                IF lo_reader->node_type <> if_sxml_node=>co_nt_attribute.
*                  EXIT.
*                ENDIF.
*                APPEND VALUE #( node_type = `CO_NT_ATTRIBUTE`
*                                name      = lo_reader->name
*                                value     = lo_reader->value
*                                path_tab  = lo_reader->get_path( ) ) TO <proc>-target_tab->*.
*              ENDDO.
*            ENDIF.
*          ENDDO.
*        CATCH cx_sxml_parse_error.
*          rv_matches = abap_false.
*          RETURN.
*      ENDTRY.
*    ENDLOOP.
*
*    LOOP AT lt_template_nodes ASSIGNING FIELD-SYMBOL(<ls_temp>).
*      me->build_path_string(
*        CHANGING
*          cs_node = <ls_temp> ).
*    ENDLOOP.
*
*    LOOP AT lt_input_nodes ASSIGNING FIELD-SYMBOL(<ls_input>).
*      me->build_path_string(
*        CHANGING
*          cs_node = <ls_input> ).
*    ENDLOOP.
*
*    DATA(lv_template_json1) = /ui2/cl_json=>serialize( data = lt_template_nodes ).
*    DATA(lv_input_nodes) = /ui2/cl_json=>serialize( data = lt_input_nodes ).
*
*    " 1. Define a Hashed Table to store the allowed paths
*    TYPES: BEGIN OF ty_schema_map,
*             string_path TYPE string,
*             node_type   TYPE string,
*           END OF ty_schema_map.
*    DATA: lt_schema_map TYPE HASHED TABLE OF ty_schema_map WITH UNIQUE KEY string_path node_type.
*
*    " 2. Load the Template (Schema) into the Hash Map
*    " IMPORTANT: We to_upper the path so that 'field1' matches 'FIELD1'
*    LOOP AT lt_template_nodes ASSIGNING FIELD-SYMBOL(<t>).
*      INSERT VALUE #(
*        string_path = to_upper( <t>-string_path )
*        node_type   = <t>-node_type
*      ) INTO TABLE lt_schema_map.
*    ENDLOOP.
*
*    " 3. Validate the Input against the Schema
*    DATA(lv_is_valid) = abap_true.
*    DATA: lt_errors TYPE TABLE OF string.
*
*    LOOP AT lt_input_nodes ASSIGNING FIELD-SYMBOL(<i>).
*      " We check if this specific path and node type exist in our allowed schema
*      DATA(lv_input_path_upper) = to_upper( <i>-string_path ).
*
*      READ TABLE lt_schema_map WITH TABLE KEY
*        string_path = lv_input_path_upper
*        node_type   = <i>-node_type
*        TRANSPORTING NO FIELDS.
*
*      IF sy-subrc <> 0.
*        " EXCEPTION: sXML adds extra structural nodes for populated arrays.
*        " If the path is '/OBJECT/ARRAY/OBJECT' or '/OBJECT/ARRAY/OBJECT/STR...',
*        " and the parent '/OBJECT/ARRAY[ARRAY1]' exists, we consider it valid structural content.
*        IF lv_input_path_upper CS '/ARRAY/OBJECT'.
*          CONTINUE.
*        ENDIF.
*
*        lv_is_valid = abap_false.
*        APPEND |Unexpected node or path: { <i>-string_path } [{ <i>-node_type }]| TO lt_errors.
*      ENDIF.
*    ENDLOOP.
*
*  ENDMETHOD.
*
*  METHOD if_oo_adt_classrun~main.
*
*    " 1. The innermost object for nested_object2
*    TYPES: BEGIN OF ty_nested_obj_level2,
*             field4 TYPE string,
*           END OF ty_nested_obj_level2.
*
*    " 2. The wrapper for nested_object1
*    TYPES: BEGIN OF ty_nested_obj_level1,
*             nested_object2 TYPE ty_nested_obj_level2,
*           END OF ty_nested_obj_level1.
*
*    " 3. The object inside the array
*    TYPES: BEGIN OF ty_array_item,
*             field2 TYPE string,
*           END OF ty_array_item,
*           tt_array1 TYPE STANDARD TABLE OF ty_array_item WITH EMPTY KEY.
*
*    " 4. The root object
*    TYPES: BEGIN OF ty_json_root,
*             field1         TYPE string,
*             array1         TYPE tt_array1,
*             field3         TYPE string,
*             nested_object1 TYPE ty_nested_obj_level1,
*             field5         TYPE string,
*           END OF ty_json_root.
*
*    DATA ls_json_root TYPE ty_json_root.
*
*    DATA lo_type      TYPE REF TO cl_abap_datadescr.
*
*    lo_type ?= cl_abap_datadescr=>describe_by_data( p_data = ls_json_root ).
*
*    DATA(lv_json) = |\{ "field1" : "value1", "array1" : [ \{ "field2" : "value2"  \} ], "field3" : "value3", "nested_object1" : \{ "nested_object2" : \{ "field4" : "value4" \} \}, "field5" : "value5" \} |.
*
*    me->test(
*      EXPORTING
*        io_type             = lo_type
*        iv_json_to_validate = lv_json
*      RECEIVING
*        rv_matches          = DATA(lv_matches)
*    ).
*
*
*
*
*  ENDMETHOD.
*
*  METHOD build_path_string.
*cs_node-string_path = ``.
*
*    " Track logical indices for each depth level
*    " You might want to define this as a member variable if you want
*    " it to persist correctly across the entire parsing session.
*    types: BEGIN OF ty_level_counter,
*               depth TYPE i,
*               pos   TYPE i,
*               index TYPE i,
*             END OF ty_level_counter.
*            data lt_counters TYPE HASHED TABLE OF ty_level_counter WITH UNIQUE KEY depth pos.
*
*    LOOP AT cs_node-path_tab INTO DATA(ls_path_node).
*      DATA(lv_depth) = sy-tabix.
*
*      " 1. Add basic tag name
*      cs_node-string_path = cs_node-string_path && `/` && ls_path_node-qname-name.
*
*      " 2. Handle Indexing for Array Elements
*      IF lv_depth > 1.
*        DATA(lv_parent_idx) = lv_depth - 1.
*        IF cs_node-path_tab[ lv_parent_idx ]-qname-name = 'array'.
*
*          " Use a logical counter instead of sXML position
*          READ TABLE lt_counters ASSIGNING FIELD-SYMBOL(<ls_count>)
*            WITH TABLE KEY depth = lv_depth pos = ls_path_node-child_position.
*
*          IF sy-subrc <> 0.
*            " If this is a new child_position at this depth, it's a new element
*            " We count how many unique child_positions we've seen at this depth
*            DATA(lv_current_index) = 0.
*            LOOP AT lt_counters TRANSPORTING NO FIELDS WHERE depth = lv_depth.
*              lv_current_index = lv_current_index + 1.
*            ENDLOOP.
*            lv_current_index = lv_current_index + 1.
*
*            INSERT VALUE #( depth = lv_depth pos = ls_path_node-child_position index = lv_current_index )
*                   INTO TABLE lt_counters ASSIGNING <ls_count>.
*          ENDIF.
*
*          cs_node-string_path = cs_node-string_path && `[` && |{ <ls_count>-index }| && `]`.
*        ENDIF.
*      ENDIF.
*    ENDLOOP.
*
*    " 3. Append JSON key name
*    IF cs_node-node_type = 'CO_NT_ATTRIBUTE' AND cs_node-name = 'name'.
*      cs_node-string_path = cs_node-string_path && `(` && cs_node-value && `)`.
*    ENDIF.
*
*    " 3. Handle Field Names (Attributes)
*    IF cs_node-node_type = 'CO_NT_ATTRIBUTE' AND cs_node-name = 'name'.
*      " Use round brackets to separate the Key Name from the Array Index
*      cs_node-string_path = cs_node-string_path && `(` && cs_node-value && `)`.
*    ENDIF.
*
**    " Inside your loop, after getting node_info-path_tab:
**    cs_node-string_path = ``.
**    LOOP AT cs_node-path_tab INTO DATA(ls_path_node).
**      cs_node-string_path = cs_node-string_path && `/` && ls_path_node-qname-name.
**    ENDLOOP.
**
**    " If it's a field name (Attribute 'name'), we append the actual field name to the path
**    IF  cs_node-node_type = 'CO_NT_ATTRIBUTE' AND   cs_node-name = 'name'.
**      cs_node-string_path = cs_node-string_path && `[` && cs_node-value && `]`.
**    ENDIF.
*  ENDMETHOD.
*ENDCLASS.
