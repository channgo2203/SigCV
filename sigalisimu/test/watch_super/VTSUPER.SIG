process VTSUPER =
     { integer M1, M2, PI, NAL, PERCENT, TICK_NUMBER, FRONT_NUMBER, TICK_HEIGHT, INTER_TICK, BOOL_HEIGHT, DELTA, BOOL_WIDTH; }
     ( ? event HE;
     )
   (| (| (| HF := HCHRONO
          | LR := SLR
          | UR := SUR
          | LL := SLL
          | UL := SUL
          | WACHAL{PI,NAL}
          |) where event UL, LL, UR, LR, HF; end
       | CONTEXT{M1,M2}
       | SIGBELL(PERCENT when (TBEEP default BEEP))
       | (| H := HCHRONO
          | SCREEN{TICK_NUMBER,FRONT_NUMBER,TICK_HEIGHT,TICK_HEIGHT+INTER_TICK,BOOL_HEIGHT,DELTA,BOOL_WIDTH}
          |) where event H; end
       |)/ HSLOW, HCHRONO, ULLULR, SLR, SUR, SLL, SUL, RINGUP, TBEEP, AMODE, ALR, AUR, ALL, AON, WMODE, WLR, BUR, WLL, WON, SWLR, SWUR, SWON, BEEP |)
   where 
   process SWITCH =
        { boolean V0; }
        ( ? event COMMUT;
          ! boolean DB;
        )
      (| COMMUT ^= DB
       | ZB := DB$1
       | DB := not ZB
       |)
      where 
      boolean ZB init V0;
      end
   ; 
   process EVERY =
        { integer V_MODULO, V_0; }
        ( ? event H;
          ! event HS;
            integer V;
        )
      (| ZV := V$1
       | V := (0 when HS) default (ZV+1)
       | V ^= H
       | HS := when (ZV>=(V_MODULO-1))
       |)
      where 
      integer ZV init V_0;
      end
   ; 
   process CONTEXT =
        { integer M1, M2; }
        ( ? event HE;
          ! event RINGUP;
            event HCHRONO;
            event HSLOW;
            event SUL;
            event SLL;
            event SUR;
            event SLR;
            event ULLULR;
            event TBEEP;
        )
      (| (| S_PACE_MAKER{}
          | SC_SELECT{}
          | (| H := HS
             | SCAN{M1,M2}
             |) where event H; end
          | (| H := HCHRONO
             | (| H ^= CRINGUP
                | RINGUP := when CRINGUP
                | CRINGUP := RRINGUP()
                |)
             |) where event H; end/ CRINGUP
          |)/ LL, UL, LR, UR, HS |)
      where 
      process SCAN =
           { integer PI0, PI1; }
           ( ? event H;
             ! event UR;
               event LR;
               event HCHRONO;
               event UL;
               event LL;
               event HSLOW;
           )
         (| FSCAN{PI0}
          | SSCAN{PI1}
          |)
         where 
         process GETSIG =
              ( ? event H;
                  boolean US;
                  boolean LS;
                ! event SUS;
                  event SLS;
              )
            (| H ^= US ^= LS
             | SUS := when US
             | SLS := when LS
             |)
         ; 
         process FSCAN =
              { integer PI0; }
              ( ? event H;
                ! event HCHRONO;
                  event UR;
                  event LR;
              )
            (| (HCHRONO,V1) := EVERY{PI0,PI0-1}(H)
             | (UR,LR) := GETSIG{}(HCHRONO,RUR(),RLR())
             |)
            where 
            integer V1;
            process RUR =
                 ( ! boolean UR;
                 )
            
            ; 
            process RLR =
                 ( ! boolean LR;
                 )
            
            ; 
            end
         ; 
         process SSCAN =
              { integer PI1; }
              ( ? event HCHRONO;
                ! event HSLOW;
                  event UL;
                  event LL;
              )
            (| (HSLOW,V2) := EVERY{PI1,PI1-1}(HCHRONO)
             | (UL,LL) := GETSIG{}(HSLOW,RUL(),RLL())
             |)
            where 
            integer V2;
            process RLL =
                 ( ! boolean LL;
                 )
            
            ; 
            process RUL =
                 ( ! boolean UL;
                 )
            
            ; 
            end
         ; 
         end
      ; 
      process S_PACE_MAKER =
           ( ? event HE;
             ! event HS;
           )
         (| (| WSTOP(HSTOP)
             | SCAN{}
             | (| UPO := UP0
                | (| PACE_MAKER{}(HSS,UPS,DOWNS)
                   | HS := HES default UPO
                   |)
                |) where event UPO; end/ HES
             |)/ HSTOP, UP0, HSS, UPS, DOWNS |)
         where 
         process WSTOP =
              ( ? event DOWN;
              )
         
         ; 
         process SCAN =
              ( ? event HE;
                ! event UP0;
                  event HSTOP;
                  event HSS;
                  event UPS;
                  event DOWNS;
              )
            (| (| (| UP := UP0
                   | (| HSTOP := DOWN when (not AUTOMOD)
                      | HSS := HE when AUTOMOD
                      | UPS := UP when AUTOMOD
                      | DOWNS := DOWN when AUTOMOD
                      |)
                   |) where event UP; end
                | (| CAUTO := SWITCH{false}(AUTO)
                   | AUTOMOD := CAUTO cell HE
                   |)/ CAUTO
                | (| INPUT{}
                   | UP0 := UP
                   |) where event UP; end
                |)/ DOWN, AUTO, AUTOMOD |)
            where 
            process INPUT =
                 ( ? event HE;
                   ! event UP;
                     event DOWN;
                     event AUTO;
                 )
               (| HE ^= C_UP ^= C_DOWN ^= C_AUTO
                | C_UP := RUP()
                | UP := when C_UP
                | C_DOWN := RDOWN()
                | DOWN := when C_DOWN
                | C_AUTO := RAUTO()
                | AUTO := when C_AUTO
                |)
               where 
               boolean C_UP, C_DOWN, C_AUTO;
               process RUP =
                    ( ! boolean UP;
                    )
               
               ; 
               process RDOWN =
                    ( ! boolean DOWN;
                    )
               
               ; 
               process RAUTO =
                    ( ! boolean AUTO;
                    )
               
               ; 
               end
            ; 
            boolean CAUTO, AUTOMOD init false;
            event AUTO, DOWN;
            end
         ; 
         process PACE_MAKER =
              ( ? event HE;
                  event UPS;
                  event DOWNS;
                ! event HES;
              )
            (| (| (| ZMAX := MAX$1
                   | VD := (ZMAX+ZMAX) when DOWNS
                   | VU := (ZMAX/2) when UPS when (ZMAX>1)
                   | MAX := VU default VD default ZMAX
                   |)/ ZMAX, VD, VU
                | (| DYN_EVERY{1} |)/ V
                |)/ MAX |)
            where 
            integer MAX, VU, VD, ZMAX init 10, V;
            end
         ; 
         event DOWNS, UPS, HSS, UP0, HSTOP, HES;
         end
      ; 
      process SC_SELECT =
           ( ? event UL;
               event LL;
               event UR;
               event LR;
             ! event TBEEP;
               event ULLULR;
               event SUL;
               event SLL;
               event SUR;
               event SLR;
           )
         (| TBEEP := LL when UL
          | SUL := when ((not LL) default UL)
          | SLL := when ((not UL) default LL)
          | ULL := UL default LL
          | SUR := when ((not ULL) default UR)
          | SLR := when ((not (ULL default UR)) default LR)
          | ULLULR := ULL default UR default LR
          |)
         where 
         event ULL;
         end
      ; 
      process RRINGUP =
           ( ! boolean CRINGUP;
           )
      
      ; 
      event HS, UR, LR, UL, LL;
      boolean CRINGUP;
      end
   ; 
   process WACHAL =
        { integer PI, NBL; }
        ( ? event UR;
            event LR;
            event HF;
            event ULLULR;
            event UL;
            event LL;
            event RINGUP;
            event HSLOW;
          ! event SWLR;
            event SWUR;
            event AON;
            event WON;
            event SWON;
            event WLL;
            event BUR;
            event WLR;
            boolean WMODE;
            event ALL;
            event AUR;
            event ALR;
            boolean AMODE;
            event BEEP;
        )
      (| (| (| LR := SLR
             | UR := SUR
             | UL := SUL
             | LL := SLL
             | H := HSLOW
             | ALWATCH{PI,NBL}
             |) where event H, LL, UL, UR, LR; end/ WMODONOFF
                                             / AMODONOFF
          | (| LL := SLL
             | SWST := SWDIS
             | SWDISPATCH{}
             | AON := OFF
             |) where event OFF, LL;
                      boolean SWST; end
          | (| HE := HF
             | CONDUCTOR{}
             |) where event HE; end/ DSTNB
          |)/ STOPAL, SLR, SUR, SUL, ADIS, WDIS, SLL, SWDIS, RINGOFF |)
      where 
      process ALWATCH =
           { integer PI, NBL; }
           ( ? boolean WDIS;
               event UL;
               event LL;
               event UR;
               event LR;
               boolean ADIS;
               event STOPAL;
               event RINGUP;
               event H;
             ! event SWON;
               event WLL;
               event BUR;
               event WLR;
               boolean WMODE;
               boolean WMODONOFF;
               event BEEP;
               event RINGOFF;
               event ALL;
               event AUR;
               event ALR;
               boolean AMODE;
               boolean AMODONOFF;
               event WON;
           )
         (| (| SELCT{}
             | SWON := WOFF
             |) where event WOFF; end
          | (| ST := ADIS
             | SELECT{}
             | WON := AOFF
             |) where boolean ST;
                      event AOFF; end
          | (| ERESET := RINGUP
             | ESTOP := STOPAL
             | ALTERNATOR{PI,NBL}(H,(not ESTOP) default ERESET)
             | RINGOFF := STOP
             |) where event ESTOP, ERESET, STOP; end
          |)
         where 
         process SELECT =
              ( ? boolean ST;
                  event UR;
                  event LR;
                  event UL;
                  event LL;
                ! event AUR;
                  event ALR;
                  boolean AMODONOFF;
                  event ALL;
                  event AOFF;
                  boolean AMODE;
              )
            (| (| (| (| SUR := UR when ST
                      | SLR := LR when ST
                      | SUL := UL when ST
                      | XLL := LL when ST
                      |)
                   | AUR := SUR
                   | ALR := SLR
                   |) where event SUR, SLR; end
                | (| (| MODE ^= when ST
                      | MODONOFF := (not ZMODE) when SUL
                      | MODE := MODONOFF default ZMODE
                      | ZMODE := MODE$1
                      | OFF := XLL when (not MODE)
                      | SLL := XLL when MODE
                      |)
                   | AMODONOFF := MODONOFF
                   | ALL := SLL
                   | AOFF := OFF
                   | AMODE := MODE
                   |) where boolean MODONOFF, MODE;
                            event SLL, OFF; end/ ZMODE
                |)/ XLL, SUL |)
            where 
            event SUL, XLL;
            boolean ZMODE init false;
            end
         ; 
         process SELCT =
              ( ? boolean WDIS;
                  event UR;
                  event LR;
                  event UL;
                  event LL;
                ! boolean WMODONOFF;
                  event WLL;
                  event WOFF;
                  boolean WMODE;
                  event BUR;
                  event WLR;
              )
            (| (| (| ST := WDIS
                   | (| SUR := UR when ST
                      | SLR := LR when ST
                      | SUL := UL when ST
                      | XLL := LL when ST
                      |)
                   | BUR := SUR
                   | WLR := SLR
                   |) where boolean ST;
                            event SUR, SLR; end
                | (| SWSET := SUL
                   | ST := WDIS
                   | (| MODE ^= when ST
                      | MODONOFF := (not ZMODE) when SWSET
                      | MODE := MODONOFF default ZMODE
                      | ZMODE := MODE$1
                      | OFF := XLL when (not MODE)
                      | SLL := XLL when MODE
                      |)
                   | WMODONOFF := MODONOFF
                   | WLL := SLL
                   | WOFF := OFF
                   | WMODE := MODE
                   |) where boolean ST, MODONOFF, MODE;
                            event SLL, OFF, SWSET; end/ ZMODE
                |)/ XLL, SUL |)
            where 
            event SUL, XLL;
            boolean ZMODE init false;
            end
         ; 
         process ALTERNATOR =
              { integer M, N; }
              ( ? event H;
                  boolean CUPDOWN;
                ! event BEEP;
                  event STOP;
              )
            (| (| (| (H_MOD,V) := WHEEL{M,0}(ERESET,HBL)
                   | HN := H_MOD default ERESET
                   | BEEP := ERESET default (H_MOD when WBI)
                   |)/ H_MOD, V
                | (| (STOP,V) := WHEEL{N,0}(ERESET,HN) |)/ V
                | (| BTI ^= H default (^CUPDOWN)
                   | WBI := ((not STOP) when (^BTI)) default CUPDOWN default BTI
                   | ERESET := when CUPDOWN
                   | BTI := WBI$1
                   | HBL := ERESET default (when BTI)
                   |)/ BTI
                |)/ WBI, HBL, ERESET, HN |)
            where 
            event HN, H_MOD, ERESET, HBL;
            integer V;
            boolean WBI, BTI init false;
            end
         ; 
         process WHEEL =
              { integer V_MODULO, V_0; }
              ( ? event RESET;
                  event H;
                ! event HS;
                  integer V;
              )
            (| (| (| ERESET := RESET
                   | (| LocRESET := ERESET default HS
                      | V ^= ERESET default H
                      |)
                   |) where event ERESET; end
                | (| ZV := V$1
                   | V := (0 when LocRESET) default (ZV+1)
                   | HS := when (ZV>=(V_MODULO-1))
                   |)/ ZV
                |)/ LocRESET |)
            where 
            event LocRESET;
            integer ZV init V_0;
            end
         ; 
         end
      ; 
      process SWDISPATCH =
           ( ? boolean SWST;
               event UR;
               event LR;
               event LL;
             ! event OFF;
               event SWUR;
               event SWLR;
           )
         (| OFF := LL when SWST
          | SWLR := LR when SWST
          | SWUR := UR when SWST
          |)
      ; 
      process CONDUCTOR =
           ( ? event WON;
               event SWON;
               event AON;
               event HE;
               event ULLULR;
               event UL;
               event LL;
               event UR;
               event LR;
               event RINGUP;
               event RINGOFF;
             ! integer DSTNB;
               boolean WDIS;
               boolean SWDIS;
               boolean ADIS;
               event SUL;
               event SLL;
               event SUR;
               event SLR;
               event STOPAL;
           )
         (| (| H := HE
             | (| CST := NST cell H
                | STNB := CST$1
                | (HS1,NST) := EVERY{3,0}(AON default SWON default WON)
                | WDIS := STNB=0
                | SWDIS := STNB=1
                | ADIS := STNB=2
                |)
             | DSTNB := NST
             |) where event H;
                      integer NST; end/ CST
                                      / STNB
                                      / HS1
          | INHIB{}
          |)
         where 
         process INHIB =
              ( ? event HE;
                  event ULLULR;
                  event UL;
                  event LL;
                  event UR;
                  event LR;
                  event RINGUP;
                  event RINGOFF;
                ! event SUL;
                  event SLL;
                  event SUR;
                  event SLR;
                  event STOPAL;
              )
            (| CRINGING ^= ULLULR default HE
             | NRINGING := RINGUP default (not RINGOFF) default (not ULLULR) default CRINGING
             | CRINGING := NRINGING$1
             | RINGING := CRINGING when ULLULR
             | SUL := UL when (not RINGING)
             | SLL := LL when (not RINGING)
             | SUR := UR when (not RINGING)
             | SLR := LR when (not RINGING)
             | STOPAL := ULLULR when RINGING
             |)
            where 
            boolean NRINGING, RINGING init false, CRINGING init false;
            end
         ; 
         integer CST init 0, STNB;
         event HS1;
         end
      ; 
      event RINGOFF, SLL, SUL, SUR, SLR, STOPAL;
      boolean WMODONOFF, AMODONOFF, SWDIS, WDIS, ADIS;
      integer DSTNB;
      end
   ; 
   process SIGBELL =
        ( ? integer PERCENT;
        )
   
   ; 
   process DYN_EVERY =
        { integer V_0; }
        ( ? event HE;
            integer MAX;
          ! event HES;
            integer V;
        )
      (| V ^= HE
       | ZV := V$1
       | V := (0 when HES) default (ZV+1)
       | HES := when (ZV>=(MAX-1))
       |)
      where 
      integer ZV init V_0;
      end
   ; 
   process SCREEN =
        { integer TICK_NUMBER, FRONT_NUMBER, TICK_HEIGHT, TICK_SIZE, BOOL_HEIGHT, DELTA, BOOL_WIDTH; }
        ( ? event WON;
            boolean WMODE;
            event BUR;
            event WLR;
            event WLL;
            event SWON;
            event SWUR;
            event SWLR;
            event AON;
            boolean AMODE;
            event AUR;
            event ALR;
            event ALL;
            event HSLOW;
            event HCHRONO;
            event H;
        )
      (| (| (| HE := H
             | X := WSET{TICK_NUMBER,FRONT_NUMBER,(11*TICK_SIZE)+(5*BOOL_HEIGHT)+(3*TICK_HEIGHT),DELTA+DELTA+BOOL_WIDTH}(HE)
             |) where event HE; end
          | (| WMODONONFF := WMODE
             | DISPLAY{TICK_SIZE,TICK_HEIGHT,TICK_SIZE,BOOL_HEIGHT,DELTA,BOOL_WIDTH}(WON,WMODONONFF,BUR,WLR,WLL,X)
             |) where boolean WMODONONFF; end
          | EVDISPLAY{(4*TICK_SIZE)+(2*BOOL_HEIGHT)+TICK_HEIGHT,TICK_HEIGHT,TICK_SIZE,BOOL_HEIGHT,DELTA,BOOL_WIDTH}(SWON,SWUR,SWLR,X)
          | (| AMODONONFF := AMODE
             | DISPLAY{(6*TICK_SIZE)+(3*BOOL_HEIGHT)+(2*TICK_HEIGHT),TICK_HEIGHT,TICK_SIZE,BOOL_HEIGHT,DELTA,BOOL_WIDTH}(AON,AMODONONFF,AUR,ALR,ALL,X)
             |) where boolean AMODONONFF; end
          | EV2DISPLAY{(9*TICK_SIZE)+(5*BOOL_HEIGHT)+(3*TICK_HEIGHT),TICK_HEIGHT,TICK_SIZE,BOOL_HEIGHT,DELTA,BOOL_WIDTH}(HSLOW,HCHRONO,X)
          |)/ X |)
      where 
      process WSET =
           { integer XN, FN, YS, TS; }
           ( ? boolean HE;
             ! integer V;
           )
         (| (| V := ACCU_MOD{TS,XN*TS,TS*(FN-1)}(HE)
             | WEFFACE(V,0,V+TS,YS)
             |)/ V
          | V := ACCU_MOD{TS,TS*XN,TS*(XN-1)}(HE)
          |)
         where 
         process ACCU_MOD =
              { integer V_INC, V_BOUND, V_INIT; }
              ( ? boolean HE;
                ! integer V;
              )
            (| (| V ^= HE
                | ZV := V$1
                | V1 := ZV+V_INC
                | V := (0 when (V1>=V_BOUND)) default V1
                |)/ V1, ZV |)
            where 
            integer V1, ZV init V_INIT;
            end
         ; 
         process WEFFACE =
              ( ? integer X1, Y1, X2, Y2;
              )
              spec (| X1 ^= Y1 ^= X2 ^= Y2 |)
         
         ; 
         end
      ; 
      process WBOOL =
           { integer Y_POS, BOOL_HEIGHT, DELTA, BOOL_WIDTH; }
           ( ? boolean C;
               integer X;
           )
         (| (| X0 := X when (^C)
             | X1 := X0+DELTA
             | WHLINE(X0,Y_POS,X1)
             |)
          | (| Y21 := (-BOOL_HEIGHT) when C
             | Y22 := BOOL_HEIGHT when (not C)
             | Y2 := Y_POS+(Y21 default Y22)
             | WVLINE(X1,Y_POS,Y2)
             | X2 := X1+BOOL_WIDTH
             | WHLINE(X1,Y2,X2)
             | WVLINE(X2,Y_POS,Y2)
             |)
          | (| X3 := X2+DELTA
             | WHLINE(X2,Y_POS,X3)
             |)
          |)
         where 
         integer X0, X1, Y21, Y22, Y2, X2, X3;
         end
      ; 
      process WVLINE =
           ( ? integer X1, Y1, Y2;
           )
           spec (| X1 ^= Y1 ^= Y2 |)
      
      ; 
      process WHLINE =
           ( ? integer X1, Y1, X2;
           )
           spec (| X1 ^= Y1 ^= X2 |)
      
      ; 
      process WBOTTOM =
           { integer Y_POS, DELTA; }
           ( ? event H;
               integer X;
           )
         (| X1 := X when ((not H) default (^X))
          | WHLINE(X1,Y_POS,X1+DELTA)
          |)
         where 
         integer X1;
         end
      ; 
      process WSTATE =
           { integer Y_POS, BOOL_HEIGHT, DELTA; }
           ( ? boolean C;
               integer X;
           )
         (| X1 := X when (^C)
          | X2 := X1+DELTA
          | (| Y11 := (-BOOL_HEIGHT) when C
             | Y21 := Y11-1
             | Y12 := BOOL_HEIGHT when (not C)
             | Y22 := Y12+1
             | Y1 := Y_POS+(Y11 default Y12)
             | Y2 := Y_POS+(Y21 default Y22)
             |)
          | WHLINE(X1,Y1,X2)
          | WHLINE(X1,Y2,X2)
          |)
         where 
         integer X1, Y1, Y11, Y12, Y2, Y21, Y22, X2;
         end
      ; 
      process WBOOLININTER =
           { integer Y_POS, BOOL_HEIGHT, DELTA, BOOL_WIDTH; }
           ( ? boolean C, S;
               integer X;
           )
         (| WBOTTOM{Y_POS,DELTA+DELTA+BOOL_WIDTH}(^C,X)
          | WBOOL{Y_POS,BOOL_HEIGHT,DELTA,BOOL_WIDTH}(C,X)
          | WSTATE{Y_POS,BOOL_HEIGHT/2,DELTA+DELTA+BOOL_WIDTH}(S,X)
          |)
      ; 
      process DISPLAY =
           { integer POS_Y, TICK_HEIGHT, TICK_SIZE, BOOL_HEIGHT, DELTA, BOOL_WIDTH; }
           ( ? event ON;
               boolean MODONOFF;
               event UR;
               event LR;
               event LL;
               integer X;
           )
         (| WBOOLININTER{POS_Y,BOOL_HEIGHT,DELTA,BOOL_WIDTH}(ON,MODONOFF,X)
          | WBOOL{POS_Y+(TICK_SIZE+BOOL_HEIGHT),TICK_HEIGHT,DELTA,BOOL_WIDTH}(UR,X)
          | WBOOL{POS_Y+(2*TICK_SIZE)+BOOL_HEIGHT,TICK_HEIGHT,DELTA,BOOL_WIDTH}(LR,X)
          | WBOOL{POS_Y+(3*TICK_SIZE)+BOOL_HEIGHT,TICK_HEIGHT,DELTA,BOOL_WIDTH}(LL,X)
          |)
      ; 
      process EVDISPLAY =
           { integer POS_Y, TICK_HEIGHT, TICK_SIZE, BOOL_HEIGHT, DELTA, BOOL_WIDTH; }
           ( ? event EV1, EV2, EV3;
               integer X;
           )
         (| WBOOL{POS_Y,TICK_HEIGHT,DELTA,BOOL_WIDTH}(EV1,X)
          | WBOOL{POS_Y+TICK_SIZE,TICK_HEIGHT,DELTA,BOOL_WIDTH}(EV2,X)
          | WBOOL{POS_Y+(2*TICK_SIZE),TICK_HEIGHT,DELTA,BOOL_WIDTH}(EV3,X)
          |)
      ; 
      process EV2DISPLAY =
           { integer POS_Y, TICK_HEIGHT, TICK_SIZE, BOOL_HEIGHT, DELTA, BOOL_WIDTH; }
           ( ? event EV1;
               event EV2;
               integer X;
           )
         (| WBOOL{POS_Y,TICK_HEIGHT,DELTA,BOOL_WIDTH}(EV1,X)
          | WBOOL{POS_Y+TICK_SIZE,TICK_HEIGHT,DELTA,BOOL_WIDTH}(EV2,X)
          |)
      ; 
      integer X;
      end
   ; 
   event BEEP, SWON, SWUR, SWLR, WON, WLL, BUR, WLR, AON, ALL, AUR, ALR, TBEEP, RINGUP, SUL, SLL, SUR, SLR, ULLULR, HCHRONO, HSLOW;
   boolean WMODE, AMODE;
   end
; 
