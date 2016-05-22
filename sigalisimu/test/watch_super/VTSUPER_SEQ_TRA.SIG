process VTSUPER_SEQ_TRA =
     { integer M1, M2, PI, NAL, PERCENT, TICK_NUMBER, FRONT_NUMBER, TICK_HEIGHT, INTER_TICK, BOOL_HEIGHT, DELTA, BOOL_WIDTH; }
     ( ? boolean HE;
     )
   pragmas 
      Main
      DefinedClockHierarchy
   end pragmas
   (| (| Tick := true
       | when Tick ^= HE
       | ACT_Tick{}
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
   boolean Tick;
   process ACT_Tick =
        ( )
      (| when Tick ^= AUTOMOD ^= C_UP ^= C_DOWN ^= C_AUTO ^= C ^= C_4817 ^= C_4825 ^= C_4837 ^= C_VD ^= C_4843 ^= C_VU ^= C_4855 ^= C_ZV ^= C_4868 ^= C_4872
       | (| when AUTOMOD ^= ZMAX ^= C_4814 ^= C_4822
          | ACT_AUTOMOD{}
          |)
       | (| when C_AUTO ^= CAUTO
          | ACT_C_AUTO{}
          |)
       | (| (| WSTOP(true when C_4837) |) |)
       | (| when C_VD ^= VD
          | (| VD := (ZMAX+ZMAX) when C_VD |)
          |)
       | (| when C_VU ^= VU
          | (| VU := (ZMAX/2) when C_VU |)
          |)
       | (| ACT_C_ZV{} |)
       | (| AUTOMOD := (CAUTO when C_AUTO) cell Tick init false
          | C_UP := RUP()
          | C_DOWN := RDOWN()
          | C_AUTO := RAUTO()
          | C := not AUTOMOD
          | C_4817 := left_tt ( C_4814,AUTOMOD )
          | C_4825 := left_tt ( C_4822,AUTOMOD )
          | C_4837 := C and C_DOWN
          | C_VD := AUTOMOD and C_DOWN
          | C_4843 := AUTOMOD and C_UP
          | C_VU := C_4843 and C_4817
          | C_4855 := C_VD or C_VU
          | C_ZV := C_UP or C_4825
          | C_4868 := (not C_VU) and C_VD
          | C_4872 := (not C_4855) and AUTOMOD
          |)
       |)
      where 
      integer VU, VD, ZMAX;
      boolean AUTOMOD, CAUTO, C_UP, C_DOWN, C_AUTO, C, C_4814, C_4817, C_4822, C_4825, C_4837, C_VD, C_4843, C_VU, C_4855, C_ZV, C_4868, C_4872;
      process ACT_AUTOMOD =
           ( )
         (| when AUTOMOD ^= MAX ^= V_842 ^= ZV_855 ^= C_4828
          | (| MAX := (VU when C_VU) default (VD when C_4868) default (ZMAX when C_4872)
             | ZMAX := MAX$1 init 10
             | V_842 := (0 when C_4822) default ((ZV_855+1) when C_4828)
             | ZV_855 := V_842$1 init 1
             | C_4814 := ZMAX>1
             | C_4822 := ZV_855>=(MAX-1)
             | C_4828 := not (ZV_855>=(MAX-1))
             |)
          |)
         where 
         boolean C_4828;
         integer MAX, V_842, ZV_855;
         end
      %ACT_AUTOMOD%; 
      process ACT_C_AUTO =
           ( )
         (| when C_AUTO ^= ZB
          | (| CAUTO := not ZB
             | ZB := CAUTO$1 init V0
             |)
          |)
         where 
         boolean ZB;
         end
      %ACT_C_AUTO%; 
      process ACT_C_ZV =
           ( )
         (| when C_ZV ^= V1 ^= ZV_956 ^= C_X3 ^= C_4881
          | (| ACT_C_X3{} |)
          | (| V1 := (0 when C_X3) default ((ZV_956+1) when C_4881)
             | ZV_956 := V1$1 init V_0_950
             | C_X3 := ZV_956>=(M1-1)
             | C_4881 := not (ZV_956>=(M1-1))
             |)
          |)
         where 
         boolean C_X3, C_4881;
         integer V1, ZV_956;
         process ACT_C_X3 =
              ( )
            (| when C_X3 ^= SWDIS ^= WDIS ^= ADIS ^= CST ^= STNB ^= NRINGING ^= CRINGING ^= LR_967 ^= UR_975 ^= V2 ^= ZV_1010 ^= CRINGUP ^= X ^= V_1134 ^= ZV_1149 ^= V1_1150 ^= XZX_1161 ^= ZV_1207 ^= V1_1208 ^= XZX_1249 ^= XZX_1931 ^= X1_2395 ^= Y21_2396 
               ^= Y2_2398 ^= X2_2399 ^= X3_2400 ^= C_X3_4889 ^= C_4892 ^= C_4903 ^= C_4906 ^= C_4908 ^= C_4911 ^= C_4926 ^= C__4932 ^= C__4935 ^= C__4938 ^= C_4951 ^= C_4955 ^= MODE_4964 ^= C_Y22_4969 ^= MODE_4975 ^= C_Y22_4980 ^= RINGING_4986 ^= C_4991 ^=
               XZX_4997 ^= XZX_5006 ^= XZX_5012 ^= XZX_5018 ^= C_5027 ^= C_5030 ^= C_5033 ^= C_5036 ^= C__5045 ^= C_BTI ^= C_5074 ^= C_X3_5077 ^= C_X3_5080 ^= C_MODONOFF ^= C_MODONOFF_5086 ^= C_X3_5089 ^= C_X3_5092 ^= C_X3_5095 ^= C_X3_5101 ^= C_X3_5104 ^=
               C_X3_5110 ^= C_X3_5113 ^= C_X3_5116 ^= C_X3_5119 ^= C_5155 ^= C_ZV_5170 ^= C_5225 ^= C_5228 ^= C_5232 ^= C_5236 ^= WBI_5239 ^= XZX_5245 ^= BTI_5251 ^= C_ZV_5262 ^= C_5271 ^= C_5277 ^= C_5280 ^= C__5283 ^= C_ZV_5289 ^= C_5303 ^= C_5327 ^= 
               C_5333 ^= C_5339 ^= C_5342 ^= C_5345 ^= C_5349 ^= C_5353 ^= C_5357 ^= C_5360 ^= C_5364 ^= C_5370
             | (| when WDIS ^= ZMODE ^= MODE ^= C_Y22
                | ACT_WDIS{}
                |)
             | (| when ADIS ^= ZMODE_353 ^= AMODE ^= C_Y22_4977
                | ACT_ADIS{}
                |)
             | (| ACT_XZX_1249{} |)
             | (| ACT_XZX_1931{} |)
             | (| when C_X3_4889 ^= C_4923 ^= C_
                | ACT_C_X3_4889{}
                |)
             | (| when C__4935 ^= XZX_906
                | ACT_C__4935{}
                |)
             | (| when C__4938 ^= RINGING ^= XZX_910 ^= C_4988 ^= C_5024
                | ACT_C__4938{}
                |)
             | (| when C__5045 ^= XZX_383
                | ACT_C__5045{}
                |)
             | (| when C_BTI ^= WBI ^= BTI
                | ACT_C_BTI{}
                |)
             | (| ACT_C_X3_5077{} |)
             | (| ACT_C_X3_5080{} |)
             | (| when C_MODONOFF ^= AMODONOFF
                | (| AMODONOFF := (not ZMODE_353) when C_MODONOFF |)
                |)
             | (| when C_MODONOFF_5086 ^= MODONOFF
                | (| MODONOFF := (not ZMODE) when C_MODONOFF_5086 |)
                |)
             | (| ACT_C_X3_5089{} |)
             | (| ACT_C_X3_5092{} |)
             | (| ACT_C_X3_5095{} |)
             | (| ACT_C_X3_5101{} |)
             | (| ACT_C_X3_5104{} |)
             | (| ACT_C_X3_5110{} |)
             | (| ACT_C_X3_5113{} |)
             | (| ACT_C_X3_5116{} |)
             | (| ACT_C_X3_5119{} |)
             | (| when C_ZV_5170 ^= NST
                | ACT_C_ZV_5170{}
                |)
             | (| when C_ZV_5262 ^= C_5268
                | ACT_C_ZV_5262{}
                |)
             | (| ACT_C__5283{} |)
             | (| when C_ZV_5289 ^= C_5324
                | ACT_C_ZV_5289{}
                |)
             | (| SWDIS := STNB=1
                | WDIS := STNB=0
                | ADIS := STNB=2
                | CST := (NST when C_ZV_5170) cell C_X3 init 0
                | STNB := CST$1 init 0
                | NRINGING := (true when CRINGUP) default (false when C_5370) default (false when C_5364) default (CRINGING when C_5360)
                | CRINGING := NRINGING$1 init false
                | LR_967 := RLR()
                | UR_975 := RUR()
                | V2 := (0 when C_X3_4889) default ((ZV_1010+1) when C_4892)
                | ZV_1010 := V2$1 init V_0_1004
                | CRINGUP := RRINGUP()
                | X := (0 when C_4908) default (V1_1208 when C_4911)
                | V_1134 := (0 when C_4903) default (V1_1150 when C_4906)
                | ZV_1149 := V_1134$1 init V_INIT
                | V1_1150 := ZV_1149+TS
                | XZX_1161 := V_1134+TS
                | WEFFACE(V_1134,0 when C_X3,XZX_1161,YS)
                | ZV_1207 := X$1 init V_INIT_1198
                | V1_1208 := ZV_1207+TS
                | XZX_1249 := (false when C_X3_5095) default (true when C_5228)
                | XZX_1931 := (false when C_X3_5089) default (true when C_5225)
                | X1_2395 := X+DELTA
                | Y21_2396 := (-TICK_HEIGHT) when C_X3
                | Y2_2398 := Y_POS_2386+Y21_2396
                | X2_2399 := X1_2395+BOOL_WIDTH
                | X3_2400 := X2_2399+DELTA
                | WHLINE(X,Y_POS_2386,X1_2395)
                | WVLINE(X1_2395,Y_POS_2386,Y2_2398)
                | WHLINE(X1_2395,Y2_2398,X2_2399)
                | WVLINE(X2_2399,Y_POS_2386,Y2_2398)
                | WHLINE(X2_2399,Y_POS_2386,X3_2400)
                | C_X3_4889 := ZV_1010>=(M2-1)
                | C_4892 := not (ZV_1010>=(M2-1))
                | C_4903 := V1_1150>=V_BOUND
                | C_4906 := not (V1_1150>=V_BOUND)
                | C_4908 := V1_1208>=V_BOUND_1195
                | C_4911 := not (V1_1208>=V_BOUND_1195)
                | C_4926 := left_tt ( C_4923,C_X3_4889 )
                | C__4932 := left_tt ( C_,C_X3_4889 )
                | C__4935 := UR_975 or C__4932
                | C__4938 := C__4935 or LR_967
                | C_4951 := (not C__4935) and LR_967
                | C_4955 := (not C__4932) and UR_975
                | MODE_4964 := left_tt ( MODE,WDIS )
                | C_Y22_4969 := left_tt ( C_Y22,WDIS )
                | MODE_4975 := left_tt ( AMODE,ADIS )
                | C_Y22_4980 := left_tt ( C_Y22_4977,ADIS )
                | RINGING_4986 := left_tt ( RINGING,C__4938 )
                | C_4991 := left_tt ( C_4988,C__4938 )
                | XZX_4997 := left_tt ( XZX_896,C_X3_4889 )
                | XZX_5006 := left_tt ( XZX_900,C_X3_4889 )
                | XZX_5012 := left_tt ( XZX_906,C__4935 )
                | XZX_5018 := left_tt ( XZX_910,C__4938 )
                | C_5027 := left_tt ( C_5024,C__4938 )
                | C_5030 := C_4991 and XZX_5012
                | C_5033 := C_4991 and XZX_5006
                | C_5036 := C_4991 and XZX_4997
                | C__5045 := CRINGUP or RINGING_4986
                | C_BTI := C__5045 or C_X3_4889
                | C_5074 := (not RINGING_4986) and CRINGUP
                | C_X3_5077 := SWDIS and XZX_5012
                | C_X3_5080 := SWDIS and XZX_5018
                | C_MODONOFF := ADIS and C_5036
                | C_MODONOFF_5086 := WDIS and C_5036
                | C_X3_5089 := SWDIS and C_5033
                | C_X3_5092 := C_5033 and MODE_4975
                | C_X3_5095 := C_5033 and C_Y22_4980
                | C_X3_5101 := C_5033 and MODE_4964
                | C_X3_5104 := C_5033 and C_Y22_4969
                | C_X3_5110 := ADIS and C_5030
                | C_X3_5113 := WDIS and C_5030
                | C_X3_5116 := ADIS and C_5027
                | C_X3_5119 := WDIS and C_5027
                | C_5155 := C_X3_5089 or C_X3_5104
                | C_ZV_5170 := C_5155 or C_X3_5095
                | C_5225 := not C_X3_5089
                | C_5228 := not C_X3_5095
                | C_5232 := (not C_MODONOFF_5086) and WDIS
                | C_5236 := (not C_MODONOFF) and ADIS
                | WBI_5239 := left_tt ( WBI,C_BTI )
                | XZX_5245 := left_tt ( XZX_383,C__5045 )
                | BTI_5251 := left_tt ( BTI,C_BTI )
                | C_ZV_5262 := XZX_5245 or BTI_5251
                | C_5271 := left_tt ( C_5268,C_ZV_5262 )
                | C_5277 := C_5271 and WBI_5239
                | C_5280 := C_5277 or XZX_5245
                | C__5283 := C_5280 or C_4926
                | C_ZV_5289 := C_5271 or XZX_5245
                | C_5303 := (not C_ZV_5289) and C_ZV_5262
                | C_5327 := left_tt ( C_5324,C_ZV_5289 )
                | C_5333 := C__5045 or C_5327
                | C_5339 := CRINGUP or C_5327
                | C_5342 := C_5327 or XZX_5245
                | C_5345 := C_5339 or C__4938
                | C_5349 := (not C_5342) and C_ZV_5289
                | C_5353 := (not C_5333) and C_BTI
                | C_5357 := (not C_5327) and C__5045
                | C_5360 := not C_5345
                | C_5364 := (not C_5339) and C__4938
                | C_5370 := (not CRINGUP) and C_5327
                |)
             |)
            where 
            integer CST, STNB, NST, V2, ZV_1010, X, V_1134, ZV_1149, V1_1150, XZX_1161, ZV_1207, V1_1208, X1_2395, Y21_2396, Y2_2398, X2_2399, X3_2400;
            boolean SWDIS, WDIS, ADIS, ZMODE, MODONOFF, MODE, ZMODE_353, AMODONOFF, AMODE, XZX_383, WBI, BTI, NRINGING, RINGING, CRINGING, XZX_896, XZX_900, XZX_906, XZX_910, LR_967, UR_975, CRINGUP, XZX_1249, XZX_1931, C_X3_4889, C_4892, C_4903, C_4906, 
                   C_4908, C_4911, C_4923, C_4926, C_, C__4932, C__4935, C__4938, C_4951, C_4955, MODE_4964, C_Y22, C_Y22_4969, MODE_4975, C_Y22_4977, C_Y22_4980, RINGING_4986, C_4988, C_4991, XZX_4997, XZX_5006, XZX_5012, XZX_5018, C_5024, C_5027, C_5030,
                   C_5033, C_5036, C__5045, C_BTI, C_5074, C_X3_5077, C_X3_5080, C_MODONOFF, C_MODONOFF_5086, C_X3_5089, C_X3_5092, C_X3_5095, C_X3_5101, C_X3_5104, C_X3_5110, C_X3_5113, C_X3_5116, C_X3_5119, C_5155, C_ZV_5170, C_5225, C_5228, C_5232, 
                   C_5236, WBI_5239, XZX_5245, BTI_5251, C_ZV_5262, C_5268, C_5271, C_5277, C_5280, C__5283, C_ZV_5289, C_5303, C_5324, C_5327, C_5333, C_5339, C_5342, C_5345, C_5349, C_5353, C_5357, C_5360, C_5364, C_5370;
            process ACT_WDIS =
                 ( )
               (| when WDIS ^= X1_1376 ^= Y1 ^= Y2_1380 ^= X2_1383 ^= XZX_1395 ^= XZX_1401
                | (| when MODE ^= Y11 ^= Y21_1381
                   | ACT_MODE{}
                   | when C_Y22 ^= Y12 ^= Y22_1382
                   | ACT_C_Y22{}
                   |)
                | (| ZMODE := MODE$1 init false
                   | MODE := (MODONOFF when C_MODONOFF_5086) default (ZMODE when C_5232)
                   | X1_1376 := X when WDIS
                   | Y1 := TICK_SIZE+XZX_1395
                   | Y2_1380 := TICK_SIZE+XZX_1401
                   | X2_1383 := X1_1376+DELTA_1370
                   | XZX_1395 := (Y11 when MODE) default (Y12 when C_Y22)
                   | XZX_1401 := (Y21_1381 when MODE) default (Y22_1382 when C_Y22)
                   | WHLINE(X1_1376,Y1,X2_1383)
                   | WHLINE(X1_1376,Y2_1380,X2_1383)
                   | C_Y22 := not MODE
                   |)
                |)
               where 
               integer X1_1376, Y1, Y11, Y12, Y2_1380, Y21_1381, Y22_1382, X2_1383, XZX_1395, XZX_1401;
               process ACT_MODE =
                    ( )
                  (| (| Y11 := (-BOOL_HEIGHT_1367) when MODE
                      | Y21_1381 := Y11-1
                      |) |)
               %ACT_MODE%; 
               process ACT_C_Y22 =
                    ( )
                  (| (| Y12 := BOOL_HEIGHT_1367 when C_Y22
                      | Y22_1382 := Y12+1
                      |) |)
               %ACT_C_Y22%; 
               end
            %ACT_WDIS%; 
            process ACT_ADIS =
                 ( )
               (| when ADIS ^= X1_2027 ^= Y1_2028 ^= Y2_2031 ^= X2_2034 ^= XZX_2046 ^= XZX_2052
                | (| when AMODE ^= Y11_2029 ^= Y21_2032
                   | ACT_AMODE{}
                   | when C_Y22_4977 ^= Y12_2030 ^= Y22_2033
                   | ACT_C_Y22_4977{}
                   |)
                | (| ZMODE_353 := AMODE$1 init false
                   | AMODE := (AMODONOFF when C_MODONOFF) default (ZMODE_353 when C_5236)
                   | X1_2027 := X when ADIS
                   | Y1_2028 := POS_Y_1894+XZX_2046
                   | Y2_2031 := POS_Y_1894+XZX_2052
                   | X2_2034 := X1_2027+DELTA_2021
                   | XZX_2046 := (Y11_2029 when AMODE) default (Y12_2030 when C_Y22_4977)
                   | XZX_2052 := (Y21_2032 when AMODE) default (Y22_2033 when C_Y22_4977)
                   | WHLINE(X1_2027,Y1_2028,X2_2034)
                   | WHLINE(X1_2027,Y2_2031,X2_2034)
                   | C_Y22_4977 := not AMODE
                   |)
                |)
               where 
               integer X1_2027, Y1_2028, Y11_2029, Y12_2030, Y2_2031, Y21_2032, Y22_2033, X2_2034, XZX_2046, XZX_2052;
               process ACT_AMODE =
                    ( )
                  (| (| Y11_2029 := (-BOOL_HEIGHT_2020) when AMODE
                      | Y21_2032 := Y11_2029-1
                      |) |)
               %ACT_AMODE%; 
               process ACT_C_Y22_4977 =
                    ( )
                  (| (| Y12_2030 := BOOL_HEIGHT_2020 when C_Y22_4977
                      | Y22_2033 := Y12_2030+1
                      |) |)
               %ACT_C_Y22_4977%; 
               end
            %ACT_ADIS%; 
            process ACT_XZX_1249 =
                 ( )
               (| when XZX_1249 ^= X1 ^= XZX_1254
                | (| X1 := X when XZX_1249
                   | XZX_1254 := X1+DELTA_1242
                   | WHLINE(X1,TICK_SIZE,XZX_1254)
                   |)
                |)
               where 
               integer X1, XZX_1254;
               end
            %ACT_XZX_1249%; 
            process ACT_XZX_1931 =
                 ( )
               (| when XZX_1931 ^= X1_1930 ^= XZX_1936
                | (| X1_1930 := X when XZX_1931
                   | XZX_1936 := X1_1930+DELTA_1924
                   | WHLINE(X1_1930,POS_Y_1894,XZX_1936)
                   |)
                |)
               where 
               integer X1_1930, XZX_1936;
               end
            %ACT_XZX_1931%; 
            process ACT_C_X3_4889 =
                 ( )
               (| when C_X3_4889 ^= LL_1021 ^= UL_1029 ^= X0_2320 ^= X1_2321 ^= Y21_2322 ^= Y2_2324 ^= X2_2325 ^= X3_2326 ^= C_4944 ^= C_4947
                | (| when C_ ^= XZX_896 ^= XZX_900
                   | ACT_C_{}
                   |)
                | (| LL_1021 := RLL()
                   | UL_1029 := RUL()
                   | X0_2320 := X when C_X3_4889
                   | X1_2321 := X0_2320+DELTA
                   | Y21_2322 := (-TICK_HEIGHT) when C_X3_4889
                   | Y2_2324 := POS_Y_2300+Y21_2322
                   | X2_2325 := X1_2321+BOOL_WIDTH
                   | X3_2326 := X2_2325+DELTA
                   | WHLINE(X0_2320,POS_Y_2300,X1_2321)
                   | WVLINE(X1_2321,POS_Y_2300,Y2_2324)
                   | WHLINE(X1_2321,Y2_2324,X2_2325)
                   | WVLINE(X2_2325,POS_Y_2300,Y2_2324)
                   | WHLINE(X2_2325,POS_Y_2300,X3_2326)
                   | C_4923 := UL_1029 and LL_1021
                   | C_ := UL_1029 or LL_1021
                   | C_4944 := (not UL_1029) and LL_1021
                   | C_4947 := (not LL_1021) and UL_1029
                   |)
                |)
               where 
               integer X0_2320, X1_2321, Y21_2322, Y2_2324, X2_2325, X3_2326;
               boolean LL_1021, UL_1029, C_4944, C_4947;
               process ACT_C_ =
                    ( )
                  (| (| XZX_896 := (false when LL_1021) default (true when C_4947)
                      | XZX_900 := (false when UL_1029) default (true when C_4944)
                      |) |)
               %ACT_C_%; 
               end
            %ACT_C_X3_4889%; 
            process ACT_C__4935 =
                 ( )
               (| (| XZX_906 := (false when C_) default (true when C_4955) |) |)
            %ACT_C__4935%; 
            process ACT_C__4938 =
                 ( )
               (| (| RINGING := CRINGING when C__4938
                   | XZX_910 := (false when C__4935) default (true when C_4951)
                   | C_4988 := not RINGING
                   | C_5024 := C_4988 and XZX_910
                   |) |)
            %ACT_C__4938%; 
            process ACT_C__5045 =
                 ( )
               (| (| XZX_383 := (false when RINGING) default (true when C_5074) |) |)
            %ACT_C__5045%; 
            process ACT_C_BTI =
                 ( )
               (| (| WBI := (false when C_5324) default (XZX_383 when C_5357) default (BTI when C_5353)
                   | BTI := WBI$1 init false
                   |) |)
            %ACT_C_BTI%; 
            process ACT_C_X3_5077 =
                 ( )
               (| when C_X3_5077 ^= X0_1752 ^= X1_1753 ^= Y21_1754 ^= Y2_1756 ^= X2_1757 ^= X3_1758
                | (| X0_1752 := X when C_X3_5077
                   | X1_1753 := X0_1752+DELTA
                   | Y21_1754 := (-TICK_HEIGHT) when C_X3_5077
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
            %ACT_C_X3_5077%; 
            process ACT_C_X3_5080 =
                 ( )
               (| when C_X3_5080 ^= X0_1826 ^= X1_1827 ^= Y21_1828 ^= Y2_1830 ^= X2_1831 ^= X3_1832
                | (| X0_1826 := X when C_X3_5080
                   | X1_1827 := X0_1826+DELTA
                   | Y21_1828 := (-TICK_HEIGHT) when C_X3_5080
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
            %ACT_C_X3_5080%; 
            process ACT_C_X3_5089 =
                 ( )
               (| when C_X3_5089 ^= X0_1954 ^= X1_1955 ^= Y21_1956 ^= Y2_1958 ^= X2_1959 ^= X3_1960
                | (| X0_1954 := X when C_X3_5089
                   | X1_1955 := X0_1954+DELTA
                   | Y21_1956 := (-BOOL_HEIGHT) when C_X3_5089
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
            %ACT_C_X3_5089%; 
            process ACT_C_X3_5092 =
                 ( )
               (| when C_X3_5092 ^= X0_2234 ^= X1_2235 ^= Y21_2236 ^= Y2_2238 ^= X2_2239 ^= X3_2240
                | (| X0_2234 := X when C_X3_5092
                   | X1_2235 := X0_2234+DELTA
                   | Y21_2236 := (-TICK_HEIGHT) when C_X3_5092
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
            %ACT_C_X3_5092%; 
            process ACT_C_X3_5095 =
                 ( )
               (| when C_X3_5095 ^= X0 ^= X1_1286 ^= Y21 ^= Y2 ^= X2 ^= X3
                | (| X0 := X when C_X3_5095
                   | X1_1286 := X0+DELTA
                   | Y21 := (-BOOL_HEIGHT) when C_X3_5095
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
            %ACT_C_X3_5095%; 
            process ACT_C_X3_5101 =
                 ( )
               (| when C_X3_5101 ^= X0_1589 ^= X1_1590 ^= Y21_1591 ^= Y2_1593 ^= X2_1594 ^= X3_1595
                | (| X0_1589 := X when C_X3_5101
                   | X1_1590 := X0_1589+DELTA
                   | Y21_1591 := (-TICK_HEIGHT) when C_X3_5101
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
            %ACT_C_X3_5101%; 
            process ACT_C_X3_5104 =
                 ( )
               (| when C_X3_5104 ^= X0_1678 ^= X1_1679 ^= Y21_1680 ^= Y2_1682 ^= X2_1683 ^= X3_1684
                | (| X0_1678 := X when C_X3_5104
                   | X1_1679 := X0_1678+DELTA
                   | Y21_1680 := (-TICK_HEIGHT) when C_X3_5104
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
            %ACT_C_X3_5104%; 
            process ACT_C_X3_5110 =
                 ( )
               (| when C_X3_5110 ^= X0_2084 ^= X1_2085 ^= Y21_2086 ^= Y2_2088 ^= X2_2089 ^= X3_2090
                | (| X0_2084 := X when C_X3_5110
                   | X1_2085 := X0_2084+DELTA
                   | Y21_2086 := (-TICK_HEIGHT) when C_X3_5110
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
            %ACT_C_X3_5110%; 
            process ACT_C_X3_5113 =
                 ( )
               (| when C_X3_5113 ^= X0_1434 ^= X1_1435 ^= Y21_1436 ^= Y2_1438 ^= X2_1439 ^= X3_1440
                | (| X0_1434 := X when C_X3_5113
                   | X1_1435 := X0_1434+DELTA
                   | Y21_1436 := (-TICK_HEIGHT) when C_X3_5113
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
            %ACT_C_X3_5113%; 
            process ACT_C_X3_5116 =
                 ( )
               (| when C_X3_5116 ^= X0_2159 ^= X1_2160 ^= Y21_2161 ^= Y2_2163 ^= X2_2164 ^= X3_2165
                | (| X0_2159 := X when C_X3_5116
                   | X1_2160 := X0_2159+DELTA
                   | Y21_2161 := (-TICK_HEIGHT) when C_X3_5116
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
            %ACT_C_X3_5116%; 
            process ACT_C_X3_5119 =
                 ( )
               (| when C_X3_5119 ^= X0_1513 ^= X1_1514 ^= Y21_1515 ^= Y2_1517 ^= X2_1518 ^= X3_1519
                | (| X0_1513 := X when C_X3_5119
                   | X1_1514 := X0_1513+DELTA
                   | Y21_1515 := (-TICK_HEIGHT) when C_X3_5119
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
            %ACT_C_X3_5119%; 
            process ACT_C_ZV_5170 =
                 ( )
               (| when C_ZV_5170 ^= ZV_605 ^= C_5256 ^= C_5259
                | (| NST := (0 when C_5256) default ((ZV_605+1) when C_5259)
                   | ZV_605 := NST$1 init 0
                   | C_5256 := ZV_605>=2
                   | C_5259 := not (ZV_605>=2)
                   |)
                |)
               where 
               boolean C_5256, C_5259;
               integer ZV_605;
               end
            %ACT_C_ZV_5170%; 
            process ACT_C_ZV_5262 =
                 ( )
               (| when C_ZV_5262 ^= V ^= ZV
                | (| V := (0 when C_ZV_5289) default ((ZV+1) when C_5303)
                   | ZV := V$1 init 0
                   | C_5268 := ZV>=(PI-1)
                   |)
                |)
               where 
               integer V, ZV;
               end
            %ACT_C_ZV_5262%; 
            process ACT_C__5283 =
                 ( )
               (| when C__5283 ^= XZX_1054
                | (| XZX_1054 := PERCENT when C__5283
                   | SIGBELL(XZX_1054)
                   |)
                |)
               where 
               integer XZX_1054;
               end
            %ACT_C__5283%; 
            process ACT_C_ZV_5289 =
                 ( )
               (| when C_ZV_5289 ^= V_446 ^= ZV_471
                | (| V_446 := (0 when C_5342) default ((ZV_471+1) when C_5349)
                   | ZV_471 := V_446$1 init 0
                   | C_5324 := ZV_471>=(NAL-1)
                   |)
                |)
               where 
               integer V_446, ZV_471;
               end
            %ACT_C_ZV_5289%; 
            end
         %ACT_C_X3%; 
         end
      %ACT_C_ZV%; 
      end
   %ACT_Tick%; 
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
%VTSUPER_SEQ_TRA%; %^0 ^= Y22 ^= Y22_1437 ^= Y22_1516 ^= Y22_1592 ^= Y22_1681 ^= Y22_1755 ^= Y22_1829 ^= Y22_1957 ^= Y22_2087 ^= Y22_2162 ^= Y22_2237 ^= Y22_2323 ^= Y22_2397***WARNING: null clock signals 
%
(| Tick := true when Tick
 | C_4806 := not C_UP
 | C_4809 := not C_DOWN
 | C_4812 := not C_AUTO
 | C_4820 := not (ZMAX>1)
 | C_4831 := C_DOWN or C_AUTO
 | C_4834 := C_4831 or C_UP
 | C_4846 := AUTOMOD or C_UP
 | C_4852 := C_VD or C_4843
 | C_4858 := C_4837 or AUTOMOD
 | C_4861 := C_4858 or C_UP
 | C_4876 := (not C_4825) and C_UP
 | C_4884 := not UR_975
 | C_4887 := not LR_967
 | C_4895 := not UL_1029
 | C_4898 := not LL_1021
 | C_4901 := not CRINGUP
 | C_4914 := not XZX_1249
 | C_4917 := not XZX_1931
 | C_4920 := UR_975 or LR_967
 | C_4941 := C__4938 or C_X3_4889
 | C_4958 := not C__4938
 | C_4961 := not WDIS
 | C_4972 := not ADIS
 | C_4983 := not SWDIS
 | XZX_4994 := left_tt ( XZX_896,C_ )
 | C_5000 := not XZX_896
 | XZX_5003 := left_tt ( XZX_900,C_ )
 | C_5009 := not XZX_900
 | C_5015 := not XZX_906
 | C_5021 := not XZX_910
 | C_5039 := RINGING or C_5024
 | C_5042 := left_tt ( C_5039,C__4938 )
 | C_5051 := C_5030 or C_5042
 | C_5054 := C_5051 or C_5033
 | C_5057 := C_5054 or C_5036
 | C_5060 := XZX_5012 or XZX_5018
 | C_5063 := C_5060 or XZX_5006
 | C_5066 := C_5063 or XZX_4997
 | C_5070 := (not C_X3_4889) and C__5045
 | C_5098 := ADIS and C_5033
 | C_5107 := WDIS and C_5033
 | C_5122 := C_X3_5113 or C_X3_5119
 | C_5125 := C_X3_5110 or C_X3_5116
 | C_5128 := C_X3_5101 or C_X3_5119
 | C_5131 := C_5128 or C_X3_5113
 | C_5134 := C_X3_5095 or XZX_1249
 | C_5137 := C_X3_5095 or WDIS
 | C_5140 := C_5137 or XZX_1249
 | C_5143 := C_5134 or C_5128
 | C_5146 := C_X3_5092 or C_X3_5116
 | C_5149 := C_5146 or C_X3_5110
 | C_5152 := C_X3_5089 or C_5146
 | C_5158 := C_X3_5089 or XZX_1931
 | C_5161 := C_X3_5089 or ADIS
 | C_5164 := C_5161 or XZX_1931
 | C_5167 := C_5158 or C_5146
 | C_5173 := C_MODONOFF_5086 or C_5107
 | C_5176 := C_5173 or C_X3_5119
 | C_5179 := C_5176 or C_X3_5113
 | C_5182 := C_MODONOFF or C_X3_5095
 | C_5185 := C_MODONOFF or C_5098
 | C_5188 := C_5185 or C_X3_5116
 | C_5191 := C_5188 or C_X3_5110
 | C_5194 := C_X3_5077 or C_X3_5080
 | C_5197 := C_5194 or C_X3_5089
 | C_5200 := C_5194 or C_X3_5104
 | C_5203 := C_5194 or C_5033
 | C_5206 := C_5200 or C_5161
 | C_5209 := C_5200 or C_5164
 | C_5212 := C_5209 or C_5140
 | C_5215 := C_5206 or C_5140
 | C_5219 := (not C_5155) and C_X3_5095
 | C_5223 := (not C_X3_5089) and C_X3_5104
 | C_5242 := not WBI
 | C_5248 := not XZX_383
 | C_5254 := not BTI
 | C_5266 := (not XZX_5245) and C_ZV_5262
 | C_5274 := not (ZV>=(PI-1))
 | C_5286 := C_5280 and WBI_5239
 | C_5292 := (not XZX_5245) and C_ZV_5289
 | C_5296 := (not C_4926) and C_5280
 | C_5299 := (not XZX_5245) and C_5277
 | C_5307 := (not C_5271) and XZX_5245
 | C_5310 := ADIS or C_5280
 | C_5313 := C_5310 or WDIS
 | C_5316 := C_5313 or C_X3_5089
 | C_5319 := C_5316 or C_X3_5077
 | C_5322 := C_5319 or C_X3_5080
 | C_5330 := not (ZV_471>=(NAL-1))
 | C_5336 := C_5280 or C_5327
 | C_5367 := (not XZX_5245) and C_5327
 | C_5373 := ADIS or C_5327
 | C_5376 := C_5373 or C_5280
 | C_5379 := C_5376 or WDIS
 | C_5382 := C_MODONOFF_5086 or C_5376
 |)***WARNING: unused signals 
%
%
