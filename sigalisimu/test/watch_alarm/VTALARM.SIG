process VTALARM =
     { integer M1, M2, PS, PISET, NAL, BELLPI, ALNB, PERCENT, PM_STR, AL_STR, CH_STR, TICK_WIDTH; }
     ( ? event HE;
     )
   (| (| (| LR := SLR
          | UR := SUR
          | LL := SLL
          | UL := SUL
          | HS := HSLOW
          | HF := HCHRONO
          | S_ALARM{PS,PISET,NAL,BELLPI,ALNB}
          |) where event HF, HS, UL, LL, UR, LR; end
       | CONTEXT{M1,M2}
       | (| DL := DAHOUR
          | DM := DAMIN
          | STNB := DSTNB
          | LWHOUR := CHOUR
          | LWMIN := CMIN
          | SCREEN{7*TICK_WIDTH,10*TICK_WIDTH,5*TICK_WIDTH,3*TICK_WIDTH,PM_STR,AL_STR,CH_STR,TICK_WIDTH}
          |) where LWMIN, LWHOUR, STNB, DL;
                   integer DM; end
       | SIGBELL(PERCENT when (TBEEP default BEEP))
       |)/ ULLULR, SLR, SUR, SLL, SUL, HSLOW, HCHRONO, TBEEP, DCHIME, DALARM, DAHOUR, DAMIN, DPM, DSTNB, CHOUR, CMIN, BEEP |)
   where 
   use LocLib, CONTEXT, GraphicLib; 
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
   process S_ALARM =
        { integer PS, PISET, NAL, BELLPI, ALNB; }
        ( ? event HS;
            event UR;
            event LR;
            event HF;
            event ULLULR;
            event UL;
            event LL;
          ! integer DSTNB;
            integer CHOUR;
            integer CMIN;
            event BEEP;
            integer DAHOUR;
            integer DAMIN;
            boolean DPM;
            boolean DALARM;
            boolean DCHIME;
        )
      (| (| (| WONOFF := WSETONOFF
             | SW24 := STATE24
             | LL := SLL
             | UR := SUR
             | LR := SLR
             | UL := SUL
             | AON := OFF
             | WMIN := CMIN
             | WHOUR := CHOUR
             | H := HS
             | ALARM{PISET,NAL,BELLPI,ALNB}
             | BEEP := ALBEEP
             |) where event H, ALBEEP, AON, UL, LR, UR, LL;
                      integer WHOUR, WMIN;
                      SW24, WONOFF; end
          | (| SWST := SWDIS
             | LL := SLL
             | SWDISPATCH{}
             |) where event LL;
                      boolean SWST; end
          | (| SWON := WOFF
             | AON := OFF
             | WON := AOFF
             | HE := HF
             | CONDUCTOR{}
             |) where event HE, WON, AON;
                      SWON; end
          | (| LL := SLL
             | LR := SLR
             | UL := SUL
             | WON := AOFF
             | HE := HS
             | WATCH{PS}
             |) where event HE, WON, UL, LR, LL; end
          |)/ WSETONOFF, STATE24, WOFF, STOPAL, SWDIS, SLL, ADIS, SUR, SLR, SUL, WDIS, OFF, RINGOFF, RINGUP, AOFF |)
      where 
      process WHEEL =
           { integer V_MODULO, V_0; }
           ( ? event RESET;
               event H;
             ! event HS;
               integer V;
           )
         (| (| (| ERESET := RESET
                | (| XRESET := ERESET default HS
                   | V ^= ERESET default H
                   |)
                |) where event ERESET; end
             | (| RESET := XRESET
                | (| ZV := V$1
                   | V := (0 when RESET) default (ZV+1)
                   | HS := when (ZV>=(V_MODULO-1))
                   |)
                |) where event RESET; end/ ZV
             |)/ XRESET |)
         where 
         event XRESET;
         integer ZV init V_0;
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
      process SWDISPATCH =
           ( ? boolean SWST;
               event LL;
             ! event OFF;
           )
         (| OFF := LL when SWST |)
      ; 
      process WATCH =
           { integer PS; }
           ( ? event WON;
               boolean WDIS;
               event UL;
               event LL;
               event LR;
               event HE;
             ! event WOFF;
               boolean WSETONOFF;
               boolean STATE24;
               integer CMIN;
               integer CHOUR;
           )
         (| (| ST := WDIS
             | DON := WON
             | CONTROL{}
             | WOFF := DOFF
             | STATE24 := SW24
             |) where event DON, DOFF;
                      boolean ST, SW24; end
          | SETTIME{PS}
          |)
         where 
         process SETTIME =
              { integer PS; }
              ( ? event HE;
                ! integer CHOUR;
                  integer CMIN;
              )
            (| (| (| H := HE
                   | EVERY{PS,PS-1}
                   | HS_1 := HS
                   |) where event H;
                            HS; end/ V
                | (| H := HS_2
                   | EVERY{24,23}
                   | CHOUR := V
                   |) where integer V;
                            H; end/ HS
                | (| H := HS_1
                   | EVERY{60,59}
                   | CMIN := V
                   | HS_2 := HS
                   |) where integer V;
                            H, HS; end
                |)/ HS_2, HS_1 |)
            where 
            HS_1, HS, V, HS_2;
            end
         ; 
         process CONTROL =
              ( ? event DON;
                  boolean ST;
                  event UL;
                  event LL;
                  event LR;
                ! boolean SW24;
                  boolean WSETONOFF;
                  event DOFF;
              )
            (| (| (| LR := WLR
                   | WFILTER{}
                   |) where event LR; end
                | SW24 := SWITCH{false}(SW)
                | (| SELCT{}
                   | WSETONOFF := WMODONOFF
                   |) where boolean WMODONOFF; end
                |)/ CWSET, WLR, SW |)
            where 
            boolean CWSET, SET init false;
            event WLR, H, SW;
            process WFILTER =
                 ( ? boolean CWSET;
                     event DON;
                     boolean WSETONOFF;
                     event LR;
                   ! event SW;
                 )
               (| SETONOFF := (not DON) default WSETONOFF
                | (| HAUTO := LR default DON default (^CWSET)
                   | CSET := SETONOFF default ZCSET
                   | ZCSET := CSET$1
                   | CSET ^= HAUTO
                   |)
                | SW := LR when (not CSET)
                |)
               where 
               event HAUTO;
               boolean SETONOFF, CSET, ZCSET init false;
               end
            ; 
            process SELCT =
                 ( ? event LR;
                     event UL;
                     event LL;
                     boolean ST;
                   ! event WLR;
                     event CWSET;
                     boolean WMODONOFF;
                     event DOFF;
                 )
               (| (| (| (| SLR := LR when ST
                         | SUL := UL when ST
                         | XLL := LL when ST
                         |)
                      | WLR := SLR
                      | CWSET := SUL
                      |) where event SLR, SUL; end
                   | (| SWSET := CWSET
                      | (| MODE ^= when ST
                         | MODONOFF := (not ZMODE) when SWSET
                         | MODE := MODONOFF default ZMODE
                         | ZMODE := MODE$1
                         | OFF := XLL when (not MODE)
                         |)
                      | WMODONOFF := MODONOFF
                      | DOFF := OFF
                      |) where event SWSET, OFF;
                               boolean MODONOFF; end/ ZMODE
                                             / MODE
                   |)/ XLL |)
               where 
               event XLL;
               boolean ZMODE init false, MODE;
               end
            ; 
            end
         ; 
         end
      ; 
      process D_12_24 =
           ( ? integer DV;
               boolean SW24;
             ! boolean DPM;
               integer DHOUR;
           )
         (| STATE24 := SW24 cell (^DV)
          | CV := DV cell (^STATE24)
          | DPM := ((CV>12) when (not STATE24)) default (not (^CV))
          | DHOUR := ((CV-12) when DPM) default CV
          |)
         where 
         integer CV init 0;
         boolean STATE24 init false;
         end
      ; 
      process WHILE =
           { boolean V_0; }
           ( ? boolean INTONOFF;
               event VIN;
             ! event VOUT;
           )
         (| CSTATE := INTONOFF cell (^VIN)
          | VOUT := VIN when CSTATE
          |)
         where 
         boolean CSTATE init V_0;
         end
      ; 
      process SLOPE =
           { integer PISET, NAL; }
           ( ? event RESET;
               event CLICK;
               event TICK;
             ! event HINCR;
               event HBLINK;
           )
         (| (| (| H := HS
                | LTICK := TICK
                | LCLICK := CLICK
                | BEYOND{NAL}
                |) where event LCLICK, LTICK, H; end
             | (| H := CLICK default TICK default RESET
                | WHEEL{PISET,PISET-1}
                |)/ V, H
             |)/ HS |)
         where 
         process BEYOND =
              { integer SATURATION; }
              ( ? event H;
                  event RESET;
                  event LTICK;
                  event LCLICK;
                ! event HINCR;
                  event HBLINK;
              )
            (| (| V ^= RESET default H
                | (| ZV := V$1
                   | V := (0 when RESET) default (ZV+1)
                   | INCREASE := V<SATURATION
                   |)/ ZV
                | (| HBLINK := LTICK when INCREASE
                   | HINCR := (LTICK when (not INCREASE)) default (LCLICK when INCREASE)
                   |)
                |)/ INCREASE, V |)
            where 
            integer V, ZV init 0;
            boolean INCREASE;
            end
         ; 
         event H, HS;
         integer V;
         end
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
      process ALARM =
           { integer PI, NAL, ALPI, LA; }
           ( ? boolean SW24;
               event AON;
               boolean ADIS;
               event UL;
               event LL;
               event UR;
               event LR;
               boolean WONOFF;
               event H;
               event STOPAL;
               integer WHOUR;
               integer WMIN;
             ! event AOFF;
               boolean DPM;
               integer DAHOUR;
               integer DAMIN;
               boolean DCHIME;
               boolean DALARM;
               event RINGUP;
               event RINGOFF;
               event ALBEEP;
           )
         (| (| (| HE := H
                | WSETONOFF := WONOFF
                | ADISPATCH{}
                | AOFF := DOFF
                |) where boolean WSETONOFF;
                         event DOFF, HE; end
             | SETHOUR{PI,NAL}
             | (| ALONOFF := DALARM
                | CHONOFF := DCHIME
                | HE := H
                | PALARM{ALPI,LA}
                | ALBEEP := BEEP
                |) where event HE, BEEP;
                         boolean CHONOFF, ALONOFF; end
             | SETMN{PI,NAL}
             |)/ AMIN, AHOUR, SETH, CLICK, TICK, DISON |)
         where 
         integer STVAR;
         boolean ALST;
         integer AMIN, AHOUR, CAMIN init 0, CATMIN init 0, CAHOUR init 0;
         boolean IEV;
         process PALARM =
              { integer PI, LA; }
              ( ? event HE;
                  event STOPAL;
                  boolean CHONOFF;
                  integer WHOUR;
                  integer AHOUR;
                  boolean ALONOFF;
                  integer WMIN;
                  integer AMIN;
                ! event BEEP;
                  event RINGOFF;
                  event RINGUP;
              )
            (| (| (| CHECK := WHILE{false}(ALONOFF,^WMIN)
                   | CHECK_1 := CHECK
                   |) where event CHECK; end
                | (| CHECK := CHECK_1
                   | AV := AHOUR
                   | WV := WHOUR
                   | UNIT{}
                   | BEEP_2 := BEEP
                   |) where integer WV, AV;
                            event CHECK, BEEP; end
                | (| CHECK := BEEP_2
                   | AV := AMIN
                   | WV := WMIN
                   | UNIT{}
                   | RINGUP := BEEP
                   |) where integer WV, AV;
                            event BEEP, CHECK; end
                | CHBEEP := WHILE{false}(CHONOFF,^WHOUR)
                | (| ALBEEP := RINGUP
                   | STOP := STOPAL
                   | STRIKE{PI,LA}
                   |) where event STOP, ALBEEP; end
                |)/ CHBEEP, BEEP_2, CHECK_1 |)
            where 
            process UNIT =
                 ( ? integer AV, WV;
                     event CHECK;
                   ! event BEEP;
                 )
               (| CAV := (AV cell CHECK) when CHECK
                | CWV := (WV cell CHECK) when CHECK
                | BEEP := when (CAV=CWV)
                |)
               where 
               integer CAV init 0, CWV init 0;
               end
            ; 
            process STRIKE =
                 { integer PERIOD, DURATION; }
                 ( ? event CHBEEP;
                     event HE;
                     event ALBEEP;
                     event STOP;
                   ! event BEEP;
                     event RINGOFF;
                 )
               (| (| (| (BEEP1,AUX) := ALTERNATOR{PERIOD,1}(HE,CHBEEP) |)/ AUX
                   | (| H := HE
                      | (BEEP2,RINGOFF) := ALTERNATOR{PERIOD,DURATION}(H,(not STOP) default ALBEEP)
                      |) where event H; end
                   | BEEP := BEEP1 default BEEP2
                   |)/ BEEP2, BEEP1 |)
               where 
               event AUX, BEEP1, BEEP2;
               end
            ; 
            event CHECK_1, CHECK, BEEP_2, CHBEEP;
            end
         ; 
         process ADISPATCH =
              ( ? event HE;
                  event AON;
                  event LL;
                  event UR;
                  event LR;
                  boolean ADIS;
                  event UL;
                  boolean WSETONOFF;
                ! event DOFF;
                  event TICK;
                  event CLICK;
                  event DISON;
                  boolean SETH;
                  boolean DALARM;
                  boolean DCHIME;
              )
            (| (| (| LR := SLR
                   | UR := SUR
                   | LL := SLL
                   | ASETONOFF := MODONOFF
                   | DON := AON
                   | AFILTER{}
                   |) where event DON, LL, LR;
                            boolean ASETONOFF;
                            UR; end
                | (| SWC := SWITCHA
                   | SETALARM{}
                   |) where event SWC; end
                | (| COMMUT := SWITCHC
                   | CANCEL := WSETONOFF
                   | TAG{}
                   | DCHIME := DISB
                   |) where boolean CANCEL, DISB;
                            event COMMUT; end
                | (| INTONOFF := SETONOFF
                   | VIN := HE
                   | WHILE{false}
                   | TICK := VOUT
                   |) where event VIN, VOUT;
                            boolean INTONOFF; end
                | (| SWISET := SUL
                   | STATE := ADIS
                   | SELECT{}
                   |) where boolean STATE;
                            SWISET; end
                | (| ST := ADIS
                   | SUL := UL when ST
                   |) where boolean ST; end
                |)/ SUL, SLR, SUR, SLL, MODONOFF, SWITCHC, SWITCHA, SETONOFF |)
            where 
            boolean MODONOFF, SETONOFF, SET init false;
            event SLR, SLL, SWITCHC, SWITCHA, H;
            process TAG =
                 ( ? event COMMUT;
                     boolean CANCEL;
                   ! boolean DISB;
                 )
               (| CB := SWITCH{false}(COMMUT) cell (^CANCEL)
                | DISB := (not (when CANCEL)) default CB
                |)
               where 
               boolean ZB init false, CB init false;
               end
            ; 
            process AFILTER =
                 ( ? event DON;
                     boolean ASETONOFF;
                     event LL;
                     event UR;
                     event LR;
                   ! event DISON;
                     boolean SETONOFF;
                     boolean SETH;
                     event CLICK;
                     event SWITCHC;
                     event SWITCHA;
                 )
               (| SETONOFF := (not DON) default ASETONOFF
                | DISON := ^SETONOFF
                | (| HAUTO := UR default LR default LL default DISON
                   | CSET := SETONOFF default ZCSET
                   | ZCSET := CSET$1
                   | CSET ^= HAUTO
                   |)
                | (| RESET := when SETONOFF
                   | NEXTX := LL when CSET
                   | CLICK := LR when CSET
                   |)
                | (| SETH ^= NEXTX default RESET
                   | SETH := RESET default (not ZSETH)
                   | ZSETH := SETH$1
                   |)
                | (| SWITCHA := LR when (not CSET)
                   | SWITCHC := UR when (not CSET)
                   |)
                |)
               where 
               event HAUTO, RESET, NEXTX;
               boolean CSET, ZCSET init false, ZSETH init true;
               end
            ; 
            process SETALARM =
                 ( ? boolean WSETONOFF;
                     event SWC;
                     boolean SETONOFF;
                   ! boolean DALARM;
                 )
               (| ALCANCEL := (when WSETONOFF) default (when SETONOFF) default (not ((^WSETONOFF) default (^SETONOFF)))
                | DALARM := TAG(SWC,ALCANCEL)
                |)
               where 
               boolean ALCANCEL;
               end
            ; 
            SUR, SUL;
            end
         ; 
         process SETMN =
              { integer PISET, NAL; }
              ( ? event DISON;
                  boolean SETH;
                  event TICK;
                  event CLICK;
                ! integer DAMIN;
                  integer AMIN;
              )
            (| (| (| CL := CLICK
                   | TI := TICK
                   | ST := SETH
                   | A_UNIT{60,PISET,NAL}(not ST,TI,CL)
                   | AMIN := V
                   |) where boolean ST;
                            event TI, CL;
                            integer V; end
                | (| TICK := HBLINK
                   | V := AMIN
                   | (| SETONOFF := not SETH
                      | DISUNIT{}
                      |)
                   | DAMIN := DV
                   |) where integer DV, V;
                            TICK; end/ SETONOFF
                |)/ HBLINK |)
            where 
            HBLINK;
            boolean SETONOFF;
            end
         ; 
         process SETHOUR =
              { integer PISET, NAL; }
              ( ? boolean SW24;
                  event DISON;
                  boolean SETH;
                  event TICK;
                  event CLICK;
                ! integer DAHOUR;
                  boolean DPM;
                  integer AHOUR;
              )
            (| (| (| CL := CLICK
                   | TI := TICK
                   | ST := SETH
                   | A_UNIT{24,PISET,NAL}(ST,TI,CL)
                   | AHOUR := V
                   |) where boolean ST;
                            event TI, CL;
                            integer V; end
                | (| TICK := HBLINK
                   | V := AHOUR
                   | SETONOFF := SETH
                   | DISUNIT{}
                   |) where boolean SETONOFF;
                            integer V;
                            TICK; end
                | (| D_12_24{}
                   | DAHOUR := DHOUR
                   |) where integer DHOUR; end
                |)/ DV, HBLINK |)
            where 
            HBLINK;
            integer DV init 0;
            end
         ; 
         process A_UNIT =
              { integer P, PI, NAL; }
              ( ? boolean SETONOFF;
                  event TICK;
                  event CLICK;
                ! integer V;
                  event HBLINK;
              )
            (| (| (| (| H := HINCR
                      | EVERY{P,0}
                      |) where event H; end |)/ HS
                | AUCONTROL{}
                | (| CLICK := LCLICK
                   | TICK := LTICK
                   | SLOPE{PI,NAL}
                   |) where event TICK, CLICK; end
                |)/ HINCR, LCLICK, LTICK, RESET |)
            where 
            process AUCONTROL =
                 ( ? boolean SETONOFF;
                     event TICK;
                     event CLICK;
                   ! event LCLICK;
                     event LTICK;
                     event RESET;
                 )
               (| CSET := SETONOFF cell (TICK default CLICK)
                | LCLICK := CLICK when CSET
                | LTICK := TICK when CSET
                | RESET := ((when SETONOFF) default LCLICK) when CSET
                |)
               where 
               boolean CSET init false;
               end
            ; 
            event HS, RESET, LTICK, LCLICK, HINCR;
            end
         ; 
         process DISUNIT =
              ( ? boolean SETONOFF;
                  event DISON;
                  event TICK;
                  integer V;
                ! integer DV;
              )
            (| H := (^V) default DISON default (^SETONOFF) default TICK
             | CV := V cell H
             | DV2 := CV when DISON
             | DV3 := CV when (^SETONOFF)
             | (| HSET := WHILE{false}(SETONOFF,TICK)
                | ACTIF := (not (when SETONOFF)) default (not ZACTIF)
                | ZACTIF := ACTIF$1
                | ACTIF ^= (when SETONOFF) default HSET
                | DV4 := (CV when ACTIF) default ((-2) when (not ACTIF))
                |)
             | DV := V default DV2 default DV3 default DV4
             |)
            where 
            event HSET, H;
            boolean ACTIF, ZACTIF init false;
            integer CV init 0, DV2, DV3, DV4;
            end
         ; 
         event DISON, TICK, CLICK;
         SETH;
         end
      ; 
      process SELECT =
           ( ? boolean SWISET;
               boolean STATE;
               event UR;
               event LR;
               event LL;
             ! boolean MODONOFF;
               event SLL;
               event DOFF;
               event SLR;
               event SUR;
           )
         (| (| (| ST := STATE
                | (| SUR := UR when ST
                   | SLR := LR when ST
                   | XLL := LL when ST
                   |)
                |) where boolean ST; end
             | (| ST := STATE
                | SWSET := SWISET
                | (| MODE ^= when ST
                   | MODONOFF := (not ZMODE) when SWSET
                   | MODE := MODONOFF default ZMODE
                   | ZMODE := MODE$1
                   | OFF := XLL when (not MODE)
                   | SLL := XLL when MODE
                   |)
                | DOFF := OFF
                |) where boolean SWSET, ST;
                         event OFF; end/ ZMODE
                                       / MODE
             |)/ XLL |)
         where 
         event XLL;
         boolean ZMODE init false, MODE;
         end
      ; 
      event AOFF, RINGUP, RINGOFF, OFF, SUL, SLR, SUR, SLL, STOPAL;
      boolean WDIS, ADIS, SWDIS;
      WOFF, STATE24, WSETONOFF;
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
        { integer DTIME_X, DMTIME_Y, DTAG_Y, DLWTIME_Y, PM_STR, AL_STR, CH_STR, TICK_WIDTH; }
        ( ? integer LWMIN;
            integer LWHOUR;
            boolean DPM;
            integer DL;
            integer DM;
            boolean DALARM;
            boolean DCHIME;
            integer STNB;
        )
      (| (| DL := LWHOUR
          | DM := LWMIN
          | LWSCREEN{DTIME_X,DLWTIME_Y,TICK_WIDTH}
          |) where integer DM, DL; end
       | TIMESCREEN{DTIME_X,DMTIME_Y,PM_STR,TICK_WIDTH}
       | (| DUP := DCHIME
          | DDOWN := DALARM
          | DOUBLE_TAG{DTIME_X,DTAG_Y,CH_STR,AL_STR,TICK_WIDTH}
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
           { integer DTIME_X, DTIME_Y, PM_STR, TICK_WIDTH; }
           ( ? boolean DPM;
               integer DL;
               integer DM;
           )
         (| WTAG{DTIME_X-(2*TICK_WIDTH),DTIME_Y-TICK_WIDTH,2*TICK_WIDTH,TICK_WIDTH,PM_STR}(DPM)
          | WUNIT{DTIME_X,DTIME_Y,TICK_WIDTH}(DL)
          | WUNIT{DTIME_X+(3*TICK_WIDTH),DTIME_Y,TICK_WIDTH}(DM)
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
      process LWSCREEN =
           { integer DTIME_X, DTIME_Y, TICK_WIDTH; }
           ( ? integer DL;
               integer DM;
           )
         (| WUNIT{DTIME_X,DTIME_Y,TICK_WIDTH}(DL)
          | WUNIT{DTIME_X+(3*TICK_WIDTH),DTIME_Y,TICK_WIDTH}(DM)
          |)
      ; 
      end
   ; 
   event BEEP, TBEEP, HCHRONO, HSLOW, SUL, SLL, SUR, SLR, ULLULR;
   CMIN, CHOUR, DSTNB, DAHOUR;
   boolean DPM, DALARM, DCHIME;
   integer DAMIN;
   end
; 
