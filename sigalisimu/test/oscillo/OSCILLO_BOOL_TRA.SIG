process OSCILLO_BOOL_TRA =
     ( ? real YREF;
       ! boolean C_DOWN;
     )
   pragmas 
      Main
      COMMENT " This program receives some"
              " signals Y (-1<Y<+1) that must be displayed"
              "by package of N ( fonction yonly )and one"
              " package ( received in the same time that"
              " the first package of Y ) which is always "
              "displayed ( X-axis, reference"
              " curve,...by YREF ) "
              " - OSCILLO_C.gpk  source with display of the 2 "
              "graphs "
              " -OSCILLO_V.gpk source with( YREF ) and the "
              "segment "
              " representing the outdistance between this"
              " 2 graphs"
              " ( YREF-YONLY )."
              " GRAPH INTERFACE : pacemaker.uil source"
              " MOTIF of the part "
              " pacemaker"
              " oscillo.uil source MOTIF which load the"
              " previous "
              " OSCILLO.PAR files of parameters"
              " N size of the package"
              " v0 initial factor of deceleration ( 1 the "
              "fatest )"
              " WIDTH screen widthin pixels"
              " HEIGHT screen height, the negatives numbers"
              " are displayed"
              " in the inferior part"
              " RYREF.dat reference curve"
      C_CODE " &o1 = yonly() "
      COMMENT "  yonly() is an extern program made by "
              " Quighua ZHANG (IRISA) in old C."
              " The program tries to aproximate the "
              " reference graph ( YREF). "
              " We use wavelets because the traditional "
              " aproximation  ( polynomial function )"
              " makes oscilations when it is a high power"
              " polynomial. "
              " Then   Y =  f(X) ~ SOM(i) [ w(i) Phi( a(i) * X "
              "  + b(i) ) ],"
              " with the function Phi = d(Gaussian function)"
              " After we use an optimisation metod to find "
              " the best parameters ( w(i), a(i), b(i) ) to "
              " reproduce as well the reference graph. "
              " At each iteration the graph are redisplayed. "
      C_CODE " &o1 = RUP() "
      C_CODE " &o1 = &n() "
      C_CODE " &o1 = &n() "
      DefinedClockHierarchy
   end pragmas
   (| (| Tick := true
       | ACT_Tick{}
       |) |)
   where 
   constant integer N = 200;
   constant integer V0 = 10;
   constant integer WIDTH = 601;
   constant integer HEIGHT = 401;
   constant integer X_DELTA = 3;
   constant integer Y_DELTA = 2;
   boolean Tick;
   process ACT_Tick =
        ( )
      (| when Tick ^= ZMAX ^= MAX ^= V_448 ^= ZV_449 ^= C ^= C_661 ^= C_CIN ^= C_669 ^= C_697 ^= C_VU ^= C_712 ^= C_VD_721 ^= C_730 ^= C_745 ^= C_749 ^= C_753
       | (| when C_CIN ^= C_DOWN
          | ACT_C_CIN{}
          |)
       | (| when C_VU ^= VU
          | (| VU := (ZMAX/2) when C_VU |)
          |)
       | (| ZMAX := MAX$1 init 10
          | MAX := (1 when C_661) default (VU when C_753) default (VD when C_749) default (ZMAX when C_745)
          | V_448 := (1 when C_CIN) default ((ZV_449+1) when C_669)
          | ZV_449 := V_448$1 init 10
          | C := ZMAX>1
          | C_661 := ZMAX<=0
          | C_CIN := ZV_449>=ZMAX
          | C_669 := not (ZV_449>=ZMAX)
          | C_697 := left_tt ( C_691,C_CIN )
          | C_VU := C and C_697
          | C_712 := C_VU or C_661
          | C_VD_721 := left_tt ( C_VD,C_CIN )
          | C_730 := C_712 or C_VD_721
          | C_745 := not C_730
          | C_749 := (not C_712) and C_VD_721
          | C_753 := (not C_661) and C_VU
          |)
       |)
      where 
      boolean C, C_661, C_CIN, C_669, C_691, C_697, C_VU, C_712, C_VD, C_VD_721, C_730, C_745, C_749, C_753;
      integer ZMAX, VU, VD, MAX, V_448, ZV_449;
      process ACT_C_CIN =
           ( )
         (| when C_CIN ^= V ^= ZV ^= CIN ^= C_677 ^= C_ZCOMPT_706 ^= C_CCI ^= ZCCI_759 ^= C_
          | (| when CIN ^= LY
             | ACT_CIN{}
             |)
          | (| when C_DOWN ^= XZX_463 ^= C_691 ^= C_ZCOMPT ^= C_VD
             | ACT_C_DOWN{}
             |)
          | (| when C_CCI ^= XZX_106 ^= ZCCI
             | ACT_C_CCI{}
             |)
          | (| when C_ ^= XZX_138
             | (| XZX_138 := (LY_125 when ZCCI) cell C_ init [[0]:0] |)
             |)
          | (| V := (1 when C_DOWN) default ((ZV+1) when C_677)
             | ZV := V$1 init 200
             | CIN := (XZX_463 when C_DOWN) cell C_CIN init false
             | C_DOWN := ZV>=200
             | C_677 := not (ZV>=200)
             | C_ZCOMPT_706 := left_tt ( C_ZCOMPT,C_DOWN )
             | C_CCI := CIN or C_ZCOMPT_706
             | ZCCI_759 := left_tt ( ZCCI,C_CCI )
             | C_ := ZCCI_759 or C_ZCOMPT_706
             |)
          |)
         where 
         integer V, ZV;
         boolean ZCI, ZCCI, CIN, XZX_463, C_677, C_ZCOMPT, C_ZCOMPT_706, C_CCI, ZCCI_759, C_;
         [200]integer LY, XZX_106, LY_125, XZX_138;
         process ACT_CIN =
              ( )
            (| when CIN ^= Y ^= IY ^= XZX
             | (| Y := yonly()
                | LY := (IY$1) window 200 init [{_I_85 in 0 to 199 step 1}:0]
                | IY := (401-integer(XZX)) when CIN
                | XZX := (Y+1.0)*real(200)
                |)
             |)
            where 
            integer IY;
            real Y, XZX;
            end
         %ACT_CIN%; 
         process ACT_C_DOWN =
              ( )
            (| when C_DOWN ^= DOWN ^= AUTOMOD ^= UP ^= AUTO ^= C_679 ^= C_700 ^= C_724
             | (| when AUTO ^= CAUTO
                | ACT_AUTO{}
                |)
             | (| when C_ZCOMPT ^= ZCI
                | ACT_C_ZCOMPT{}
                |)
             | (| when C_VD ^= VD
                | (| VD := (ZMAX+ZMAX) when C_VD |)
                |)
             | (| (| WSTOP(true when C_724) |) |)
             | (| AUTOMOD := (CAUTO when AUTO) cell C_DOWN init false
                | UP := RUP()
                | DOWN := RDOWN()
                | AUTO := RAUTO()
                | XZX_463 := C_ZCOMPT
                | C_679 := not AUTOMOD
                | C_691 := AUTOMOD and UP
                | C_700 := C_679 and UP
                | C_ZCOMPT := C_700 or AUTOMOD
                | C_VD := AUTOMOD and DOWN
                | C_724 := C_679 and DOWN
                |)
             |)
            where 
            boolean DOWN, AUTOMOD, UP, AUTO, CAUTO, C_679, C_700, C_724;
            process ACT_AUTO =
                 ( )
               (| when AUTO ^= ZAUTO
                | (| ZAUTO := CAUTO$1 init false
                   | CAUTO := not ZAUTO
                   |)
                |)
               where 
               boolean ZAUTO;
               end
            %ACT_AUTO%; 
            process ACT_C_ZCOMPT =
                 ( )
               (| when C_ZCOMPT ^= VY ^= VRY ^= DO ^= COMPT ^= XZX_184 ^= XZX_188 ^= ZCOMPT
                | (| ACT_DO{} |)
                | (| VY := XZX_106 when C_ZCOMPT
                   | VRY := XZX_138 when C_ZCOMPT
                   | ZCI := (false when C_ZCOMPT)$1 init true
                   | COMPT := ZCOMPT+1
                   | DO := EFFACEVECT()
                   | XZX_184 := VY
                   | XZX_188 := VRY
                   | ZCOMPT := COMPT$1 init 0
                   | AFFICHER_COMPT(COMPT)
                   |)
                |)
               where 
               integer COMPT, ZCOMPT;
               boolean DO;
               [200]integer VY, VRY, XZX_184, XZX_188;
               process ACT_DO =
                    ( )
                  (| when DO ^= SVY ^= SVRY ^= XSCREEN ^= XZX_212 ^= XZX_242
                   | (| SVY := XZX_184 when DO
                      | SVRY := XZX_188 when DO
                      | array I to 199
                        of (| XSCREEN[I] := I*3
                            | XZX_212 := XSCREEN[I]-3
                            | WVLINE(XZX_212,SVY[I],SVRY[I])
                            | XZX_242 := XSCREEN[I]-3
                            | WLINE(XZX_242,SVRY[I],XSCREEN[I],SVRY[I+1])
                            |)
                        end 
                      |)
                   |)
                  where 
                  integer XZX_212% value = [-3,594]
                         %, XZX_242% value = [-3,594]
                         %;
                  [200]integer SVY, SVRY, XSCREEN;
                  end
               %ACT_DO%; 
               end
            %ACT_C_ZCOMPT%; 
            end
         %ACT_C_DOWN%; 
         process ACT_C_CCI =
              ( )
            (| when C_CCI ^= CCI
             | (| when ZCCI ^= YREF ^= LY_125
                | ACT_ZCCI{}
                |)
             | (| XZX_106 := (LY when CIN) cell C_CCI init [[0]:0]
                | ZCCI := CCI$1 init false
                | CCI := (ZCI when C_ZCOMPT) cell C_CCI init true
                |)
             |)
            where 
            boolean CCI;
            process ACT_ZCCI =
                 ( )
               (| when ZCCI ^= IY_126 ^= XZX_127
                | (| LY_125 := IY_126 window 200 init [{_I_120 in 0 to 199 step 1}:0]
                   | IY_126 := (401-integer(XZX_127)) when ZCCI
                   | XZX_127 := (YREF+1.0)*real(200)
                   |)
                |)
               where 
               real XZX_127;
               integer IY_126;
               end
            %ACT_ZCCI%; 
            end
         %ACT_C_CCI%; 
         end
      %ACT_C_CIN%; 
      end
   %ACT_Tick%; 
   process WVLINE =
        ( ? integer X;
            integer Y1, Y2;
        )
        spec (| X ^= Y1 ^= Y2 |)
   
   %WVLINE%; 
   process WLINE =
        ( ? integer X1, Y1, X2, Y2;
        )
        spec (| X1 ^= Y1 ^= X2 ^= Y2 |)
   
   %WLINE%; 
   process EFFACEVECT =
        ( ! boolean DONE;
        )
   
   %EFFACEVECT%; 
   process AFFICHER_COMPT =
        ( ? integer COMPT_AFF;
        )
   
   %AFFICHER_COMPT%; 
   process WSTOP =
        ( ? event DOWN;
        )
   
   %WSTOP%; 
   process RUP =
        ( ! boolean UP;
        )
      pragmas 
         C_CODE " &o1 = RUP() "
      end pragmas
   
   %RUP%; 
   process RDOWN =
        ( ! boolean DOWN;
        )
      pragmas 
         C_CODE " &o1 = &n() "
      end pragmas
   
   %RDOWN%; 
   process RAUTO =
        ( ! boolean AUTO;
        )
      pragmas 
         C_CODE " &o1 = &n() "
      end pragmas
   
   %RAUTO%; 
   function yonly =
        ( ! real Y;
        )
      pragmas 
         C_CODE " &o1 = yonly() "
         COMMENT "  yonly() is an extern program made by "
                 " Quighua ZHANG (IRISA) in old C."
                 " The program tries to aproximate the "
                 " reference graph ( YREF). "
                 " We use wavelets because the traditional "
                 " aproximation  ( polynomial function )"
                 " makes oscilations when it is a high power"
                 " polynomial. "
                 " Then   Y =  f(X) ~ SOM(i) [ w(i) Phi( a(i) * X "
                 "  + b(i) ) ],"
                 " with the function Phi = d(Gaussian function)"
                 " After we use an optimisation metod to find "
                 " the best parameters ( w(i), a(i), b(i) ) to "
                 " reproduce as well the reference graph. "
                 " At each iteration the graph are redisplayed. "
      end pragmas
      external
   %yonly%; 
   end
%OSCILLO_BOOL_TRA%; %(| C_659 := not (ZMAX>1)
                      | C_664 := not (ZMAX<=0)
                      | C_672 := not CIN
                      | C_682 := not UP
                      | C_685 := not DOWN
                      | C_688 := not AUTO
                      | C_694 := left_tt ( C_691,C_DOWN )
                      | C_VD_718 := left_tt ( C_VD,C_DOWN )
                      | C_727 := C_VD or C_691
                      | C_733 := C_ZCOMPT or C_724
                      | C_736 := DOWN or AUTO
                      | C_739 := C_736 or UP
                      | C_756 := not C_ZCOMPT
                      | C_762 := not ZCCI
                      | C_765 := not DO
                      |)***WARNING: unused signals 
%
%
