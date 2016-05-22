process VTCHRONOMETER_TRA =
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
   constant integer SWNB = 2;
   constant integer BELLPI = 4;
   constant integer PERCENT = 30;
   constant integer RUN_STR = 3;
   constant integer LAP_STR = 4;
   constant integer TICK_WIDTH = 8;
   constant integer SW_STNB = 1;
   constant integer V_MODULO = 60;
   constant integer V_0 = 0;
   constant integer V_MODULO_396 = 60;
   constant integer V_0_397 = 0;
   constant integer V_0_438 = 0;
   constant integer V_0_477 = 0;
   constant integer N = 1;
   constant integer V_0_700 = 0;
   constant integer V_0_742 = 0;
   constant integer V_0_823 = 0;
   constant integer V_0_864 = 0;
   constant integer V_MODULO_947 = 3;
   constant integer V_0_948 = 0;
   constant boolean V0 = false;
   constant integer V_0_1143 = 1;
   constant integer V_0_1247 = 4;
   constant integer V_0_1301 = 1;
   constant integer DTIME_X = 56;
   constant integer DMTIME_Y = 80;
   constant integer DTAG_Y = 40;
   constant integer DLWTIME_Y = 24;
   constant integer X = 80;
   constant integer X_1508 = 104;
   constant integer DTAG_X = 80;
   constant integer DX = 24;
   constant integer Y_POS = 56;
   constant integer DX_1619 = 24;
   constant integer DX_1655 = 32;
   constant integer DY = 16;
   process ACT_HE =
        ( )
      (| HE ^= AUTOMOD ^= C_UP ^= C_DOWN ^= C_AUTO
       | (| CLK_MAX := when AUTOMOD
          | CLK_MAX ^= ZMAX
          | ACT_CLK_MAX{}
          | CLK_601 := when (not AUTOMOD)
          |)
       | (| UP0_1020 := when C_UP |)
       | (| DOWN_1047 := when C_DOWN |)
       | (| CLK_CAUTO := when C_AUTO
          | CLK_CAUTO ^= CAUTO
          | ACT_CLK_CAUTO{}
          |)
       | (| HSTOP_1021 := CLK_601 ^* DOWN_1047
          | (| WSTOP(HSTOP_1021) |)
          |)
       | (| CLK_VD := CLK_MAX ^* DOWN_1047
          | CLK_VD ^= VD
          | (| VD := (ZMAX+ZMAX) when CLK_VD |)
          |)
       | (| UPS_1018 := CLK_MAX ^* UP0_1020 |)
       | (| CLK_VU := UPS_1018 ^* CLK_649
          | CLK_VU ^= VU
          | (| VU := (ZMAX/2) when CLK_VU |)
          |)
       | (| CLK_974 := CLK_VD ^+ CLK_VU |)
       | (| CLK_V1 := UP0_1020 ^+ HES_1108
          | ACT_CLK_V1{}
          |)
       | (| CLK_993 := CLK_VD ^- CLK_VU |)
       | (| CLK_996 := CLK_MAX ^- CLK_974 |)
       | (| AUTOMOD := (CAUTO when CLK_CAUTO) cell HE init false
          | C_UP := RUP()
          | C_DOWN := RDOWN()
          | C_AUTO := RAUTO()
          |)
       |)
      where 
      event CLK_996, CLK_993, CLK_V1, CLK_974, CLK_VU, UPS_1018, CLK_VD, HSTOP_1021, HES_1108, CLK_649, CLK_CAUTO, DOWN_1047, UP0_1020, CLK_601, CLK_MAX;
      integer VU, VD, ZMAX;
      boolean AUTOMOD, CAUTO, C_UP, C_DOWN, C_AUTO;
      process ACT_CLK_MAX =
           ( )
         (| CLK_MAX ^= MAX ^= V_1138 ^= ZV_1150
          | (| CLK_649 := when (ZMAX>1) |)
          | (| HES_1108 := when (ZV_1150>=(MAX-1))
             | CLK_672 := when (not (ZV_1150>=(MAX-1)))
             |)
          | (| MAX := (VU when CLK_VU) default (VD when CLK_993) default (ZMAX when CLK_996)
             | ZMAX := MAX$1 init 20
             | V_1138 := (0 when HES_1108) default ((ZV_1150+1) when CLK_672)
             | ZV_1150 := V_1138$1 init 1
             |)
          |)
         where 
         event CLK_672;
         integer MAX, V_1138, ZV_1150;
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
         (| CLK_V1 ^= V1 ^= ZV_1253
          | (| CLK_STNB := when (ZV_1253>=4)
             | ACT_CLK_STNB{}
             | CLK_732 := when (not (ZV_1253>=4))
             |)
          | (| V1 := (0 when CLK_STNB) default ((ZV_1253+1) when CLK_732)
             | ZV_1253 := V1$1 init 4
             |)
          |)
         where 
         event CLK_732, CLK_STNB;
         integer V1, ZV_1253;
         process ACT_CLK_STNB =
              ( )
            (| CLK_STNB ^= STNB ^= ST ^= ST_137 ^= SWST ^= VISIBLE ^= STOPPE ^= Z_VISIBLE ^= Z_ACTIF ^= ACTIF ^= SHOW ^= XZX_560 ^= CST ^= LR_1264 ^= UR_1272 ^= V2 ^= ZV_1306
             | (| CLK := when ST |)
             | (| CLK_42 := when ST_137 |)
             | (| CLK_61 := when SWST |)
             | (| CLK_86 := when STOPPE
                | CLK_87 := when (not STOPPE)
                |)
             | (| H_1_250 := when ACTIF |)
             | (| CLK_246 := when VISIBLE |)
             | (| CLK_DISPLAY := when SHOW
                | ACT_CLK_DISPLAY{}
                |)
             | (| UR_1005 := when UR_1272 |)
             | (| LR_1006 := when LR_1264 |)
             | (| CLK_LL_1317 := when (ZV_1306>=1)
                | ACT_CLK_LL_1317{}
                | CLK_755 := when (not (ZV_1306>=1))
                |)
             | (| CLK_XZX_1201 := UR_1005 ^+ CLK_XZX_1191
                | ACT_CLK_XZX_1201{}
                |)
             | (| CLK_XZX_1205 := CLK_XZX_1201 ^+ LR_1006
                | ACT_CLK_XZX_1205{}
                |)
             | (| CLK_1002 := LR_1006 ^- CLK_XZX_1201 |)
             | (| CLK_1004 := UR_1005 ^- CLK_XZX_1191 |)
             | (| CLK_DRUN := CLK_61 ^* SLR_61
                | CLK_DRUN ^= DRUN
                | ACT_CLK_DRUN{}
                |)
             | (| SWUR_183 := CLK_61 ^* SUR_60 |)
             | (| SWON_119 := CLK ^* SLL_59 |)
             | (| WON_120 := CLK_42 ^* SLL_59 |)
             | (| OFF_121 := CLK_61 ^* SLL_59 |)
             | (| CLK_DSET := SWON_119 ^+ OFF_121
                | CLK_DSET ^= DSET
                | (| DSET := (not OFF_121) default CLK_1339 |)
                |)
             | (| CLK_NST := CLK_DSET ^+ WON_120
                | CLK_NST ^= NST
                | ACT_CLK_NST{}
                |)
             | (| RESET_249 := SWUR_183 ^* CLK_86 |)
             | (| CLK_DLAP := SWUR_183 ^* CLK_87
                | CLK_DLAP ^= DLAP
                | ACT_CLK_DLAP{}
                |)
             | (| CLK_V_472 := RESET_249 ^+ H_1_250
                | ACT_CLK_V_472{}
                |)
             | (| CLK_WBI := CLK_DRUN ^+ CLK_LL_1317
                | ACT_CLK_WBI{}
                |)
             | (| CLK_1083 := CLK_246 ^* CLK_249 |)
             | (| CLK_1085 := CLK_1083 ^+ CLK_245 |)
             | (| CLK_REDISPLAY := CLK_1085 ^+ SWON_119
                | ACT_CLK_REDISPLAY{}
                |)
             | (| CLK_V_694 := CLK_DRUN ^+ CLK_428
                | ACT_CLK_V_694{}
                |)
             | (| CLK_B := RESET_249 ^+ HS_3_342
                | CLK_B ^= B
                | ACT_CLK_B{}
                |)
             | (| CLK_C_UNIT_637 := CLK_B ^+ CLK_DISPLAY
                | CLK_C_UNIT_637 ^= C_UNIT_637
                | (| C_UNIT_637 := (B when CLK_B) cell CLK_C_UNIT_637 init 0 |)
                |)
             | (| CLK_1106 := CLK_B ^* LAP_530 |)
             | (| CLK_1109 := CLK_B ^* CLK_291 |)
             | (| CLK_L_UNIT_638 := CLK_1106 ^+ CLK_DISPLAY
                | CLK_L_UNIT_638 ^= L_UNIT_638
                | (| L_UNIT_638 := (C_UNIT_637 when CLK_1118) cell CLK_L_UNIT_638 init 0 |)
                |)
             | (| CLK_1113 := CLK_L_UNIT_638 ^* CLK_283 |)
             | (| CLK_1116 := CLK_C_UNIT_637 ^* CLK_282 |)
             | (| CLK_1118 := CLK_C_UNIT_637 ^* LAP_530 |)
             | (| CLK_1120 := CLK_1116 ^+ CLK_1113 |)
             | (| CLK_DB := CLK_1120 ^+ CLK_1109
                | ACT_CLK_DB{}
                |)
             | (| CLK_1136 := H_MOD_695 ^* CLK_386 |)
             | (| BEEP1_667 := CLK_1136 ^+ CLK_DRUN |)
             | (| CLK_V_737 := CLK_DRUN ^+ H_MOD_695
                | ACT_CLK_V_737{}
                |)
             | (| CLK_S := RESET_249 ^+ HS_2_341
                | CLK_S ^= S
                | ACT_CLK_S{}
                |)
             | (| CLK_C_UNIT_612 := CLK_S ^+ CLK_DISPLAY
                | CLK_C_UNIT_612 ^= C_UNIT_612
                | (| C_UNIT_612 := (S when CLK_S) cell CLK_C_UNIT_612 init 0 |)
                |)
             | (| CLK_1148 := CLK_S ^* LAP_530 |)
             | (| CLK_1150 := CLK_S ^* CLK_291 |)
             | (| CLK_L_UNIT_613 := CLK_1148 ^+ CLK_DISPLAY
                | CLK_L_UNIT_613 ^= L_UNIT_613
                | (| L_UNIT_613 := (C_UNIT_612 when CLK_1159) cell CLK_L_UNIT_613 init 0 |)
                |)
             | (| CLK_1154 := CLK_L_UNIT_613 ^* CLK_283 |)
             | (| CLK_1157 := CLK_C_UNIT_612 ^* CLK_282 |)
             | (| CLK_1159 := CLK_C_UNIT_612 ^* LAP_530 |)
             | (| CLK_1161 := CLK_1157 ^+ CLK_1154 |)
             | (| CLK_DS := CLK_1161 ^+ CLK_1150
                | ACT_CLK_DS{}
                |)
             | (| CLK_1187 := CLK_LL_1317 ^* AUX1_669 |)
             | (| LOCRESET_752 := CLK_1187 ^+ CLK_DRUN |)
             | (| CLK_V := RESET_249 ^+ HS_1_340
                | CLK_V ^= V
                | ACT_CLK_V{}
                |)
             | (| CLK_C_UNIT := CLK_V ^+ CLK_DISPLAY
                | CLK_C_UNIT ^= C_UNIT
                | (| C_UNIT := (V when CLK_V) cell CLK_C_UNIT init 0 |)
                |)
             | (| CLK_1202 := CLK_V ^* LAP_530 |)
             | (| CLK_1204 := CLK_V ^* CLK_291 |)
             | (| CLK_L_UNIT := CLK_1202 ^+ CLK_DISPLAY
                | CLK_L_UNIT ^= L_UNIT
                | (| L_UNIT := (C_UNIT when CLK_1213) cell CLK_L_UNIT init 0 |)
                |)
             | (| CLK_1208 := CLK_L_UNIT ^* CLK_283 |)
             | (| CLK_1211 := CLK_C_UNIT ^* CLK_282 |)
             | (| CLK_1213 := CLK_C_UNIT ^* LAP_530 |)
             | (| CLK_1215 := CLK_1211 ^+ CLK_1208 |)
             | (| CLK_DUNIT := CLK_1215 ^+ CLK_1204
                | ACT_CLK_DUNIT{}
                |)
             | (| LOCRESET_365 := RESET_249 ^+ HS_344 |)
             | (| CLK_WBI_816 := CLK_LL_1317 ^+ XZX_795
                | ACT_CLK_WBI_816{}
                |)
             | (| CLK_V_817 := XZX_795 ^+ CLK_515
                | ACT_CLK_V_817{}
                |)
             | (| CLK_1250 := H_MOD_818 ^* CLK_474 |)
             | (| BEEP2_668 := CLK_1250 ^+ XZX_795 |)
             | (| BEEP_63 := BEEP2_668 ^+ BEEP1_667 |)
             | (| XZX_1711 := BEEP_63 ^+ TBEEP_62
                | (| SIGBELL(30 when XZX_1711) |)
                |)
             | (| CLK_V_859 := XZX_795 ^+ H_MOD_818
                | ACT_CLK_V_859{}
                |)
             | (| CLK_1284 := CLK_LL_1317 ^* AUX2_790 |)
             | (| LOCRESET_874 := CLK_1284 ^+ XZX_795 |)
             | (| CLK_1292 := CLK_V_859 ^- LOCRESET_874 |)
             | (| CLK_1300 := CLK_V_817 ^- CLK_V_859 |)
             | (| CLK_1302 := CLK_WBI_816 ^- LOCRESET_874 |)
             | (| CLK_1304 := CLK_V_737 ^- LOCRESET_752 |)
             | (| CLK_1307 := CLK_1204 ^- CLK_1215 |)
             | (| CLK_1309 := CLK_V ^- LOCRESET_365 |)
             | (| CLK_1312 := CLK_1150 ^- CLK_1161 |)
             | (| CLK_1314 := CLK_S ^- CLK_V |)
             | (| CLK_1320 := CLK_V_694 ^- CLK_V_737 |)
             | (| CLK_1323 := CLK_1109 ^- CLK_1120 |)
             | (| CLK_1325 := CLK_B ^- CLK_S |)
             | (| CLK_1327 := CLK_WBI ^- LOCRESET_752 |)
             | (| CLK_1331 := CLK_DRUN ^- AUX1_669 |)
             | (| CLK_1335 := CLK_V_472 ^- CLK_B |)
             | (| CLK_1337 := SWON_119 ^- CLK_1085 |)
             | (| CLK_1339 := SWON_119 ^- OFF_121 |)
             | (| CLK_1345 := CLK_STNB ^- LAP_530 |)
             | (| CLK_1347 := CLK_STNB ^- CLK_DLAP |)
             | (| CLK_1349 := CLK_STNB ^- CLK_DRUN |)
             | (| CLK_1363 := HS_1_340 ^- RESET_249 |)
             | (| CLK_1367 := CLK_245 ^- CLK_1083 |)
             | (| CLK_1372 := XZX_795 ^- AUX2_790 |)
             | (| STNB := CST$1 init 0
                | ST := STNB=0
                | ST_137 := STNB=2
                | SWST := STNB=1
                | VISIBLE := ((not DLAP) when CLK_DLAP) default (Z_VISIBLE when CLK_1347)
                | STOPPE := Z_VISIBLE and (not Z_ACTIF)
                | Z_VISIBLE := VISIBLE$1 init true
                | Z_ACTIF := ACTIF$1 init false
                | ACTIF := (DRUN when CLK_DRUN) default (Z_ACTIF when CLK_1349)
                | SHOW := (DSET when CLK_DSET) cell CLK_STNB init false
                | XZX_560 := LAP_530 default (VISIBLE when CLK_1345)
                | CST := (NST when CLK_NST) cell CLK_STNB init 0
                | LR_1264 := RLR()
                | UR_1272 := RUR()
                | V2 := (0 when CLK_LL_1317) default ((ZV_1306+1) when CLK_755)
                | ZV_1306 := V2$1 init 1
                |)
             |)
            where 
            event CLK_1372, CLK_1367, CLK_1363, CLK_1349, CLK_1347, CLK_1345, CLK_1339, CLK_1337, CLK_1335, CLK_1331, CLK_1327, CLK_1325, CLK_1323, CLK_1320, CLK_1314, CLK_1312, CLK_1309, CLK_1307, CLK_1304, CLK_1302, CLK_1300, CLK_1292, LOCRESET_874, 
                 CLK_1284, CLK_V_859, XZX_1711, BEEP_63, BEEP2_668, CLK_1250, CLK_V_817, CLK_WBI_816, LOCRESET_365, CLK_DUNIT, CLK_1215, CLK_1213, CLK_1211, CLK_1208, CLK_L_UNIT, CLK_1204, CLK_1202, CLK_C_UNIT, CLK_V, LOCRESET_752, CLK_1187, CLK_DS, 
                 CLK_1161, CLK_1159, CLK_1157, CLK_1154, CLK_L_UNIT_613, CLK_1150, CLK_1148, CLK_C_UNIT_612, CLK_S, CLK_V_737, BEEP1_667, CLK_1136, CLK_DB, CLK_1120, CLK_1118, CLK_1116, CLK_1113, CLK_L_UNIT_638, CLK_1109, CLK_1106, CLK_C_UNIT_637, CLK_B, 
                 CLK_V_694, CLK_REDISPLAY, CLK_1085, CLK_1083, CLK_WBI, CLK_V_472, CLK_DLAP, RESET_249, CLK_NST, CLK_DSET, OFF_121, WON_120, SWON_119, SWUR_183, CLK_DRUN, CLK_1004, CLK_1002, CLK_XZX_1205, CLK_XZX_1201, CLK_XZX_1191, TBEEP_62, CLK_755, 
                 CLK_LL_1317, LR_1006, UR_1005, SLR_61, SUR_60, SLL_59, CLK_515, AUX2_790, CLK_474, H_MOD_818, XZX_795, CLK_428, AUX1_669, CLK_386, H_MOD_695, CLK_291, CLK_283, CLK_282, CLK_DISPLAY, CLK_249, CLK_246, CLK_245, LAP_530, HS_3_342, HS_2_341, 
                 HS_1_340, HS_344, H_1_250, CLK_87, CLK_86, CLK_61, CLK_42, CLK;
            integer STNB, V, S, B, C_UNIT, L_UNIT, C_UNIT_612, L_UNIT_613, C_UNIT_637, L_UNIT_638, CST, NST, V2, ZV_1306;
            boolean DRUN, DLAP, ST, ST_137, SWST, VISIBLE, STOPPE, Z_VISIBLE, Z_ACTIF, ACTIF, SHOW, XZX_560, DSET, LR_1264, UR_1272;
            process ACT_CLK_DISPLAY =
                 ( )
               (| CLK_DISPLAY ^= DISPLAY
                | (| CLK_291 := when DISPLAY |)
                | (| DISPLAY := XZX_560 when CLK_DISPLAY |)
                |)
               where 
               boolean DISPLAY;
               end
            %ACT_CLK_DISPLAY%; 
            process ACT_CLK_LL_1317 =
                 ( )
               (| CLK_LL_1317 ^= LL_1317 ^= UL_1325
                | (| UL_1007 := when UL_1325 |)
                | (| LL_1008 := when LL_1317 |)
                | (| TBEEP_62 := UL_1007 ^* LL_1008 |)
                | (| CLK_XZX_1191 := UL_1007 ^+ LL_1008
                   | ACT_CLK_XZX_1191{}
                   |)
                | (| CLK_998 := LL_1008 ^- UL_1007 |)
                | (| LL_1317 := RLL()
                   | UL_1325 := RUL()
                   |)
                |)
               where 
               event CLK_998, LL_1008, UL_1007;
               boolean LL_1317, UL_1325;
               process ACT_CLK_XZX_1191 =
                    ( )
                  (| CLK_XZX_1191 ^= XZX_1195
                   | (| SLL_59 := when XZX_1195 |)
                   | (| XZX_1195 := (not UL_1007) default CLK_998 |)
                   |)
                  where 
                  boolean XZX_1195;
                  end
               %ACT_CLK_XZX_1191%; 
               end
            %ACT_CLK_LL_1317%; 
            process ACT_CLK_XZX_1201 =
                 ( )
               (| CLK_XZX_1201 ^= XZX_1201
                | (| SUR_60 := when XZX_1201 |)
                | (| XZX_1201 := (not CLK_XZX_1191) default CLK_1004 |)
                |)
               where 
               boolean XZX_1201;
               end
            %ACT_CLK_XZX_1201%; 
            process ACT_CLK_XZX_1205 =
                 ( )
               (| CLK_XZX_1205 ^= XZX_1205
                | (| SLR_61 := when XZX_1205 |)
                | (| XZX_1205 := (not CLK_XZX_1201) default CLK_1002 |)
                |)
               where 
               boolean XZX_1205;
               end
            %ACT_CLK_XZX_1205%; 
            process ACT_CLK_DRUN =
                 ( )
               (| CLK_DRUN ^= CC_1625
                | (| CLK_249 := when DRUN |)
                | (| CLK_868 := when CC_1625 |)
                | (| CLK_956 := CLK_249 ^* CLK_868
                   | (| WPTAG(80 when CLK_956,56,3) |)
                   |)
                | (| DRUN := (not Z_ACTIF) when CLK_DRUN
                   | CC_1625 := WCLEARAREA(80 when CLK_DRUN,48 when CLK_DRUN,24,8)
                   |)
                |)
               where 
               event CLK_956, CLK_868;
               boolean CC_1625;
               end
            %ACT_CLK_DRUN%; 
            process ACT_CLK_NST =
                 ( )
               (| CLK_NST ^= ZV_960 ^= CC_1663
                | (| HS1_936 := when (ZV_960>=2)
                   | CLK_560 := when (not (ZV_960>=2))
                   |)
                | (| CLK_XZX_1664 := when CC_1663
                   | ACT_CLK_XZX_1664{}
                   |)
                | (| NST := (0 when HS1_936) default ((ZV_960+1) when CLK_560)
                   | ZV_960 := NST$1 init 0
                   | CC_1663 := WCLEARAREA(8 when CLK_NST,8 when CLK_NST,32,16)
                   |)
                |)
               where 
               event CLK_XZX_1664, CLK_560, HS1_936;
               boolean CC_1663;
               integer ZV_960;
               process ACT_CLK_XZX_1664 =
                    ( )
                  (| CLK_XZX_1664 ^= XZX_1664
                   | (| XZX_1664 := NST when CLK_XZX_1664
                      | WDTAG(8,24,XZX_1664)
                      |)
                   |)
                  where 
                  integer XZX_1664;
                  end
               %ACT_CLK_XZX_1664%; 
               end
            %ACT_CLK_NST%; 
            process ACT_CLK_DLAP =
                 ( )
               (| CLK_DLAP ^= CC_1571
                | (| LAP_530 := when DLAP
                   | CLK_245 := when (not DLAP)
                   |)
                | (| CLK_848 := when CC_1571 |)
                | (| CLK_953 := LAP_530 ^* CLK_848
                   | (| WPTAG(80 when CLK_953,40,4) |)
                   |)
                | (| DLAP := Z_VISIBLE when CLK_DLAP
                   | CC_1571 := WCLEARAREA(80 when CLK_DLAP,32 when CLK_DLAP,24,8)
                   |)
                |)
               where 
               event CLK_953, CLK_848;
               boolean CC_1571;
               end
            %ACT_CLK_DLAP%; 
            process ACT_CLK_V_472 =
                 ( )
               (| CLK_V_472 ^= V_472 ^= ZV_495
                | (| HS_3_342 := when (ZV_495>=1) |)
                | (| V_472 := (0 when CLK_B) default ((ZV_495+1) when CLK_1335)
                   | ZV_495 := V_472$1 init 0
                   |)
                |)
               where 
               integer V_472, ZV_495;
               end
            %ACT_CLK_V_472%; 
            process ACT_CLK_WBI =
                 ( )
               (| CLK_WBI ^= WBI ^= BTI
                | (| CLK_386 := when WBI |)
                | (| CLK_428 := when BTI |)
                | (| WBI := (not AUX1_669) default CLK_1331 default (BTI when CLK_1327)
                   | BTI := WBI$1 init false
                   |)
                |)
               where 
               boolean WBI, BTI;
               end
            %ACT_CLK_WBI%; 
            process ACT_CLK_REDISPLAY =
                 ( )
               (| CLK_REDISPLAY ^= REDISPLAY
                | (| CLK_282 := when REDISPLAY
                   | CLK_283 := when (not REDISPLAY)
                   |)
                | (| REDISPLAY := CLK_1083 default CLK_1367 default (VISIBLE when CLK_1337) |)
                |)
               where 
               boolean REDISPLAY;
               end
            %ACT_CLK_REDISPLAY%; 
            process ACT_CLK_V_694 =
                 ( )
               (| CLK_V_694 ^= V_694 ^= ZV_721
                | (| H_MOD_695 := when (ZV_721>=3) |)
                | (| V_694 := (0 when CLK_V_737) default ((ZV_721+1) when CLK_1320)
                   | ZV_721 := V_694$1 init 0
                   |)
                |)
               where 
               integer V_694, ZV_721;
               end
            %ACT_CLK_V_694%; 
            process ACT_CLK_B =
                 ( )
               (| CLK_B ^= ZV_458
                | (| HS_2_341 := when (ZV_458>=19) |)
                | (| B := (0 when CLK_S) default ((ZV_458+1) when CLK_1325)
                   | ZV_458 := B$1 init 0
                   |)
                |)
               where 
               integer ZV_458;
               end
            %ACT_CLK_B%; 
            process ACT_CLK_DB =
                 ( )
               (| CLK_DB ^= DB ^= CC_1515
                | (| CLK_XZX_1516 := when (DB>=0)
                   | ACT_CLK_XZX_1516{}
                   |)
                | (| DB := (C_UNIT_637 when CLK_1116) default (L_UNIT_638 when CLK_1113) default (B when CLK_1323)
                   | CC_1515 := WCLEARAREA(104 when CLK_DB,64 when CLK_DB,16 when CLK_DB,16 when CLK_DB)
                   |)
                |)
               where 
               event CLK_XZX_1516;
               boolean CC_1515;
               integer DB;
               process ACT_CLK_XZX_1516 =
                    ( )
                  (| CLK_XZX_1516 ^= XZX_1516
                   | (| XZX_1516 := DB when CLK_XZX_1516
                      | WPINT2(104,80,XZX_1516)
                      |)
                   |)
                  where 
                  integer XZX_1516;
                  end
               %ACT_CLK_XZX_1516%; 
               end
            %ACT_CLK_DB%; 
            process ACT_CLK_V_737 =
                 ( )
               (| CLK_V_737 ^= V_737 ^= ZV_762
                | (| AUX1_669 := when (ZV_762>=0) |)
                | (| V_737 := (0 when LOCRESET_752) default ((ZV_762+1) when CLK_1304)
                   | ZV_762 := V_737$1 init 0
                   |)
                |)
               where 
               integer V_737, ZV_762;
               end
            %ACT_CLK_V_737%; 
            process ACT_CLK_S =
                 ( )
               (| CLK_S ^= ZV_417
                | (| HS_1_340 := when (ZV_417>=59) |)
                | (| S := (0 when CLK_V) default ((ZV_417+1) when CLK_1314)
                   | ZV_417 := S$1 init 0
                   |)
                |)
               where 
               integer ZV_417;
               end
            %ACT_CLK_S%; 
            process ACT_CLK_DS =
                 ( )
               (| CLK_DS ^= DS ^= CC_1472
                | (| CLK_XZX_1473 := when (DS>=0)
                   | ACT_CLK_XZX_1473{}
                   |)
                | (| DS := (C_UNIT_612 when CLK_1157) default (L_UNIT_613 when CLK_1154) default (S when CLK_1312)
                   | CC_1472 := WCLEARAREA(80 when CLK_DS,64 when CLK_DS,16 when CLK_DS,16 when CLK_DS)
                   |)
                |)
               where 
               event CLK_XZX_1473;
               boolean CC_1472;
               integer DS;
               process ACT_CLK_XZX_1473 =
                    ( )
                  (| CLK_XZX_1473 ^= XZX_1473
                   | (| XZX_1473 := DS when CLK_XZX_1473
                      | WPINT2(80,80,XZX_1473)
                      |)
                   |)
                  where 
                  integer XZX_1473;
                  end
               %ACT_CLK_XZX_1473%; 
               end
            %ACT_CLK_DS%; 
            process ACT_CLK_V =
                 ( )
               (| CLK_V ^= ZV ^= XZX_796
                | (| HS_344 := when (ZV>=59) |)
                | (| XZX_795 := when XZX_796 |)
                | (| V := (0 when LOCRESET_365) default ((ZV+1) when CLK_1309)
                   | ZV := V$1 init 0
                   | XZX_796 := (not RESET_249) default CLK_1363
                   |)
                |)
               where 
               boolean XZX_796;
               integer ZV;
               end
            %ACT_CLK_V%; 
            process ACT_CLK_DUNIT =
                 ( )
               (| CLK_DUNIT ^= DUNIT ^= CC
                | (| CLK_XZX_1392 := when (DUNIT>=0)
                   | ACT_CLK_XZX_1392{}
                   |)
                | (| DUNIT := (C_UNIT when CLK_1211) default (L_UNIT when CLK_1208) default (V when CLK_1307)
                   | CC := WCLEARAREA(56 when CLK_DUNIT,64 when CLK_DUNIT,16 when CLK_DUNIT,16 when CLK_DUNIT)
                   |)
                |)
               where 
               event CLK_XZX_1392;
               boolean CC;
               integer DUNIT;
               process ACT_CLK_XZX_1392 =
                    ( )
                  (| CLK_XZX_1392 ^= XZX_1392
                   | (| XZX_1392 := DUNIT when CLK_XZX_1392
                      | WPINT2(56,80,XZX_1392)
                      |)
                   |)
                  where 
                  integer XZX_1392;
                  end
               %ACT_CLK_XZX_1392%; 
               end
            %ACT_CLK_DUNIT%; 
            process ACT_CLK_WBI_816 =
                 ( )
               (| CLK_WBI_816 ^= WBI_816 ^= BTI_895
                | (| CLK_474 := when WBI_816 |)
                | (| CLK_515 := when BTI_895 |)
                | (| WBI_816 := (not AUX2_790) default CLK_1372 default (BTI_895 when CLK_1302)
                   | BTI_895 := WBI_816$1 init false
                   |)
                |)
               where 
               boolean WBI_816, BTI_895;
               end
            %ACT_CLK_WBI_816%; 
            process ACT_CLK_V_817 =
                 ( )
               (| CLK_V_817 ^= V_817 ^= ZV_844
                | (| H_MOD_818 := when (ZV_844>=3) |)
                | (| V_817 := (0 when CLK_V_859) default ((ZV_844+1) when CLK_1300)
                   | ZV_844 := V_817$1 init 0
                   |)
                |)
               where 
               integer V_817, ZV_844;
               end
            %ACT_CLK_V_817%; 
            process ACT_CLK_V_859 =
                 ( )
               (| CLK_V_859 ^= V_859 ^= ZV_884
                | (| AUX2_790 := when (ZV_884>=1) |)
                | (| V_859 := (0 when LOCRESET_874) default ((ZV_884+1) when CLK_1292)
                   | ZV_884 := V_859$1 init 0
                   |)
                |)
               where 
               integer V_859, ZV_884;
               end
            %ACT_CLK_V_859%; 
            end
         %ACT_CLK_STNB%; 
         end
      %ACT_CLK_V1%; 
      end
   %ACT_HE%; 
   process WSTOP =
        ( ? event DOWN;
        )
   
   %WSTOP%; 
   process RLL =
        ( ! boolean LL;
        )
   
   %RLL%; 
   process RUL =
        ( ! boolean UL;
        )
   
   %RUL%; 
   process WPTAG =
        ( ? integer X;
            integer Y;
            integer STR;
        )
        spec (| X ^= Y ^= STR |)
   
   %WPTAG%; 
   process WCLEARAREA =
        ( ? integer X1;
            integer Y1;
            integer X2;
            integer Y2;
          ! boolean CC;
        )
        spec (| X1 ^= Y1 ^= X2 ^= Y2 ^= CC |)
   
   %WCLEARAREA%; 
   process WDTAG =
        ( ? integer X;
            integer Y;
            integer STR;
        )
        spec (| X ^= Y ^= STR |)
   
   %WDTAG%; 
   process WPINT2 =
        ( ? integer X;
            integer Y;
            integer V;
        )
        spec (| X ^= Y ^= V |)
   
   %WPINT2%; 
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
%VTCHRONOMETER_TRA%; 
