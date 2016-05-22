process equationSolving =
     ( ? real a;
         real b;
         real c;
       ! real x2;
         real x1;
         boolean oc;
     )
   (| (| OK := a/=0.0
       | (err1,a1,x2) := SecondDegree(OK,a,b,c)
       | (a2,err2) := FirstDegree(when (not OK),b,c)
       | (| x1 := a1 default a2
          | oc := (when err1) default err2
          |)
       | a ^= b ^= c
       |)/ err2, a2, err1, a1, OK |)
   where 
   process FirstDegree =
        ( ? boolean Compute;
            real b;
            real c;
          ! real x;
            boolean err2;
        )
      (| (| (| bb1 := bb when (bb/=0.0)
             | cc1 := cc when (bb/=0.0)
             | x := -(cc1/bb1)
             |)/ cc1, bb1
          | err2 := (cc/=0.0) when (bb=0.0)
          | (| bb := b when Compute
             | cc := c when Compute
             |)
          |)/ cc, bb |)
      where 
      bb1, cc1;
      real bb, cc;
      end
   ; 
   process SecondDegree =
        ( ? boolean OK;
            real a;
            real b;
            real c;
          ! boolean err;
            real x21;
            real x2;
        )
      (| (| (nul,err,d) := Discriminant{}(bb,cc)
          | (| aa := a when OK
             | bb := (b when OK)/aa
             | cc := (c when OK)/aa
             | c ^= b ^= a
             |)/ aa
          | x := (-(bb when nul))/2.0
          | (stable,x1,x2) := twoRoots{epsilon}(d,bb)
          | (| x2 := x
             | x21 := x1 default x2
             |) where real x2; end
          | c ^= when stable
          |)/ stable, x1, x, cc, bb, d, nul |)
      where 
      constant real epsilon = 0.00001;
      process Discriminant =
           ( ? real b;
               real c;
             ! event nul;
               boolean err;
               real d;
           )
         (| dd := (b*b)-(4.0*c)
          | d := dd when (dd>0.0)
          | nul := when (dd=0.0)
          | err := when (dd<0.0)
          |)
         where 
         real dd;
         end
      ; 
      process twoRoots =
           { real eps; }
           ( ? real discr;
               real b;
             ! boolean stable;
               real x1;
               real x2;
           )
         (| (| (stable,d) := rac{eps}(discr)
             | bb := (b cell (^d)) when (^d)
             | x2 := -((bb-d)/2.0)
             | x1 := -((bb+d)/2.0)
             |)/ bb, d |)
         where 
         process rac =
              { real epsilon; }
              ( ? real x;
                ! boolean stable;
                  real y;
              )
            (| (| (| mx := x cell (^yy)
                   | next_yy := (((yy+(mx/yy))/2.0) when biterate) default yy
                   | yy := (x/2.0) default (next_yy$1 init 1.0)
                   |)/ mx
                | (| biterate := (^x) default (not stable)
                   | next_stable := abs(next_yy-yy)<epsilon
                   | stable := next_stable$1 init true
                   | yy ^= stable
                   | y := yy when (next_stable and biterate)
                   |)/ next_stable
                |)/ biterate, next_yy, yy |)
            where 
            process abs =
                 ( ? x;
                   ! s;
                 )
               (| s := (x when (x>=0.0)) default (-x) |)
            ; 
            real yy, next_yy, mx;
            boolean next_stable, biterate;
            end
         ; 
         real d;
         bb;
         end
      ; 
      event nul;
      real d, bb, aa, cc, x;
      x1, stable;
      end
   ; 
   boolean OK, err1;
   real a1, a2;
   err2;
   end
; 
