process VTALARM_TRA =
     ( ? event HE;
     )
   pragmas 
      Main
   end pragmas
   (| (| ^HE ^= HE
       | HE ^= HE
       | ACT_HE{}
       |) |)
   where 
   constant integer M1 = 5;
   constant integer M2 = 2;
   constant integer PS = 20;
   constant integer PISET = 5;
   constant integer NAL = 16;
   constant integer BELLPI = 4;
   constant integer ALNB = 150;
   constant integer PERCENT = 30;
   constant integer PM_STR = 5;
   constant integer AL_STR = 3;
   constant integer CH_STR = 4;
   constant integer TICK_WIDTH = 8;
   constant boolean V0 = false;
   constant boolean V0_459 = false;
   constant boolean V_0 = false;
   constant integer P = 24;
   constant integer V_0_616 = 0;
   constant integer V_0_729 = 4;
   constant boolean V_0_798 = false;
   constant boolean V_0_899 = false;
   constant boolean V_0_966 = false;
   constant integer N = 1;
   constant integer V_0_1029 = 0;
   constant integer V_0_1071 = 0;
   constant integer V_0_1149 = 0;
   constant integer V_0_1190 = 0;
   constant integer P_1263 = 60;
   constant integer V_0_1294 = 0;
   constant integer V_0_1406 = 4;
   constant boolean V_0_1476 = false;
   constant integer V_MODULO = 3;
   constant integer V_0_1592 = 0;
   constant boolean V0_1773 = false;
   constant integer V_0_1852 = 19;
   constant integer V_MODULO_1878 = 24;
   constant integer V_0_1879 = 23;
   constant integer V_MODULO_1906 = 60;
   constant integer V_0_1907 = 59;
   constant boolean V0_2013 = false;
   constant integer V_0_2095 = 1;
   constant integer V_0_2199 = 4;
   constant integer V_0_2253 = 1;
   constant integer DTIME_X = 56;
   constant integer DMTIME_Y = 80;
   constant integer DTAG_Y = 40;
   constant integer DLWTIME_Y = 24;
   constant integer X = 80;
   constant integer X_POS = 40;
   constant integer Y_POS = 72;
   constant integer DX = 16;
   constant integer X_2577 = 80;
   constant integer DX_2626 = 24;
   constant integer Y_POS_2664 = 56;
   constant integer DX_2667 = 24;
   constant integer DX_2703 = 32;
   constant integer DY = 16;
   process ACT_HE =
        ( )
      (| HE ^= AUTOMOD ^= C_UP ^= C_DOWN ^= C_AUTO
       | (| CLK_MAX := when AUTOMOD
          | CLK_MAX ^= ZMAX
          | ACT_CLK_MAX{}
          | CLK_1178 := when (not AUTOMOD)
          |)
       | (| UP0_1973 := when C_UP |)
       | (| DOWN_2000 := when C_DOWN |)
       | (| CLK_CAUTO := when C_AUTO
          | CLK_CAUTO ^= CAUTO
          | ACT_CLK_CAUTO{}
          |)
       | (| HSTOP_1974 := CLK_1178 ^* DOWN_2000
          | (| WSTOP(HSTOP_1974) |)
          |)
       | (| CLK_VD := CLK_MAX ^* DOWN_2000
          | CLK_VD ^= VD
          | (| VD := (ZMAX+ZMAX) when CLK_VD |)
          |)
       | (| UPS_1971 := CLK_MAX ^* UP0_1973 |)
       | (| CLK_VU := UPS_1971 ^* CLK_1226
          | CLK_VU ^= VU
          | (| VU := (ZMAX/2) when CLK_VU |)
          |)
       | (| CLK_1608 := CLK_VD ^+ CLK_VU |)
       | (| CLK_V1 := UP0_1973 ^+ HES_2060
          | ACT_CLK_V1{}
          |)
       | (| CLK_1636 := CLK_VD ^- CLK_VU |)
       | (| CLK_1639 := CLK_MAX ^- CLK_1608 |)
       | (| AUTOMOD := (CAUTO when CLK_CAUTO) cell HE init false
          | C_UP := RUP()
          | C_DOWN := RDOWN()
          | C_AUTO := RAUTO()
          |)
       |)
      where 
      event CLK_1639, CLK_1636, CLK_V1, CLK_1608, CLK_VU, UPS_1971, CLK_VD, HSTOP_1974, HES_2060, CLK_1226, CLK_CAUTO, DOWN_2000, UP0_1973, CLK_1178, CLK_MAX;
      integer VU, VD, ZMAX;
      boolean AUTOMOD, CAUTO, C_UP, C_DOWN, C_AUTO;
      process ACT_CLK_MAX =
           ( )
         (| CLK_MAX ^= MAX ^= V_2090 ^= ZV_2102
          | (| CLK_1226 := when (ZMAX>1) |)
          | (| HES_2060 := when (ZV_2102>=(MAX-1))
             | CLK_1249 := when (not (ZV_2102>=(MAX-1)))
             |)
          | (| MAX := (VU when CLK_VU) default (VD when CLK_1636) default (ZMAX when CLK_1639)
             | ZMAX := MAX$1 init 20
             | V_2090 := (0 when HES_2060) default ((ZV_2102+1) when CLK_1249)
             | ZV_2102 := V_2090$1 init 1
             |)
          |)
         where 
         event CLK_1249;
         integer MAX, V_2090, ZV_2102;
         end
      %ACT_CLK_MAX%; 
      process ACT_CLK_CAUTO =
           ( )
         (| CLK_CAUTO ^= ZB_2017
          | (| CAUTO := not ZB_2017
             | ZB_2017 := CAUTO$1 init V0_2013
             |)
          |)
         where 
         boolean ZB_2017;
         end
      %ACT_CLK_CAUTO%; 
      process ACT_CLK_V1 =
           ( )
         (| CLK_V1 ^= V1 ^= ZV_2205
          | (| CLK_WDIS := when (ZV_2205>=4)
             | ACT_CLK_WDIS{}
             | CLK_1310 := when (not (ZV_2205>=4))
             |)
          | (| V1 := (0 when CLK_WDIS) default ((ZV_2205+1) when CLK_1310)
             | ZV_2205 := V1$1 init 4
             |)
          |)
         where 
         event CLK_1310, CLK_WDIS;
         integer V1, ZV_2205;
         process ACT_CLK_WDIS =
              ( )
            (| CLK_WDIS ^= WDIS ^= ADIS ^= SWDIS ^= STNB ^= CST ^= NRINGING ^= CRINGING ^= LR_2216 ^= UR_2224 ^= V2 ^= ZV_2259
             | (| CLK_ZMODE := when ADIS
                | CLK_ZMODE ^= ZMODE
                | ACT_CLK_ZMODE{}
                |)
             | (| CLK_928 := when SWDIS |)
             | (| CLK_ZMODE_1812 := when WDIS
                | CLK_ZMODE_1812 ^= ZMODE_1812
                | ACT_CLK_ZMODE_1812{}
                |)
             | (| UR_1958 := when UR_2224 |)
             | (| LR_1959 := when LR_2216 |)
             | (| CLK_CSTATE := when (ZV_2259>=1)
                | ACT_CLK_CSTATE{}
                | CLK_1333 := when (not (ZV_2259>=1))
                |)
             | (| CLK_XZX_2153 := UR_1958 ^+ CLK_XZX_2143
                | ACT_CLK_XZX_2153{}
                |)
             | (| CLK_RINGING := CLK_XZX_2153 ^+ LR_1959
                | ACT_CLK_RINGING{}
                |)
             | (| SUR_160 := CLK_990 ^* SUR_72 |)
             | (| SLL_159 := CLK_990 ^* SLL_71 |)
             | (| SUL_158 := CLK_990 ^* SUL_70 |)
             | (| CLK_1645 := LR_1959 ^- CLK_XZX_2153 |)
             | (| CLK_1647 := UR_1958 ^- CLK_XZX_2143 |)
             | (| CLK_WMODONOFF := CLK_ZMODE_1812 ^* SUL_158
                | CLK_WMODONOFF ^= WMODONOFF
                | ACT_CLK_WMODONOFF{}
                |)
             | (| CLK_MODONOFF := CLK_ZMODE ^* SUL_158
                | CLK_MODONOFF ^= MODONOFF
                | (| MODONOFF := (not ZMODE) when CLK_MODONOFF |)
                |)
             | (| WOFF := SLL_159 ^* CLK_1087 |)
             | (| OFF_165 := CLK_928 ^* SLL_159 |)
             | (| SLL_315 := SLL_159 ^* CLK_238 |)
             | (| AOFF_162 := SLL_159 ^* CLK_239 |)
             | (| SUR_316 := CLK_ZMODE ^* SUR_160 |)
             | (| WLR_1736 := CLK_ZMODE_1812 ^* SLR_161 |)
             | (| SLR_317 := CLK_ZMODE ^* SLR_161 |)
             | (| CLK_1779 := SUR_316 ^+ SLR_317 |)
             | (| CLK_1788 := AOFF_162 ^+ WLR_1736 |)
             | (| CLK_1792 := SLL_315 ^+ CLK_1779 |)
             | (| CLK_1796 := WOFF ^+ OFF_165 |)
             | (| CLK_NST := CLK_1796 ^+ AOFF_162
                | CLK_NST ^= NST
                | ACT_CLK_NST{}
                |)
             | (| CLK_SETONOFF := CLK_MODONOFF ^+ OFF_165
                | CLK_SETONOFF ^= SETONOFF ^= DV2 ^= DV2_1460
                | ACT_CLK_SETONOFF{}
                |)
             | (| CLK_CSET := CLK_SETONOFF ^+ CLK_1792
                | ACT_CLK_CSET{}
                |)
             | (| CLK_ALCANCEL := CLK_WMODONOFF ^+ CLK_SETONOFF
                | ACT_CLK_ALCANCEL{}
                |)
             | (| CLK_CSET_1752 := CLK_WMODONOFF ^+ CLK_1788
                | ACT_CLK_CSET_1752{}
                |)
             | (| CLK_SETONOFF_1751 := CLK_WMODONOFF ^+ AOFF_162
                | CLK_SETONOFF_1751 ^= SETONOFF_1751
                | (| SETONOFF_1751 := (not AOFF_162) default (WMODONOFF when CLK_2357) |)
                |)
             | (| NEXTX := SLL_315 ^* CLK_118 |)
             | (| CLK_DB_457 := SUR_316 ^* CLK_119
                | CLK_DB_457 ^= DB_457
                | ACT_CLK_DB_457{}
                |)
             | (| CLK_STATE24 := WLR_1736 ^* CLK_1047
                | CLK_STATE24 ^= STATE24
                | ACT_CLK_STATE24{}
                |)
             | (| CLICK_259 := SLR_317 ^* CLK_118 |)
             | (| CLK_DB := SLR_317 ^* CLK_119
                | CLK_DB ^= DB
                | ACT_CLK_DB{}
                |)
             | (| XZX_646 := CLICK_259 ^+ TICK_260 |)
             | (| CLK_DISB := CLK_DB_457 ^+ CLK_WMODONOFF
                | CLK_DISB ^= DISB
                | ACT_CLK_DISB{}
                |)
             | (| CLK_CSTATE_973 := CLK_DISB ^+ CLK_CHOUR
                | ACT_CLK_CSTATE_973{}
                |)
             | (| CLK_1875 := NEXTX ^+ CLK_SETONOFF |)
             | (| CLK_SETH := NEXTX ^+ RESET
                | CLK_SETH ^= SETH ^= DV3 ^= XZX_1268 ^= SETONOFF_1440 ^= DV3_1461
                | ACT_CLK_SETH{}
                |)
             | (| CLK_CSET_645 := CLK_SETH ^+ XZX_646
                | ACT_CLK_CSET_645{}
                |)
             | (| LCLICK_1286 := CLICK_259 ^* CLK_758 |)
             | (| LCLICK_608 := CLICK_259 ^* CLK_298 |)
             | (| CHBEEP_895 := CLK_537 ^* CLK_CHOUR |)
             | (| LTICK_1285 := TICK_260 ^* CLK_758 |)
             | (| LTICK_607 := TICK_260 ^* CLK_298 |)
             | (| CLK_V_1023 := CHBEEP_895 ^+ CLK_619
                | ACT_CLK_V_1023{}
                |)
             | (| CLK_1920 := LCLICK_608 ^+ LTICK_607 |)
             | (| CLK_1924 := LCLICK_1286 ^+ LTICK_1285 |)
             | (| CLK_1928 := H_MOD_1024 ^* CLK_577 |)
             | (| BEEP1_998 := CLK_1928 ^+ CHBEEP_895 |)
             | (| CLK_V_1066 := CHBEEP_895 ^+ H_MOD_1024
                | ACT_CLK_V_1066{}
                |)
             | (| CLK_1934 := CLICK_259 ^+ CLK_305 |)
             | (| CLK_1936 := CLICK_259 ^+ CLK_765 |)
             | (| CLK_1938 := RESET ^+ CLK_151 |)
             | (| CLK_DALARM := CLK_ALCANCEL ^+ CLK_DB
                | CLK_DALARM ^= DALARM
                | ACT_CLK_DALARM{}
                |)
             | (| CLK_CSTATE_906 := CLK_DALARM ^+ CLK_XZX_958
                | ACT_CLK_CSTATE_906{}
                |)
             | (| RESET_1283 := CLK_1936 ^* CLK_758 |)
             | (| CLK_V_1397 := RESET_1283 ^+ CLK_1924
                | ACT_CLK_V_1397{}
                |)
             | (| RESET_605 := CLK_1934 ^* CLK_298 |)
             | (| CLK_V_720 := RESET_605 ^+ CLK_1920
                | ACT_CLK_V_720{}
                |)
             | (| CLK_CAV := CLK_485 ^* CLK_XZX_958
                | ACT_CLK_CAV{}
                |)
             | (| CLK_XZX_931 := CLK_CAV ^+ CLK_CHOUR
                | CLK_XZX_931 ^= XZX_931
                | (| XZX_931 := (CHOUR when CLK_CHOUR) cell CLK_XZX_931 init 0 |)
                |)
             | (| XRESET_1081 := CHBEEP_895 ^+ AUX_1000 |)
             | (| CLK_V_697 := RESET_605 ^+ HS_676
                | ACT_CLK_V_697{}
                |)
             | (| CLK_V_1374 := RESET_1283 ^+ HS_1353
                | ACT_CLK_V_1374{}
                |)
             | (| CLK_XZX_1122 := STOPAL_166 ^+ RINGUP_163
                | CLK_XZX_1122 ^= XZX_1122
                | ACT_CLK_XZX_1122{}
                |)
             | (| CLK_WBI_1142 := CLK_XZX_1122 ^+ CLK_CSTATE
                | ACT_CLK_WBI_1142{}
                |)
             | (| CLK_2019 := LCLICK_1286 ^* CLK_788 |)
             | (| CLK_2021 := LCLICK_608 ^* CLK_328 |)
             | (| HBLINK_1254 := LTICK_1285 ^* CLK_788 |)
             | (| CLK_2025 := LTICK_1285 ^* CLK_789 |)
             | (| HBLINK := LTICK_607 ^* CLK_328 |)
             | (| CLK_2029 := LTICK_607 ^* CLK_329 |)
             | (| CLK_2033 := HBLINK ^+ CLK_1875 |)
             | (| CLK_CSTATE_804 := HBLINK ^+ CLK_SETH
                | ACT_CLK_CSTATE_804{}
                |)
             | (| CLK_2039 := HBLINK_1254 ^+ CLK_1875 |)
             | (| CLK_CSTATE_1482 := HBLINK_1254 ^+ CLK_SETH
                | ACT_CLK_CSTATE_1482{}
                |)
             | (| CLK_V := CLK_2021 ^+ CLK_2029
                | CLK_V ^= V
                | ACT_CLK_V{}
                |)
             | (| CLK_CV := CLK_V ^+ CLK_2033
                | CLK_CV ^= CV
                | (| CV := (V when CLK_V) cell CLK_CV init 0 |)
                |)
             | (| CLK_XZX_927 := CLK_V ^+ CLK_CAV
                | CLK_XZX_927 ^= XZX_927
                | (| XZX_927 := (V when CLK_V) cell CLK_XZX_927 init 0 |)
                |)
             | (| CLK_2058 := CLK_V ^+ CLK_SETONOFF |)
             | (| CLK_2065 := CLK_2058 ^+ CLK_SETH |)
             | (| CLK_AMIN := CLK_2019 ^+ CLK_2025
                | CLK_AMIN ^= AMIN
                | ACT_CLK_AMIN{}
                |)
             | (| CLK_CV_1459 := CLK_AMIN ^+ CLK_2039
                | CLK_CV_1459 ^= CV_1459
                | (| CV_1459 := (AMIN when CLK_AMIN) cell CLK_CV_1459 init 0 |)
                |)
             | (| CLK_2085 := CLK_AMIN ^+ CLK_SETONOFF |)
             | (| CLK_XZX_954 := CLK_AMIN ^+ CLK_CAV_952
                | CLK_XZX_954 ^= XZX_954
                | (| XZX_954 := (AMIN when CLK_AMIN) cell CLK_XZX_954 init 0 |)
                |)
             | (| CLK_2094 := CLK_2085 ^+ CLK_SETH |)
             | (| HSET_1455 := HBLINK_1254 ^* CLK_865 |)
             | (| HSET := HBLINK ^* CLK_405 |)
             | (| CLK_ACTIF := HSET ^+ CLK_305
                | CLK_ACTIF ^= DV4
                | ACT_CLK_ACTIF{}
                |)
             | (| CLK_ACTIF_1457 := HSET_1455 ^+ CLK_871
                | CLK_ACTIF_1457 ^= DV4_1462
                | ACT_CLK_ACTIF_1457{}
                |)
             | (| CLK_DV := CLK_ACTIF ^+ CLK_2065
                | CLK_DV ^= DV
                | (| DV := (V when CLK_V) default (DV2 when CLK_2363) default (DV3 when CLK_2343) default (DV4 when CLK_2280) |)
                |)
             | (| CLK_DPM := CLK_DV ^+ CLK_STATE24
                | ACT_CLK_DPM{}
                |)
             | (| CLK_DAMIN := CLK_ACTIF_1457 ^+ CLK_2094
                | ACT_CLK_DAMIN{}
                |)
             | (| CLK_V_1143 := ERESET_1139 ^+ CLK_708
                | ACT_CLK_V_1143{}
                |)
             | (| CLK_2187 := H_MOD_1144 ^* CLK_665 |)
             | (| BEEP2_999 := CLK_2187 ^+ ERESET_1139 |)
             | (| BEEP_76 := BEEP2_999 ^+ BEEP1_998 |)
             | (| XZX_2759 := BEEP_76 ^+ TBEEP_75
                | (| SIGBELL(30 when XZX_2759) |)
                |)
             | (| CLK_V_1185 := H_MOD_1144 ^+ ERESET_1139
                | ACT_CLK_V_1185{}
                |)
             | (| CLK_2235 := CLK_CSTATE ^* RINGOFF_164 |)
             | (| CLK_2237 := CLK_2235 ^+ CLK_XZX_1122 |)
             | (| CLK_2244 := RINGOFF_164 ^+ RINGUP_163 |)
             | (| XRESET_1200 := RINGOFF_164 ^+ ERESET_1139 |)
             | (| CLK_2251 := CLK_2244 ^+ CLK_RINGING |)
             | (| CLK_2266 := CLK_V_1185 ^- XRESET_1200 |)
             | (| CLK_2274 := CLK_V_1143 ^- CLK_V_1185 |)
             | (| CLK_2278 := CLK_ACTIF_1457 ^- CLK_2094 |)
             | (| CLK_2280 := CLK_ACTIF ^- CLK_2065 |)
             | (| CLK_2282 := CLK_ACTIF_1457 ^- CLK_871 |)
             | (| CLK_2285 := CLK_ACTIF ^- CLK_305 |)
             | (| CLK_2294 := CLK_V_697 ^- RESET_605 |)
             | (| CLK_2296 := CLK_V_1374 ^- RESET_1283 |)
             | (| CLK_2298 := CLK_V_1066 ^- XRESET_1081 |)
             | (| CLK_2300 := CLK_WBI_1142 ^- CLK_2237 |)
             | (| CLK_2304 := CLK_XZX_1122 ^- RINGOFF_164 |)
             | (| CLK_2310 := CLK_V_720 ^- CLK_V_697 |)
             | (| CLK_2316 := CLK_V_1397 ^- CLK_V_1374 |)
             | (| CLK_2320 := CLK_DALARM ^- CLK_166 |)
             | (| CLK_2328 := CLK_V_1023 ^- CLK_V_1066 |)
             | (| CLK_2333 := CHBEEP_895 ^- AUX_1000 |)
             | (| CLK_2341 := CLK_SETH ^- RESET |)
             | (| CLK_2343 := CLK_SETH ^- CLK_2058 |)
             | (| CLK_2345 := CLK_SETH ^- CLK_2085 |)
             | (| CLK_2347 := CLK_DISB ^- CLK_151 |)
             | (| CLK_2351 := CLK_ALCANCEL ^- CLK_1938 |)
             | (| CLK_2353 := CLK_CSET_1752 ^- CLK_SETONOFF_1751 |)
             | (| CLK_2357 := CLK_WMODONOFF ^- AOFF_162 |)
             | (| CLK_2359 := CLK_CSET ^- CLK_SETONOFF |)
             | (| CLK_2363 := CLK_SETONOFF ^- CLK_V |)
             | (| CLK_2365 := CLK_SETONOFF ^- CLK_AMIN |)
             | (| CLK_2369 := CLK_MODONOFF ^- OFF_165 |)
             | (| CLK_2381 := CLK_CSTATE ^- XRESET_1081 |)
             | (| CLK_2383 := CLK_WDIS ^- CLK_2251 |)
             | (| CLK_2385 := CLK_RINGING ^- CLK_2244 |)
             | (| CLK_2387 := CLK_ZMODE_1812 ^- CLK_WMODONOFF |)
             | (| CLK_2395 := CLK_ZMODE ^- CLK_MODONOFF |)
             | (| CLK_2399 := RESET ^- CLK_151 |)
             | (| CLK_2402 := RINGUP_163 ^- STOPAL_166 |)
             | (| CLK_2410 := RINGOFF_164 ^- RINGUP_163 |)
             | (| WDIS := STNB=0
                | ADIS := STNB=2
                | SWDIS := STNB=1
                | STNB := CST$1 init 0
                | CST := (NST when CLK_NST) cell CLK_WDIS init 0
                | NRINGING := RINGUP_163 default (not CLK_2410) default (not CLK_2385) default (CRINGING when CLK_2383)
                | CRINGING := NRINGING$1 init false
                | LR_2216 := RLR()
                | UR_2224 := RUR()
                | V2 := (0 when CLK_CSTATE) default ((ZV_2259+1) when CLK_1333)
                | ZV_2259 := V2$1 init 1
                |)
             |)
            where 
            event CLK_2410, CLK_2402, CLK_2399, CLK_2395, CLK_2387, CLK_2385, CLK_2383, CLK_2381, CLK_2369, CLK_2365, CLK_2363, CLK_2359, CLK_2357, CLK_2353, CLK_2351, CLK_2347, CLK_2345, CLK_2343, CLK_2341, CLK_2333, CLK_2328, CLK_2320, CLK_2316, 
                 CLK_2310, CLK_2304, CLK_2300, CLK_2298, CLK_2296, CLK_2294, CLK_2285, CLK_2282, CLK_2280, CLK_2278, CLK_2274, CLK_2266, CLK_2251, XRESET_1200, CLK_2244, CLK_2237, CLK_2235, CLK_V_1185, XZX_2759, BEEP_76, BEEP2_999, CLK_2187, CLK_V_1143, 
                 CLK_DAMIN, CLK_DPM, CLK_DV, CLK_ACTIF_1457, CLK_ACTIF, HSET, HSET_1455, CLK_2094, CLK_XZX_954, CLK_2085, CLK_CV_1459, CLK_AMIN, CLK_2065, CLK_2058, CLK_XZX_927, CLK_CV, CLK_V, CLK_CSTATE_1482, CLK_2039, CLK_CSTATE_804, CLK_2033, CLK_2029, 
                 HBLINK, CLK_2025, HBLINK_1254, CLK_2021, CLK_2019, CLK_WBI_1142, CLK_XZX_1122, CLK_V_1374, CLK_V_697, XRESET_1081, CLK_XZX_931, CLK_CAV, CLK_V_720, RESET_605, CLK_V_1397, RESET_1283, CLK_CSTATE_906, CLK_DALARM, CLK_1938, CLK_1936, 
                 CLK_1934, CLK_V_1066, BEEP1_998, CLK_1928, CLK_1924, CLK_1920, CLK_V_1023, LTICK_607, LTICK_1285, CHBEEP_895, LCLICK_608, LCLICK_1286, CLK_CSET_645, CLK_SETH, CLK_1875, CLK_CSTATE_973, CLK_DISB, XZX_646, CLK_DB, CLICK_259, CLK_STATE24, 
                 CLK_DB_457, NEXTX, CLK_SETONOFF_1751, CLK_CSET_1752, CLK_ALCANCEL, CLK_CSET, CLK_SETONOFF, CLK_NST, CLK_1796, CLK_1792, CLK_1788, CLK_1779, SLR_317, WLR_1736, SUR_316, AOFF_162, SLL_315, OFF_165, WOFF, CLK_MODONOFF, CLK_WMODONOFF, 
                 CLK_1647, CLK_1645, SUL_158, SLL_159, SUR_160, SLR_161, CLK_RINGING, CLK_XZX_2153, CLK_XZX_2143, TBEEP_75, CLK_1333, CLK_CSTATE, LR_1959, UR_1958, SUR_72, SLL_71, SUL_70, CLK_CHOUR, CLK_XZX_958, CLK_1087, CLK_ZMODE_1812, CLK_1047, CLK_990,
                 STOPAL_166, CLK_928, CLK_871, CLK_865, HS_1353, CLK_789, CLK_788, CLK_765, CLK_758, CLK_708, ERESET_1139, RINGOFF_164, CLK_665, H_MOD_1144, CLK_619, AUX_1000, CLK_577, H_MOD_1024, CLK_537, RINGUP_163, CLK_CAV_952, CLK_485, CLK_405, HS_676,
                 CLK_329, CLK_328, CLK_305, CLK_298, CLK_239, CLK_238, CLK_ZMODE, TICK_260, CLK_166, CLK_151, CLK_119, CLK_118, RESET;
            integer DV, V, CV, DV2, DV3, DV4, XZX_927, XZX_931, XZX_954, XZX_958, AMIN, CV_1459, DV2_1460, DV3_1461, DV4_1462, STNB, CST, NST, CHOUR, V2, ZV_2259;
            boolean DALARM, WDIS, ADIS, SWDIS, SETH, MODONOFF, SETONOFF, DB, DISB, DB_457, ZMODE, XZX_1122, XZX_1268, SETONOFF_1440, NRINGING, CRINGING, STATE24, SETONOFF_1751, WMODONOFF, ZMODE_1812, LR_2216, UR_2224;
            process ACT_CLK_ZMODE =
                 ( )
               (| CLK_ZMODE ^= MODE
                | (| CLK_238 := when MODE
                   | CLK_239 := when (not MODE)
                   |)
                | (| ZMODE := MODE$1 init false
                   | MODE := (MODONOFF when CLK_MODONOFF) default (ZMODE when CLK_2395)
                   |)
                |)
               where 
               boolean MODE;
               end
            %ACT_CLK_ZMODE%; 
            process ACT_CLK_ZMODE_1812 =
                 ( )
               (| CLK_ZMODE_1812 ^= MODE_1813
                | (| CLK_1087 := when (not MODE_1813) |)
                | (| ZMODE_1812 := MODE_1813$1 init false
                   | MODE_1813 := (WMODONOFF when CLK_WMODONOFF) default (ZMODE_1812 when CLK_2387)
                   |)
                |)
               where 
               boolean MODE_1813;
               end
            %ACT_CLK_ZMODE_1812%; 
            process ACT_CLK_CSTATE =
                 ( )
               (| CLK_CSTATE ^= CSTATE ^= WBI ^= BTI ^= V_1846 ^= ZV_1860 ^= LL_2270 ^= UL_2278
                | (| TICK_260 := when CSTATE |)
                | (| CLK_577 := when WBI |)
                | (| CLK_619 := when BTI |)
                | (| CLK_XZX_958 := when (ZV_1860>=19)
                   | CLK_XZX_958 ^= XZX_958
                   | ACT_CLK_XZX_958{}
                   | CLK_1113 := when (not (ZV_1860>=19))
                   |)
                | (| UL_1960 := when UL_2278 |)
                | (| LL_1961 := when LL_2270 |)
                | (| TBEEP_75 := UL_1960 ^* LL_1961 |)
                | (| CLK_XZX_2143 := UL_1960 ^+ LL_1961
                   | ACT_CLK_XZX_2143{}
                   |)
                | (| CLK_1641 := LL_1961 ^- UL_1960 |)
                | (| CLK_1643 := UL_1960 ^- LL_1961 |)
                | (| CSTATE := (SETONOFF when CLK_SETONOFF) cell CLK_CSTATE init V_0
                   | WBI := (not AUX_1000) default CLK_2333 default (BTI when CLK_2381)
                   | BTI := WBI$1 init false
                   | V_1846 := (0 when CLK_XZX_958) default ((ZV_1860+1) when CLK_1113)
                   | ZV_1860 := V_1846$1 init 19
                   | LL_2270 := RLL()
                   | UL_2278 := RUL()
                   |)
                |)
               where 
               event CLK_1643, CLK_1641, LL_1961, UL_1960, CLK_1113;
               integer V_1846, ZV_1860;
               boolean CSTATE, WBI, BTI, LL_2270, UL_2278;
               process ACT_CLK_XZX_958 =
                    ( )
                  (| CLK_XZX_958 ^= CMIN ^= ZV_1915 ^= CC_2432
                   | (| CLK_CHOUR := when (ZV_1915>=59)
                      | CLK_CHOUR ^= CHOUR
                      | ACT_CLK_CHOUR{}
                      | CLK_1136 := when (not (ZV_1915>=59))
                      |)
                   | (| CLK_XZX_2433 := when (CMIN>=0)
                      | ACT_CLK_XZX_2433{}
                      |)
                   | (| XZX_958 := CMIN
                      | CMIN := (0 when CLK_CHOUR) default ((ZV_1915+1) when CLK_1136)
                      | ZV_1915 := CMIN$1 init 59
                      | CC_2432 := WCLEARAREA(80 when CLK_XZX_958,8 when CLK_XZX_958,16 when CLK_XZX_958,16 when CLK_XZX_958)
                      |)
                   |)
                  where 
                  event CLK_XZX_2433, CLK_1136;
                  boolean CC_2432;
                  integer CMIN, ZV_1915;
                  process ACT_CLK_CHOUR =
                       ( )
                     (| CLK_CHOUR ^= ZV_1887 ^= CC
                      | (| HS_1871 := when (ZV_1887>=23)
                         | CLK_1125 := when (not (ZV_1887>=23))
                         |)
                      | (| CLK_XZX_2354 := when (CHOUR>=0)
                         | ACT_CLK_XZX_2354{}
                         |)
                      | (| CHOUR := (0 when HS_1871) default ((ZV_1887+1) when CLK_1125)
                         | ZV_1887 := CHOUR$1 init 23
                         | CC := WCLEARAREA(56 when CLK_CHOUR,8 when CLK_CHOUR,16 when CLK_CHOUR,16 when CLK_CHOUR)
                         |)
                      |)
                     where 
                     event CLK_XZX_2354, CLK_1125, HS_1871;
                     boolean CC;
                     integer ZV_1887;
                     process ACT_CLK_XZX_2354 =
                          ( )
                        (| CLK_XZX_2354 ^= XZX_2354
                         | (| XZX_2354 := CHOUR when CLK_XZX_2354
                            | WPINT2(56,24,XZX_2354)
                            |)
                         |)
                        where 
                        integer XZX_2354;
                        end
                     %ACT_CLK_XZX_2354%; 
                     end
                  %ACT_CLK_CHOUR%; 
                  process ACT_CLK_XZX_2433 =
                       ( )
                     (| CLK_XZX_2433 ^= XZX_2433
                      | (| XZX_2433 := CMIN when CLK_XZX_2433
                         | WPINT2(80,24,XZX_2433)
                         |)
                      |)
                     where 
                     integer XZX_2433;
                     end
                  %ACT_CLK_XZX_2433%; 
                  end
               %ACT_CLK_XZX_958%; 
               process ACT_CLK_XZX_2143 =
                    ( )
                  (| CLK_XZX_2143 ^= XZX_2143 ^= XZX_2147
                   | (| SUL_70 := when XZX_2143 |)
                   | (| SLL_71 := when XZX_2147 |)
                   | (| XZX_2143 := (not LL_1961) default CLK_1643
                      | XZX_2147 := (not UL_1960) default CLK_1641
                      |)
                   |)
                  where 
                  boolean XZX_2143, XZX_2147;
                  end
               %ACT_CLK_XZX_2143%; 
               end
            %ACT_CLK_CSTATE%; 
            process ACT_CLK_XZX_2153 =
                 ( )
               (| CLK_XZX_2153 ^= XZX_2153
                | (| SUR_72 := when XZX_2153 |)
                | (| XZX_2153 := (not CLK_XZX_2143) default CLK_1647 |)
                |)
               where 
               boolean XZX_2153;
               end
            %ACT_CLK_XZX_2153%; 
            process ACT_CLK_RINGING =
                 ( )
               (| CLK_RINGING ^= RINGING ^= XZX_2157
                | (| STOPAL_166 := when RINGING
                   | CLK_990 := when (not RINGING)
                   |)
                | (| SLR_73 := when XZX_2157 |)
                | (| SLR_161 := CLK_990 ^* SLR_73 |)
                | (| RINGING := CRINGING when CLK_RINGING
                   | XZX_2157 := (not CLK_XZX_2153) default CLK_1645
                   |)
                |)
               where 
               event SLR_73;
               boolean RINGING, XZX_2157;
               end
            %ACT_CLK_RINGING%; 
            process ACT_CLK_WMODONOFF =
                 ( )
               (| (| CLK_151 := when WMODONOFF |)
                | (| WMODONOFF := (not ZMODE_1812) when CLK_WMODONOFF |)
                |)
            %ACT_CLK_WMODONOFF%; 
            process ACT_CLK_NST =
                 ( )
               (| CLK_NST ^= ZV_1604 ^= CC_2711
                | (| HS1_1580 := when (ZV_1604>=2)
                   | CLK_966 := when (not (ZV_1604>=2))
                   |)
                | (| CLK_XZX_2712 := when CC_2711
                   | ACT_CLK_XZX_2712{}
                   |)
                | (| NST := (0 when HS1_1580) default ((ZV_1604+1) when CLK_966)
                   | ZV_1604 := NST$1 init 0
                   | CC_2711 := WCLEARAREA(8 when CLK_NST,8 when CLK_NST,32,16)
                   |)
                |)
               where 
               event CLK_XZX_2712, CLK_966, HS1_1580;
               boolean CC_2711;
               integer ZV_1604;
               process ACT_CLK_XZX_2712 =
                    ( )
                  (| CLK_XZX_2712 ^= XZX_2712
                   | (| XZX_2712 := NST when CLK_XZX_2712
                      | WDTAG(8,24,XZX_2712)
                      |)
                   |)
                  where 
                  integer XZX_2712;
                  end
               %ACT_CLK_XZX_2712%; 
               end
            %ACT_CLK_NST%; 
            process ACT_CLK_SETONOFF =
                 ( )
               (| (| RESET := when SETONOFF |)
                | (| SETONOFF := (not OFF_165) default (MODONOFF when CLK_2369)
                   | DV2 := CV when CLK_SETONOFF
                   | DV2_1460 := CV_1459 when CLK_SETONOFF
                   |)
                |)
            %ACT_CLK_SETONOFF%; 
            process ACT_CLK_CSET =
                 ( )
               (| CLK_CSET ^= CSET ^= ZCSET
                | (| CLK_118 := when CSET
                   | CLK_119 := when (not CSET)
                   |)
                | (| CSET := (SETONOFF when CLK_SETONOFF) default (ZCSET when CLK_2359)
                   | ZCSET := CSET$1 init false
                   |)
                |)
               where 
               boolean CSET, ZCSET;
               end
            %ACT_CLK_CSET%; 
            process ACT_CLK_ALCANCEL =
                 ( )
               (| CLK_ALCANCEL ^= ALCANCEL
                | (| CLK_166 := when ALCANCEL |)
                | (| ALCANCEL := CLK_151 default CLK_2399 default (not CLK_2351) |)
                |)
               where 
               boolean ALCANCEL;
               end
            %ACT_CLK_ALCANCEL%; 
            process ACT_CLK_CSET_1752 =
                 ( )
               (| CLK_CSET_1752 ^= CSET_1752 ^= ZCSET_1753
                | (| CLK_1047 := when (not CSET_1752) |)
                | (| CSET_1752 := (SETONOFF_1751 when CLK_SETONOFF_1751) default (ZCSET_1753 when CLK_2353)
                   | ZCSET_1753 := CSET_1752$1 init false
                   |)
                |)
               where 
               boolean CSET_1752, ZCSET_1753;
               end
            %ACT_CLK_CSET_1752%; 
            process ACT_CLK_DB_457 =
                 ( )
               (| CLK_DB_457 ^= ZB_464
                | (| DB_457 := not ZB_464
                   | ZB_464 := DB_457$1 init V0_459
                   |)
                |)
               where 
               boolean ZB_464;
               end
            %ACT_CLK_DB_457%; 
            process ACT_CLK_STATE24 =
                 ( )
               (| CLK_STATE24 ^= ZB_1775
                | (| STATE24 := not ZB_1775
                   | ZB_1775 := STATE24$1 init V0_1773
                   |)
                |)
               where 
               boolean ZB_1775;
               end
            %ACT_CLK_STATE24%; 
            process ACT_CLK_DB =
                 ( )
               (| CLK_DB ^= ZB
                | (| DB := not ZB
                   | ZB := DB$1 init V0
                   |)
                |)
               where 
               boolean ZB;
               end
            %ACT_CLK_DB%; 
            process ACT_CLK_DISB =
                 ( )
               (| CLK_DISB ^= CB_456 ^= CC_2634
                | (| CLK_1469 := when CC_2634 |)
                | (| CLK_1472 := when DISB |)
                | (| CLK_1581 := CLK_1469 ^* CLK_1472
                   | (| WPTAG(56 when CLK_1581,40,4) |)
                   |)
                | (| DISB := (not CLK_151) default (CB_456 when CLK_2347)
                   | CB_456 := (DB_457 when CLK_DB_457) cell CLK_DISB init false
                   | CC_2634 := WCLEARAREA(56 when CLK_DISB,32 when CLK_DISB,24,8)
                   |)
                |)
               where 
               event CLK_1581, CLK_1472, CLK_1469;
               boolean CB_456, CC_2634;
               end
            %ACT_CLK_DISB%; 
            process ACT_CLK_CSTATE_973 =
                 ( )
               (| CLK_CSTATE_973 ^= CSTATE_973
                | (| CLK_537 := when CSTATE_973 |)
                | (| CSTATE_973 := (DISB when CLK_DISB) cell CLK_CSTATE_973 init V_0_966 |)
                |)
               where 
               boolean CSTATE_973;
               end
            %ACT_CLK_CSTATE_973%; 
            process ACT_CLK_SETH =
                 ( )
               (| CLK_SETH ^= ZSETH
                | (| CLK_305 := when SETH |)
                | (| CLK_765 := when XZX_1268 |)
                | (| CLK_871 := when SETONOFF_1440 |)
                | (| SETH := RESET default ((not ZSETH) when CLK_2341)
                   | ZSETH := SETH$1 init true
                   | DV3 := CV when CLK_SETH
                   | XZX_1268 := not SETH
                   | SETONOFF_1440 := not SETH
                   | DV3_1461 := CV_1459 when CLK_SETH
                   |)
                |)
               where 
               boolean ZSETH;
               end
            %ACT_CLK_SETH%; 
            process ACT_CLK_CSET_645 =
                 ( )
               (| CLK_CSET_645 ^= CSET_645 ^= CSET_1322
                | (| CLK_298 := when CSET_645 |)
                | (| CLK_758 := when CSET_1322 |)
                | (| CSET_645 := (SETH when CLK_SETH) cell CLK_CSET_645 init false
                   | CSET_1322 := (XZX_1268 when CLK_SETH) cell CLK_CSET_645 init false
                   |)
                |)
               where 
               boolean CSET_645, CSET_1322;
               end
            %ACT_CLK_CSET_645%; 
            process ACT_CLK_V_1023 =
                 ( )
               (| CLK_V_1023 ^= V_1023 ^= ZV_1050
                | (| H_MOD_1024 := when (ZV_1050>=3) |)
                | (| V_1023 := (0 when CLK_V_1066) default ((ZV_1050+1) when CLK_2328)
                   | ZV_1050 := V_1023$1 init 0
                   |)
                |)
               where 
               integer V_1023, ZV_1050;
               end
            %ACT_CLK_V_1023%; 
            process ACT_CLK_V_1066 =
                 ( )
               (| CLK_V_1066 ^= V_1066 ^= ZV_1091
                | (| AUX_1000 := when (ZV_1091>=0) |)
                | (| V_1066 := (0 when XRESET_1081) default ((ZV_1091+1) when CLK_2298)
                   | ZV_1091 := V_1066$1 init 0
                   |)
                |)
               where 
               integer V_1066, ZV_1091;
               end
            %ACT_CLK_V_1066%; 
            process ACT_CLK_DALARM =
                 ( )
               (| CLK_DALARM ^= CB ^= CC_2673
                | (| CLK_1485 := when CC_2673 |)
                | (| CLK_1488 := when DALARM |)
                | (| CLK_1583 := CLK_1485 ^* CLK_1488
                   | (| WPTAG(56 when CLK_1583,56,3) |)
                   |)
                | (| DALARM := (not CLK_166) default (CB when CLK_2320)
                   | CB := (DB when CLK_DB) cell CLK_DALARM init false
                   | CC_2673 := WCLEARAREA(56 when CLK_DALARM,48 when CLK_DALARM,24,8)
                   |)
                |)
               where 
               event CLK_1583, CLK_1488, CLK_1485;
               boolean CB, CC_2673;
               end
            %ACT_CLK_DALARM%; 
            process ACT_CLK_CSTATE_906 =
                 ( )
               (| CLK_CSTATE_906 ^= CSTATE_906
                | (| CLK_485 := when CSTATE_906 |)
                | (| CSTATE_906 := (DALARM when CLK_DALARM) cell CLK_CSTATE_906 init V_0_899 |)
                |)
               where 
               boolean CSTATE_906;
               end
            %ACT_CLK_CSTATE_906%; 
            process ACT_CLK_V_1397 =
                 ( )
               (| CLK_V_1397 ^= V_1397 ^= ZV_1426
                | (| HS_1353 := when (ZV_1426>=4) |)
                | (| V_1397 := (0 when CLK_V_1374) default ((ZV_1426+1) when CLK_2316)
                   | ZV_1426 := V_1397$1 init 4
                   |)
                |)
               where 
               integer V_1397, ZV_1426;
               end
            %ACT_CLK_V_1397%; 
            process ACT_CLK_V_720 =
                 ( )
               (| CLK_V_720 ^= V_720 ^= ZV_751
                | (| HS_676 := when (ZV_751>=4) |)
                | (| V_720 := (0 when CLK_V_697) default ((ZV_751+1) when CLK_2310)
                   | ZV_751 := V_720$1 init 4
                   |)
                |)
               where 
               integer V_720, ZV_751;
               end
            %ACT_CLK_V_720%; 
            process ACT_CLK_CAV =
                 ( )
               (| CLK_CAV ^= CAV ^= CWV
                | (| CLK_CAV_952 := when (CAV=CWV)
                   | ACT_CLK_CAV_952{}
                   |)
                | (| CAV := XZX_927 when CLK_CAV
                   | CWV := XZX_931 when CLK_CAV
                   |)
                |)
               where 
               integer CAV, CWV;
               process ACT_CLK_CAV_952 =
                    ( )
                  (| CLK_CAV_952 ^= CAV_952 ^= CWV_953
                   | (| RINGUP_163 := when (CAV_952=CWV_953) |)
                   | (| CAV_952 := XZX_954 when CLK_CAV_952
                      | CWV_953 := XZX_958 when CLK_CAV_952
                      |)
                   |)
                  where 
                  integer CAV_952, CWV_953;
                  end
               %ACT_CLK_CAV_952%; 
               end
            %ACT_CLK_CAV%; 
            process ACT_CLK_V_697 =
                 ( )
               (| CLK_V_697 ^= V_697 ^= INCREASE ^= ZV_705
                | (| CLK_328 := when INCREASE
                   | CLK_329 := when (not INCREASE)
                   |)
                | (| V_697 := (0 when RESET_605) default ((ZV_705+1) when CLK_2294)
                   | INCREASE := V_697<16
                   | ZV_705 := V_697$1 init 0
                   |)
                |)
               where 
               boolean INCREASE;
               integer V_697, ZV_705;
               end
            %ACT_CLK_V_697%; 
            process ACT_CLK_V_1374 =
                 ( )
               (| CLK_V_1374 ^= V_1374 ^= INCREASE_1375 ^= ZV_1382
                | (| CLK_788 := when INCREASE_1375
                   | CLK_789 := when (not INCREASE_1375)
                   |)
                | (| V_1374 := (0 when RESET_1283) default ((ZV_1382+1) when CLK_2296)
                   | INCREASE_1375 := V_1374<16
                   | ZV_1382 := V_1374$1 init 0
                   |)
                |)
               where 
               boolean INCREASE_1375;
               integer V_1374, ZV_1382;
               end
            %ACT_CLK_V_1374%; 
            process ACT_CLK_XZX_1122 =
                 ( )
               (| (| ERESET_1139 := when XZX_1122 |)
                | (| XZX_1122 := (not STOPAL_166) default CLK_2402 |)
                |)
            %ACT_CLK_XZX_1122%; 
            process ACT_CLK_WBI_1142 =
                 ( )
               (| CLK_WBI_1142 ^= WBI_1142 ^= BTI_1221
                | (| CLK_665 := when WBI_1142 |)
                | (| CLK_708 := when BTI_1221 |)
                | (| WBI_1142 := (not RINGOFF_164) default (XZX_1122 when CLK_2304) default (BTI_1221 when CLK_2300)
                   | BTI_1221 := WBI_1142$1 init false
                   |)
                |)
               where 
               boolean WBI_1142, BTI_1221;
               end
            %ACT_CLK_WBI_1142%; 
            process ACT_CLK_CSTATE_804 =
                 ( )
               (| CLK_CSTATE_804 ^= CSTATE_804
                | (| CLK_405 := when CSTATE_804 |)
                | (| CSTATE_804 := (SETH when CLK_SETH) cell CLK_CSTATE_804 init V_0_798 |)
                |)
               where 
               boolean CSTATE_804;
               end
            %ACT_CLK_CSTATE_804%; 
            process ACT_CLK_CSTATE_1482 =
                 ( )
               (| CLK_CSTATE_1482 ^= CSTATE_1482
                | (| CLK_865 := when CSTATE_1482 |)
                | (| CSTATE_1482 := (SETONOFF_1440 when CLK_SETH) cell CLK_CSTATE_1482 init V_0_1476 |)
                |)
               where 
               boolean CSTATE_1482;
               end
            %ACT_CLK_CSTATE_1482%; 
            process ACT_CLK_V =
                 ( )
               (| CLK_V ^= ZV
                | (| HS_610 := when (ZV>=23)
                   | CLK_287 := when (not (ZV>=23))
                   |)
                | (| V := (0 when HS_610) default ((ZV+1) when CLK_287)
                   | ZV := V$1 init 0
                   |)
                |)
               where 
               event CLK_287, HS_610;
               integer ZV;
               end
            %ACT_CLK_V%; 
            process ACT_CLK_AMIN =
                 ( )
               (| CLK_AMIN ^= ZV_1300
                | (| HS_1288 := when (ZV_1300>=59)
                   | CLK_751 := when (not (ZV_1300>=59))
                   |)
                | (| AMIN := (0 when HS_1288) default ((ZV_1300+1) when CLK_751)
                   | ZV_1300 := AMIN$1 init 0
                   |)
                |)
               where 
               event CLK_751, HS_1288;
               integer ZV_1300;
               end
            %ACT_CLK_AMIN%; 
            process ACT_CLK_ACTIF =
                 ( )
               (| CLK_ACTIF ^= ACTIF ^= ZACTIF
                | (| CLK_421 := when ACTIF
                   | CLK_422 := when (not ACTIF)
                   |)
                | (| ACTIF := (not CLK_305) default ((not ZACTIF) when CLK_2285)
                   | ZACTIF := ACTIF$1 init false
                   | DV4 := (CV when CLK_421) default ((-2) when CLK_422)
                   |)
                |)
               where 
               event CLK_422, CLK_421;
               boolean ACTIF, ZACTIF;
               end
            %ACT_CLK_ACTIF%; 
            process ACT_CLK_ACTIF_1457 =
                 ( )
               (| CLK_ACTIF_1457 ^= ACTIF_1457 ^= ZACTIF_1458
                | (| CLK_881 := when ACTIF_1457
                   | CLK_882 := when (not ACTIF_1457)
                   |)
                | (| ACTIF_1457 := (not CLK_871) default ((not ZACTIF_1458) when CLK_2282)
                   | ZACTIF_1458 := ACTIF_1457$1 init false
                   | DV4_1462 := (CV_1459 when CLK_881) default ((-2) when CLK_882)
                   |)
                |)
               where 
               event CLK_882, CLK_881;
               boolean ACTIF_1457, ZACTIF_1458;
               end
            %ACT_CLK_ACTIF_1457%; 
            process ACT_CLK_DPM =
                 ( )
               (| CLK_DPM ^= DPM ^= DHOUR ^= CV_841 ^= STATE24_842 ^= CC_2491 ^= CC_2540
                | (| CLK_455 := when STATE24_842
                   | CLK_456 := when (not STATE24_842)
                   |)
                | (| CLK_462 := when DPM
                   | CLK_463 := when (not DPM)
                   |)
                | (| CLK_1411 := when CC_2491 |)
                | (| CLK_XZX_2541 := when (DHOUR>=0)
                   | ACT_CLK_XZX_2541{}
                   |)
                | (| CLK_1578 := CLK_462 ^* CLK_1411
                   | (| WPTAG(40 when CLK_1578,72,5) |)
                   |)
                | (| DPM := ((CV_841>12) when CLK_456) default (not CLK_455)
                   | DHOUR := ((CV_841-12) when CLK_462) default (CV_841 when CLK_463)
                   | CV_841 := (DV when CLK_DV) cell CLK_DPM init 0
                   | STATE24_842 := (STATE24 when CLK_STATE24) cell CLK_DPM init false
                   | CC_2491 := WCLEARAREA(40 when CLK_DPM,64 when CLK_DPM,16,8)
                   | CC_2540 := WCLEARAREA(56 when CLK_DPM,64 when CLK_DPM,16 when CLK_DPM,16 when CLK_DPM)
                   |)
                |)
               where 
               event CLK_1578, CLK_XZX_2541, CLK_1411, CLK_463, CLK_462, CLK_456, CLK_455;
               integer DHOUR, CV_841;
               boolean DPM, STATE24_842, CC_2491, CC_2540;
               process ACT_CLK_XZX_2541 =
                    ( )
                  (| CLK_XZX_2541 ^= XZX_2541
                   | (| XZX_2541 := DHOUR when CLK_XZX_2541
                      | WPINT2(56,80,XZX_2541)
                      |)
                   |)
                  where 
                  integer XZX_2541;
                  end
               %ACT_CLK_XZX_2541%; 
               end
            %ACT_CLK_DPM%; 
            process ACT_CLK_DAMIN =
                 ( )
               (| CLK_DAMIN ^= DAMIN ^= CC_2580
                | (| CLK_XZX_2581 := when (DAMIN>=0)
                   | ACT_CLK_XZX_2581{}
                   |)
                | (| DAMIN := (AMIN when CLK_AMIN) default (DV2_1460 when CLK_2365) default (DV3_1461 when CLK_2345) default (DV4_1462 when CLK_2278)
                   | CC_2580 := WCLEARAREA(80 when CLK_DAMIN,64 when CLK_DAMIN,16 when CLK_DAMIN,16 when CLK_DAMIN)
                   |)
                |)
               where 
               event CLK_XZX_2581;
               boolean CC_2580;
               integer DAMIN;
               process ACT_CLK_XZX_2581 =
                    ( )
                  (| CLK_XZX_2581 ^= XZX_2581
                   | (| XZX_2581 := DAMIN when CLK_XZX_2581
                      | WPINT2(80,80,XZX_2581)
                      |)
                   |)
                  where 
                  integer XZX_2581;
                  end
               %ACT_CLK_XZX_2581%; 
               end
            %ACT_CLK_DAMIN%; 
            process ACT_CLK_V_1143 =
                 ( )
               (| CLK_V_1143 ^= V_1143 ^= ZV_1170
                | (| H_MOD_1144 := when (ZV_1170>=3) |)
                | (| V_1143 := (0 when CLK_V_1185) default ((ZV_1170+1) when CLK_2274)
                   | ZV_1170 := V_1143$1 init 0
                   |)
                |)
               where 
               integer V_1143, ZV_1170;
               end
            %ACT_CLK_V_1143%; 
            process ACT_CLK_V_1185 =
                 ( )
               (| CLK_V_1185 ^= V_1185 ^= ZV_1210
                | (| RINGOFF_164 := when (ZV_1210>=149) |)
                | (| V_1185 := (0 when XRESET_1200) default ((ZV_1210+1) when CLK_2266)
                   | ZV_1210 := V_1185$1 init 0
                   |)
                |)
               where 
               integer V_1185, ZV_1210;
               end
            %ACT_CLK_V_1185%; 
            end
         %ACT_CLK_WDIS%; 
         end
      %ACT_CLK_V1%; 
      end
   %ACT_HE%; 
   process WSTOP =
        ( ? event DOWN;
        )
   
   %WSTOP%; 
   process WPINT2 =
        ( ? integer X;
            integer Y;
            integer V;
        )
        spec (| X ^= Y ^= V |)
   
   %WPINT2%; 
   process WCLEARAREA =
        ( ? integer X1;
            integer Y1;
            integer X2;
            integer Y2;
          ! boolean CC;
        )
        spec (| X1 ^= Y1 ^= X2 ^= Y2 ^= CC |)
   
   %WCLEARAREA%; 
   process RLL =
        ( ! boolean LL;
        )
   
   %RLL%; 
   process RUL =
        ( ! boolean UL;
        )
   
   %RUL%; 
   process WDTAG =
        ( ? integer X;
            integer Y;
            integer STR;
        )
        spec (| X ^= Y ^= STR |)
   
   %WDTAG%; 
   process WPTAG =
        ( ? integer X;
            integer Y;
            integer STR;
        )
        spec (| X ^= Y ^= STR |)
   
   %WPTAG%; 
   process SIGBELL =
        ( ? integer PERCENT;
        )
   
   %SIGBELL%; 
   process RLR =
        ( ! boolean LR;
        )
   
   %RLR%; 
   process RUR =
        ( ! boolean UR;
        )
   
   %RUR%; 
   process RUP =
        ( ! boolean UP;
        )
   
   %RUP%; 
   process RDOWN =
        ( ! boolean DOWN;
        )
   
   %RDOWN%; 
   process RAUTO =
        ( ! boolean AUTO;
        )
   
   %RAUTO%; 
   end
%VTALARM_TRA%; 
