process OSCILLO =
     { integer N, V0, WIDTH, HEIGHT; }
     ( ? event H;
         real YREF;
     )
   pragmas 
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
   end pragmas
   (| (| yonly{}
       | (| H := HIN
          | HSUB := HES
          | PACK{N,HEIGHT}
          |) where event HSUB, H; end
       | SCREEN{N,WIDTH/(N-1),HEIGHT/(N-1)}
       | (| HE := H
          | S_PACE_MAKER{N,V0}
          |) where event HE; end
       |)/ HIN, HES, VRY, VY, Y |)
   where 
   integer CPT init 0;
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
   
   ; 
   process PACK =
        { integer N, Y_0; }
        ( ? real Y;
            event H;
            event HSUB;
            real YREF;
          ! [N]integer VY;
            [N]integer VRY;
        )
      (| (| VY := VECTOR{N,Y_0}(HSUB,H,Y)
          | (| RY := YREF
             | VRY := IVECTOR{N,Y_0}(HSUB,HRY,RY)
             |) where real RY; end
          | (| CI := (not HSUB) and ZCI
             | ZCI := CI$1
             | CCI := ZCI cell H
             | ZCCI := CCI$1
             | HRY := when ZCCI
             |)/ CCI, CI, ZCCI, ZCI
          |)/ HRY |)
      where 
      [N]integer LY init [{ to (N-1)}:0];
      integer IY;
      integer ZNB init 0;
      event AFF, HRY;
      integer NB;
      process VECTOR =
           { integer N, Y_0; }
           ( ? event HSLOW;
               event H;
               real Y;
             ! [N]integer AFFY;
           )
         (| IY := Y_0-integer((Y+1.0)*real(N))
          | LY := (IY$1) window N
          | AFFY := (LY cell HSLOW) when HSLOW
          | H ^= Y
          |)
         where 
         [N]integer LY init [{ to (N-1)}:0];
         integer IY;
         end
      ; 
      process IVECTOR =
           { integer N, Y_0; }
           ( ? event HSLOW;
               event H;
               real Y;
             ! [N]integer AFFY;
           )
         (| IY := Y_0-integer((Y+1.0)*real(N))
          | LY := IY window N
          | AFFY := (LY cell HSLOW) when HSLOW
          | H ^= Y
          |)
         where 
         [N]integer LY init [{ to (N-1)}:0];
         integer IY;
         end
      ; 
      boolean ZCI init true, ZCCI init false, CI, CCI init true;
      end
   ; 
   process SCREEN =
        { integer N, X_DELTA, Y_DELTA; }
        ( ? [N]integer VY;
            [N]integer VRY;
        )
      (| (| (| DO ^= VY
             | DO := EFFACEVECT{}()
             |)
          | (| DONE := DO
             | (| SVY := (VY cell DONE) when DONE
                | SVRY := (VRY cell DONE) when DONE
                | DISPLAY{N,X_DELTA,Y_DELTA}(SVY,SVRY)
                |)
             |) where boolean DONE; end/ SVRY
                                       / SVY
          | (| COMPT := ZCOMPT+(1 when (^VY))
             | ZCOMPT := COMPT$1
             |)/ ZCOMPT
          | (| COMPT_AFF := COMPT
             | AFFICHER_COMPT{}
             |) where integer COMPT_AFF; end
          |)/ COMPT, DO |)
      where 
      use DISPLAY; 
      process EFFACEVECT =
           ( ! boolean DONE;
           )
      
      ; 
      process AFFICHER_COMPT =
           ( ? integer COMPT_AFF;
           )
      
      ; 
      boolean DO;
      [N]integer SVRY, SVY;
      integer COMPT, ZCOMPT init 0;
      end
   ; 
   process S_PACE_MAKER =
        { integer N, V0; }
        ( ? event HE;
          ! event HIN;
            event HES;
        )
      (| (| WSTOP(HSTOP)
          | SCAN{}
          | SPEED_UP{N,V0}
          |)/ HSTOP, UPS, DOWNS |)
      where 
      process WSTOP =
           ( ? event DOWN;
           )
      
      ; 
      process SCAN =
           ( ? event HE;
             ! event HSTOP;
               event HES;
               event UPS;
               event DOWNS;
           )
         (| (| (| HSTOP := DOWNO when (not AUTOMOD)
                | HES := (HE when AUTOMOD) default (UPO when (not AUTOMOD))
                | UPS := UPO when AUTOMOD
                | DOWNS := DOWNO when AUTOMOD
                |)
             | (| UP ^= DOWN ^= AUTO ^= HE
                | UPO := when UP
                | DOWNO := when DOWN
                | COMMUT := when AUTO
                |)
             | (| CAUTO ^= COMMUT
                | CAUTO := not ZAUTO
                | ZAUTO := CAUTO$1
                | AUTOMOD := CAUTO cell HE
                |)/ CAUTO, ZAUTO
             | INPUT{}
             |)/ AUTO, DOWN, UP, AUTOMOD, COMMUT, DOWNO, UPO |)
         where 
         process INPUT =
              ( ! boolean UP;
                  boolean DOWN;
                  boolean AUTO;
              )
            (| RUP{}
             | RDOWN{}
             | RAUTO{}
             |)
            where 
            process RUP =
                 ( ! boolean UP;
                 )
               pragmas 
                  C_CODE " &o1 = RUP() "
               end pragmas
            
            ; 
            process RDOWN =
                 ( ! boolean DOWN;
                 )
               pragmas 
                  C_CODE " &o1 = &n() "
               end pragmas
            
            ; 
            process RAUTO =
                 ( ! boolean AUTO;
                 )
               pragmas 
                  C_CODE " &o1 = &n() "
               end pragmas
            
            ; 
            end
         ; 
         event UPO, DOWNO, COMMUT;
         boolean ZAUTO init false, CAUTO init false, AUTOMOD init false, UP, DOWN, AUTO;
         end
      ; 
      process SPEED_UP =
           { integer N, V0; }
           ( ? event HES;
               event HE;
               event UPS;
               event DOWNS;
             ! event HIN;
           )
         (| (| STAT_SPEED_UP{N}
             | (| DYN_SPEED_UP{V0} |)/ HFAST
             | (| CIN := (HES default (not HE)) cell HSIG
                | HIN := when CIN
                |)/ CIN
             |)/ HSIG |)
         where 
         process STAT_SPEED_UP =
              { integer N; }
              ( ? event HE;
                ! event HSIG;
              )
            (| HE ^= when (ZV>=N)
             | ZV := V$1
             | V := (1 when HE) default (ZV+1)
             | HSIG := ^V
             |)
            where 
            integer V, ZV init N;
            end
         ; 
         process DYN_SPEED_UP =
              { integer V0; }
              ( ? event HSIG;
                  event UPS;
                  event DOWNS;
                ! event HFAST;
              )
            (| (| (| ZMAX := MAX$1
                   | VD := (ZMAX+ZMAX) when DOWNS
                   | VU := (ZMAX/2) when UPS when (ZMAX>1)
                   | MAX := (1 when (ZMAX<=0)) default VU default VD default ZMAX
                   |)/ MAX, VD, VU
                | (| HE := HSIG
                   | (| when (ZV>=ZMAX) ^= HE
                      | ZV := V$1
                      | V := (1 when HE) default (ZV+1)
                      | HES := ^V
                      |)
                   | HFAST := HES
                   |) where event HE, HES; end/ V
                                             / ZV
                |)/ ZMAX |)
            where 
            integer ZMAX init V0, VU, VD, MAX, V, ZV init V0;
            end
         ; 
         event HSIG, HFAST;
         boolean CIN init false;
         end
      ; 
      event DOWNS, UPS, HSTOP;
      end
   ; 
   real Y;
   [N]integer VY, VRY;
   event HES, HIN;
   end
; 
