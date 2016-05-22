process equationSolving_BOOL_TRA =
     ( ? real a, b, c;
       ! real x2, x1;
         boolean oc;
     )
   pragmas 
      Main
      DefinedClockHierarchy
   end pragmas
   (| (| Tick := true
       | ACT_Tick{}
       |) |)
   where 
   constant real epsilon = 0.00001;
   boolean Tick;
   process ACT_Tick =
        ( )
      (| when Tick ^= stable ^= yy ^= next_yy ^= biterate ^= mx ^= pre_next_yy ^= next_stable ^= s ^= XZX_160 ^= C ^= C_265 ^= C_268 ^= C_x1 ^= OK_281 ^= C_cc1_297 ^= C_ ^= C_d_308 ^= C__319 ^= C_a1 ^= C_x1_357 ^= C_363 ^= C_367 ^= C_371
       | (| when stable ^= a ^= b ^= c ^= OK ^= C_cc
          | ACT_stable{}
          |)
       | (| when C_x1 ^= x2 ^= x1_60
          | ACT_C_x1{}
          |)
       | (| when C_ ^= XZX_179
          | (| XZX_179 := (bb when OK) cell C_ init 0.0e0 |)
          |)
       | (| when C_a1 ^= a1
          | (| a1 := (x1_60 when C_x1) default (x when C_367) |)
          |)
       | (| when C_x1_357 ^= x1
          | (| x1 := (a1 when C_a1) default (a2 when C_371) |)
          |)
       | (| stable := next_stable$1 init true
          | yy := ((d/2.0) when C_d) default (pre_next_yy when C_363)
          | next_yy := (((yy+(mx/yy))/2.0) when biterate) default (yy when C)
          | biterate := (true when C_d) default ((not stable) when C_363)
          | mx := (d when C_d) cell Tick init 0.0e0
          | pre_next_yy := next_yy$1 init 1.0
          | next_stable := s<epsilon
          | s := (XZX_160 when C_265) default ((-XZX_160) when C_268)
          | XZX_160 := next_yy-yy
          | C := not biterate
          | C_265 := XZX_160>=0.0
          | C_268 := not (XZX_160>=0.0)
          | C_x1 := next_stable and biterate
          | OK_281 := left_tt ( OK,stable )
          | C_cc1_297 := left_tt ( C_cc1,stable )
          | C_ := C_x1 or OK_281
          | C_d_308 := left_tt ( C_d,stable )
          | C__319 := left_tt ( C__313,stable )
          | C_a1 := C_x1 or C__319
          | C_x1_357 := C_a1 or C_cc1_297
          | C_363 := not C_d_308
          | C_367 := (not C_x1) and C__319
          | C_371 := (not C_a1) and C_cc1_297
          |)
       |)
      where 
      real a1, a2, x, x1_60, d, bb, yy, next_yy, mx, pre_next_yy, s, XZX_160, XZX_179;
      boolean OK, stable, biterate, next_stable, C, C_265, C_268, C_x1, OK_281, C_cc, C_cc1, C_cc1_297, C_, C_d, C_d_308, C__313, C__319, C_a1, C_x1_357, C_363, C_367, C_371;
      process ACT_stable =
           ( )
         (| when stable ^= C_err2_288 ^= C_327 ^= C_oc
          | (| when OK ^= bb ^= C_d ^= C__313 ^= C_324
             | ACT_OK{}
             | when C_cc ^= C_err2 ^= C_cc1
             | ACT_C_cc{}
             |)
          | (| when C_oc ^= oc
             | (| oc := (true when C_324) default (err2 when C_err2) |)
             |)
          | (| OK := a/=0.0
             | C_cc := not OK
             | C_err2_288 := left_tt ( C_err2,C_cc )
             | C_327 := left_tt ( C_324,OK )
             | C_oc := C_327 or C_err2_288
             |)
          |)
         where 
         boolean err2, C_err2, C_err2_288, C_324, C_327, C_oc;
         process ACT_OK =
              ( )
            (| when OK ^= cc ^= dd ^= aa ^= XZX ^= XZX_95
             | (| when C_d ^= d
                | (| d := dd when C_d |)
                |)
             | (| when C__313 ^= x
                | ACT_C__313{}
                |)
             | (| bb := XZX/aa
                | cc := XZX_95/aa
                | dd := (bb*bb)-(4.0*cc)
                | aa := a when OK
                | XZX := b when OK
                | XZX_95 := c when OK
                | C_d := dd>0.0
                | C__313 := dd=0.0
                | C_324 := dd<0.0
                |)
             |)
            where 
            real cc, dd, aa, XZX, XZX_95;
            process ACT_C__313 =
                 ( )
               (| when C__313 ^= XZX_102
                | (| x := (-XZX_102)/2.0
                   | XZX_102 := bb when C__313
                   |)
                |)
               where 
               real XZX_102;
               end
            %ACT_C__313%; 
            end
         %ACT_OK%; 
         process ACT_C_cc =
              ( )
            (| when C_cc ^= bb_214 ^= cc_215
             | (| when C_err2 ^= err2
                | (| err2 := (cc_215/=0.0) when C_err2 |)
                |)
             | (| when C_cc1 ^= a2
                | ACT_C_cc1{}
                |)
             | (| bb_214 := b when C_cc
                | cc_215 := c when C_cc
                | C_err2 := bb_214=0.0
                | C_cc1 := not (bb_214=0.0)
                |)
             |)
            where 
            real bb_214, cc_215;
            process ACT_C_cc1 =
                 ( )
               (| when C_cc1 ^= bb1 ^= cc1
                | (| a2 := -(cc1/bb1)
                   | bb1 := bb_214 when C_cc1
                   | cc1 := cc_215 when C_cc1
                   |)
                |)
               where 
               real bb1, cc1;
               end
            %ACT_C_cc1%; 
            end
         %ACT_C_cc%; 
         end
      %ACT_stable%; 
      process ACT_C_x1 =
           ( )
         (| when C_x1 ^= d_121 ^= bb_122
          | (| x2 := -((bb_122-d_121)/2.0)
             | x1_60 := -((bb_122+d_121)/2.0)
             | d_121 := yy when C_x1
             | bb_122 := XZX_179 when C_x1
             |)
          |)
         where 
         real d_121, bb_122;
         end
      %ACT_C_x1%; 
      end
   %ACT_Tick%; 
   end
%equationSolving_BOOL_TRA%; %(| C_273 := not (next_stable and biterate)
                              | C_275 := not stable
                              | C_278 := C_x1 or stable
                              | C_cc1_294 := left_tt ( C_cc1,C_cc )
                              | C_d_305 := left_tt ( C_d,OK )
                              | C_311 := not (dd>0.0)
                              | C__316 := left_tt ( C__313,OK )
                              | C_322 := not (dd=0.0)
                              | C_330 := left_tt ( C_324,stable )
                              | C_333 := not (dd<0.0)
                              | C_336 := C__313 or C_324
                              | C_339 := C_d or C_336
                              | C_342 := C_d or C_324
                              | C_oc_351 := left_tt ( C_oc,stable )
                              | C_354 := C_a1 or C_330
                              | C_360 := C_x1_357 or C_oc_351
                              |)***WARNING: unused signals 
%
%
