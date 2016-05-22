process VTALARM_BOOL_TRA =
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
   boolean Tick;
   process ACT_Tick =
        ( )
      (| when Tick ^= AUTOMOD ^= C_UP ^= C_DOWN ^= C_AUTO ^= C ^= C_6157 ^= C_6165 ^= C_6177 ^= C_VD ^= C_6183 ^= C_VU ^= C_6195 ^= C_ZV ^= C_6208 ^= C_6212
       | (| when AUTOMOD ^= ZMAX ^= C_6154 ^= C_6162
          | ACT_AUTOMOD{}
          |)
       | (| when C_AUTO ^= CAUTO
          | ACT_C_AUTO{}
          |)
       | (| (| WSTOP(true when C_6177) |) |)
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
          | C_6157 := left_tt ( C_6154,AUTOMOD )
          | C_6165 := left_tt ( C_6162,AUTOMOD )
          | C_6177 := C and C_DOWN
          | C_VD := AUTOMOD and C_DOWN
          | C_6183 := AUTOMOD and C_UP
          | C_VU := C_6183 and C_6157
          | C_6195 := C_VD or C_VU
          | C_ZV := C_UP or C_6165
          | C_6208 := (not C_VU) and C_VD
          | C_6212 := (not C_6195) and AUTOMOD
          |)
       |)
      where 
      integer VU, VD, ZMAX;
      boolean AUTOMOD, CAUTO, C_UP, C_DOWN, C_AUTO, C, C_6154, C_6157, C_6162, C_6165, C_6177, C_VD, C_6183, C_VU, C_6195, C_ZV, C_6208, C_6212;
      process ACT_AUTOMOD =
           ( )
         (| when AUTOMOD ^= MAX ^= V_2090 ^= ZV_2102 ^= C_6168
          | (| MAX := (VU when C_VU) default (VD when C_6208) default (ZMAX when C_6212)
             | ZMAX := MAX$1 init 20
             | V_2090 := (0 when C_6162) default ((ZV_2102+1) when C_6168)
             | ZV_2102 := V_2090$1 init 1
             | C_6154 := ZMAX>1
             | C_6162 := ZV_2102>=(MAX-1)
             | C_6168 := not (ZV_2102>=(MAX-1))
             |)
          |)
         where 
         boolean C_6168;
         integer MAX, V_2090, ZV_2102;
         end
      %ACT_AUTOMOD%; 
      process ACT_C_AUTO =
           ( )
         (| when C_AUTO ^= ZB_2017
          | (| CAUTO := not ZB_2017
             | ZB_2017 := CAUTO$1 init V0_2013
             |)
          |)
         where 
         boolean ZB_2017;
         end
      %ACT_C_AUTO%; 
      process ACT_C_ZV =
           ( )
         (| when C_ZV ^= V1 ^= ZV_2205 ^= C_ZV_6218 ^= C_6221
          | (| ACT_C_ZV_6218{} |)
          | (| V1 := (0 when C_ZV_6218) default ((ZV_2205+1) when C_6221)
             | ZV_2205 := V1$1 init 4
             | C_ZV_6218 := ZV_2205>=4
             | C_6221 := not (ZV_2205>=4)
             |)
          |)
         where 
         boolean C_ZV_6218, C_6221;
         integer V1, ZV_2205;
         process ACT_C_ZV_6218 =
              ( )
            (| when C_ZV_6218 ^= WDIS ^= ADIS ^= SWDIS ^= STNB ^= CST ^= NRINGING ^= CRINGING ^= LR_2216 ^= UR_2224 ^= V2 ^= ZV_2259 ^= C_UL ^= C_6232 ^= C_6247 ^= C__6253 ^= C__6256 ^= C__6259 ^= C_6272 ^= C_6276 ^= CSTATE_6282 ^= MODE_6291 ^= C_6296 ^= 
               WBI_6299 ^= BTI_6305 ^= RINGING_6314 ^= C_6319 ^= C_6327 ^= C_CC_6332 ^= C_CC_6343 ^= XZX_6352 ^= XZX_6361 ^= XZX_6367 ^= C_6392 ^= C_6395 ^= C_6398 ^= C_6401 ^= C_MODONOFF ^= C_MODONOFF_6431 ^= C_6434 ^= C_6440 ^= C_6443 ^= C_6446 ^= 
               C_6452 ^= C_6455 ^= C_6458 ^= C_6461 ^= C_6473 ^= C_6476 ^= C_6482 ^= C_CC_6485 ^= C_DV2 ^= C_ZCSET ^= C_ALCANCEL ^= C_ZCSET_6509 ^= C_SETONOFF ^= C_6528 ^= C_6536 ^= C_6540 ^= C_6552 ^= C_6574 ^= C_6578 ^= SETONOFF_6581 ^= CSET_6587 ^= 
               C_6592 ^= MODONOFF_6595 ^= ALCANCEL_6601 ^= C_6614 ^= C_6625 ^= C_ZB ^= C_ZB_6631 ^= C_6634 ^= C_ZB_6637 ^= C_6640 ^= C_CC_6661 ^= C_CSTATE ^= C_6676 ^= C_DV3 ^= C_CSET ^= C_6706 ^= C_CC_6709 ^= C_CSTATE_6715 ^= C_6734 ^= C_6738 ^= C_6742 ^=
               C_6750 ^= C_6757 ^= CSET_6760 ^= SETH_6766 ^= CSTATE_6771 ^= CSTATE_6777 ^= CSET_6783 ^= XZX_6789 ^= SETONOFF_6795 ^= C_6819 ^= C_6822 ^= C_6825 ^= C_6828 ^= C_6831 ^= C_ZV_6834 ^= C_6837 ^= C_6843 ^= C_6849 ^= C_6852 ^= C_6855 ^= C_ZV_6858 
               ^= C_6861 ^= C_ZV_6864 ^= C_CWV ^= C__6870 ^= C_6911 ^= C_CWV_6919 ^= C_6930 ^= C_6938 ^= C_6946 ^= C_6952 ^= C_6955 ^= C_ZV_6958 ^= C_ZV_6964 ^= C_ZV_6967 ^= C__6970 ^= C_BTI ^= C_6979 ^= C_6982 ^= C_6993 ^= C_6997 ^= C_7004 ^= C_7012 ^= 
               INCREASE_7015 ^= C_7020 ^= C_7025 ^= WBI_7031 ^= XZX_7037 ^= BTI_7043 ^= INCREASE_7049 ^= C_7054 ^= C_7057 ^= C_7063 ^= C_7066 ^= C_7069 ^= C_7072 ^= C_7075 ^= C_7078 ^= C_7084 ^= C_CSTATE_7087 ^= C_7093 ^= C_CSTATE_7096 ^= C_ZV_7099 ^= 
               C_CV ^= C__7114 ^= C_7120 ^= C_7129 ^= C_ZV_7132 ^= C_CV_7138 ^= C_7147 ^= C__7150 ^= C_7159 ^= C_ZV_7165 ^= C_7193 ^= C_7197 ^= C_7201 ^= C_7205 ^= C_7209 ^= C_7213 ^= C_7216 ^= CSTATE_7227 ^= C_7235 ^= CSTATE_7246 ^= C_7252 ^= C_7255 ^= 
               C_DV4 ^= C_DV4_7264 ^= C_DV ^= C_CC_7279 ^= C_CC_7291 ^= C_7318 ^= C_7321 ^= C_7324 ^= C_7330 ^= C_ZV_7339 ^= C_7363 ^= C_7366 ^= C_7369 ^= C_7373 ^= C_7376 ^= C_7392 ^= C_7416 ^= C_7419 ^= C_7428 ^= C_7431 ^= C_7437 ^= C_7456 ^= C_7460 ^= 
               C_7464 ^= C_7467 ^= C_7471 ^= C_7478
             | (| when ADIS ^= ZMODE ^= MODE ^= C_6293
                | ACT_ADIS{}
                |)
             | (| when WDIS ^= ZMODE_1812 ^= C_6324
                | ACT_WDIS{}
                |)
             | (| when C_UL ^= CSTATE ^= WBI ^= BTI ^= C_6244 ^= C_ ^= C_CC
                | ACT_C_UL{}
                |)
             | (| when C__6256 ^= XZX_2153
                | ACT_C__6256{}
                |)
             | (| when C__6259 ^= RINGING ^= C_6316 ^= C_6389
                | ACT_C__6259{}
                |)
             | (| when C_MODONOFF ^= WMODONOFF
                | ACT_C_MODONOFF{}
                |)
             | (| when C_MODONOFF_6431 ^= MODONOFF
                | (| MODONOFF := (not ZMODE) when C_MODONOFF_6431 |)
                |)
             | (| when C_CC_6485 ^= NST
                | ACT_C_CC_6485{}
                |)
             | (| when C_DV2 ^= SETONOFF ^= DV2 ^= DV2_1460
                | ACT_C_DV2{}
                |)
             | (| when C_ZCSET ^= CSET ^= C_6589
                | ACT_C_ZCSET{}
                |)
             | (| when C_ALCANCEL ^= ALCANCEL
                | ACT_C_ALCANCEL{}
                |)
             | (| when C_ZCSET_6509 ^= C_6611
                | ACT_C_ZCSET_6509{}
                |)
             | (| when C_SETONOFF ^= SETONOFF_1751
                | (| SETONOFF_1751 := (false when C_6446) default (WMODONOFF when C_6536) |)
                |)
             | (| when C_ZB ^= DB_457
                | ACT_C_ZB{}
                |)
             | (| when C_ZB_6631 ^= STATE24
                | ACT_C_ZB_6631{}
                |)
             | (| when C_ZB_6637 ^= DB
                | ACT_C_ZB_6637{}
                |)
             | (| when C_CC_6661 ^= DISB
                | ACT_C_CC_6661{}
                |)
             | (| when C_CSTATE ^= CSTATE_973
                | ACT_C_CSTATE{}
                |)
             | (| when C_DV3 ^= SETH ^= DV3 ^= XZX_1268 ^= SETONOFF_1440 ^= DV3_1461
                | ACT_C_DV3{}
                |)
             | (| when C_CSET ^= CSET_645 ^= CSET_1322
                | ACT_C_CSET{}
                |)
             | (| when C_CC_6709 ^= DALARM
                | ACT_C_CC_6709{}
                |)
             | (| when C_CSTATE_6715 ^= CSTATE_906
                | ACT_C_CSTATE_6715{}
                |)
             | (| when C_ZV_6834 ^= C_6935
                | ACT_C_ZV_6834{}
                |)
             | (| when C_ZV_6858 ^= C_6943
                | ACT_C_ZV_6858{}
                |)
             | (| when C_ZV_6864 ^= C_6908
                | ACT_C_ZV_6864{}
                |)
             | (| when C_CWV ^= C_CWV_6916
                | ACT_C_CWV{}
                |)
             | (| when C__6870 ^= XZX_931
                | (| XZX_931 := (CHOUR when C_CC_6337) cell C__6870 init 0 |)
                |)
             | (| when C_ZV_6958 ^= C_7022
                | ACT_C_ZV_6958{}
                |)
             | (| when C_ZV_6964 ^= INCREASE ^= C_7017
                | ACT_C_ZV_6964{}
                |)
             | (| when C_ZV_6967 ^= INCREASE_1375 ^= C_7051
                | ACT_C_ZV_6967{}
                |)
             | (| when C__6970 ^= XZX_1122
                | ACT_C__6970{}
                |)
             | (| when C_BTI ^= WBI_1142 ^= BTI_1221
                | ACT_C_BTI{}
                |)
             | (| when C_CSTATE_7087 ^= CSTATE_804
                | ACT_C_CSTATE_7087{}
                |)
             | (| when C_CSTATE_7096 ^= CSTATE_1482
                | ACT_C_CSTATE_7096{}
                |)
             | (| when C_ZV_7099 ^= V
                | ACT_C_ZV_7099{}
                |)
             | (| when C_CV ^= CV
                | (| CV := (V when C_ZV_7099) cell C_CV init 0 |)
                |)
             | (| when C__7114 ^= XZX_927
                | (| XZX_927 := (V when C_ZV_7099) cell C__7114 init 0 |)
                |)
             | (| when C_ZV_7132 ^= AMIN
                | ACT_C_ZV_7132{}
                |)
             | (| when C_CV_7138 ^= CV_1459
                | (| CV_1459 := (AMIN when C_ZV_7132) cell C_CV_7138 init 0 |)
                |)
             | (| when C__7150 ^= XZX_954
                | (| XZX_954 := (AMIN when C_ZV_7132) cell C__7150 init 0 |)
                |)
             | (| when C_ZV_7165 ^= C_7232
                | ACT_C_ZV_7165{}
                |)
             | (| when C_DV4 ^= DV4
                | ACT_C_DV4{}
                |)
             | (| when C_DV4_7264 ^= DV4_1462
                | ACT_C_DV4_7264{}
                |)
             | (| when C_DV ^= DV
                | (| DV := (V when C_ZV_7099) default (DV2 when C_7209) default (DV3 when C_7201) default (DV4 when C_7369) |)
                |)
             | (| ACT_C_CC_7279{} |)
             | (| ACT_C_CC_7291{} |)
             | (| (| SIGBELL(30 when C_7330) |) |)
             | (| when C_ZV_7339 ^= C_7389
                | ACT_C_ZV_7339{}
                |)
             | (| WDIS := STNB=0
                | ADIS := STNB=2
                | SWDIS := STNB=1
                | STNB := CST$1 init 0
                | CST := (NST when C_CC_6485) cell C_ZV_6218 init 0
                | NRINGING := (true when C_6924) default (false when C_7478) default (false when C_7471) default (CRINGING when C_7467)
                | CRINGING := NRINGING$1 init false
                | LR_2216 := RLR()
                | UR_2224 := RUR()
                | V2 := (0 when C_UL) default ((ZV_2259+1) when C_6232)
                | ZV_2259 := V2$1 init 1
                | C_UL := ZV_2259>=1
                | C_6232 := not (ZV_2259>=1)
                | C_6247 := left_tt ( C_6244,C_UL )
                | C__6253 := left_tt ( C_,C_UL )
                | C__6256 := UR_2224 or C__6253
                | C__6259 := C__6256 or LR_2216
                | C_6272 := (not C__6256) and LR_2216
                | C_6276 := (not C__6253) and UR_2224
                | CSTATE_6282 := left_tt ( CSTATE,C_UL )
                | MODE_6291 := left_tt ( MODE,ADIS )
                | C_6296 := left_tt ( C_6293,ADIS )
                | WBI_6299 := left_tt ( WBI,C_UL )
                | BTI_6305 := left_tt ( BTI,C_UL )
                | RINGING_6314 := left_tt ( RINGING,C__6259 )
                | C_6319 := left_tt ( C_6316,C__6259 )
                | C_6327 := left_tt ( C_6324,WDIS )
                | C_CC_6332 := left_tt ( C_CC,C_UL )
                | C_CC_6343 := left_tt ( C_CC_6337,C_UL )
                | XZX_6352 := left_tt ( XZX_2143,C_UL )
                | XZX_6361 := left_tt ( XZX_2147,C_UL )
                | XZX_6367 := left_tt ( XZX_2153,C__6256 )
                | C_6392 := left_tt ( C_6389,C__6259 )
                | C_6395 := C_6319 and XZX_6367
                | C_6398 := C_6319 and XZX_6361
                | C_6401 := C_6319 and XZX_6352
                | C_MODONOFF := WDIS and C_6401
                | C_MODONOFF_6431 := ADIS and C_6401
                | C_6434 := C_6398 and C_6327
                | C_6440 := SWDIS and C_6398
                | C_6443 := C_6398 and MODE_6291
                | C_6446 := C_6398 and C_6296
                | C_6452 := ADIS and C_6395
                | C_6455 := WDIS and C_6392
                | C_6458 := ADIS and C_6392
                | C_6461 := C_6452 or C_6458
                | C_6473 := C_6446 or C_6455
                | C_6476 := C_6443 or C_6461
                | C_6482 := C_6434 or C_6440
                | C_CC_6485 := C_6482 or C_6446
                | C_DV2 := C_MODONOFF_6431 or C_6440
                | C_ZCSET := C_DV2 or C_6476
                | C_ALCANCEL := C_MODONOFF or C_DV2
                | C_ZCSET_6509 := C_MODONOFF or C_6473
                | C_SETONOFF := C_MODONOFF or C_6446
                | C_6528 := (not C_SETONOFF) and C_ZCSET_6509
                | C_6536 := (not C_6446) and C_MODONOFF
                | C_6540 := (not C_DV2) and C_ZCSET
                | C_6552 := (not C_6440) and C_MODONOFF_6431
                | C_6574 := (not C_MODONOFF) and WDIS
                | C_6578 := (not C_MODONOFF_6431) and ADIS
                | SETONOFF_6581 := left_tt ( SETONOFF,C_DV2 )
                | CSET_6587 := left_tt ( CSET,C_ZCSET )
                | C_6592 := left_tt ( C_6589,C_ZCSET )
                | MODONOFF_6595 := left_tt ( WMODONOFF,C_MODONOFF )
                | ALCANCEL_6601 := left_tt ( ALCANCEL,C_ALCANCEL )
                | C_6614 := left_tt ( C_6611,C_ZCSET_6509 )
                | C_6625 := C_6443 and CSET_6587
                | C_ZB := C_6452 and C_6592
                | C_ZB_6631 := C_6455 and C_6614
                | C_6634 := C_6458 and CSET_6587
                | C_ZB_6637 := C_6458 and C_6592
                | C_6640 := C_6634 or CSTATE_6282
                | C_CC_6661 := C_ZB or C_MODONOFF
                | C_CSTATE := C_CC_6661 or C_CC_6343
                | C_6676 := C_6625 or C_DV2
                | C_DV3 := C_6625 or SETONOFF_6581
                | C_CSET := C_DV3 or C_6640
                | C_6706 := SETONOFF_6581 or MODONOFF_6595
                | C_CC_6709 := C_ALCANCEL or C_ZB_6637
                | C_CSTATE_6715 := C_CC_6709 or C_CC_6332
                | C_6734 := (not ALCANCEL_6601) and C_CC_6709
                | C_6738 := (not SETONOFF_6581) and C_DV3
                | C_6742 := (not MODONOFF_6595) and C_CC_6661
                | C_6750 := (not C_6706) and C_ALCANCEL
                | C_6757 := (not MODONOFF_6595) and SETONOFF_6581
                | CSET_6760 := left_tt ( CSET_645,C_CSET )
                | SETH_6766 := left_tt ( SETH,C_DV3 )
                | CSTATE_6771 := left_tt ( CSTATE_906,C_CSTATE_6715 )
                | CSTATE_6777 := left_tt ( CSTATE_973,C_CSTATE )
                | CSET_6783 := left_tt ( CSET_1322,C_CSET )
                | XZX_6789 := left_tt ( XZX_1268,C_DV3 )
                | SETONOFF_6795 := left_tt ( SETONOFF_1440,C_DV3 )
                | C_6819 := C_6634 and CSET_6783
                | C_6822 := C_6634 and CSET_6760
                | C_6825 := CSTATE_6777 and C_CC_6343
                | C_6828 := CSTATE_6282 and CSET_6783
                | C_6831 := CSTATE_6282 and CSET_6760
                | C_ZV_6834 := C_6825 or BTI_6305
                | C_6837 := C_6822 or C_6831
                | C_6843 := C_6819 or C_6828
                | C_6849 := C_6634 or SETH_6766
                | C_6852 := C_6634 or XZX_6789
                | C_6855 := C_6852 and CSET_6783
                | C_ZV_6858 := C_6855 or C_6843
                | C_6861 := C_6849 and CSET_6760
                | C_ZV_6864 := C_6861 or C_6837
                | C_CWV := CSTATE_6771 and C_CC_6332
                | C__6870 := C_CWV or C_CC_6343
                | C_6911 := left_tt ( C_6908,C_ZV_6864 )
                | C_CWV_6919 := left_tt ( C_CWV_6916,C_CWV )
                | C_6930 := left_tt ( C_6924,C_CWV )
                | C_6938 := left_tt ( C_6935,C_ZV_6834 )
                | C_6946 := left_tt ( C_6943,C_ZV_6858 )
                | C_6952 := C_6938 and WBI_6299
                | C_6955 := C_6952 or C_6825
                | C_ZV_6958 := C_6825 or C_6938
                | C_ZV_6964 := C_6861 or C_6911
                | C_ZV_6967 := C_6855 or C_6946
                | C__6970 := RINGING_6314 or C_6930
                | C_BTI := C__6970 or C_UL
                | C_6979 := (not C_6861) and C_ZV_6964
                | C_6982 := (not C_6855) and C_ZV_6967
                | C_6993 := (not C_ZV_6964) and C_ZV_6864
                | C_6997 := (not C_ZV_6967) and C_ZV_6858
                | C_7004 := (not C_ZV_6958) and C_ZV_6834
                | C_7012 := (not RINGING_6314) and C_6930
                | INCREASE_7015 := left_tt ( INCREASE,C_ZV_6964 )
                | C_7020 := left_tt ( C_7017,C_ZV_6964 )
                | C_7025 := left_tt ( C_7022,C_ZV_6958 )
                | WBI_7031 := left_tt ( WBI_1142,C_BTI )
                | XZX_7037 := left_tt ( XZX_1122,C__6970 )
                | BTI_7043 := left_tt ( BTI_1221,C_BTI )
                | INCREASE_7049 := left_tt ( INCREASE_1375,C_ZV_6967 )
                | C_7054 := left_tt ( C_7051,C_ZV_6967 )
                | C_7057 := C_6825 or C_7025
                | C_7063 := C_6819 and INCREASE_7049
                | C_7066 := C_6822 and INCREASE_7015
                | C_7069 := C_6828 and INCREASE_7049
                | C_7072 := C_6828 and C_7054
                | C_7075 := C_6831 and INCREASE_7015
                | C_7078 := C_6831 and C_7020
                | C_7084 := C_7075 or C_6676
                | C_CSTATE_7087 := C_7075 or C_DV3
                | C_7093 := C_7069 or C_6676
                | C_CSTATE_7096 := C_7069 or C_DV3
                | C_ZV_7099 := C_7066 or C_7078
                | C_CV := C_ZV_7099 or C_7084
                | C__7114 := C_ZV_7099 or C_CWV
                | C_7120 := C_ZV_7099 or C_DV2
                | C_7129 := C_7120 or C_DV3
                | C_ZV_7132 := C_7063 or C_7072
                | C_CV_7138 := C_ZV_7132 or C_7093
                | C_7147 := C_ZV_7132 or C_DV2
                | C__7150 := C_ZV_7132 or C_CWV_6919
                | C_7159 := C_7147 or C_DV3
                | C_ZV_7165 := XZX_7037 or BTI_7043
                | C_7193 := (not C_7057) and C_ZV_6958
                | C_7197 := (not C_7025) and C_6825
                | C_7201 := (not C_7120) and C_DV3
                | C_7205 := (not C_7147) and C_DV3
                | C_7209 := (not C_ZV_7099) and C_DV2
                | C_7213 := (not C_ZV_7132) and C_DV2
                | C_7216 := (not C_7057) and C_UL
                | CSTATE_7227 := left_tt ( CSTATE_804,C_CSTATE_7087 )
                | C_7235 := left_tt ( C_7232,C_ZV_7165 )
                | CSTATE_7246 := left_tt ( CSTATE_1482,C_CSTATE_7096 )
                | C_7252 := C_7069 and CSTATE_7246
                | C_7255 := C_7075 and CSTATE_7227
                | C_DV4 := C_7255 or SETH_6766
                | C_DV4_7264 := C_7252 or SETONOFF_6795
                | C_DV := C_DV4 or C_7129
                | C_CC_7279 := C_DV or C_ZB_6631
                | C_CC_7291 := C_DV4_7264 or C_7159
                | C_7318 := C_7235 and WBI_7031
                | C_7321 := C_7318 or XZX_7037
                | C_7324 := C_7321 or C_6955
                | C_7330 := C_7324 or C_6247
                | C_ZV_7339 := C_7235 or XZX_7037
                | C_7363 := (not C_ZV_7339) and C_ZV_7165
                | C_7366 := (not C_7159) and C_DV4_7264
                | C_7369 := (not C_7129) and C_DV4
                | C_7373 := (not SETONOFF_6795) and C_DV4_7264
                | C_7376 := (not SETH_6766) and C_DV4
                | C_7392 := left_tt ( C_7389,C_ZV_7339 )
                | C_7416 := C_UL and C_7392
                | C_7419 := C_7416 or C__6970
                | C_7428 := C_7392 or C_6930
                | C_7431 := C_7392 or XZX_7037
                | C_7437 := C_7428 or C__6259
                | C_7456 := (not C_7431) and C_ZV_7339
                | C_7460 := (not C_7419) and C_BTI
                | C_7464 := (not C_7392) and C__6970
                | C_7467 := not C_7437
                | C_7471 := (not C_7428) and C__6259
                | C_7478 := (not C_6930) and C_7392
                |)
             |)
            where 
            integer DV, V, CV, DV2, DV3, DV4, XZX_927, XZX_931, XZX_954, XZX_958, AMIN, CV_1459, DV2_1460, DV3_1461, DV4_1462, STNB, CST, NST, CHOUR, V2, ZV_2259;
            boolean DALARM, WDIS, ADIS, SWDIS, SETH, MODONOFF, SETONOFF, CSET, ALCANCEL, DB, DISB, DB_457, CSTATE, ZMODE, MODE, CSET_645, INCREASE, CSTATE_804, CSTATE_906, CSTATE_973, WBI, BTI, XZX_1122, WBI_1142, BTI_1221, XZX_1268, CSET_1322, 
                   INCREASE_1375, SETONOFF_1440, CSTATE_1482, NRINGING, RINGING, CRINGING, STATE24, SETONOFF_1751, WMODONOFF, ZMODE_1812, XZX_2143, XZX_2147, XZX_2153, LR_2216, UR_2224, C_UL, C_6232, C_6244, C_6247, C_, C__6253, C__6256, C__6259, C_6272, 
                   C_6276, CSTATE_6282, MODE_6291, C_6293, C_6296, WBI_6299, BTI_6305, RINGING_6314, C_6316, C_6319, C_6324, C_6327, C_CC, C_CC_6332, C_CC_6337, C_CC_6343, XZX_6352, XZX_6361, XZX_6367, C_6389, C_6392, C_6395, C_6398, C_6401, C_MODONOFF, 
                   C_MODONOFF_6431, C_6434, C_6440, C_6443, C_6446, C_6452, C_6455, C_6458, C_6461, C_6473, C_6476, C_6482, C_CC_6485, C_DV2, C_ZCSET, C_ALCANCEL, C_ZCSET_6509, C_SETONOFF, C_6528, C_6536, C_6540, C_6552, C_6574, C_6578, SETONOFF_6581, 
                   CSET_6587, C_6589, C_6592, MODONOFF_6595, ALCANCEL_6601, C_6611, C_6614, C_6625, C_ZB, C_ZB_6631, C_6634, C_ZB_6637, C_6640, C_CC_6661, C_CSTATE, C_6676, C_DV3, C_CSET, C_6706, C_CC_6709, C_CSTATE_6715, C_6734, C_6738, C_6742, C_6750, 
                   C_6757, CSET_6760, SETH_6766, CSTATE_6771, CSTATE_6777, CSET_6783, XZX_6789, SETONOFF_6795, C_6819, C_6822, C_6825, C_6828, C_6831, C_ZV_6834, C_6837, C_6843, C_6849, C_6852, C_6855, C_ZV_6858, C_6861, C_ZV_6864, C_CWV, C__6870, C_6908, 
                   C_6911, C_CWV_6916, C_CWV_6919, C_6924, C_6930, C_6935, C_6938, C_6943, C_6946, C_6952, C_6955, C_ZV_6958, C_ZV_6964, C_ZV_6967, C__6970, C_BTI, C_6979, C_6982, C_6993, C_6997, C_7004, C_7012, INCREASE_7015, C_7017, C_7020, C_7022, 
                   C_7025, WBI_7031, XZX_7037, BTI_7043, INCREASE_7049, C_7051, C_7054, C_7057, C_7063, C_7066, C_7069, C_7072, C_7075, C_7078, C_7084, C_CSTATE_7087, C_7093, C_CSTATE_7096, C_ZV_7099, C_CV, C__7114, C_7120, C_7129, C_ZV_7132, C_CV_7138, 
                   C_7147, C__7150, C_7159, C_ZV_7165, C_7193, C_7197, C_7201, C_7205, C_7209, C_7213, C_7216, CSTATE_7227, C_7232, C_7235, CSTATE_7246, C_7252, C_7255, C_DV4, C_DV4_7264, C_DV, C_CC_7279, C_CC_7291, C_7318, C_7321, C_7324, C_7330, 
                   C_ZV_7339, C_7363, C_7366, C_7369, C_7373, C_7376, C_7389, C_7392, C_7416, C_7419, C_7428, C_7431, C_7437, C_7456, C_7460, C_7464, C_7467, C_7471, C_7478;
            process ACT_ADIS =
                 ( )
               (| (| ZMODE := MODE$1 init false
                   | MODE := (MODONOFF when C_MODONOFF_6431) default (ZMODE when C_6578)
                   | C_6293 := not MODE
                   |) |)
            %ACT_ADIS%; 
            process ACT_WDIS =
                 ( )
               (| when WDIS ^= MODE_1813
                | (| ZMODE_1812 := MODE_1813$1 init false
                   | MODE_1813 := (WMODONOFF when C_MODONOFF) default (ZMODE_1812 when C_6574)
                   | C_6324 := not MODE_1813
                   |)
                |)
               where 
               boolean MODE_1813;
               end
            %ACT_WDIS%; 
            process ACT_C_UL =
                 ( )
               (| when C_UL ^= V_1846 ^= ZV_1860 ^= LL_2270 ^= UL_2278 ^= C_6265 ^= C_6268 ^= C_6335
                | (| when C_ ^= XZX_2143 ^= XZX_2147
                   | ACT_C_{}
                   |)
                | (| when C_CC ^= XZX_958 ^= C_CC_6337
                   | ACT_C_CC{}
                   |)
                | (| CSTATE := (SETONOFF when C_DV2) cell C_UL init V_0
                   | WBI := (false when C_7022) default (true when C_7197) default (BTI when C_7216)
                   | BTI := WBI$1 init false
                   | V_1846 := (0 when C_CC) default ((ZV_1860+1) when C_6335)
                   | ZV_1860 := V_1846$1 init 19
                   | LL_2270 := RLL()
                   | UL_2278 := RUL()
                   | C_6244 := UL_2278 and LL_2270
                   | C_ := UL_2278 or LL_2270
                   | C_6265 := (not UL_2278) and LL_2270
                   | C_6268 := (not LL_2270) and UL_2278
                   | C_CC := ZV_1860>=19
                   | C_6335 := not (ZV_1860>=19)
                   |)
                |)
               where 
               boolean LL_2270, UL_2278, C_6265, C_6268, C_6335;
               integer V_1846, ZV_1860;
               process ACT_C_ =
                    ( )
                  (| (| XZX_2143 := (false when LL_2270) default (true when C_6268)
                      | XZX_2147 := (false when UL_2278) default (true when C_6265)
                      |) |)
               %ACT_C_%; 
               process ACT_C_CC =
                    ( )
                  (| when C_CC ^= CMIN ^= ZV_1915 ^= CC_2432 ^= C_6346 ^= C__6383
                   | (| when C_CC_6337 ^= CHOUR
                      | ACT_C_CC_6337{}
                      |)
                   | (| ACT_C__6383{} |)
                   | (| XZX_958 := CMIN
                      | CMIN := (0 when C_CC_6337) default ((ZV_1915+1) when C_6346)
                      | ZV_1915 := CMIN$1 init 59
                      | CC_2432 := WCLEARAREA(80 when C_CC,8 when C_CC,16 when C_CC,16 when C_CC)
                      | C_CC_6337 := ZV_1915>=59
                      | C_6346 := not (ZV_1915>=59)
                      | C__6383 := CMIN>=0
                      |)
                   |)
                  where 
                  boolean CC_2432, C_6346, C__6383;
                  integer CMIN, ZV_1915;
                  process ACT_C_CC_6337 =
                       ( )
                     (| when C_CC_6337 ^= ZV_1887 ^= CC ^= C__6378 ^= C_6616 ^= C_6619
                      | (| ACT_C__6378{} |)
                      | (| CHOUR := (0 when C_6616) default ((ZV_1887+1) when C_6619)
                         | ZV_1887 := CHOUR$1 init 23
                         | CC := WCLEARAREA(56 when C_CC_6337,8 when C_CC_6337,16 when C_CC_6337,16 when C_CC_6337)
                         | C__6378 := CHOUR>=0
                         | C_6616 := ZV_1887>=23
                         | C_6619 := not (ZV_1887>=23)
                         |)
                      |)
                     where 
                     boolean CC, C__6378, C_6616, C_6619;
                     integer ZV_1887;
                     process ACT_C__6378 =
                          ( )
                        (| when C__6378 ^= XZX_2354
                         | (| XZX_2354 := CHOUR when C__6378
                            | WPINT2(56,24,XZX_2354)
                            |)
                         |)
                        where 
                        integer XZX_2354;
                        end
                     %ACT_C__6378%; 
                     end
                  %ACT_C_CC_6337%; 
                  process ACT_C__6383 =
                       ( )
                     (| when C__6383 ^= XZX_2433
                      | (| XZX_2433 := CMIN when C__6383
                         | WPINT2(80,24,XZX_2433)
                         |)
                      |)
                     where 
                     integer XZX_2433;
                     end
                  %ACT_C__6383%; 
                  end
               %ACT_C_CC%; 
               end
            %ACT_C_UL%; 
            process ACT_C__6256 =
                 ( )
               (| (| XZX_2153 := (false when C_) default (true when C_6276) |) |)
            %ACT_C__6256%; 
            process ACT_C__6259 =
                 ( )
               (| when C__6259 ^= XZX_2157
                | (| RINGING := CRINGING when C__6259
                   | XZX_2157 := (false when C__6256) default (true when C_6272)
                   | C_6316 := not RINGING
                   | C_6389 := C_6316 and XZX_2157
                   |)
                |)
               where 
               boolean XZX_2157;
               end
            %ACT_C__6259%; 
            process ACT_C_MODONOFF =
                 ( )
               (| (| WMODONOFF := (not ZMODE_1812) when C_MODONOFF |) |)
            %ACT_C_MODONOFF%; 
            process ACT_C_CC_6485 =
                 ( )
               (| when C_CC_6485 ^= ZV_1604 ^= CC_2711 ^= C_6606 ^= C_6609
                | (| ACT_CC_2711{} |)
                | (| NST := (0 when C_6606) default ((ZV_1604+1) when C_6609)
                   | ZV_1604 := NST$1 init 0
                   | CC_2711 := WCLEARAREA(8 when C_CC_6485,8 when C_CC_6485,32,16)
                   | C_6606 := ZV_1604>=2
                   | C_6609 := not (ZV_1604>=2)
                   |)
                |)
               where 
               boolean CC_2711, C_6606, C_6609;
               integer ZV_1604;
               process ACT_CC_2711 =
                    ( )
                  (| when CC_2711 ^= XZX_2712
                   | (| XZX_2712 := NST when CC_2711
                      | WDTAG(8,24,XZX_2712)
                      |)
                   |)
                  where 
                  integer XZX_2712;
                  end
               %ACT_CC_2711%; 
               end
            %ACT_C_CC_6485%; 
            process ACT_C_DV2 =
                 ( )
               (| (| SETONOFF := (false when C_6440) default (MODONOFF when C_6552)
                   | DV2 := CV when C_DV2
                   | DV2_1460 := CV_1459 when C_DV2
                   |) |)
            %ACT_C_DV2%; 
            process ACT_C_ZCSET =
                 ( )
               (| when C_ZCSET ^= ZCSET
                | (| CSET := (SETONOFF when C_DV2) default (ZCSET when C_6540)
                   | ZCSET := CSET$1 init false
                   | C_6589 := not CSET
                   |)
                |)
               where 
               boolean ZCSET;
               end
            %ACT_C_ZCSET%; 
            process ACT_C_ALCANCEL =
                 ( )
               (| (| ALCANCEL := (true when WMODONOFF) default (true when C_6757) default (false when C_6750) |) |)
            %ACT_C_ALCANCEL%; 
            process ACT_C_ZCSET_6509 =
                 ( )
               (| when C_ZCSET_6509 ^= CSET_1752 ^= ZCSET_1753
                | (| CSET_1752 := (SETONOFF_1751 when C_SETONOFF) default (ZCSET_1753 when C_6528)
                   | ZCSET_1753 := CSET_1752$1 init false
                   | C_6611 := not CSET_1752
                   |)
                |)
               where 
               boolean CSET_1752, ZCSET_1753;
               end
            %ACT_C_ZCSET_6509%; 
            process ACT_C_ZB =
                 ( )
               (| when C_ZB ^= ZB_464
                | (| DB_457 := not ZB_464
                   | ZB_464 := DB_457$1 init V0_459
                   |)
                |)
               where 
               boolean ZB_464;
               end
            %ACT_C_ZB%; 
            process ACT_C_ZB_6631 =
                 ( )
               (| when C_ZB_6631 ^= ZB_1775
                | (| STATE24 := not ZB_1775
                   | ZB_1775 := STATE24$1 init V0_1773
                   |)
                |)
               where 
               boolean ZB_1775;
               end
            %ACT_C_ZB_6631%; 
            process ACT_C_ZB_6637 =
                 ( )
               (| when C_ZB_6637 ^= ZB
                | (| DB := not ZB
                   | ZB := DB$1 init V0
                   |)
                |)
               where 
               boolean ZB;
               end
            %ACT_C_ZB_6637%; 
            process ACT_C_CC_6661 =
                 ( )
               (| when C_CC_6661 ^= CB_456 ^= CC_2634 ^= C_6813
                | (| (| WPTAG(56 when C_6813,40,4) |) |)
                | (| DISB := (false when WMODONOFF) default (CB_456 when C_6742)
                   | CB_456 := (DB_457 when C_ZB) cell C_CC_6661 init false
                   | CC_2634 := WCLEARAREA(56 when C_CC_6661,32 when C_CC_6661,24,8)
                   | C_6813 := CC_2634 and DISB
                   |)
                |)
               where 
               boolean CB_456, CC_2634, C_6813;
               end
            %ACT_C_CC_6661%; 
            process ACT_C_CSTATE =
                 ( )
               (| (| CSTATE_973 := (DISB when C_CC_6661) cell C_CSTATE init V_0_966 |) |)
            %ACT_C_CSTATE%; 
            process ACT_C_DV3 =
                 ( )
               (| when C_DV3 ^= ZSETH
                | (| SETH := (true when SETONOFF) default ((not ZSETH) when C_6738)
                   | ZSETH := SETH$1 init true
                   | DV3 := CV when C_DV3
                   | XZX_1268 := not SETH
                   | SETONOFF_1440 := not SETH
                   | DV3_1461 := CV_1459 when C_DV3
                   |)
                |)
               where 
               boolean ZSETH;
               end
            %ACT_C_DV3%; 
            process ACT_C_CSET =
                 ( )
               (| (| CSET_645 := (SETH when C_DV3) cell C_CSET init false
                   | CSET_1322 := (XZX_1268 when C_DV3) cell C_CSET init false
                   |) |)
            %ACT_C_CSET%; 
            process ACT_C_CC_6709 =
                 ( )
               (| when C_CC_6709 ^= CB ^= CC_2673 ^= C_6816
                | (| (| WPTAG(56 when C_6816,56,3) |) |)
                | (| DALARM := (false when ALCANCEL) default (CB when C_6734)
                   | CB := (DB when C_ZB_6637) cell C_CC_6709 init false
                   | CC_2673 := WCLEARAREA(56 when C_CC_6709,48 when C_CC_6709,24,8)
                   | C_6816 := CC_2673 and DALARM
                   |)
                |)
               where 
               boolean CB, CC_2673, C_6816;
               end
            %ACT_C_CC_6709%; 
            process ACT_C_CSTATE_6715 =
                 ( )
               (| (| CSTATE_906 := (DALARM when C_CC_6709) cell C_CSTATE_6715 init V_0_899 |) |)
            %ACT_C_CSTATE_6715%; 
            process ACT_C_ZV_6834 =
                 ( )
               (| when C_ZV_6834 ^= V_1023 ^= ZV_1050
                | (| V_1023 := (0 when C_ZV_6958) default ((ZV_1050+1) when C_7004)
                   | ZV_1050 := V_1023$1 init 0
                   | C_6935 := ZV_1050>=3
                   |)
                |)
               where 
               integer V_1023, ZV_1050;
               end
            %ACT_C_ZV_6834%; 
            process ACT_C_ZV_6858 =
                 ( )
               (| when C_ZV_6858 ^= V_1397 ^= ZV_1426
                | (| V_1397 := (0 when C_ZV_6967) default ((ZV_1426+1) when C_6997)
                   | ZV_1426 := V_1397$1 init 4
                   | C_6943 := ZV_1426>=4
                   |)
                |)
               where 
               integer V_1397, ZV_1426;
               end
            %ACT_C_ZV_6858%; 
            process ACT_C_ZV_6864 =
                 ( )
               (| when C_ZV_6864 ^= V_720 ^= ZV_751
                | (| V_720 := (0 when C_ZV_6964) default ((ZV_751+1) when C_6993)
                   | ZV_751 := V_720$1 init 4
                   | C_6908 := ZV_751>=4
                   |)
                |)
               where 
               integer V_720, ZV_751;
               end
            %ACT_C_ZV_6864%; 
            process ACT_C_CWV =
                 ( )
               (| when C_CWV ^= CAV ^= CWV
                | (| when C_CWV_6916 ^= C_6924
                   | ACT_C_CWV_6916{}
                   |)
                | (| CAV := XZX_927 when C_CWV
                   | CWV := XZX_931 when C_CWV
                   | C_CWV_6916 := CAV=CWV
                   |)
                |)
               where 
               integer CAV, CWV;
               process ACT_C_CWV_6916 =
                    ( )
                  (| when C_CWV_6916 ^= CAV_952 ^= CWV_953
                   | (| CAV_952 := XZX_954 when C_CWV_6916
                      | CWV_953 := XZX_958 when C_CWV_6916
                      | C_6924 := CAV_952=CWV_953
                      |)
                   |)
                  where 
                  integer CAV_952, CWV_953;
                  end
               %ACT_C_CWV_6916%; 
               end
            %ACT_C_CWV%; 
            process ACT_C_ZV_6958 =
                 ( )
               (| when C_ZV_6958 ^= V_1066 ^= ZV_1091
                | (| V_1066 := (0 when C_7057) default ((ZV_1091+1) when C_7193)
                   | ZV_1091 := V_1066$1 init 0
                   | C_7022 := ZV_1091>=0
                   |)
                |)
               where 
               integer V_1066, ZV_1091;
               end
            %ACT_C_ZV_6958%; 
            process ACT_C_ZV_6964 =
                 ( )
               (| when C_ZV_6964 ^= V_697 ^= ZV_705
                | (| V_697 := (0 when C_6861) default ((ZV_705+1) when C_6979)
                   | INCREASE := V_697<16
                   | ZV_705 := V_697$1 init 0
                   | C_7017 := not INCREASE
                   |)
                |)
               where 
               integer V_697, ZV_705;
               end
            %ACT_C_ZV_6964%; 
            process ACT_C_ZV_6967 =
                 ( )
               (| when C_ZV_6967 ^= V_1374 ^= ZV_1382
                | (| V_1374 := (0 when C_6855) default ((ZV_1382+1) when C_6982)
                   | INCREASE_1375 := V_1374<16
                   | ZV_1382 := V_1374$1 init 0
                   | C_7051 := not INCREASE_1375
                   |)
                |)
               where 
               integer V_1374, ZV_1382;
               end
            %ACT_C_ZV_6967%; 
            process ACT_C__6970 =
                 ( )
               (| (| XZX_1122 := (false when RINGING) default (true when C_7012) |) |)
            %ACT_C__6970%; 
            process ACT_C_BTI =
                 ( )
               (| (| WBI_1142 := (false when C_7389) default (XZX_1122 when C_7464) default (BTI_1221 when C_7460)
                   | BTI_1221 := WBI_1142$1 init false
                   |) |)
            %ACT_C_BTI%; 
            process ACT_C_CSTATE_7087 =
                 ( )
               (| (| CSTATE_804 := (SETH when C_DV3) cell C_CSTATE_7087 init V_0_798 |) |)
            %ACT_C_CSTATE_7087%; 
            process ACT_C_CSTATE_7096 =
                 ( )
               (| (| CSTATE_1482 := (SETONOFF_1440 when C_DV3) cell C_CSTATE_7096 init V_0_1476 |) |)
            %ACT_C_CSTATE_7096%; 
            process ACT_C_ZV_7099 =
                 ( )
               (| when C_ZV_7099 ^= ZV ^= C_7221 ^= C_7224
                | (| V := (0 when C_7221) default ((ZV+1) when C_7224)
                   | ZV := V$1 init 0
                   | C_7221 := ZV>=23
                   | C_7224 := not (ZV>=23)
                   |)
                |)
               where 
               boolean C_7221, C_7224;
               integer ZV;
               end
            %ACT_C_ZV_7099%; 
            process ACT_C_ZV_7132 =
                 ( )
               (| when C_ZV_7132 ^= ZV_1300 ^= C_7240 ^= C_7243
                | (| AMIN := (0 when C_7240) default ((ZV_1300+1) when C_7243)
                   | ZV_1300 := AMIN$1 init 0
                   | C_7240 := ZV_1300>=59
                   | C_7243 := not (ZV_1300>=59)
                   |)
                |)
               where 
               boolean C_7240, C_7243;
               integer ZV_1300;
               end
            %ACT_C_ZV_7132%; 
            process ACT_C_ZV_7165 =
                 ( )
               (| when C_ZV_7165 ^= V_1143 ^= ZV_1170
                | (| V_1143 := (0 when C_ZV_7339) default ((ZV_1170+1) when C_7363)
                   | ZV_1170 := V_1143$1 init 0
                   | C_7232 := ZV_1170>=3
                   |)
                |)
               where 
               integer V_1143, ZV_1170;
               end
            %ACT_C_ZV_7165%; 
            process ACT_C_DV4 =
                 ( )
               (| when C_DV4 ^= ACTIF ^= ZACTIF ^= C_7382
                | (| ACTIF := (false when SETH) default ((not ZACTIF) when C_7376)
                   | ZACTIF := ACTIF$1 init false
                   | DV4 := (CV when ACTIF) default ((-2) when C_7382)
                   | C_7382 := not ACTIF
                   |)
                |)
               where 
               boolean ACTIF, ZACTIF, C_7382;
               end
            %ACT_C_DV4%; 
            process ACT_C_DV4_7264 =
                 ( )
               (| when C_DV4_7264 ^= ACTIF_1457 ^= ZACTIF_1458 ^= C_7397
                | (| ACTIF_1457 := (false when SETONOFF_1440) default ((not ZACTIF_1458) when C_7373)
                   | ZACTIF_1458 := ACTIF_1457$1 init false
                   | DV4_1462 := (CV_1459 when ACTIF_1457) default ((-2) when C_7397)
                   | C_7397 := not ACTIF_1457
                   |)
                |)
               where 
               boolean ACTIF_1457, ZACTIF_1458, C_7397;
               end
            %ACT_C_DV4_7264%; 
            process ACT_C_CC_7279 =
                 ( )
               (| when C_CC_7279 ^= DPM ^= DHOUR ^= CV_841 ^= STATE24_842 ^= CC_2491 ^= CC_2540 ^= C_7384 ^= C_7387 ^= C__7402 ^= C_7413
                | (| ACT_C__7402{} |)
                | (| (| WPTAG(40 when C_7413,72,5) |) |)
                | (| DPM := ((CV_841>12) when C_7384) default (false when STATE24_842)
                   | DHOUR := ((CV_841-12) when DPM) default (CV_841 when C_7387)
                   | CV_841 := (DV when C_DV) cell C_CC_7279 init 0
                   | STATE24_842 := (STATE24 when C_ZB_6631) cell C_CC_7279 init false
                   | CC_2491 := WCLEARAREA(40 when C_CC_7279,64 when C_CC_7279,16,8)
                   | CC_2540 := WCLEARAREA(56 when C_CC_7279,64 when C_CC_7279,16 when C_CC_7279,16 when C_CC_7279)
                   | C_7384 := not STATE24_842
                   | C_7387 := not DPM
                   | C__7402 := DHOUR>=0
                   | C_7413 := DPM and CC_2491
                   |)
                |)
               where 
               integer DHOUR, CV_841;
               boolean DPM, STATE24_842, CC_2491, CC_2540, C_7384, C_7387, C__7402, C_7413;
               process ACT_C__7402 =
                    ( )
                  (| when C__7402 ^= XZX_2541
                   | (| XZX_2541 := DHOUR when C__7402
                      | WPINT2(56,80,XZX_2541)
                      |)
                   |)
                  where 
                  integer XZX_2541;
                  end
               %ACT_C__7402%; 
               end
            %ACT_C_CC_7279%; 
            process ACT_C_CC_7291 =
                 ( )
               (| when C_CC_7291 ^= DAMIN ^= CC_2580 ^= C__7407
                | (| ACT_C__7407{} |)
                | (| DAMIN := (AMIN when C_ZV_7132) default (DV2_1460 when C_7213) default (DV3_1461 when C_7205) default (DV4_1462 when C_7366)
                   | CC_2580 := WCLEARAREA(80 when C_CC_7291,64 when C_CC_7291,16 when C_CC_7291,16 when C_CC_7291)
                   | C__7407 := DAMIN>=0
                   |)
                |)
               where 
               boolean CC_2580, C__7407;
               integer DAMIN;
               process ACT_C__7407 =
                    ( )
                  (| when C__7407 ^= XZX_2581
                   | (| XZX_2581 := DAMIN when C__7407
                      | WPINT2(80,80,XZX_2581)
                      |)
                   |)
                  where 
                  integer XZX_2581;
                  end
               %ACT_C__7407%; 
               end
            %ACT_C_CC_7291%; 
            process ACT_C_ZV_7339 =
                 ( )
               (| when C_ZV_7339 ^= V_1185 ^= ZV_1210
                | (| V_1185 := (0 when C_7431) default ((ZV_1210+1) when C_7456)
                   | ZV_1210 := V_1185$1 init 0
                   | C_7389 := ZV_1210>=149
                   |)
                |)
               where 
               integer V_1185, ZV_1210;
               end
            %ACT_C_ZV_7339%; 
            end
         %ACT_C_ZV_6218%; 
         end
      %ACT_C_ZV%; 
      end
   %ACT_Tick%; 
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
%VTALARM_BOOL_TRA%; %(| C_6146 := not C_UP
                      | C_6149 := not C_DOWN
                      | C_6152 := not C_AUTO
                      | C_6160 := not (ZMAX>1)
                      | C_6171 := C_DOWN or C_AUTO
                      | C_6174 := C_6171 or C_UP
                      | C_6186 := AUTOMOD or C_UP
                      | C_6192 := C_VD or C_6183
                      | C_6198 := C_6177 or AUTOMOD
                      | C_6201 := C_6198 or C_UP
                      | C_6216 := (not C_6165) and C_UP
                      | C_6224 := not UR_2224
                      | C_6227 := not LR_2216
                      | C_6235 := not UL_2278
                      | C_6238 := not LL_2270
                      | C_6241 := UR_2224 or LR_2216
                      | C_6262 := C__6259 or C_UL
                      | C_6279 := not C__6259
                      | C_6285 := not CSTATE
                      | C_6288 := not ADIS
                      | C_6302 := not WBI
                      | C_6308 := not BTI
                      | C_6311 := not SWDIS
                      | C_6322 := not WDIS
                      | C_CC_6340 := left_tt ( C_CC_6337,C_CC )
                      | XZX_6349 := left_tt ( XZX_2143,C_ )
                      | C_6355 := not XZX_2143
                      | XZX_6358 := left_tt ( XZX_2147,C_ )
                      | C_6364 := not XZX_2147
                      | C_6370 := not XZX_2153
                      | XZX_6373 := left_tt ( XZX_2157,C__6259 )
                      | C_6376 := not XZX_2157
                      | C_6381 := not (CHOUR>=0)
                      | C_6386 := not (CMIN>=0)
                      | C_6404 := RINGING or C_6389
                      | C_6407 := left_tt ( C_6404,C__6259 )
                      | C_6410 := C_6395 or C_6407
                      | C_6413 := C_6410 or C_6398
                      | C_6416 := C_6413 or C_6401
                      | C_6419 := XZX_6367 or XZX_6373
                      | C_6422 := C_6419 or XZX_6361
                      | C_6425 := C_6422 or XZX_6352
                      | C_6437 := WDIS and C_6398
                      | C_6449 := ADIS and C_6398
                      | C_6464 := C_6449 or C_6458
                      | C_6467 := C_6464 or C_6452
                      | C_6470 := C_6446 or C_6461
                      | C_6479 := C_6440 or C_6476
                      | C_6491 := C_MODONOFF_6431 or C_6467
                      | C_6494 := C_MODONOFF_6431 or C_6476
                      | C_6503 := C_MODONOFF or C_6434
                      | C_6506 := C_MODONOFF or C_6437
                      | C_6515 := C_MODONOFF or C_6455
                      | C_6518 := C_6506 or C_6455
                      | C_6521 := WDIS or C_ZCSET_6509
                      | C_6524 := C_6503 or C_6455
                      | C_6532 := (not C_6473) and C_MODONOFF
                      | C_6544 := (not C_6476) and C_DV2
                      | C_6548 := (not C_MODONOFF) and C_DV2
                      | C_6555 := (not C_6440) and C_6434
                      | C_6559 := (not C_6461) and C_6443
                      | C_6563 := (not C_6482) and C_6446
                      | C_6567 := (not C_6455) and C_6446
                      | C_6571 := (not C_6452) and C_6458
                      | C_6584 := not SETONOFF
                      | C_6598 := not WMODONOFF
                      | C_6604 := not ALCANCEL
                      | C_6622 := not CC_2711
                      | C_6643 := C_ZB_6631 or C_6503
                      | C_6646 := C_ZB_6631 or C_6434
                      | C_6649 := C_ZB_6631 or C_CC_6332
                      | C_6652 := C_6649 or C_MODONOFF
                      | C_6655 := C_6652 or C_6434
                      | C_6658 := C_ZB or C_ZB_6637
                      | C_6667 := C_6658 or C_6634
                      | C_6670 := C_6625 or C_6667
                      | C_6673 := C_6625 or C_6634
                      | C_6682 := C_DV3 or C_6667
                      | C_6685 := C_DV3 or C_6658
                      | C_6691 := C_6673 or SETONOFF_6581
                      | C_6694 := C_6682 or C_6494
                      | C_6697 := C_6682 or C_6479
                      | C_6700 := C_6682 or C_6476
                      | C_6703 := C_6670 or C_DV2
                      | C_6712 := C_CC_6709 or C_CC_6661
                      | C_6718 := C_6712 or C_DV3
                      | C_6721 := C_6712 or C_CC_6485
                      | C_6724 := C_6718 or C_6634
                      | C_6727 := C_6724 or CSTATE_6282
                      | C_6730 := C_6727 or C_6446
                      | C_6746 := (not CSTATE_6282) and C_6634
                      | C_6754 := (not C_6625) and SETONOFF_6581
                      | C_6763 := not CSET_645
                      | C_6768 := not SETH
                      | C_6774 := not CSTATE_906
                      | C_6780 := not CSTATE_973
                      | C_6786 := not CSET_1322
                      | C_6792 := not XZX_1268
                      | C_6798 := not SETONOFF_1440
                      | C_6801 := not CC_2634
                      | C_6804 := not DISB
                      | C_6807 := not CC_2673
                      | C_6810 := not DALARM
                      | C_6840 := C_6822 or SETH_6766
                      | C_6846 := C_6819 or XZX_6789
                      | C_6874 := (not C_6861) and C_ZV_6864
                      | C_6878 := (not C_6837) and C_6861
                      | C_6882 := (not C_6855) and C_ZV_6858
                      | C_6886 := (not C_6843) and C_6855
                      | C_6890 := (not XZX_6789) and C_6819
                      | C_6894 := (not SETH_6766) and C_6822
                      | C_6898 := (not C_6825) and C_ZV_6834
                      | C_6902 := (not C_6819) and C_6828
                      | C_6906 := (not C_6822) and C_6831
                      | C_6914 := not (ZV_751>=4)
                      | C_6922 := not (CAV=CWV)
                      | C_6927 := left_tt ( C_6924,C_CWV_6916 )
                      | C_6933 := not (CAV_952=CWV_953)
                      | C_6941 := not (ZV_1050>=3)
                      | C_6949 := not (ZV_1426>=4)
                      | C_6961 := C_ZV_6958 and WBI_6299
                      | C_6976 := C_BTI or C_CSTATE
                      | C_6986 := (not C_UL) and C__6970
                      | C_6989 := (not C_6825) and C_ZV_6958
                      | C_7000 := (not C_6825) and C_6952
                      | C_7008 := (not C_6938) and C_6825
                      | C_7028 := not (ZV_1091>=0)
                      | C_7034 := not WBI_1142
                      | C_7040 := not XZX_1122
                      | C_7046 := not BTI_1221
                      | C_7060 := C_6955 or C_7025
                      | C_7081 := C_7078 or C_6822
                      | C_7090 := C_7072 or C_6819
                      | C_7102 := C_7066 or C_6831
                      | C_7108 := C_ZV_7099 or C_7075
                      | C_7111 := C_ZV_7099 or C__6870
                      | C_7117 := C_ZV_7099 or C_6861
                      | C_7123 := C_ZV_7099 or C_CC_6343
                      | C_7126 := C_7120 or C_7075
                      | C_7135 := C_7063 or C_6828
                      | C_7141 := C_ZV_7132 or C_7069
                      | C_7144 := C_ZV_7132 or C_6855
                      | C_7153 := C_ZV_7132 or C_CC_6332
                      | C_7156 := C_7147 or C_7069
                      | C_7162 := C_CV_7138 or C_CSET
                      | C_7168 := C_6976 or C_7153
                      | C_7171 := C_7168 or C_7111
                      | C_7174 := C_7171 or C_CSTATE_6715
                      | C_7177 := C_7174 or C_7162
                      | C_7181 := (not XZX_7037) and C_ZV_7165
                      | C_7185 := (not C_7159) and C_7069
                      | C_7189 := (not C_7129) and C_7075
                      | C_7219 := (not C_6825) and C_7025
                      | C_7230 := not CSTATE_804
                      | C_7238 := not (ZV_1170>=3)
                      | C_7249 := not CSTATE_1482
                      | C_7261 := C_DV4 or C_7075
                      | C_7267 := C_DV4_7264 or C_7069
                      | C_7273 := C_DV4 or C_7120
                      | C_7276 := C_7273 or C_7261
                      | C_7282 := C_CC_7279 or C_CV
                      | C_7285 := C_CC_7279 or C_6712
                      | C_7288 := C_7282 or C_CSET
                      | C_7294 := C_DV4_7264 or C_7147
                      | C_7297 := C_DV4_7264 or C_6676
                      | C_7300 := C_7294 or C_7267
                      | C_7303 := C_CC_7291 or C_7285
                      | C_7306 := C_CC_7291 or C_CC_7279
                      | C_7309 := C_CC_7291 or C_6712
                      | C_7312 := C_7306 or C_6721
                      | C_7315 := C_7312 or C_CC_6332
                      | C_7327 := C_7324 or C_7303
                      | C_7333 := C_7327 or C_CC_6332
                      | C_7336 := C_7333 or C_CC_6485
                      | C_7342 := C_ZV_7339 and WBI_7031
                      | C_7345 := C_7177 or C_7288
                      | C_7348 := (not XZX_7037) and C_ZV_7339
                      | C_7352 := (not C_6247) and C_7324
                      | C_7356 := (not C_6955) and C_7321
                      | C_7359 := (not XZX_7037) and C_7318
                      | C_7380 := (not C_7235) and XZX_7037
                      | C_7395 := not (ZV_1210>=149)
                      | C_7400 := not CC_2491
                      | C_7405 := not (DHOUR>=0)
                      | C_7410 := not (DAMIN>=0)
                      | C_7422 := C_7324 or C_7392
                      | C_7425 := C_7321 or C_7392
                      | C_7434 := C_7428 or C_7324
                      | C_7440 := C_7434 or C_CC_6709
                      | C_7443 := C_7440 or C_CC_6661
                      | C_7446 := C_7443 or C_CC_7291
                      | C_7449 := C_7446 or C_CC_7279
                      | C_7452 := C_7449 or C_6446
                      | C_7474 := (not XZX_7037) and C_7392
                      |)***WARNING: unused signals 
%
%
