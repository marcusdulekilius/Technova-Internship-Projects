REPORT ZITEM_LIST_AD.

PARAMETERS: p_objid TYPE crmt_object_id_db.

TYPES: BEGIN OF ty_header_guid,
         guid   TYPE crmd_orderadm_h-guid,
         header TYPE crmd_orderadm_i-header,
       END OF ty_header_guid.

DATA: it_result TYPE TABLE OF ty_header_guid,
      wa_result TYPE ty_header_guid.

START-OF-SELECTION.

  SELECT h~guid, i~header
    FROM crmd_orderadm_h AS h
    INNER JOIN crmd_orderadm_i AS i
      ON h~guid = i~header
    INTO TABLE @it_result
    WHERE h~object_id = @p_objid.

  IF it_result IS INITIAL.
    WRITE: / 'Ne header ne guid bulunamadı:', p_objid.
  ELSE.
    LOOP AT it_result INTO wa_result.
      WRITE: / 'GUID:',   wa_result-guid,
             'HEADER:', wa_result-header.
    ENDLOOP.
  ENDIF.
