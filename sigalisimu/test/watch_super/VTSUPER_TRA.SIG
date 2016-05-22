process VTSUPER_TRA =
     { integer M1, M2, PI, NAL, PERCENT, TICK_NUMBER, FRONT_NUMBER, TICK_HEIGHT, INTER_TICK, BOOL_HEIGHT, DELTA, BOOL_WIDTH; }
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
   constant integer V_0 = 0;
   constant integer V_0_451 = 0;
   constant integer V_MODULO = 3;
   constant integer V_0_593 = 0;
   constant boolean V0 = false;
   constant integer V_0_847 = 1;
   constant integer V_0_950 = M1-1;
   constant integer V_0_1004 = M2-1;
   constant integer TICK_SIZE = TICK_HEIGHT+INTER_TICK;
   constant integer YS = (11*TICK_SIZE)+(5*BOOL_HEIGHT)+(3*TICK_HEIGHT);
   constant integer TS = DELTA+DELTA+BOOL_WIDTH;
   constant integer V_BOUND = TICK_NUMBER*TS;
   constant integer V_INIT = TS*(FRONT_NUMBER-1);
   constant integer V_BOUND_1195 = TS*TICK_NUMBER;
   constant integer V_INIT_1198 = TS*(TICK_NUMBER-1);
   constant integer DELTA_1242 = DELTA+DELTA+BOOL_WIDTH;
   constant integer BOOL_HEIGHT_1367 = BOOL_HEIGHT/2;
   constant integer DELTA_1370 = DELTA+DELTA+BOOL_WIDTH;
   constant integer Y_POS = TICK_SIZE+(TICK_SIZE+BOOL_HEIGHT);
   constant integer Y_POS_1503 = TICK_SIZE+(2*TICK_SIZE)+BOOL_HEIGHT;
   constant integer Y_POS_1579 = TICK_SIZE+(3*TICK_SIZE)+BOOL_HEIGHT;
   constant integer POS_Y = (4*TICK_SIZE)+(2*BOOL_HEIGHT)+TICK_HEIGHT;
   constant integer Y_POS_1744 = POS_Y+TICK_SIZE;
   constant integer Y_POS_1818 = POS_Y+(2*TICK_SIZE);
   constant integer POS_Y_1894 = (6*TICK_SIZE)+(3*BOOL_HEIGHT)+(2*TICK_HEIGHT);
   constant integer DELTA_1924 = DELTA+DELTA+BOOL_WIDTH;
   constant integer BOOL_HEIGHT_2020 = BOOL_HEIGHT/2;
   constant integer DELTA_2021 = DELTA+DELTA+BOOL_WIDTH;
   constant integer Y_POS_2076 = POS_Y_1894+(TICK_SIZE+BOOL_HEIGHT);
   constant integer Y_POS_2150 = POS_Y_1894+(2*TICK_SIZE)+BOOL_HEIGHT;
   constant integer Y_POS_2225 = POS_Y_1894+(3*TICK_SIZE)+BOOL_HEIGHT;
   constant integer POS_Y_2300 = (9*TICK_SIZE)+(5*BOOL_HEIGHT)+(3*TICK_HEIGHT);
   constant integer Y_POS_2386 = POS_Y_2300+TICK_SIZE;
   process ACT_HE =
        ( )
      (| HE ^= AUTOMOD ^= C_UP ^= C_DOWN ^= C_AUTO
       | (| CLK_MAX := when AUTOMOD
          | CLK_MAX ^= ZMAX
          | ACT_CLK_MAX{}
          | CLK_405 := when (not AUTOMOD)
          |)
       | (| UP0_723 := when C_UP
          | CLK_430 := when (not C_UP)
          |)
       | (| DOWN_750 := when C_DOWN
          | CLK_435 := when (not C_DOWN)
          |)
       | (| CLK_CAUTO := when C_AUTO
          | CLK_CAUTO ^= CAUTO
          | ACT_CLK_CAUTO{}
          | CLK_440 := when (not C_AUTO)
          |)
       | (| CLK_968 := DOWN_750 ^+ CLK_CAUTO |)
       | (| CLK_970 := CLK_968 ^+ UP0_723 |)
       | (| HSTOP_724 := CLK_405 ^* DOWN_750
          | (| WSTOP(HSTOP_724) |)
          |)
       | (| CLK_VD := CLK_MAX ^* DOWN_750
          | CLK_VD ^= VD
          | (| VD := (ZMAX+ZMAX) when CLK_VD |)
          |)
       | (| UPS_721 := CLK_MAX ^* UP0_723 |)
       | (| CLK_1007 := CLK_MAX ^+ UP0_723 |)
       | (| CLK_VU := UPS_721 ^* CLK_453
          | CLK_VU ^= VU
          | (| VU := (ZMAX/2) when CLK_VU |)
          |)
       | (| CLK_1013 := CLK_VD ^+ UPS_721 |)
       | (| CLK_1016 := CLK_VD ^+ CLK_VU |)
       | (| CLK_1020 := HSTOP_724 ^+ CLK_MAX |)
       | (| CLK_1022 := CLK_1020 ^+ UP0_723 |)
       | (| CLK_V1 := UP0_723 ^+ HES_811
          | ACT_CLK_V1{}
          |)
       | (| CLK_1106 := CLK_VD ^- CLK_VU |)
       | (| CLK_1109 := CLK_MAX ^- CLK_1016 |)
       | (| CLK_1125 := UP0_723 ^- HES_811 |)
       | (| AUTOMOD := (CAUTO when CLK_CAUTO) cell HE init false
          | C_UP := RUP()
          | C_DOWN := RDOWN()
          | C_AUTO := RAUTO()
          |)
       |)
      where 
      event CLK_1125, CLK_1109, CLK_1106, CLK_V1, CLK_1022, CLK_1020, CLK_1016, CLK_1013, CLK_VU, CLK_1007, UPS_721, CLK_VD, HSTOP_724, CLK_970, CLK_968, HES_811, CLK_453, CLK_440, CLK_CAUTO, CLK_435, DOWN_750, CLK_430, UP0_723, CLK_405, CLK_MAX;
      integer VU, VD, ZMAX;
      boolean AUTOMOD, CAUTO, C_UP, C_DOWN, C_AUTO;
      process ACT_CLK_MAX =
           ( )
         (| CLK_MAX ^= MAX ^= V_842 ^= ZV_855
          | (| CLK_453 := when (ZMAX>1)
             | CLK_454 := when (not (ZMAX>1))
             |)
          | (| HES_811 := when (ZV_855>=(MAX-1))
             | CLK_476 := when (not (ZV_855>=(MAX-1)))
             |)
          | (| MAX := (VU when CLK_VU) default (VD when CLK_1106) default (ZMAX when CLK_1109)
             | ZMAX := MAX$1 init 10
             | V_842 := (0 when HES_811) default ((ZV_855+1) when CLK_476)
             | ZV_855 := V_842$1 init 1
             |)
          |)
         where 
         event CLK_476, CLK_454;
         integer MAX, V_842, ZV_855;
         end
      %ACT_CLK_MAX%; 
      process ACT_CLK_CAUTO =
           ( )
         (| CLK_CAUTO ^= ZB
          | (| CAUTO := not ZB
             | ZB := CAUTO$1 init V0
             |)
          |)
         where 
         boolean ZB;
         end
      %ACT_CLK_CAUTO%; 
      process ACT_CLK_V1 =
           ( )
         (| CLK_V1 ^= V1 ^= ZV_956
          | (| CLK_SWDIS := when (ZV_956>=(M1-1))
             | ACT_CLK_SWDIS{}
             | CLK_537 := when (not (ZV_956>=(M1-1)))
             |)
          | (| V1 := (0 when CLK_SWDIS) default ((ZV_956+1) when CLK_537)
             | ZV_956 := V1$1 init V_0_950
             |)
          |)
         where 
         event CLK_537, CLK_SWDIS;
         integer V1, ZV_956;
         process ACT_CLK_SWDIS =
              ( )
            (| CLK_SWDIS ^= SWDIS ^= WDIS ^= ADIS ^= CST ^= STNB ^= NRINGING ^= CRINGING ^= LR_967 ^= UR_975 ^= V2 ^= ZV_1010 ^= CRINGUP ^= X ^= V_1134 ^= ZV_1149 ^= V1_1150 ^= XZX_1161 ^= ZV_1207 ^= V1_1208 ^= XZX_1249 ^= XZX_1931 ^= X1_2395 ^= Y21_2396 
               ^= Y2_2398 ^= X2_2399 ^= X3_2400
             | (| CLK_ZMODE := when WDIS
                | CLK_ZMODE ^= ZMODE
                | ACT_CLK_ZMODE{}
                | CLK := when (not WDIS)
                |)
             | (| CLK_ZMODE_353 := when ADIS
                | CLK_ZMODE_353 ^= ZMODE_353
                | ACT_CLK_ZMODE_353{}
                | CLK_143 := when (not ADIS)
                |)
             | (| CLK_291 := when SWDIS
                | CLK_292 := when (not SWDIS)
                |)
             | (| UR_708 := when UR_975
                | CLK_548 := when (not UR_975)
                |)
             | (| LR_709 := when LR_967
                | CLK_550 := when (not LR_967)
                |)
             | (| CLK_LL_1021 := when (ZV_1010>=(M2-1))
                | ACT_CLK_LL_1021{}
                | CLK_560 := when (not (ZV_1010>=(M2-1)))
                |)
             | (| RINGUP_69 := when CRINGUP
                | CLK_580 := when (not CRINGUP)
                |)
             | (| CLK_603 := when (V1_1150>=V_BOUND)
                | CLK_604 := when (not (V1_1150>=V_BOUND))
                |)
             | (| CLK_620 := when (V1_1208>=V_BOUND_1195)
                | CLK_621 := when (not (V1_1208>=V_BOUND_1195))
                |)
             | (| CLK_X1 := when XZX_1249
                | ACT_CLK_X1{}
                | CLK_633 := when (not XZX_1249)
                |)
             | (| CLK_X1_1930 := when XZX_1931
                | ACT_CLK_X1_1930{}
                | CLK_805 := when (not XZX_1931)
                |)
             | (| CLK_972 := UR_708 ^+ LR_709 |)
             | (| CLK_XZX_906 := UR_708 ^+ CLK_XZX_896
                | ACT_CLK_XZX_906{}
                |)
             | (| CLK_RINGING := CLK_XZX_906 ^+ LR_709
                | ACT_CLK_RINGING{}
                |)
             | (| CLK_991 := CLK_RINGING ^+ CLK_LL_1021 |)
             | (| SUR_163 := CLK_356 ^* SUR_72 |)
             | (| SLL_162 := CLK_356 ^* SLL_71 |)
             | (| SUL_161 := CLK_356 ^* SUL_70 |)
             | (| CLK_XZX_383 := RINGUP_69 ^+ STOPAL_166
                | CLK_XZX_383 ^= XZX_383
                | ACT_CLK_XZX_383{}
                |)
             | (| CLK_WBI := CLK_XZX_383 ^+ CLK_LL_1021
                | ACT_CLK_WBI{}
                |)
             | (| CLK_1031 := SUR_163 ^+ CLK_1024 |)
             | (| CLK_1033 := CLK_1031 ^+ SLL_162 |)
             | (| CLK_1035 := CLK_1033 ^+ SUL_161 |)
             | (| CLK_1038 := SUR_72 ^+ SLR_73 |)
             | (| CLK_V := ERESET_401 ^+ CLK_265
                | ACT_CLK_V{}
                |)
             | (| CLK_1048 := CLK_1038 ^+ SLL_71 |)
             | (| CLK_1050 := CLK_1048 ^+ SUL_70 |)
             | (| CLK_1054 := H_MOD_405 ^* CLK_223 |)
             | (| BEEP_56 := CLK_1054 ^+ ERESET_401 |)
             | (| CLK_XZX_1054 := BEEP_56 ^+ TBEEP_68
                | ACT_CLK_XZX_1054{}
                |)
             | (| CLK_1060 := BEEP_56 ^* CLK_223 |)
             | (| CLK_V_446 := H_MOD_405 ^+ ERESET_401
                | ACT_CLK_V_446{}
                |)
             | (| CLK_1075 := CLK_XZX_383 ^+ RINGOFF_165 |)
             | (| CLK_1078 := BEEP_56 ^+ RINGOFF_165 |)
             | (| CLK_1080 := RINGUP_69 ^+ RINGOFF_165 |)
             | (| LocRESET_461 := RINGOFF_165 ^+ ERESET_401 |)
             | (| CLK_1085 := CLK_1080 ^+ CLK_RINGING |)
             | (| CLK_1087 := CLK_V_446 ^- ERESET_401 |)
             | (| CLK_1089 := CLK_V_446 ^- LocRESET_461 |)
             | (| CLK_1091 := BEEP_56 ^- TBEEP_68 |)
             | (| CLK_1093 := CLK_1054 ^- ERESET_401 |)
             | (| CLK_1096 := CLK_V ^- CLK_V_446 |)
             | (| CLK_1098 := CLK_V ^- ERESET_401 |)
             | (| CLK_1100 := CLK_WBI ^- CLK_1075 |)
             | (| CLK_1102 := CLK_XZX_383 ^- CLK_LL_1021 |)
             | (| CLK_1104 := CLK_XZX_383 ^- RINGOFF_165 |)
             | (| CLK_1111 := RINGUP_69 ^- STOPAL_166 |)
             | (| CLK_1113 := CLK_SWDIS ^- CLK_1085 |)
             | (| CLK_1115 := CLK_RINGING ^- CLK_1080 |)
             | (| CLK_1121 := LR_709 ^- CLK_XZX_906 |)
             | (| CLK_1123 := UR_708 ^- CLK_XZX_896 |)
             | (| CLK_1128 := ERESET_401 ^- H_MOD_405 |)
             | (| CLK_1133 := RINGOFF_165 ^- ERESET_401 |)
             | (| CLK_1135 := RINGOFF_165 ^- RINGUP_69 |)
             | (| CLK_1138 := CLK_SWDIS ^- CLK_RINGING |)
             | (| CLK_X0_1752 := CLK_291 ^* SUR_72
                | ACT_CLK_X0_1752{}
                |)
             | (| CLK_X0_1826 := CLK_291 ^* SLR_73
                | ACT_CLK_X0_1826{}
                |)
             | (| CLK_AMODONOFF := CLK_ZMODE_353 ^* SUL_161
                | CLK_AMODONOFF ^= AMODONOFF
                | (| AMODONOFF := (not ZMODE_353) when CLK_AMODONOFF |)
                |)
             | (| CLK_MODONOFF := CLK_ZMODE ^* SUL_161
                | CLK_MODONOFF ^= MODONOFF
                | (| MODONOFF := (not ZMODE) when CLK_MODONOFF |)
                |)
             | (| CLK_X0_1954 := CLK_291 ^* SLL_162
                | ACT_CLK_X0_1954{}
                |)
             | (| CLK_X0_2234 := SLL_162 ^* CLK_Y11_2029
                | ACT_CLK_X0_2234{}
                |)
             | (| CLK_X0 := SLL_162 ^* CLK_Y12_2030
                | ACT_CLK_X0{}
                |)
             | (| XLL_342 := CLK_ZMODE_353 ^* SLL_162 |)
             | (| CLK_X0_1589 := SLL_162 ^* CLK_Y11
                | ACT_CLK_X0_1589{}
                |)
             | (| CLK_X0_1678 := SLL_162 ^* CLK_Y12
                | ACT_CLK_X0_1678{}
                |)
             | (| XLL_274 := CLK_ZMODE ^* SLL_162 |)
             | (| CLK_X0_2084 := CLK_ZMODE_353 ^* SUR_163
                | ACT_CLK_X0_2084{}
                |)
             | (| CLK_X0_1434 := CLK_ZMODE ^* SUR_163
                | ACT_CLK_X0_1434{}
                |)
             | (| CLK_X0_2159 := CLK_ZMODE_353 ^* SLR_164
                | ACT_CLK_X0_2159{}
                |)
             | (| CLK_X0_1513 := CLK_ZMODE ^* SLR_164
                | ACT_CLK_X0_1513{}
                |)
             | (| CLK_1228 := CLK_X0_1434 ^+ CLK_X0_1513 |)
             | (| CLK_1230 := CLK_X0_2084 ^+ CLK_X0_2159 |)
             | (| CLK_1234 := CLK_X0_1589 ^+ CLK_X0_1513 |)
             | (| CLK_1237 := CLK_1234 ^+ CLK_X0_1434 |)
             | (| CLK_1239 := CLK_X0 ^+ CLK_X1 |)
             | (| CLK_1241 := CLK_X0 ^+ CLK_ZMODE |)
             | (| CLK_1243 := CLK_1241 ^+ CLK_X1 |)
             | (| CLK_1246 := CLK_1239 ^+ CLK_1234 |)
             | (| CLK_1251 := CLK_X0_2234 ^+ CLK_X0_2159 |)
             | (| CLK_1253 := CLK_1251 ^+ CLK_X0_2084 |)
             | (| CLK_1255 := CLK_ZMODE_353 ^+ RINGOFF_165 |)
             | (| CLK_1257 := CLK_1255 ^+ BEEP_56 |)
             | (| CLK_1259 := CLK_1257 ^+ CLK_ZMODE |)
             | (| CLK_1265 := CLK_X0_1954 ^+ CLK_1251 |)
             | (| CLK_1267 := CLK_X0_1954 ^+ CLK_X0_1678 |)
             | (| CLK_1269 := CLK_X0_1954 ^+ CLK_X1_1930 |)
             | (| CLK_1271 := CLK_X0_1954 ^+ CLK_ZMODE_353 |)
             | (| CLK_1273 := CLK_1271 ^+ CLK_X1_1930 |)
             | (| CLK_1276 := CLK_1269 ^+ CLK_1251 |)
             | (| CLK_NST := CLK_1267 ^+ CLK_X0
                | CLK_NST ^= NST
                | ACT_CLK_NST{}
                |)
             | (| CLK_1282 := CLK_MODONOFF ^+ CLK_1257 |)
             | (| CLK_1285 := CLK_MODONOFF ^+ XLL_274 |)
             | (| CLK_1287 := CLK_1285 ^+ CLK_X0_1513 |)
             | (| CLK_1289 := CLK_1287 ^+ CLK_X0_1434 |)
             | (| CLK_1292 := CLK_AMODONOFF ^+ CLK_X0 |)
             | (| CLK_1294 := CLK_AMODONOFF ^+ XLL_342 |)
             | (| CLK_1296 := CLK_1294 ^+ CLK_X0_2159 |)
             | (| CLK_1298 := CLK_1296 ^+ CLK_X0_2084 |)
             | (| CLK_1303 := CLK_X0_1752 ^+ CLK_X0_1826 |)
             | (| CLK_1305 := CLK_1303 ^+ CLK_X0_1954 |)
             | (| CLK_1307 := CLK_1303 ^+ CLK_X0_1678 |)
             | (| CLK_1309 := CLK_1303 ^+ SLL_162 |)
             | (| CLK_1311 := CLK_1307 ^+ CLK_1271 |)
             | (| CLK_1313 := CLK_1307 ^+ CLK_1273 |)
             | (| CLK_1315 := CLK_1313 ^+ CLK_1243 |)
             | (| CLK_1317 := CLK_1311 ^+ CLK_1243 |)
             | (| CLK_1319 := CLK_ZMODE_353 ^+ BEEP_56 |)
             | (| CLK_1324 := CLK_1319 ^+ CLK_ZMODE |)
             | (| CLK_1331 := CLK_1324 ^+ CLK_X0_1954 |)
             | (| CLK_1333 := CLK_1331 ^+ CLK_X0_1752 |)
             | (| CLK_1335 := CLK_1333 ^+ CLK_X0_1826 |)
             | (| CLK_1337 := CLK_X0 ^- CLK_1267 |)
             | (| CLK_1339 := CLK_X0_1678 ^- CLK_X0_1954 |)
             | (| CLK_1341 := CLK_SWDIS ^- CLK_X0_1954 |)
             | (| CLK_1343 := CLK_SWDIS ^- CLK_X0 |)
             | (| CLK_1345 := CLK_ZMODE ^- CLK_MODONOFF |)
             | (| CLK_1347 := CLK_ZMODE_353 ^- CLK_AMODONOFF |)
             | (| SWDIS := STNB=1
                | WDIS := STNB=0
                | ADIS := STNB=2
                | CST := (NST when CLK_NST) cell CLK_SWDIS init 0
                | STNB := CST$1 init 0
                | NRINGING := RINGUP_69 default (not CLK_1135) default (not CLK_1115) default (CRINGING when CLK_1113)
                | CRINGING := NRINGING$1 init false
                | LR_967 := RLR()
                | UR_975 := RUR()
                | V2 := (0 when CLK_LL_1021) default ((ZV_1010+1) when CLK_560)
                | ZV_1010 := V2$1 init V_0_1004
                | CRINGUP := RRINGUP()
                | X := (0 when CLK_620) default (V1_1208 when CLK_621)
                | V_1134 := (0 when CLK_603) default (V1_1150 when CLK_604)
                | ZV_1149 := V_1134$1 init V_INIT
                | V1_1150 := ZV_1149+TS
                | XZX_1161 := V_1134+TS
                | WEFFACE(V_1134,0 when CLK_SWDIS,XZX_1161,YS)
                | ZV_1207 := X$1 init V_INIT_1198
                | V1_1208 := ZV_1207+TS
                | XZX_1249 := (not CLK_X0) default CLK_1343
                | XZX_1931 := (not CLK_X0_1954) default CLK_1341
                | X1_2395 := X+DELTA
                | Y21_2396 := (-TICK_HEIGHT) when CLK_SWDIS
                | Y2_2398 := Y_POS_2386+Y21_2396
                | X2_2399 := X1_2395+BOOL_WIDTH
                | X3_2400 := X2_2399+DELTA
                | WHLINE(X,Y_POS_2386,X1_2395)
                | WVLINE(X1_2395,Y_POS_2386,Y2_2398)
                | WHLINE(X1_2395,Y2_2398,X2_2399)
                | WVLINE(X2_2399,Y_POS_2386,Y2_2398)
                | WHLINE(X2_2399,Y_POS_2386,X3_2400)
                |)
             |)
            where 
            event CLK_1347, CLK_1345, CLK_1343, CLK_1341, CLK_1339, CLK_1337, CLK_1335, CLK_1333, CLK_1331, CLK_1324, CLK_1319, CLK_1317, CLK_1315, CLK_1313, CLK_1311, CLK_1309, CLK_1307, CLK_1305, CLK_1303, CLK_1298, CLK_1296, CLK_1294, CLK_1292, 
                 CLK_1289, CLK_1287, CLK_1285, CLK_1282, CLK_NST, CLK_1276, CLK_1273, CLK_1271, CLK_1269, CLK_1267, CLK_1265, CLK_1259, CLK_1257, CLK_1255, CLK_1253, CLK_1251, CLK_1246, CLK_1243, CLK_1241, CLK_1239, CLK_1237, CLK_1234, CLK_1230, CLK_1228, 
                 CLK_X0_1513, CLK_X0_2159, CLK_X0_1434, CLK_X0_2084, XLL_274, CLK_X0_1678, CLK_X0_1589, XLL_342, CLK_X0, CLK_X0_2234, CLK_X0_1954, CLK_MODONOFF, CLK_AMODONOFF, CLK_X0_1826, CLK_X0_1752, CLK_1138, CLK_1135, CLK_1133, CLK_1128, CLK_1123, 
                 CLK_1121, CLK_1115, CLK_1113, CLK_1111, CLK_1104, CLK_1102, CLK_1100, CLK_1098, CLK_1096, CLK_1093, CLK_1091, CLK_1089, CLK_1087, CLK_1085, LocRESET_461, CLK_1080, CLK_1078, CLK_1075, CLK_V_446, CLK_1060, CLK_XZX_1054, BEEP_56, CLK_1054, 
                 CLK_1050, CLK_1048, CLK_V, CLK_1038, CLK_1035, CLK_1033, CLK_1031, CLK_WBI, CLK_XZX_383, CLK_1024, SUL_161, SLL_162, SUR_163, SLR_164, CLK_991, CLK_RINGING, CLK_XZX_906, CLK_XZX_896, TBEEP_68, CLK_972, CLK_805, CLK_X1_1930, CLK_633, 
                 CLK_X1, CLK_621, CLK_620, CLK_604, CLK_603, CLK_580, RINGUP_69, CLK_560, CLK_LL_1021, CLK_550, LR_709, CLK_548, UR_708, SLR_73, SUR_72, SLL_71, SUL_70, CLK_356, STOPAL_166, CLK_292, CLK_291, CLK_265, ERESET_401, RINGOFF_165, CLK_223, 
                 H_MOD_405, CLK_Y12_2030, CLK_Y11_2029, CLK_143, CLK_ZMODE_353, CLK_Y12, CLK_Y11, CLK, CLK_ZMODE;
            integer CST, STNB, NST, V2, ZV_1010, X, V_1134, ZV_1149, V1_1150, XZX_1161, ZV_1207, V1_1208, X1_2395, Y21_2396, Y2_2398, X2_2399, X3_2400;
            boolean SWDIS, WDIS, ADIS, ZMODE, MODONOFF, ZMODE_353, AMODONOFF, XZX_383, NRINGING, CRINGING, LR_967, UR_975, CRINGUP, XZX_1249, XZX_1931;
            process ACT_CLK_ZMODE =
                 ( )
               (| CLK_ZMODE ^= MODE ^= X1_1376 ^= Y1 ^= Y2_1380 ^= X2_1383 ^= XZX_1395 ^= XZX_1401
                | (| CLK_Y11 := when MODE
                   | CLK_Y11 ^= Y11 ^= Y21_1381
                   | ACT_CLK_Y11{}
                   | CLK_Y12 := when (not MODE)
                   | CLK_Y12 ^= Y12 ^= Y22_1382
                   | ACT_CLK_Y12{}
                   |)
                | (| ZMODE := MODE$1 init false
                   | MODE := (MODONOFF when CLK_MODONOFF) default (ZMODE when CLK_1345)
                   | X1_1376 := X when CLK_ZMODE
                   | Y1 := TICK_SIZE+XZX_1395
                   | Y2_1380 := TICK_SIZE+XZX_1401
                   | X2_1383 := X1_1376+DELTA_1370
                   | XZX_1395 := (Y11 when CLK_Y11) default (Y12 when CLK_Y12)
                   | XZX_1401 := (Y21_1381 when CLK_Y11) default (Y22_1382 when CLK_Y12)
                   | WHLINE(X1_1376,Y1,X2_1383)
                   | WHLINE(X1_1376,Y2_1380,X2_1383)
                   |)
                |)
               where 
               integer X1_1376, Y1, Y11, Y12, Y2_1380, Y21_1381, Y22_1382, X2_1383, XZX_1395, XZX_1401;
               boolean MODE;
               process ACT_CLK_Y11 =
                    ( )
                  (| (| Y11 := (-BOOL_HEIGHT_1367) when CLK_Y11
                      | Y21_1381 := Y11-1
                      |) |)
               %ACT_CLK_Y11%; 
               process ACT_CLK_Y12 =
                    ( )
                  (| (| Y12 := BOOL_HEIGHT_1367 when CLK_Y12
                      | Y22_1382 := Y12+1
                      |) |)
               %ACT_CLK_Y12%; 
               end
            %ACT_CLK_ZMODE%; 
            process ACT_CLK_ZMODE_353 =
                 ( )
               (| CLK_ZMODE_353 ^= AMODE ^= X1_2027 ^= Y1_2028 ^= Y2_2031 ^= X2_2034 ^= XZX_2046 ^= XZX_2052
                | (| CLK_Y11_2029 := when AMODE
                   | CLK_Y11_2029 ^= Y11_2029 ^= Y21_2032
                   | ACT_CLK_Y11_2029{}
                   | CLK_Y12_2030 := when (not AMODE)
                   | CLK_Y12_2030 ^= Y12_2030 ^= Y22_2033
                   | ACT_CLK_Y12_2030{}
                   |)
                | (| ZMODE_353 := AMODE$1 init false
                   | AMODE := (AMODONOFF when CLK_AMODONOFF) default (ZMODE_353 when CLK_1347)
                   | X1_2027 := X when CLK_ZMODE_353
                   | Y1_2028 := POS_Y_1894+XZX_2046
                   | Y2_2031 := POS_Y_1894+XZX_2052
                   | X2_2034 := X1_2027+DELTA_2021
                   | XZX_2046 := (Y11_2029 when CLK_Y11_2029) default (Y12_2030 when CLK_Y12_2030)
                   | XZX_2052 := (Y21_2032 when CLK_Y11_2029) default (Y22_2033 when CLK_Y12_2030)
                   | WHLINE(X1_2027,Y1_2028,X2_2034)
                   | WHLINE(X1_2027,Y2_2031,X2_2034)
                   |)
                |)
               where 
               integer X1_2027, Y1_2028, Y11_2029, Y12_2030, Y2_2031, Y21_2032, Y22_2033, X2_2034, XZX_2046, XZX_2052;
               boolean AMODE;
               process ACT_CLK_Y11_2029 =
                    ( )
                  (| (| Y11_2029 := (-BOOL_HEIGHT_2020) when CLK_Y11_2029
                      | Y21_2032 := Y11_2029-1
                      |) |)
               %ACT_CLK_Y11_2029%; 
               process ACT_CLK_Y12_2030 =
                    ( )
                  (| (| Y12_2030 := BOOL_HEIGHT_2020 when CLK_Y12_2030
                      | Y22_2033 := Y12_2030+1
                      |) |)
               %ACT_CLK_Y12_2030%; 
               end
            %ACT_CLK_ZMODE_353%; 
            process ACT_CLK_LL_1021 =
                 ( )
               (| CLK_LL_1021 ^= LL_1021 ^= UL_1029 ^= X0_2320 ^= X1_2321 ^= Y21_2322 ^= Y2_2324 ^= X2_2325 ^= X3_2326
                | (| UL_710 := when UL_1029
                   | CLK_571 := when (not UL_1029)
                   |)
                | (| LL_711 := when LL_1021
                   | CLK_573 := when (not LL_1021)
                   |)
                | (| TBEEP_68 := UL_710 ^* LL_711 |)
                | (| CLK_XZX_896 := UL_710 ^+ LL_711
                   | ACT_CLK_XZX_896{}
                   |)
                | (| CLK_1117 := LL_711 ^- UL_710 |)
                | (| CLK_1119 := UL_710 ^- LL_711 |)
                | (| LL_1021 := RLL()
                   | UL_1029 := RUL()
                   | X0_2320 := X when CLK_LL_1021
                   | X1_2321 := X0_2320+DELTA
                   | Y21_2322 := (-TICK_HEIGHT) when CLK_LL_1021
                   | Y2_2324 := POS_Y_2300+Y21_2322
                   | X2_2325 := X1_2321+BOOL_WIDTH
                   | X3_2326 := X2_2325+DELTA
                   | WHLINE(X0_2320,POS_Y_2300,X1_2321)
                   | WVLINE(X1_2321,POS_Y_2300,Y2_2324)
                   | WHLINE(X1_2321,Y2_2324,X2_2325)
                   | WVLINE(X2_2325,POS_Y_2300,Y2_2324)
                   | WHLINE(X2_2325,POS_Y_2300,X3_2326)
                   |)
                |)
               where 
               event CLK_1119, CLK_1117, CLK_573, LL_711, CLK_571, UL_710;
               integer X0_2320, X1_2321, Y21_2322, Y2_2324, X2_2325, X3_2326;
               boolean LL_1021, UL_1029;
               process ACT_CLK_XZX_896 =
                    ( )
                  (| CLK_XZX_896 ^= XZX_896 ^= XZX_900
                   | (| SUL_70 := when XZX_896
                      | CLK_499 := when (not XZX_896)
                      |)
                   | (| SLL_71 := when XZX_900
                      | CLK_503 := when (not XZX_900)
                      |)
                   | (| XZX_896 := (not LL_711) default CLK_1119
                      | XZX_900 := (not UL_710) default CLK_1117
                      |)
                   |)
                  where 
                  event CLK_503, CLK_499;
                  boolean XZX_896, XZX_900;
                  end
               %ACT_CLK_XZX_896%; 
               end
            %ACT_CLK_LL_1021%; 
            process ACT_CLK_X1 =
                 ( )
               (| CLK_X1 ^= X1 ^= XZX_1254
                | (| X1 := X when CLK_X1
                   | XZX_1254 := X1+DELTA_1242
                   | WHLINE(X1,TICK_SIZE,XZX_1254)
                   |)
                |)
               where 
               integer X1, XZX_1254;
               end
            %ACT_CLK_X1%; 
            process ACT_CLK_X1_1930 =
                 ( )
               (| CLK_X1_1930 ^= X1_1930 ^= XZX_1936
                | (| X1_1930 := X when CLK_X1_1930
                   | XZX_1936 := X1_1930+DELTA_1924
                   | WHLINE(X1_1930,POS_Y_1894,XZX_1936)
                   |)
                |)
               where 
               integer X1_1930, XZX_1936;
               end
            %ACT_CLK_X1_1930%; 
            process ACT_CLK_XZX_906 =
                 ( )
               (| CLK_XZX_906 ^= XZX_906
                | (| SUR_72 := when XZX_906
                   | CLK_509 := when (not XZX_906)
                   |)
                | (| XZX_906 := (not CLK_XZX_896) default CLK_1123 |)
                |)
               where 
               event CLK_509;
               boolean XZX_906;
               end
            %ACT_CLK_XZX_906%; 
            process ACT_CLK_RINGING =
                 ( )
               (| CLK_RINGING ^= RINGING ^= XZX_910
                | (| STOPAL_166 := when RINGING
                   | CLK_356 := when (not RINGING)
                   |)
                | (| SLR_73 := when XZX_910
                   | CLK_514 := when (not XZX_910)
                   |)
                | (| SLR_164 := CLK_356 ^* SLR_73 |)
                | (| CLK_1024 := STOPAL_166 ^+ SLR_164 |)
                | (| RINGING := CRINGING when CLK_RINGING
                   | XZX_910 := (not CLK_XZX_906) default CLK_1121
                   |)
                |)
               where 
               event CLK_514;
               boolean RINGING, XZX_910;
               end
            %ACT_CLK_RINGING%; 
            process ACT_CLK_XZX_383 =
                 ( )
               (| (| ERESET_401 := when XZX_383
                   | CLK_264 := when (not XZX_383)
                   |)
                | (| XZX_383 := (not STOPAL_166) default CLK_1111 |)
                |)
               where 
               event CLK_264;
               end
            %ACT_CLK_XZX_383%; 
            process ACT_CLK_WBI =
                 ( )
               (| CLK_WBI ^= WBI ^= BTI
                | (| CLK_223 := when WBI
                   | CLK_224 := when (not WBI)
                   |)
                | (| CLK_265 := when BTI
                   | CLK_266 := when (not BTI)
                   |)
                | (| WBI := (not RINGOFF_165) default (XZX_383 when CLK_1104) default (BTI when CLK_1100)
                   | BTI := WBI$1 init false
                   |)
                |)
               where 
               event CLK_266, CLK_224;
               boolean WBI, BTI;
               end
            %ACT_CLK_WBI%; 
            process ACT_CLK_V =
                 ( )
               (| CLK_V ^= V ^= ZV
                | (| H_MOD_405 := when (ZV>=(PI-1))
                   | CLK_216 := when (not (ZV>=(PI-1)))
                   |)
                | (| V := (0 when CLK_V_446) default ((ZV+1) when CLK_1096)
                   | ZV := V$1 init 0
                   |)
                |)
               where 
               event CLK_216;
               integer V, ZV;
               end
            %ACT_CLK_V%; 
            process ACT_CLK_XZX_1054 =
                 ( )
               (| CLK_XZX_1054 ^= XZX_1054
                | (| XZX_1054 := PERCENT when CLK_XZX_1054
                   | SIGBELL(XZX_1054)
                   |)
                |)
               where 
               integer XZX_1054;
               end
            %ACT_CLK_XZX_1054%; 
            process ACT_CLK_V_446 =
                 ( )
               (| CLK_V_446 ^= V_446 ^= ZV_471
                | (| RINGOFF_165 := when (ZV_471>=(NAL-1))
                   | CLK_247 := when (not (ZV_471>=(NAL-1)))
                   |)
                | (| V_446 := (0 when LocRESET_461) default ((ZV_471+1) when CLK_1089)
                   | ZV_471 := V_446$1 init 0
                   |)
                |)
               where 
               event CLK_247;
               integer V_446, ZV_471;
               end
            %ACT_CLK_V_446%; 
            process ACT_CLK_X0_1752 =
                 ( )
               (| CLK_X0_1752 ^= X0_1752 ^= X1_1753 ^= Y21_1754 ^= Y2_1756 ^= X2_1757 ^= X3_1758
                | (| X0_1752 := X when CLK_X0_1752
                   | X1_1753 := X0_1752+DELTA
                   | Y21_1754 := (-TICK_HEIGHT) when CLK_X0_1752
                   | Y2_1756 := Y_POS_1744+Y21_1754
                   | X2_1757 := X1_1753+BOOL_WIDTH
                   | X3_1758 := X2_1757+DELTA
                   | WHLINE(X0_1752,Y_POS_1744,X1_1753)
                   | WVLINE(X1_1753,Y_POS_1744,Y2_1756)
                   | WHLINE(X1_1753,Y2_1756,X2_1757)
                   | WVLINE(X2_1757,Y_POS_1744,Y2_1756)
                   | WHLINE(X2_1757,Y_POS_1744,X3_1758)
                   |)
                |)
               where 
               integer X0_1752, X1_1753, Y21_1754, Y2_1756, X2_1757, X3_1758;
               end
            %ACT_CLK_X0_1752%; 
            process ACT_CLK_X0_1826 =
                 ( )
               (| CLK_X0_1826 ^= X0_1826 ^= X1_1827 ^= Y21_1828 ^= Y2_1830 ^= X2_1831 ^= X3_1832
                | (| X0_1826 := X when CLK_X0_1826
                   | X1_1827 := X0_1826+DELTA
                   | Y21_1828 := (-TICK_HEIGHT) when CLK_X0_1826
                   | Y2_1830 := Y_POS_1818+Y21_1828
                   | X2_1831 := X1_1827+BOOL_WIDTH
                   | X3_1832 := X2_1831+DELTA
                   | WHLINE(X0_1826,Y_POS_1818,X1_1827)
                   | WVLINE(X1_1827,Y_POS_1818,Y2_1830)
                   | WHLINE(X1_1827,Y2_1830,X2_1831)
                   | WVLINE(X2_1831,Y_POS_1818,Y2_1830)
                   | WHLINE(X2_1831,Y_POS_1818,X3_1832)
                   |)
                |)
               where 
               integer X0_1826, X1_1827, Y21_1828, Y2_1830, X2_1831, X3_1832;
               end
            %ACT_CLK_X0_1826%; 
            process ACT_CLK_X0_1954 =
                 ( )
               (| CLK_X0_1954 ^= X0_1954 ^= X1_1955 ^= Y21_1956 ^= Y2_1958 ^= X2_1959 ^= X3_1960
                | (| X0_1954 := X when CLK_X0_1954
                   | X1_1955 := X0_1954+DELTA
                   | Y21_1956 := (-BOOL_HEIGHT) when CLK_X0_1954
                   | Y2_1958 := POS_Y_1894+Y21_1956
                   | X2_1959 := X1_1955+BOOL_WIDTH
                   | X3_1960 := X2_1959+DELTA
                   | WHLINE(X0_1954,POS_Y_1894,X1_1955)
                   | WVLINE(X1_1955,POS_Y_1894,Y2_1958)
                   | WHLINE(X1_1955,Y2_1958,X2_1959)
                   | WVLINE(X2_1959,POS_Y_1894,Y2_1958)
                   | WHLINE(X2_1959,POS_Y_1894,X3_1960)
                   |)
                |)
               where 
               integer X0_1954, X1_1955, Y21_1956, Y2_1958, X2_1959, X3_1960;
               end
            %ACT_CLK_X0_1954%; 
            process ACT_CLK_X0_2234 =
                 ( )
               (| CLK_X0_2234 ^= X0_2234 ^= X1_2235 ^= Y21_2236 ^= Y2_2238 ^= X2_2239 ^= X3_2240
                | (| X0_2234 := X when CLK_X0_2234
                   | X1_2235 := X0_2234+DELTA
                   | Y21_2236 := (-TICK_HEIGHT) when CLK_X0_2234
                   | Y2_2238 := Y_POS_2225+Y21_2236
                   | X2_2239 := X1_2235+BOOL_WIDTH
                   | X3_2240 := X2_2239+DELTA
                   | WHLINE(X0_2234,Y_POS_2225,X1_2235)
                   | WVLINE(X1_2235,Y_POS_2225,Y2_2238)
                   | WHLINE(X1_2235,Y2_2238,X2_2239)
                   | WVLINE(X2_2239,Y_POS_2225,Y2_2238)
                   | WHLINE(X2_2239,Y_POS_2225,X3_2240)
                   |)
                |)
               where 
               integer X0_2234, X1_2235, Y21_2236, Y2_2238, X2_2239, X3_2240;
               end
            %ACT_CLK_X0_2234%; 
            process ACT_CLK_X0 =
                 ( )
               (| CLK_X0 ^= X0 ^= X1_1286 ^= Y21 ^= Y2 ^= X2 ^= X3
                | (| X0 := X when CLK_X0
                   | X1_1286 := X0+DELTA
                   | Y21 := (-BOOL_HEIGHT) when CLK_X0
                   | Y2 := TICK_SIZE+Y21
                   | X2 := X1_1286+BOOL_WIDTH
                   | X3 := X2+DELTA
                   | WHLINE(X0,TICK_SIZE,X1_1286)
                   | WVLINE(X1_1286,TICK_SIZE,Y2)
                   | WHLINE(X1_1286,Y2,X2)
                   | WVLINE(X2,TICK_SIZE,Y2)
                   | WHLINE(X2,TICK_SIZE,X3)
                   |)
                |)
               where 
               integer X0, X1_1286, Y21, Y2, X2, X3;
               end
            %ACT_CLK_X0%; 
            process ACT_CLK_X0_1589 =
                 ( )
               (| CLK_X0_1589 ^= X0_1589 ^= X1_1590 ^= Y21_1591 ^= Y2_1593 ^= X2_1594 ^= X3_1595
                | (| X0_1589 := X when CLK_X0_1589
                   | X1_1590 := X0_1589+DELTA
                   | Y21_1591 := (-TICK_HEIGHT) when CLK_X0_1589
                   | Y2_1593 := Y_POS_1579+Y21_1591
                   | X2_1594 := X1_1590+BOOL_WIDTH
                   | X3_1595 := X2_1594+DELTA
                   | WHLINE(X0_1589,Y_POS_1579,X1_1590)
                   | WVLINE(X1_1590,Y_POS_1579,Y2_1593)
                   | WHLINE(X1_1590,Y2_1593,X2_1594)
                   | WVLINE(X2_1594,Y_POS_1579,Y2_1593)
                   | WHLINE(X2_1594,Y_POS_1579,X3_1595)
                   |)
                |)
               where 
               integer X0_1589, X1_1590, Y21_1591, Y2_1593, X2_1594, X3_1595;
               end
            %ACT_CLK_X0_1589%; 
            process ACT_CLK_X0_1678 =
                 ( )
               (| CLK_X0_1678 ^= X0_1678 ^= X1_1679 ^= Y21_1680 ^= Y2_1682 ^= X2_1683 ^= X3_1684
                | (| X0_1678 := X when CLK_X0_1678
                   | X1_1679 := X0_1678+DELTA
                   | Y21_1680 := (-TICK_HEIGHT) when CLK_X0_1678
                   | Y2_1682 := POS_Y+Y21_1680
                   | X2_1683 := X1_1679+BOOL_WIDTH
                   | X3_1684 := X2_1683+DELTA
                   | WHLINE(X0_1678,POS_Y,X1_1679)
                   | WVLINE(X1_1679,POS_Y,Y2_1682)
                   | WHLINE(X1_1679,Y2_1682,X2_1683)
                   | WVLINE(X2_1683,POS_Y,Y2_1682)
                   | WHLINE(X2_1683,POS_Y,X3_1684)
                   |)
                |)
               where 
               integer X0_1678, X1_1679, Y21_1680, Y2_1682, X2_1683, X3_1684;
               end
            %ACT_CLK_X0_1678%; 
            process ACT_CLK_X0_2084 =
                 ( )
               (| CLK_X0_2084 ^= X0_2084 ^= X1_2085 ^= Y21_2086 ^= Y2_2088 ^= X2_2089 ^= X3_2090
                | (| X0_2084 := X when CLK_X0_2084
                   | X1_2085 := X0_2084+DELTA
                   | Y21_2086 := (-TICK_HEIGHT) when CLK_X0_2084
                   | Y2_2088 := Y_POS_2076+Y21_2086
                   | X2_2089 := X1_2085+BOOL_WIDTH
                   | X3_2090 := X2_2089+DELTA
                   | WHLINE(X0_2084,Y_POS_2076,X1_2085)
                   | WVLINE(X1_2085,Y_POS_2076,Y2_2088)
                   | WHLINE(X1_2085,Y2_2088,X2_2089)
                   | WVLINE(X2_2089,Y_POS_2076,Y2_2088)
                   | WHLINE(X2_2089,Y_POS_2076,X3_2090)
                   |)
                |)
               where 
               integer X0_2084, X1_2085, Y21_2086, Y2_2088, X2_2089, X3_2090;
               end
            %ACT_CLK_X0_2084%; 
            process ACT_CLK_X0_1434 =
                 ( )
               (| CLK_X0_1434 ^= X0_1434 ^= X1_1435 ^= Y21_1436 ^= Y2_1438 ^= X2_1439 ^= X3_1440
                | (| X0_1434 := X when CLK_X0_1434
                   | X1_1435 := X0_1434+DELTA
                   | Y21_1436 := (-TICK_HEIGHT) when CLK_X0_1434
                   | Y2_1438 := Y_POS+Y21_1436
                   | X2_1439 := X1_1435+BOOL_WIDTH
                   | X3_1440 := X2_1439+DELTA
                   | WHLINE(X0_1434,Y_POS,X1_1435)
                   | WVLINE(X1_1435,Y_POS,Y2_1438)
                   | WHLINE(X1_1435,Y2_1438,X2_1439)
                   | WVLINE(X2_1439,Y_POS,Y2_1438)
                   | WHLINE(X2_1439,Y_POS,X3_1440)
                   |)
                |)
               where 
               integer X0_1434, X1_1435, Y21_1436, Y2_1438, X2_1439, X3_1440;
               end
            %ACT_CLK_X0_1434%; 
            process ACT_CLK_X0_2159 =
                 ( )
               (| CLK_X0_2159 ^= X0_2159 ^= X1_2160 ^= Y21_2161 ^= Y2_2163 ^= X2_2164 ^= X3_2165
                | (| X0_2159 := X when CLK_X0_2159
                   | X1_2160 := X0_2159+DELTA
                   | Y21_2161 := (-TICK_HEIGHT) when CLK_X0_2159
                   | Y2_2163 := Y_POS_2150+Y21_2161
                   | X2_2164 := X1_2160+BOOL_WIDTH
                   | X3_2165 := X2_2164+DELTA
                   | WHLINE(X0_2159,Y_POS_2150,X1_2160)
                   | WVLINE(X1_2160,Y_POS_2150,Y2_2163)
                   | WHLINE(X1_2160,Y2_2163,X2_2164)
                   | WVLINE(X2_2164,Y_POS_2150,Y2_2163)
                   | WHLINE(X2_2164,Y_POS_2150,X3_2165)
                   |)
                |)
               where 
               integer X0_2159, X1_2160, Y21_2161, Y2_2163, X2_2164, X3_2165;
               end
            %ACT_CLK_X0_2159%; 
            process ACT_CLK_X0_1513 =
                 ( )
               (| CLK_X0_1513 ^= X0_1513 ^= X1_1514 ^= Y21_1515 ^= Y2_1517 ^= X2_1518 ^= X3_1519
                | (| X0_1513 := X when CLK_X0_1513
                   | X1_1514 := X0_1513+DELTA
                   | Y21_1515 := (-TICK_HEIGHT) when CLK_X0_1513
                   | Y2_1517 := Y_POS_1503+Y21_1515
                   | X2_1518 := X1_1514+BOOL_WIDTH
                   | X3_1519 := X2_1518+DELTA
                   | WHLINE(X0_1513,Y_POS_1503,X1_1514)
                   | WVLINE(X1_1514,Y_POS_1503,Y2_1517)
                   | WHLINE(X1_1514,Y2_1517,X2_1518)
                   | WVLINE(X2_1518,Y_POS_1503,Y2_1517)
                   | WHLINE(X2_1518,Y_POS_1503,X3_1519)
                   |)
                |)
               where 
               integer X0_1513, X1_1514, Y21_1515, Y2_1517, X2_1518, X3_1519;
               end
            %ACT_CLK_X0_1513%; 
            process ACT_CLK_NST =
                 ( )
               (| CLK_NST ^= ZV_605
                | (| HS1_579 := when (ZV_605>=2)
                   | CLK_331 := when (not (ZV_605>=2))
                   |)
                | (| NST := (0 when HS1_579) default ((ZV_605+1) when CLK_331)
                   | ZV_605 := NST$1 init 0
                   |)
                |)
               where 
               event CLK_331, HS1_579;
               integer ZV_605;
               end
            %ACT_CLK_NST%; 
            end
         %ACT_CLK_SWDIS%; 
         end
      %ACT_CLK_V1%; 
      end
   %ACT_HE%; 
   process WSTOP =
        ( ? event DOWN;
        )
   
   %WSTOP%; 
   process WHLINE =
        ( ? integer X1, Y1, X2;
        )
        spec (| X1 ^= Y1 ^= X2 |)
   
   %WHLINE%; 
   process RLL =
        ( ! boolean LL;
        )
   
   %RLL%; 
   process RUL =
        ( ! boolean UL;
        )
   
   %RUL%; 
   process WVLINE =
        ( ? integer X1, Y1, Y2;
        )
        spec (| X1 ^= Y1 ^= Y2 |)
   
   %WVLINE%; 
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
   process RRINGUP =
        ( ! boolean CRINGUP;
        )
   
   %RRINGUP%; 
   process WEFFACE =
        ( ? integer X1, Y1, X2, Y2;
        )
        spec (| X1 ^= Y1 ^= X2 ^= Y2 |)
   
   %WEFFACE%; 
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
%VTSUPER_TRA%; %^0 ^= Y22 ^= Y22_1437 ^= Y22_1516 ^= Y22_1592 ^= Y22_1681 ^= Y22_1755 ^= Y22_1829 ^= Y22_1957 ^= Y22_2087 ^= Y22_2162 ^= Y22_2237 ^= Y22_2323 ^= Y22_2397***WARNING: null clock signals 
%
%
