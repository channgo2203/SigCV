process OSCILLO_TRA =
     ( ? event H;
         real YREF;
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
   end pragmas
   (| (| CLK_ZMAX := ^CLK_ZMAX
       | ACT_CLK_ZMAX{}
       |) |)
   where 
   constant integer N = 200;
   constant integer V0 = 10;
   constant integer WIDTH = 601;
   constant integer HEIGHT = 401;
   constant integer X_DELTA = 3;
   constant integer Y_DELTA = 2;
   event CLK_ZMAX;
   process ACT_CLK_ZMAX =
        ( )
      (| CLK_ZMAX ^= ZMAX ^= MAX ^= V_448 ^= ZV_449
       | (| CLK_165 := when (ZMAX>1) |)
       | (| CLK_171 := when (ZMAX<=0) |)
       | (| CLK_V := when (ZV_449>=ZMAX)
          | ACT_CLK_V{}
          | CLK_190 := when (not (ZV_449>=ZMAX))
          |)
       | (| CLK_VU := CLK_165 ^* UPS_303
          | CLK_VU ^= VU
          | (| VU := (ZMAX/2) when CLK_VU |)
          |)
       | (| CLK_225 := CLK_VU ^+ CLK_171 |)
       | (| CLK_233 := CLK_225 ^+ CLK_VD |)
       | (| CLK_248 := CLK_ZMAX ^- CLK_233 |)
       | (| CLK_251 := CLK_VD ^- CLK_225 |)
       | (| CLK_253 := CLK_VU ^- CLK_171 |)
       | (| ZMAX := MAX$1 init 10
          | MAX := (1 when CLK_171) default (VU when CLK_253) default (VD when CLK_251) default (ZMAX when CLK_248)
          | V_448 := (1 when CLK_V) default ((ZV_449+1) when CLK_190)
          | ZV_449 := V_448$1 init 10
          |)
       |)
      where 
      event CLK_253, CLK_251, CLK_248, CLK_233, CLK_VD, CLK_225, CLK_VU, UPS_303, CLK_190, CLK_V, CLK_171, CLK_165;
      integer ZMAX, VU, VD, MAX, V_448, ZV_449;
      process ACT_CLK_V =
           ( )
         (| CLK_V ^= V ^= ZV ^= CIN
          | (| when (ZV>=200) ^= H
             | H ^= H ^= XZX_463
             | ACT_H{}
             | CLK_152 := when (not (ZV>=200))
             |)
          | (| CLK_Y := when CIN
             | CLK_Y ^= LY
             | ACT_CLK_Y{}
             |)
          | (| CLK_XZX_106 := CLK_Y ^+ CLK_VY
             | CLK_XZX_106 ^= XZX_106
             | ACT_CLK_XZX_106{}
             |)
          | (| CLK_XZX_138 := CLK_YREF ^+ CLK_VY
             | CLK_XZX_138 ^= XZX_138
             | (| XZX_138 := (LY_125 when CLK_YREF) cell CLK_XZX_138 init [[0]:0] |)
             |)
          | (| V := (1 when H) default ((ZV+1) when CLK_152)
             | ZV := V$1 init 200
             | CIN := (XZX_463 when H) cell CLK_V init false
             |)
          |)
         where 
         event CLK_XZX_138, CLK_XZX_106, CLK_VY, CLK_Y, CLK_152, CLK_YREF;
         integer V, ZV;
         boolean ZCI, CIN, XZX_463;
         [200]integer LY, XZX_106, LY_125, XZX_138;
         process ACT_H =
              ( )
            (| H ^= DOWN ^= AUTOMOD ^= UP ^= AUTO
             | (| CLK_101 := when AUTOMOD
                | CLK_102 := when (not AUTOMOD)
                |)
             | (| UPO_333 := when UP |)
             | (| DOWNO_334 := when DOWN |)
             | (| CLK_ZAUTO := when AUTO
                | CLK_ZAUTO ^= CAUTO
                | ACT_CLK_ZAUTO{}
                |)
             | (| UPS_303 := CLK_101 ^* UPO_333 |)
             | (| CLK_217 := CLK_102 ^* UPO_333 |)
             | (| CLK_VY := CLK_217 ^+ CLK_101
                | CLK_VY ^= ZCI
                | ACT_CLK_VY{}
                |)
             | (| CLK_VD := CLK_101 ^* DOWNO_334
                | CLK_VD ^= VD
                | (| VD := (ZMAX+ZMAX) when CLK_VD |)
                |)
             | (| HSTOP_304 := CLK_102 ^* DOWNO_334
                | (| WSTOP(HSTOP_304) |)
                |)
             | (| CLK_256 := H ^- CLK_VY |)
             | (| AUTOMOD := (CAUTO when CLK_ZAUTO) cell H init false
                | UP := RUP()
                | DOWN := RDOWN()
                | AUTO := RAUTO()
                | XZX_463 := CLK_VY default (not CLK_256)
                |)
             |)
            where 
            event CLK_256, HSTOP_304, CLK_217, CLK_ZAUTO, DOWNO_334, UPO_333, CLK_102, CLK_101;
            boolean DOWN, AUTOMOD, UP, AUTO, CAUTO;
            process ACT_CLK_ZAUTO =
                 ( )
               (| CLK_ZAUTO ^= ZAUTO
                | (| ZAUTO := CAUTO$1 init false
                   | CAUTO := not ZAUTO
                   |)
                |)
               where 
               boolean ZAUTO;
               end
            %ACT_CLK_ZAUTO%; 
            process ACT_CLK_VY =
                 ( )
               (| CLK_VY ^= VY ^= VRY ^= DO ^= COMPT ^= XZX_184 ^= XZX_188 ^= ZCOMPT
                | (| CLK_SVY := when DO
                   | ACT_CLK_SVY{}
                   |)
                | (| VY := XZX_106 when CLK_VY
                   | VRY := XZX_138 when CLK_VY
                   | ZCI := (false when CLK_VY)$1 init true
                   | COMPT := ZCOMPT+1
                   | DO := EFFACEVECT()
                   | XZX_184 := VY
                   | XZX_188 := VRY
                   | ZCOMPT := COMPT$1 init 0
                   | AFFICHER_COMPT(COMPT)
                   |)
                |)
               where 
               event CLK_SVY;
               integer COMPT, ZCOMPT;
               boolean DO;
               [200]integer VY, VRY, XZX_184, XZX_188;
               process ACT_CLK_SVY =
                    ( )
                  (| CLK_SVY ^= SVY ^= SVRY ^= XSCREEN ^= XZX_212 ^= XZX_242
                   | (| SVY := XZX_184 when CLK_SVY
                      | SVRY := XZX_188 when CLK_SVY
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
               %ACT_CLK_SVY%; 
               end
            %ACT_CLK_VY%; 
            end
         %ACT_H%; 
         process ACT_CLK_Y =
              ( )
            (| CLK_Y ^= Y ^= IY ^= XZX
             | (| Y := yonly()
                | LY := (IY$1) window 200 init [{_I_85 in 0 to 199 step 1}:0]
                | IY := (401-integer(XZX)) when CLK_Y
                | XZX := (Y+1.0)*real(200)
                |)
             |)
            where 
            integer IY;
            real Y, XZX;
            end
         %ACT_CLK_Y%; 
         process ACT_CLK_XZX_106 =
              ( )
            (| CLK_XZX_106 ^= ZCCI ^= CCI
             | (| CLK_YREF := when ZCCI
                | CLK_YREF ^= YREF ^= LY_125
                | ACT_CLK_YREF{}
                |)
             | (| XZX_106 := (LY when CLK_Y) cell CLK_XZX_106 init [[0]:0]
                | ZCCI := CCI$1 init false
                | CCI := (ZCI when CLK_VY) cell CLK_XZX_106 init true
                |)
             |)
            where 
            boolean ZCCI, CCI;
            process ACT_CLK_YREF =
                 ( )
               (| CLK_YREF ^= IY_126 ^= XZX_127
                | (| LY_125 := IY_126 window 200 init [{_I_120 in 0 to 199 step 1}:0]
                   | IY_126 := (401-integer(XZX_127)) when CLK_YREF
                   | XZX_127 := (YREF+1.0)*real(200)
                   |)
                |)
               where 
               real XZX_127;
               integer IY_126;
               end
            %ACT_CLK_YREF%; 
            end
         %ACT_CLK_XZX_106%; 
         end
      %ACT_CLK_V%; 
      end
   %ACT_CLK_ZMAX%; 
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
%OSCILLO_TRA%; 
