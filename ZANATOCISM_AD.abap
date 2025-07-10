REPORT ZANATOCISM_AD.

DATA: lv_anapara     TYPE p DECIMALS 2 VALUE '100000',
      lv_faiz_orani  TYPE p DECIMALS 2 VALUE '12',
      lv_sure        TYPE i VALUE 60,
      lv_ay          TYPE i,
      lv_faiz_tutari TYPE p DECIMALS 2.

WRITE: / 'AY', 15 'FAIZ TUTARI (TL)', 35 'YENI ANAPARA (TL)'.
WRITE: / '-------------------------------------------------------------'.

DO lv_sure TIMES.
  lv_ay = sy-index.
  lv_faiz_tutari = ( lv_anapara * lv_faiz_orani ) / 100.
  lv_anapara = lv_anapara + lv_faiz_tutari.

  WRITE: / lv_ay RIGHT-JUSTIFIED,
           lv_faiz_tutari CURRENCY 'TL',
           lv_anapara     CURRENCY 'TL'.
ENDDO.
