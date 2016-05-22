process VTCHRONOMETER_SEQ_TRA =
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
   boolean Tick;
   process ACT_Tick =
        ( )
      (| when Tick ^= AUTOMOD ^= C_UP ^= C_DOWN ^= C_AUTO ^= C ^= C_3619 ^= C_3627 ^= C_3639 ^= C_VD ^= C_3645 ^= C_VU ^= C_3657 ^= C_ZV ^= C_3670 ^= C_3674
       | (| when AUTOMOD ^= ZMAX ^= C_3616 ^= C_3624
          | ACT_AUTOMOD{}
          |)
       | (| when C_AUTO ^= CAUTO
          | ACT_C_AUTO{}
          |)
       | (| (| WSTOP(true when C_3639) |) |)
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
          | C_3619 := left_tt ( C_3616,AUTOMOD )
          | C_3627 := left_tt ( C_3624,AUTOMOD )
          | C_3639 := C and C_DOWN
          | C_VD := AUTOMOD and C_DOWN
          | C_3645 := AUTOMOD and C_UP
          | C_VU := C_3645 and C_3619
          | C_3657 := C_VD or C_VU
          | C_ZV := C_UP or C_3627
          | C_3670 := (not C_VU) and C_VD
          | C_3674 := (not C_3657) and AUTOMOD
          |)
       |)
      where 
      integer VU, VD, ZMAX;
      boolean AUTOMOD, CAUTO, C_UP, C_DOWN, C_AUTO, C, C_3616, C_3619, C_3624, C_3627, C_3639, C_VD, C_3645, C_VU, C_3657, C_ZV, C_3670, C_3674;
      process ACT_AUTOMOD =
           ( )
         (| when AUTOMOD ^= MAX ^= V_1138 ^= ZV_1150 ^= C_3630
          | (| MAX := (VU when C_VU) default (VD when C_3670) default (ZMAX when C_3674)
             | ZMAX := MAX$1 init 20
             | V_1138 := (0 when C_3624) default ((ZV_1150+1) when C_3630)
             | ZV_1150 := V_1138$1 init 1
             | C_3616 := ZMAX>1
             | C_3624 := ZV_1150>=(MAX-1)
             | C_3630 := not (ZV_1150>=(MAX-1))
             |)
          |)
         where 
         boolean C_3630;
         integer MAX, V_1138, ZV_1150;
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
         (| when C_ZV ^= V1 ^= ZV_1253 ^= C_ZV_3680 ^= C_3683
          | (| ACT_C_ZV_3680{} |)
          | (| V1 := (0 when C_ZV_3680) default ((ZV_1253+1) when C_3683)
             | ZV_1253 := V1$1 init 4
             | C_ZV_3680 := ZV_1253>=4
             | C_3683 := not (ZV_1253>=4)
             |)
          |)
         where 
         boolean C_ZV_3680, C_3683;
         integer V1, ZV_1253;
         process ACT_C_ZV_3680 =
              ( )
            (| when C_ZV_3680 ^= STNB ^= ST ^= ST_137 ^= SWST ^= VISIBLE ^= STOPPE ^= Z_VISIBLE ^= Z_ACTIF ^= ACTIF ^= SHOW ^= XZX_560 ^= CST ^= LR_1264 ^= UR_1272 ^= V2 ^= ZV_1306 ^= C_UL ^= C_3694 ^= C_3709 ^= C__3715 ^= C__3718 ^= C__3721 ^= C_3734 ^= 
               C_3738 ^= C_3749 ^= DISPLAY_3761 ^= XZX_3779 ^= XZX_3785 ^= XZX_3791 ^= C_CC ^= C_3809 ^= C_3812 ^= C_3815 ^= C_3818 ^= C_DSET ^= C_CC_3827 ^= C_3830 ^= C_CC_3833 ^= C_ZV_3836 ^= C_BTI ^= C_3868 ^= C_3879 ^= C_3882 ^= C_3887 ^= DLAP_3893 ^= 
               C_3898 ^= DRUN_3901 ^= WBI_3907 ^= BTI_3913 ^= C_3942 ^= C_3945 ^= C_REDISPLAY ^= C_ZV_3963 ^= C_ZV_3966 ^= C_C_UNIT ^= C_3972 ^= C_3975 ^= C_L_UNIT ^= C_3981 ^= C_3988 ^= C_3992 ^= C_3995 ^= C_4002 ^= C_4007 ^= REDISPLAY_4013 ^= C_4018 ^= 
               C_4023 ^= C_4029 ^= C_4032 ^= C_4035 ^= C_CC_4038 ^= C_4050 ^= C_4053 ^= C_ZV_4056 ^= C_ZV_4059 ^= C_C_UNIT_4062 ^= C_4065 ^= C_4068 ^= C_L_UNIT_4071 ^= C_4074 ^= C_4077 ^= C_4080 ^= C_4083 ^= C_CC_4086 ^= C_4111 ^= C_4118 ^= C_4122 ^= 
               C_4126 ^= C_4141 ^= C_4149 ^= C_4165 ^= C_4168 ^= C__4174 ^= C_C_UNIT_4177 ^= C_4180 ^= C_4183 ^= C_L_UNIT_4186 ^= C_4189 ^= C_4192 ^= C_4195 ^= C_4198 ^= C_CC_4201 ^= C_4214 ^= C_4218 ^= C_4222 ^= C_4225 ^= C_4229 ^= C_4235 ^= C_4240 ^= 
               XZX_4246 ^= C_4257 ^= C_BTI_4260 ^= C_4264 ^= WBI_4273 ^= BTI_4279 ^= C_ZV_4285 ^= C_4294 ^= C_4300 ^= C_4303 ^= C_4306 ^= C_4315 ^= C_ZV_4324 ^= C_4345 ^= C_4357 ^= C_4363 ^= C_4366 ^= C_4373 ^= C_4376 ^= C_4383
             | (| when SHOW ^= DISPLAY
                | ACT_SHOW{}
                |)
             | (| when C_UL ^= C_3706 ^= C_
                | ACT_C_UL{}
                |)
             | (| when C__3718 ^= XZX_1201
                | ACT_C__3718{}
                |)
             | (| when C__3721 ^= XZX_1205
                | ACT_C__3721{}
                |)
             | (| when C_CC ^= DRUN
                | ACT_C_CC{}
                |)
             | (| when C_DSET ^= DSET
                | (| DSET := (false when C_3818) default (true when C_3868) |)
                |)
             | (| when C_CC_3827 ^= NST
                | ACT_C_CC_3827{}
                |)
             | (| when C_CC_3833 ^= DLAP ^= C_3895
                | ACT_C_CC_3833{}
                |)
             | (| when C_ZV_3836 ^= C_3884
                | ACT_C_ZV_3836{}
                |)
             | (| when C_BTI ^= WBI ^= BTI
                | ACT_C_BTI{}
                |)
             | (| when C_REDISPLAY ^= REDISPLAY ^= C_4015
                | ACT_C_REDISPLAY{}
                |)
             | (| when C_ZV_3963 ^= C_4020
                | ACT_C_ZV_3963{}
                |)
             | (| when C_ZV_3966 ^= B ^= C_4004
                | ACT_C_ZV_3966{}
                |)
             | (| when C_C_UNIT ^= C_UNIT_637
                | (| C_UNIT_637 := (B when C_ZV_3966) cell C_C_UNIT init 0 |)
                |)
             | (| when C_L_UNIT ^= L_UNIT_638
                | (| L_UNIT_638 := (C_UNIT_637 when C_3981) cell C_L_UNIT init 0 |)
                |)
             | (| ACT_C_CC_4038{} |)
             | (| when C_ZV_4056 ^= C_4146
                | ACT_C_ZV_4056{}
                |)
             | (| when C_ZV_4059 ^= S ^= C_4138
                | ACT_C_ZV_4059{}
                |)
             | (| when C_C_UNIT_4062 ^= C_UNIT_612
                | (| C_UNIT_612 := (S when C_ZV_4059) cell C_C_UNIT_4062 init 0 |)
                |)
             | (| when C_L_UNIT_4071 ^= L_UNIT_613
                | (| L_UNIT_613 := (C_UNIT_612 when C_4080) cell C_L_UNIT_4071 init 0 |)
                |)
             | (| ACT_C_CC_4086{} |)
             | (| when C__4174 ^= V ^= XZX_796 ^= C_4237
                | ACT_C__4174{}
                |)
             | (| when C_C_UNIT_4177 ^= C_UNIT
                | (| C_UNIT := (V when C__4174) cell C_C_UNIT_4177 init 0 |)
                |)
             | (| when C_L_UNIT_4186 ^= L_UNIT
                | (| L_UNIT := (C_UNIT when C_4195) cell C_L_UNIT_4186 init 0 |)
                |)
             | (| ACT_C_CC_4201{} |)
             | (| when C_BTI_4260 ^= WBI_816 ^= BTI_895
                | ACT_C_BTI_4260{}
                |)
             | (| when C_ZV_4285 ^= C_4291
                | ACT_C_ZV_4285{}
                |)
             | (| (| SIGBELL(30 when C_4315) |) |)
             | (| when C_ZV_4324 ^= C_4354
                | ACT_C_ZV_4324{}
                |)
             | (| STNB := CST$1 init 0
                | ST := STNB=0
                | ST_137 := STNB=2
                | SWST := STNB=1
                | VISIBLE := ((not DLAP) when C_CC_3833) default (Z_VISIBLE when C_3879)
                | STOPPE := Z_VISIBLE and (not Z_ACTIF)
                | Z_VISIBLE := VISIBLE$1 init true
                | Z_ACTIF := ACTIF$1 init false
                | ACTIF := (DRUN when C_CC) default (Z_ACTIF when C_3882)
                | SHOW := (DSET when C_DSET) cell C_ZV_3680 init false
                | XZX_560 := (true when DLAP) default (VISIBLE when C_3995)
                | CST := (NST when C_CC_3827) cell C_ZV_3680 init 0
                | LR_1264 := RLR()
                | UR_1272 := RUR()
                | V2 := (0 when C_UL) default ((ZV_1306+1) when C_3694)
                | ZV_1306 := V2$1 init 1
                | C_UL := ZV_1306>=1
                | C_3694 := not (ZV_1306>=1)
                | C_3709 := left_tt ( C_3706,C_UL )
                | C__3715 := left_tt ( C_,C_UL )
                | C__3718 := UR_1272 or C__3715
                | C__3721 := C__3718 or LR_1264
                | C_3734 := (not C__3718) and LR_1264
                | C_3738 := (not C__3715) and UR_1272
                | C_3749 := not STOPPE
                | DISPLAY_3761 := left_tt ( DISPLAY,SHOW )
                | XZX_3779 := left_tt ( XZX_1195,C_UL )
                | XZX_3785 := left_tt ( XZX_1201,C__3718 )
                | XZX_3791 := left_tt ( XZX_1205,C__3721 )
                | C_CC := SWST and XZX_3791
                | C_3809 := SWST and XZX_3785
                | C_3812 := ST and XZX_3779
                | C_3815 := ST_137 and XZX_3779
                | C_3818 := SWST and XZX_3779
                | C_DSET := C_3812 or C_3818
                | C_CC_3827 := C_DSET or C_3815
                | C_3830 := C_3809 and STOPPE
                | C_CC_3833 := C_3809 and C_3749
                | C_ZV_3836 := C_3830 or ACTIF
                | C_BTI := C_CC or C_UL
                | C_3868 := (not C_3818) and C_3812
                | C_3879 := not C_CC_3833
                | C_3882 := not C_CC
                | C_3887 := left_tt ( C_3884,C_ZV_3836 )
                | DLAP_3893 := left_tt ( DLAP,C_CC_3833 )
                | C_3898 := left_tt ( C_3895,C_CC_3833 )
                | DRUN_3901 := left_tt ( DRUN,C_CC )
                | WBI_3907 := left_tt ( WBI,C_BTI )
                | BTI_3913 := left_tt ( BTI,C_BTI )
                | C_3942 := VISIBLE and DRUN_3901
                | C_3945 := C_3942 or C_3898
                | C_REDISPLAY := C_3945 or C_3812
                | C_ZV_3963 := C_CC or BTI_3913
                | C_ZV_3966 := C_3830 or C_3887
                | C_C_UNIT := C_ZV_3966 or SHOW
                | C_3972 := C_ZV_3966 and DLAP_3893
                | C_3975 := C_ZV_3966 and DISPLAY_3761
                | C_L_UNIT := C_3972 or SHOW
                | C_3981 := C_C_UNIT and DLAP_3893
                | C_3988 := (not C_ZV_3966) and C_ZV_3836
                | C_3992 := (not C_3945) and C_3812
                | C_3995 := not DLAP_3893
                | C_4002 := (not C_3942) and C_3898
                | C_4007 := left_tt ( C_4004,C_ZV_3966 )
                | REDISPLAY_4013 := left_tt ( REDISPLAY,C_REDISPLAY )
                | C_4018 := left_tt ( C_4015,C_REDISPLAY )
                | C_4023 := left_tt ( C_4020,C_ZV_3963 )
                | C_4029 := C_L_UNIT and C_4018
                | C_4032 := C_C_UNIT and REDISPLAY_4013
                | C_4035 := C_4032 or C_4029
                | C_CC_4038 := C_4035 or C_3975
                | C_4050 := C_4023 and WBI_3907
                | C_4053 := C_4050 or C_CC
                | C_ZV_4056 := C_CC or C_4023
                | C_ZV_4059 := C_3830 or C_4007
                | C_C_UNIT_4062 := C_ZV_4059 or SHOW
                | C_4065 := C_ZV_4059 and DLAP_3893
                | C_4068 := C_ZV_4059 and DISPLAY_3761
                | C_L_UNIT_4071 := C_4065 or SHOW
                | C_4074 := C_L_UNIT_4071 and C_4018
                | C_4077 := C_C_UNIT_4062 and REDISPLAY_4013
                | C_4080 := C_C_UNIT_4062 and DLAP_3893
                | C_4083 := C_4077 or C_4074
                | C_CC_4086 := C_4083 or C_4068
                | C_4111 := (not C_4083) and C_4068
                | C_4118 := (not C_ZV_4056) and C_ZV_3963
                | C_4122 := (not C_4035) and C_3975
                | C_4126 := (not C_ZV_4059) and C_ZV_3966
                | C_4141 := left_tt ( C_4138,C_ZV_4059 )
                | C_4149 := left_tt ( C_4146,C_ZV_4056 )
                | C_4165 := C_UL and C_4149
                | C_4168 := C_4165 or C_CC
                | C__4174 := C_3830 or C_4141
                | C_C_UNIT_4177 := C__4174 or SHOW
                | C_4180 := C__4174 and DLAP_3893
                | C_4183 := C__4174 and DISPLAY_3761
                | C_L_UNIT_4186 := C_4180 or SHOW
                | C_4189 := C_L_UNIT_4186 and C_4018
                | C_4192 := C_C_UNIT_4177 and REDISPLAY_4013
                | C_4195 := C_C_UNIT_4177 and DLAP_3893
                | C_4198 := C_4192 or C_4189
                | C_CC_4201 := C_4198 or C_4183
                | C_4214 := (not C_4168) and C_ZV_4056
                | C_4218 := (not C_4198) and C_4183
                | C_4222 := (not C__4174) and C_ZV_4059
                | C_4225 := (not C_4168) and C_BTI
                | C_4229 := (not C_4149) and C_CC
                | C_4235 := (not C_3830) and C_4141
                | C_4240 := left_tt ( C_4237,C__4174 )
                | XZX_4246 := left_tt ( XZX_796,C__4174 )
                | C_4257 := C_3830 or C_4240
                | C_BTI_4260 := C_UL or XZX_4246
                | C_4264 := (not C_4257) and C__4174
                | WBI_4273 := left_tt ( WBI_816,C_BTI_4260 )
                | BTI_4279 := left_tt ( BTI_895,C_BTI_4260 )
                | C_ZV_4285 := XZX_4246 or BTI_4279
                | C_4294 := left_tt ( C_4291,C_ZV_4285 )
                | C_4300 := C_4294 and WBI_4273
                | C_4303 := C_4300 or XZX_4246
                | C_4306 := C_4303 or C_4053
                | C_4315 := C_4306 or C_3709
                | C_ZV_4324 := XZX_4246 or C_4294
                | C_4345 := (not C_ZV_4324) and C_ZV_4285
                | C_4357 := left_tt ( C_4354,C_ZV_4324 )
                | C_4363 := C_UL and C_4357
                | C_4366 := C_4363 or XZX_4246
                | C_4373 := (not C_4366) and C_ZV_4324
                | C_4376 := (not C_4366) and C_BTI_4260
                | C_4383 := (not C_4357) and XZX_4246
                |)
             |)
            where 
            integer STNB, V, S, B, C_UNIT, L_UNIT, C_UNIT_612, L_UNIT_613, C_UNIT_637, L_UNIT_638, CST, NST, V2, ZV_1306;
            boolean DRUN, DLAP, ST, ST_137, SWST, VISIBLE, STOPPE, Z_VISIBLE, Z_ACTIF, ACTIF, DISPLAY, REDISPLAY, SHOW, XZX_560, DSET, WBI, BTI, XZX_796, WBI_816, BTI_895, XZX_1195, XZX_1201, XZX_1205, LR_1264, UR_1272, C_UL, C_3694, C_3706, C_3709, C_, 
                   C__3715, C__3718, C__3721, C_3734, C_3738, C_3749, DISPLAY_3761, XZX_3779, XZX_3785, XZX_3791, C_CC, C_3809, C_3812, C_3815, C_3818, C_DSET, C_CC_3827, C_3830, C_CC_3833, C_ZV_3836, C_BTI, C_3868, C_3879, C_3882, C_3884, C_3887, 
                   DLAP_3893, C_3895, C_3898, DRUN_3901, WBI_3907, BTI_3913, C_3942, C_3945, C_REDISPLAY, C_ZV_3963, C_ZV_3966, C_C_UNIT, C_3972, C_3975, C_L_UNIT, C_3981, C_3988, C_3992, C_3995, C_4002, C_4004, C_4007, REDISPLAY_4013, C_4015, C_4018, 
                   C_4020, C_4023, C_4029, C_4032, C_4035, C_CC_4038, C_4050, C_4053, C_ZV_4056, C_ZV_4059, C_C_UNIT_4062, C_4065, C_4068, C_L_UNIT_4071, C_4074, C_4077, C_4080, C_4083, C_CC_4086, C_4111, C_4118, C_4122, C_4126, C_4138, C_4141, C_4146, 
                   C_4149, C_4165, C_4168, C__4174, C_C_UNIT_4177, C_4180, C_4183, C_L_UNIT_4186, C_4189, C_4192, C_4195, C_4198, C_CC_4201, C_4214, C_4218, C_4222, C_4225, C_4229, C_4235, C_4237, C_4240, XZX_4246, C_4257, C_BTI_4260, C_4264, WBI_4273, 
                   BTI_4279, C_ZV_4285, C_4291, C_4294, C_4300, C_4303, C_4306, C_4315, C_ZV_4324, C_4345, C_4354, C_4357, C_4363, C_4366, C_4373, C_4376, C_4383;
            process ACT_SHOW =
                 ( )
               (| (| DISPLAY := XZX_560 when SHOW |) |)
            %ACT_SHOW%; 
            process ACT_C_UL =
                 ( )
               (| when C_UL ^= LL_1317 ^= UL_1325 ^= C_3727
                | (| when C_ ^= XZX_1195
                   | ACT_C_{}
                   |)
                | (| LL_1317 := RLL()
                   | UL_1325 := RUL()
                   | C_3706 := UL_1325 and LL_1317
                   | C_ := UL_1325 or LL_1317
                   | C_3727 := (not UL_1325) and LL_1317
                   |)
                |)
               where 
               boolean LL_1317, UL_1325, C_3727;
               process ACT_C_ =
                    ( )
                  (| (| XZX_1195 := (false when UL_1325) default (true when C_3727) |) |)
               %ACT_C_%; 
               end
            %ACT_C_UL%; 
            process ACT_C__3718 =
                 ( )
               (| (| XZX_1201 := (false when C_) default (true when C_3738) |) |)
            %ACT_C__3718%; 
            process ACT_C__3721 =
                 ( )
               (| (| XZX_1205 := (false when C__3718) default (true when C_3734) |) |)
            %ACT_C__3721%; 
            process ACT_C_CC =
                 ( )
               (| when C_CC ^= CC_1625 ^= C_3936
                | (| (| WPTAG(80 when C_3936,56,3) |) |)
                | (| DRUN := (not Z_ACTIF) when C_CC
                   | CC_1625 := WCLEARAREA(80 when C_CC,48 when C_CC,24,8)
                   | C_3936 := DRUN and CC_1625
                   |)
                |)
               where 
               boolean CC_1625, C_3936;
               end
            %ACT_C_CC%; 
            process ACT_C_CC_3827 =
                 ( )
               (| when C_CC_3827 ^= ZV_960 ^= CC_1663 ^= C_3918 ^= C_3921
                | (| ACT_CC_1663{} |)
                | (| NST := (0 when C_3918) default ((ZV_960+1) when C_3921)
                   | ZV_960 := NST$1 init 0
                   | CC_1663 := WCLEARAREA(8 when C_CC_3827,8 when C_CC_3827,32,16)
                   | C_3918 := ZV_960>=2
                   | C_3921 := not (ZV_960>=2)
                   |)
                |)
               where 
               boolean CC_1663, C_3918, C_3921;
               integer ZV_960;
               process ACT_CC_1663 =
                    ( )
                  (| when CC_1663 ^= XZX_1664
                   | (| XZX_1664 := NST when CC_1663
                      | WDTAG(8,24,XZX_1664)
                      |)
                   |)
                  where 
                  integer XZX_1664;
                  end
               %ACT_CC_1663%; 
               end
            %ACT_C_CC_3827%; 
            process ACT_C_CC_3833 =
                 ( )
               (| when C_CC_3833 ^= CC_1571 ^= C_3933
                | (| (| WPTAG(80 when C_3933,40,4) |) |)
                | (| DLAP := Z_VISIBLE when C_CC_3833
                   | CC_1571 := WCLEARAREA(80 when C_CC_3833,32 when C_CC_3833,24,8)
                   | C_3895 := not DLAP
                   | C_3933 := DLAP and CC_1571
                   |)
                |)
               where 
               boolean CC_1571, C_3933;
               end
            %ACT_C_CC_3833%; 
            process ACT_C_ZV_3836 =
                 ( )
               (| when C_ZV_3836 ^= V_472 ^= ZV_495
                | (| V_472 := (0 when C_ZV_3966) default ((ZV_495+1) when C_3988)
                   | ZV_495 := V_472$1 init 0
                   | C_3884 := ZV_495>=1
                   |)
                |)
               where 
               integer V_472, ZV_495;
               end
            %ACT_C_ZV_3836%; 
            process ACT_C_BTI =
                 ( )
               (| (| WBI := (false when C_4146) default (true when C_4229) default (BTI when C_4225)
                   | BTI := WBI$1 init false
                   |) |)
            %ACT_C_BTI%; 
            process ACT_C_REDISPLAY =
                 ( )
               (| (| REDISPLAY := (true when C_3942) default (true when C_4002) default (VISIBLE when C_3992)
                   | C_4015 := not REDISPLAY
                   |) |)
            %ACT_C_REDISPLAY%; 
            process ACT_C_ZV_3963 =
                 ( )
               (| when C_ZV_3963 ^= V_694 ^= ZV_721
                | (| V_694 := (0 when C_ZV_4056) default ((ZV_721+1) when C_4118)
                   | ZV_721 := V_694$1 init 0
                   | C_4020 := ZV_721>=3
                   |)
                |)
               where 
               integer V_694, ZV_721;
               end
            %ACT_C_ZV_3963%; 
            process ACT_C_ZV_3966 =
                 ( )
               (| when C_ZV_3966 ^= ZV_458
                | (| B := (0 when C_ZV_4059) default ((ZV_458+1) when C_4126)
                   | ZV_458 := B$1 init 0
                   | C_4004 := ZV_458>=19
                   |)
                |)
               where 
               integer ZV_458;
               end
            %ACT_C_ZV_3966%; 
            process ACT_C_CC_4038 =
                 ( )
               (| when C_CC_4038 ^= DB ^= CC_1515 ^= C__4159
                | (| ACT_C__4159{} |)
                | (| DB := (C_UNIT_637 when C_4032) default (L_UNIT_638 when C_4029) default (B when C_4122)
                   | CC_1515 := WCLEARAREA(104 when C_CC_4038,64 when C_CC_4038,16 when C_CC_4038,16 when C_CC_4038)
                   | C__4159 := DB>=0
                   |)
                |)
               where 
               boolean CC_1515, C__4159;
               integer DB;
               process ACT_C__4159 =
                    ( )
                  (| when C__4159 ^= XZX_1516
                   | (| XZX_1516 := DB when C__4159
                      | WPINT2(104,80,XZX_1516)
                      |)
                   |)
                  where 
                  integer XZX_1516;
                  end
               %ACT_C__4159%; 
               end
            %ACT_C_CC_4038%; 
            process ACT_C_ZV_4056 =
                 ( )
               (| when C_ZV_4056 ^= V_737 ^= ZV_762
                | (| V_737 := (0 when C_4168) default ((ZV_762+1) when C_4214)
                   | ZV_762 := V_737$1 init 0
                   | C_4146 := ZV_762>=0
                   |)
                |)
               where 
               integer V_737, ZV_762;
               end
            %ACT_C_ZV_4056%; 
            process ACT_C_ZV_4059 =
                 ( )
               (| when C_ZV_4059 ^= ZV_417
                | (| S := (0 when C__4174) default ((ZV_417+1) when C_4222)
                   | ZV_417 := S$1 init 0
                   | C_4138 := ZV_417>=59
                   |)
                |)
               where 
               integer ZV_417;
               end
            %ACT_C_ZV_4059%; 
            process ACT_C_CC_4086 =
                 ( )
               (| when C_CC_4086 ^= DS ^= CC_1472 ^= C__4154
                | (| ACT_C__4154{} |)
                | (| DS := (C_UNIT_612 when C_4077) default (L_UNIT_613 when C_4074) default (S when C_4111)
                   | CC_1472 := WCLEARAREA(80 when C_CC_4086,64 when C_CC_4086,16 when C_CC_4086,16 when C_CC_4086)
                   | C__4154 := DS>=0
                   |)
                |)
               where 
               boolean CC_1472, C__4154;
               integer DS;
               process ACT_C__4154 =
                    ( )
                  (| when C__4154 ^= XZX_1473
                   | (| XZX_1473 := DS when C__4154
                      | WPINT2(80,80,XZX_1473)
                      |)
                   |)
                  where 
                  integer XZX_1473;
                  end
               %ACT_C__4154%; 
               end
            %ACT_C_CC_4086%; 
            process ACT_C__4174 =
                 ( )
               (| when C__4174 ^= ZV
                | (| V := (0 when C_4257) default ((ZV+1) when C_4264)
                   | ZV := V$1 init 0
                   | XZX_796 := (false when C_3830) default (true when C_4235)
                   | C_4237 := ZV>=59
                   |)
                |)
               where 
               integer ZV;
               end
            %ACT_C__4174%; 
            process ACT_C_CC_4201 =
                 ( )
               (| when C_CC_4201 ^= DUNIT ^= CC ^= C__4251
                | (| ACT_C__4251{} |)
                | (| DUNIT := (C_UNIT when C_4192) default (L_UNIT when C_4189) default (V when C_4218)
                   | CC := WCLEARAREA(56 when C_CC_4201,64 when C_CC_4201,16 when C_CC_4201,16 when C_CC_4201)
                   | C__4251 := DUNIT>=0
                   |)
                |)
               where 
               boolean CC, C__4251;
               integer DUNIT;
               process ACT_C__4251 =
                    ( )
                  (| when C__4251 ^= XZX_1392
                   | (| XZX_1392 := DUNIT when C__4251
                      | WPINT2(56,80,XZX_1392)
                      |)
                   |)
                  where 
                  integer XZX_1392;
                  end
               %ACT_C__4251%; 
               end
            %ACT_C_CC_4201%; 
            process ACT_C_BTI_4260 =
                 ( )
               (| (| WBI_816 := (false when C_4354) default (true when C_4383) default (BTI_895 when C_4376)
                   | BTI_895 := WBI_816$1 init false
                   |) |)
            %ACT_C_BTI_4260%; 
            process ACT_C_ZV_4285 =
                 ( )
               (| when C_ZV_4285 ^= V_817 ^= ZV_844
                | (| V_817 := (0 when C_ZV_4324) default ((ZV_844+1) when C_4345)
                   | ZV_844 := V_817$1 init 0
                   | C_4291 := ZV_844>=3
                   |)
                |)
               where 
               integer V_817, ZV_844;
               end
            %ACT_C_ZV_4285%; 
            process ACT_C_ZV_4324 =
                 ( )
               (| when C_ZV_4324 ^= V_859 ^= ZV_884
                | (| V_859 := (0 when C_4366) default ((ZV_884+1) when C_4373)
                   | ZV_884 := V_859$1 init 0
                   | C_4354 := ZV_884>=1
                   |)
                |)
               where 
               integer V_859, ZV_884;
               end
            %ACT_C_ZV_4324%; 
            end
         %ACT_C_ZV_3680%; 
         end
      %ACT_C_ZV%; 
      end
   %ACT_Tick%; 
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
%VTCHRONOMETER_SEQ_TRA%; %(| Tick := true when Tick
                           | C_3608 := not C_UP
                           | C_3611 := not C_DOWN
                           | C_3614 := not C_AUTO
                           | C_3622 := not (ZMAX>1)
                           | C_3633 := C_DOWN or C_AUTO
                           | C_3636 := C_3633 or C_UP
                           | C_3648 := AUTOMOD or C_UP
                           | C_3654 := C_VD or C_3645
                           | C_3660 := C_3639 or AUTOMOD
                           | C_3663 := C_3660 or C_UP
                           | C_3678 := (not C_3627) and C_UP
                           | C_3686 := not UR_1272
                           | C_3689 := not LR_1264
                           | C_3697 := not UL_1325
                           | C_3700 := not LL_1317
                           | C_3703 := UR_1272 or LR_1264
                           | C_3724 := C__3721 or C_UL
                           | C_3730 := (not LL_1317) and UL_1325
                           | C_3741 := not ST
                           | C_3744 := not ST_137
                           | C_3747 := not SWST
                           | C_3752 := not ACTIF
                           | C_3755 := not VISIBLE
                           | C_3758 := not SHOW
                           | C_3764 := not DISPLAY
                           | XZX_3767 := left_tt ( XZX_1191,C_ )
                           | XZX_3770 := left_tt ( XZX_1191,C_UL )
                           | C_3773 := not XZX_1191
                           | XZX_3776 := left_tt ( XZX_1195,C_ )
                           | C_3782 := not XZX_1195
                           | C_3788 := not XZX_1201
                           | C_3794 := not XZX_1205
                           | C_3797 := XZX_3785 or XZX_3791
                           | C_3800 := C_3797 or XZX_3779
                           | C_3803 := C_3800 or XZX_3770
                           | C_3821 := C_3812 or C_3815
                           | C_3839 := C_CC or C_3809
                           | C_3842 := C_CC or C_CC_3833
                           | C_3845 := C_CC or ACTIF
                           | C_3851 := C_3845 or C_3830
                           | C_3854 := C_3851 or C_CC_3833
                           | C_3857 := C_3842 or C_CC_3827
                           | C_3860 := C_3839 or C_3818
                           | C_3864 := (not C_UL) and C_CC
                           | C_3872 := (not C_DSET) and C_3815
                           | C_3876 := (not C_3830) and ACTIF
                           | C_3890 := not (ZV_495>=1)
                           | C_3904 := not DRUN
                           | C_3910 := not WBI
                           | C_3916 := not BTI
                           | C_3924 := not CC_1571
                           | C_3927 := not CC_1625
                           | C_3930 := not CC_1663
                           | C_3939 := SHOW and DLAP_3893
                           | C_3951 := C_REDISPLAY or DLAP_3893
                           | C_3954 := C_REDISPLAY or SHOW
                           | C_3957 := C_REDISPLAY and VISIBLE
                           | C_3960 := C_3954 or DLAP_3893
                           | C_3984 := (not C_CC) and C_ZV_3963
                           | C_3998 := (not C_3830) and C_3887
                           | C_4010 := not (ZV_458>=19)
                           | C_4026 := not (ZV_721>=3)
                           | C_4041 := C_4035 or C_ZV_3966
                           | C_4044 := C_4041 and DISPLAY_3761
                           | C_4047 := C_CC_4038 or C_L_UNIT
                           | C_4089 := C_4083 or C_ZV_4059
                           | C_4092 := C_4089 and DISPLAY_3761
                           | C_4095 := C_CC_4086 or C_L_UNIT_4071
                           | C_4098 := C_CC_4038 or C_3857
                           | C_4101 := C_ZV_4056 and WBI_3907
                           | C_4104 := C_CC_4038 or C_CC_3833
                           | C_4107 := C_4104 or C_CC
                           | C_4114 := (not C_CC) and C_4050
                           | C_4130 := (not C_4023) and C_CC
                           | C_4133 := (not C_CC) and C_4023
                           | C_4136 := (not C_3830) and C_4007
                           | C_4144 := not (ZV_417>=59)
                           | C_4152 := not (ZV_762>=0)
                           | C_4157 := not (DS>=0)
                           | C_4162 := not (DB>=0)
                           | C_4171 := C_4053 or C_4149
                           | C_4204 := C_4198 or C__4174
                           | C_4207 := C_4204 and DISPLAY_3761
                           | C_4210 := C_CC_4201 or C_L_UNIT_4186
                           | C_4232 := (not C_CC) and C_4149
                           | C_4243 := not (ZV>=59)
                           | C_4249 := not XZX_796
                           | C_4254 := not (DUNIT>=0)
                           | C_4267 := (not C_3830) and C_4240
                           | C_4270 := (not C_UL) and XZX_4246
                           | C_4276 := not WBI_816
                           | C_4282 := not BTI_895
                           | C_4289 := (not XZX_4246) and BTI_4279
                           | C_4297 := not (ZV_844>=3)
                           | C_4309 := C_4306 or C_4107
                           | C_4312 := C_4306 or C_CC_4038
                           | C_4318 := C_4309 or C_CC_3827
                           | C_4321 := C_4309 or C_3818
                           | C_4327 := C_ZV_4324 and WBI_4273
                           | C_4330 := C_BTI_4260 or C_4306
                           | C_4334 := (not C_3709) and C_4306
                           | C_4338 := (not C_4053) and C_4303
                           | C_4341 := (not XZX_4246) and C_4300
                           | C_4348 := (not XZX_4246) and C_4294
                           | C_4352 := (not C_4294) and XZX_4246
                           | C_4360 := not (ZV_884>=1)
                           | C_4369 := C_4303 or C_4357
                           | C_4379 := (not XZX_4246) and C_4357
                           |)***WARNING: unused signals 
%
%
