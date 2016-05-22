process equationSolving_TRA =
     ( ? real a, b, c;
       ! real x2, x1;
         boolean oc;
     )
   pragmas 
      Main
   end pragmas
   (| (| CLK_stable := ^CLK_stable
       | ACT_CLK_stable{}
       |) |)
   where 
   constant real epsilon = 0.00001;
   event CLK_stable;
   process ACT_CLK_stable =
        ( )
      (| CLK_stable ^= stable ^= yy ^= next_yy ^= biterate ^= mx ^= pre_next_yy ^= next_stable ^= s ^= XZX_160
       | (| CLK_56 := when biterate
          | CLK_57 := when (not biterate)
          |)
       | (| CLK_73 := when (XZX_160>=0.0)
          | CLK_74 := when (not (XZX_160>=0.0))
          |)
       | (| CLK_x2 := when (next_stable and biterate)
          | CLK_x2 ^= x2 ^= x1_60
          | ACT_CLK_x2{}
          |)
       | (| CLK_a := when stable
          | CLK_a ^= a ^= b ^= c
          | ACT_CLK_a{}
          |)
       | (| CLK_XZX_179 := CLK_x2 ^+ CLK_bb
          | CLK_XZX_179 ^= XZX_179
          | (| XZX_179 := (bb when CLK_bb) cell CLK_XZX_179 init 0.0e0 |)
          |)
       | (| CLK_a1 := CLK_x2 ^+ CLK_x
          | CLK_a1 ^= a1
          | (| a1 := (x1_60 when CLK_x2) default (x when CLK_170) |)
          |)
       | (| CLK_x1 := CLK_a1 ^+ CLK_a2
          | CLK_x1 ^= x1
          | (| x1 := (a1 when CLK_a1) default (a2 when CLK_173) |)
          |)
       | (| CLK_167 := CLK_stable ^- CLK_d |)
       | (| CLK_170 := CLK_x ^- CLK_x2 |)
       | (| CLK_173 := CLK_a2 ^- CLK_a1 |)
       | (| stable := next_stable$1 init true
          | yy := ((d/2.0) when CLK_d) default (pre_next_yy when CLK_167)
          | next_yy := (((yy+(mx/yy))/2.0) when CLK_56) default (yy when CLK_57)
          | biterate := CLK_d default ((not stable) when CLK_167)
          | mx := (d when CLK_d) cell CLK_stable init 0.0e0
          | pre_next_yy := next_yy$1 init 1.0
          | next_stable := s<epsilon
          | s := (XZX_160 when CLK_73) default ((-XZX_160) when CLK_74)
          | XZX_160 := next_yy-yy
          |)
       |)
      where 
      event CLK_173, CLK_170, CLK_167, CLK_x1, CLK_a1, CLK_XZX_179, CLK_a2, CLK_a, CLK_x2, CLK_74, CLK_73, CLK_57, CLK_56, CLK_bb, CLK_x, CLK_d;
      boolean stable, biterate, next_stable;
      real a1, a2, x, x1_60, d, bb, yy, next_yy, mx, pre_next_yy, s, XZX_160, XZX_179;
      process ACT_CLK_x2 =
           ( )
         (| CLK_x2 ^= d_121 ^= bb_122
          | (| x2 := -((bb_122-d_121)/2.0)
             | x1_60 := -((bb_122+d_121)/2.0)
             | d_121 := yy when CLK_x2
             | bb_122 := XZX_179 when CLK_x2
             |)
          |)
         where 
         real d_121, bb_122;
         end
      %ACT_CLK_x2%; 
      process ACT_CLK_a =
           ( )
         (| CLK_a ^= OK
          | (| CLK_bb := when OK
             | CLK_bb ^= bb
             | ACT_CLK_bb{}
             | CLK_bb_214 := when (not OK)
             | ACT_CLK_bb_214{}
             |)
          | (| CLK_oc := err1 ^+ CLK_err2
             | CLK_oc ^= oc
             | (| oc := err1 default (err2 when CLK_err2) |)
             |)
          | (| OK := a/=0.0 |)
          |)
         where 
         event CLK_oc, CLK_err2, CLK_bb_214, err1;
         boolean OK, err2;
         process ACT_CLK_bb =
              ( )
            (| CLK_bb ^= cc ^= dd ^= aa ^= XZX ^= XZX_95
             | (| CLK_d := when (dd>0.0)
                | CLK_d ^= d
                | (| d := dd when CLK_d |)
                |)
             | (| CLK_x := when (dd=0.0)
                | CLK_x ^= x
                | ACT_CLK_x{}
                |)
             | (| err1 := when (dd<0.0) |)
             | (| bb := XZX/aa
                | cc := XZX_95/aa
                | dd := (bb*bb)-(4.0*cc)
                | aa := a when CLK_bb
                | XZX := b when CLK_bb
                | XZX_95 := c when CLK_bb
                |)
             |)
            where 
            real cc, dd, aa, XZX, XZX_95;
            process ACT_CLK_x =
                 ( )
               (| CLK_x ^= XZX_102
                | (| x := (-XZX_102)/2.0
                   | XZX_102 := bb when CLK_x
                   |)
                |)
               where 
               real XZX_102;
               end
            %ACT_CLK_x%; 
            end
         %ACT_CLK_bb%; 
         process ACT_CLK_bb_214 =
              ( )
            (| CLK_bb_214 ^= bb_214 ^= cc_215
             | (| CLK_err2 := when (bb_214=0.0)
                | CLK_err2 ^= err2
                | (| err2 := (cc_215/=0.0) when CLK_err2 |)
                | CLK_a2 := when (not (bb_214=0.0))
                | CLK_a2 ^= a2
                | ACT_CLK_a2{}
                |)
             | (| bb_214 := b when CLK_bb_214
                | cc_215 := c when CLK_bb_214
                |)
             |)
            where 
            real bb_214, cc_215;
            process ACT_CLK_a2 =
                 ( )
               (| CLK_a2 ^= bb1 ^= cc1
                | (| a2 := -(cc1/bb1)
                   | bb1 := bb_214 when CLK_a2
                   | cc1 := cc_215 when CLK_a2
                   |)
                |)
               where 
               real bb1, cc1;
               end
            %ACT_CLK_a2%; 
            end
         %ACT_CLK_bb_214%; 
         end
      %ACT_CLK_a%; 
      end
   %ACT_CLK_stable%; 
   end
%equationSolving_TRA%; 
