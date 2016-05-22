process VTCHRONOMETER =
     { integer M1, M2, PS, SWNB, BELLPI, PERCENT, RUN_STR, LAP_STR, TICK_WIDTH; }
     ( ? event HE;
     )
   (| (| (| LR := SLR
          | UR := SUR
          | LL := SLL
          | HS := HSLOW
          | HF := HCHRONO
          | WACHAL{M2,PS,BELLPI,SWNB}
          |) where event HF, HS, LL, UR, LR; end
       | (| CONTEXT{M1,M2} |)/ SUL
                             / ULLULR
       | (| STNB := STNB1
          | DR := DB
          | DM := DS
          | DL := DMN
          | SCREEN{7*TICK_WIDTH,10*TICK_WIDTH,5*TICK_WIDTH,3*TICK_WIDTH,RUN_STR,LAP_STR,TICK_WIDTH}
          |) where integer DL, DM, DR, STNB; end
       | SIGBELL(PERCENT when (TBEEP default BEEP))
       |)/ SLR, SUR, SLL, HSLOW, HCHRONO, TBEEP, STNB1, DLAP, DRUN, DB, DS, DMN, BEEP |)
   where 
   use LocLib, CONTEXT, GraphicLib; 
   process SCREEN =
        { integer DTIME_X, DMTIME_Y, DTAG_Y, DLWTIME_Y, RUN_STR, LAP_STR, TICK_WIDTH; }
        ( ? integer DL;
            integer DM;
            integer DR;
            boolean DRUN;
            boolean DLAP;
            integer STNB;
        )
      (| TIMESCREEN{DTIME_X,DMTIME_Y,TICK_WIDTH}
       | (| DUP := DLAP
          | DDOWN := DRUN
          | DOUBLE_TAG{DTIME_X+(3*TICK_WIDTH),DTAG_Y,LAP_STR,RUN_STR,TICK_WIDTH}
          |) where boolean DDOWN, DUP; end
       | WINTTAG{TICK_WIDTH,DLWTIME_Y,4*TICK_WIDTH,2*TICK_WIDTH}(STNB)
       |)
      where 
      process WUNIT =
           { integer X, Y, TICK_SIZE; }
           ( ? integer V;
           )
         (| WPINT2(X,Y,V when (V>=0))
          | CC := WCLEARAREA(X when (^V),Y-(2*TICK_SIZE),2*TICK_SIZE,2*TICK_SIZE)
          |)
         where 
         boolean CC;
         end
      ; 
      process TIMESCREEN =
           { integer DTIME_X, DTIME_Y, TICK_WIDTH; }
           ( ? integer DL;
               integer DM;
               integer DR;
           )
         (| WUNIT{DTIME_X,DTIME_Y,TICK_WIDTH}(DL)
          | WUNIT{DTIME_X+(3*TICK_WIDTH),DTIME_Y,TICK_WIDTH}(DM)
          | WUNIT{DTIME_X+(6*TICK_WIDTH),DTIME_Y,TICK_WIDTH}(DR)
          |)
      ; 
      process WTAG =
           { integer X_POS, Y_POS, DX, DY, STR_IND; }
           ( ? boolean C;
           )
         (| WPTAG(X_POS when C when CC,Y_POS,STR_IND)
          | CC := WCLEARAREA(X_POS when (^C),Y_POS-DY,DX,DY)
          |)
         where 
         boolean CC;
         end
      ; 
      process DOUBLE_TAG =
           { integer DTAG_X, DTAG_Y, UP_STR, DOWN_STR, TICK_WIDTH; }
           ( ? boolean DUP;
               boolean DDOWN;
           )
         (| WTAG{DTAG_X,DTAG_Y,3*TICK_WIDTH,TICK_WIDTH,UP_STR}(DUP)
          | WTAG{DTAG_X,DTAG_Y+(2*TICK_WIDTH),3*TICK_WIDTH,TICK_WIDTH,DOWN_STR}(DDOWN)
          |)
      ; 
      process WINTTAG =
           { integer X_POS, Y_POS, DX, DY; }
           ( ? integer STNB;
           )
         (| WDTAG(X_POS,Y_POS,STNB when CC)
          | CC := WCLEARAREA(X_POS when (^STNB),Y_POS-DY,DX,DY)
          |)
         where 
         boolean CC;
         end
      ; 
      end
   ; 
   process WACHAL =
        { integer M, PS, BELLPI, SWNB; }
        ( ? event UR;
            event LR;
            event HF;
            event HS;
            event LL;
          ! integer STNB1;
            boolean DRUN;
            boolean DLAP;
            event BEEP;
            integer DMN, DS, DB;
        )
      (| (| ALWATCH{}
          | (| DISON := SWON
             | S_CHRONO{M,PS,BELLPI,SWNB}
             | BEEP := DBEEP
             |) where event DBEEP, DISON; end
          | (| AON := OFF
             | HE := HF
             | CONDUCTOR{}
             | STNB1 := DSTNB
             |) where event HE, AON;
                      integer DSTNB; end
          |)/ STNB, OFF, WON, SWON |)
      where 
      process S_CHRONO =
           { integer M, PS, BELLPI, SWNB; }
           ( ? integer STNB;
               event LL;
               event UR;
               event LR;
               event HF;
               event HS;
               event DISON;
             ! event OFF;
               event DBEEP;
               boolean DRUN;
               boolean DLAP;
               integer DMN;
               integer DS;
               integer DB;
           )
         (| (| SWDISPATCH{1}
             | (| LAP := SWUR
                | RUN := SWLR
                | DISOFF := OFF
                | CHRONO{M,PS,BELLPI,SWNB}
                |) where event DISOFF, RUN, LAP; end
             |)/ SWUR, SWLR |)
         where 
         process SWDISPATCH =
              { integer SW_STNB; }
              ( ? integer STNB;
                  event UR;
                  event LR;
                  event LL;
                ! event OFF;
                  event SWUR;
                  event SWLR;
              )
            (| SWST := STNB=SW_STNB
             | OFF := LL when SWST
             | SWLR := LR when SWST
             | SWUR := UR when SWST
             |)
            where 
            boolean SWST;
            end
         ; 
         process CHRONO =
              { integer M, PS, PI, LA; }
              ( ? event HS;
                  event HF;
                  event LAP;
                  event RUN;
                  event DISON;
                  event DISOFF;
                ! event DBEEP;
                  boolean DRUN;
                  boolean DLAP;
                  integer DMN;
                  integer DS;
                  integer DB;
              )
            (| (| (| H := HF
                   | CONTROL{}
                   |) where event H; end
                | (| H := H_1
                   | GEARS{M,PS}
                   |) where event H; end
                | SWDISPLAY{}
                | (| HE := HS
                   | SWSTRIKE{PI,LA}
                   | DBEEP := BEEP
                   |) where event HE, BEEP; end
                |)/ B, S, MN, VISIBLE, H_1, RESET |)
            where 
            process CONTROL =
                 ( ? event LAP;
                     event RUN;
                     event H;
                   ! boolean VISIBLE, DLAP;
                     event RESET;
                     boolean DRUN;
                     event H_1;
                 )
               (| (| (| ZACTIF := Z_ACTIF
                      | ZVISIBLE := Z_VISIBLE
                      | (| STOPPE := ZVISIBLE and (not ZACTIF)
                         | RESET := LAP when STOPPE
                         |)
                      |) where boolean ZVISIBLE init true, ZACTIF init false; end
                   | (| (| HS := H when ACTIF
                         | ACTIF ^= H default RUN default LAP
                         |)
                      | H_1 := HS
                      |) where event HS; end
                   | (| DLAP := Z_VISIBLE when LAP when (not STOPPE)
                      | VISIBLE := (not DLAP) default Z_VISIBLE
                      | Z_VISIBLE := VISIBLE$1
                      |)
                   | (| DRUN := (not Z_ACTIF) when RUN
                      | ACTIF := DRUN default Z_ACTIF
                      | Z_ACTIF := ACTIF$1
                      |)
                   |)/ ACTIF, Z_ACTIF, Z_VISIBLE, STOPPE |)
               where 
               boolean STOPPE, Z_VISIBLE init true, Z_ACTIF init false, ACTIF init false;
               end
            ; 
            process SWDISPLAY =
                 ( ? boolean DRUN;
                     boolean DLAP;
                     event DISON;
                     event DISOFF;
                     boolean VISIBLE;
                     integer MN;
                     integer S;
                     integer B;
                   ! integer DMN;
                     integer DS;
                     integer DB;
                 )
               (| (| CONTROL{}
                   | (| UNIT := MN
                      | AFFUNIT{}
                      | DMN := DUNIT
                      |) where integer UNIT, DUNIT; end
                   | (| UNIT := S
                      | AFFUNIT{}
                      | DS := DUNIT
                      |) where integer UNIT, DUNIT; end
                   | (| UNIT := B
                      | AFFUNIT{}
                      | DB := DUNIT
                      |) where integer UNIT, DUNIT; end
                   |)/ REDISPLAY, DISPLAY, LAP |)
               where 
               process AFFUNIT =
                    ( ? event LAP;
                        boolean DISPLAY, REDISPLAY;
                        integer UNIT;
                      ! integer DUNIT;
                    )
                  (| C_UNIT := UNIT cell (^DISPLAY)
                   | L_UNIT := (C_UNIT when LAP) cell (^DISPLAY)
                   | DUNIT := (C_UNIT when REDISPLAY) default (L_UNIT when (not REDISPLAY)) default (UNIT when DISPLAY)
                   |)
                  where 
                  integer C_UNIT init 0, L_UNIT init 0;
                  end
               ; 
               process CONTROL =
                    ( ? boolean DRUN, DLAP;
                        event DISON;
                        boolean VISIBLE;
                        event DISOFF;
                      ! event LAP;
                        boolean REDISPLAY, DISPLAY;
                    )
                  (| (| (| LAP := when DLAP
                         | REDISPLAY := ((when DRUN) when VISIBLE) default (when (not DLAP)) default (VISIBLE when DISON)
                         | DISPLAY := (LAP default VISIBLE) when SHOW
                         |)
                      | (| DSET := (not DISOFF) default DISON
                         | SHOW := DSET cell (^VISIBLE)
                         | SHOW ^= VISIBLE
                         |)/ DSET
                      |)/ SHOW |)
                  where 
                  boolean DSET, SHOW init false, H_ETAT, C_ETAT init false, N_ETAT;
                  end
               ; 
               event LAP;
               boolean DISPLAY, REDISPLAY;
               end
            ; 
            process GEARS =
                 { integer M, PS; }
                 ( ? event RESET;
                     event H;
                   ! integer MN, S, B;
                 )
               (| (| (| H := HS_1
                      | WHEEL{60,0}
                      | MN := V
                      |) where integer V;
                               event H; end/ HS
                   | (| H := HS_2
                      | WHEEL{60,0}
                      | S := V
                      | HS_1 := HS
                      |) where integer V;
                               event HS, H; end
                   | (| H := HS_3
                      | WHEEL{PS,0}
                      | B := V
                      | HS_2 := HS
                      |) where integer V;
                               event HS, H; end
                   | (| WHEEL{M,0}
                      | HS_3 := HS
                      |) where event HS; end/ V
                   |)/ HS_3, HS_2, HS_1 |)
               where 
               event HS, HS_1, HS_2, HS_3;
               integer V;
               end
            ; 
            process SWSTRIKE =
                 { integer PERIOD, DURATION; }
                 ( ? boolean DRUN;
                     event HE;
                     event RESET;
                     integer MN;
                   ! event BEEP;
                 )
               (| (| (| (BEEP1,AUX1) := ALTERNATOR{PERIOD,1}(HE,^DRUN) |)/ AUX1
                   | (| (BEEP2,AUX2) := ALTERNATOR{PERIOD,DURATION}(HE,when ((not RESET) default (^MN))) |)/ AUX2
                   | BEEP := BEEP1 default BEEP2
                   |)/ BEEP2, BEEP1 |)
               where 
               event AUX1, BEEP1, BEEP2, AUX2;
               end
            ; 
            event RESET, H_1;
            boolean VISIBLE init true;
            integer MN, S, B;
            end
         ; 
         event SWLR, SWUR;
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
                | (| LOCRESET := ERESET default HS
                   | V ^= ERESET default H
                   |)
                |) where event ERESET; end
             | (| RESET := LOCRESET
                | (| ZV := V$1
                   | V := (0 when RESET) default (ZV+1)
                   | HS := when (ZV>=(V_MODULO-1))
                   |)
                |) where event RESET; end/ ZV
             |)/ LOCRESET |)
         where 
         event LOCRESET;
         integer ZV init V_0;
         end
      ; 
      process CONDUCTOR =
           ( ? event WON;
               event SWON;
               event AON;
               event HE;
             ! integer DSTNB;
               integer STNB;
           )
         (| (| H := HE
             | (| CST := NST cell H
                | STNB := CST$1
                | (HS1,NST) := EVERY{3,0}(AON default SWON default WON)
                |)
             | DSTNB := NST
             |) where event H;
                      integer NST; end/ CST
                                      / HS1 |)
         where 
         integer CST init 0;
         event HS1;
         end
      ; 
      process ALWATCH =
           ( ? integer STNB;
               event LL;
             ! event SWON;
               event WON;
           )
         (| (| (| ST := STNB=0
                | OFF := LL when ST
                |)
             | SWON := OFF
             |) where event OFF; end/ ST
          | (| (| ST := STNB=2
                | OFF := LL when ST
                |)
             | WON := OFF
             |) where event OFF; end/ ST
          |)
         where 
         boolean ST;
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
      event SWON, WON, OFF;
      integer STNB;
      end
   ; 
   process SIGBELL =
        ( ? integer PERCENT;
        )
   
   ; 
   event BEEP, TBEEP, HCHRONO, HSLOW, SUL, SLL, SUR, SLR, ULLULR;
   integer DMN, DS, DB, STNB1;
   boolean DRUN, DLAP;
   end
; 
