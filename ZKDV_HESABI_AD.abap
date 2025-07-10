REPORT ZKDV_HESABI_AD.

DATA: lv_urun_tanimi        TYPE string VALUE 'Bilgisayar',
      lv_net_birim_fiyat    TYPE p DECIMALS 2 VALUE '1000.00',
      lv_urun_sayisi        TYPE i VALUE 8,
      lv_kdv_orani          TYPE p DECIMALS 2 VALUE '0.20',
      lv_toplam_net_fiyat   TYPE p DECIMALS 2,
      lv_kdv_tutari         TYPE p DECIMALS 2,
      lv_toplam_brut_fiyat  TYPE p DECIMALS 2,
      lv_yuzde_kdv_orani    TYPE p DECIMALS 2.

lv_toplam_net_fiyat  = lv_net_birim_fiyat * lv_urun_sayisi.
lv_kdv_tutari        = lv_toplam_net_fiyat * lv_kdv_orani.
lv_toplam_brut_fiyat = lv_toplam_net_fiyat + lv_kdv_tutari.
lv_yuzde_kdv_orani   = lv_kdv_orani * 100.

WRITE: / 'Urun adi        :', 30 'Bilgisayar'.
WRITE: / 'KDV orani(%)    :', 27 lv_yuzde_kdv_orani.
WRITE: / 'Net birim fiyati:', 30 lv_net_birim_fiyat, ' YTL'.
WRITE: / 'Urun sayisi     :', 29 lv_urun_sayisi, ' ADET'.
WRITE: / 'Toplam Net Fiyat:', 30 lv_toplam_net_fiyat, ' YTL'.
WRITE: / 'KDV tutari      :', 30 lv_kdv_tutari, ' YTL'.
WRITE: /.
WRITE: / 'Toplam Brut Fiyat:', 30 lv_toplam_brut_fiyat, ' YTL'.
