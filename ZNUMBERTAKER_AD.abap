REPORT ZNUMBERTAKER_AD.

DATA: lv_number TYPE p LENGTH 16 DECIMALS 9,
      lv_string TYPE string,
      lv_length TYPE i.

lv_number = '123456789.987654321'.
lv_string = |{ lv_number }|.
lv_length = STRLEN( lv_string ).

WRITE: / lv_length.
WRITE: / lv_string.

IF lv_length < 10.
  WRITE / 'Bu sayı kısa'.
ELSE.
  WRITE / 'Bu sayı uzun'.
ENDIF.
