*et rmsg on
use logan

program define mlr
  args lnf eta2 eta3 eta4 eta5
  tempvar pi1 pi2 pi3 pi4 pi5
  quietly {
    gen double
`pi1'=1/(1+exp(`eta2')+exp(`eta3')+exp(`eta4')+exp(`eta5'))
    gen double `pi2'=exp(`eta2')*`pi1'
    gen double `pi3'=exp(`eta3')*`pi1'
    gen double `pi4'=exp(`eta4')*`pi1'
    gen double `pi5'=exp(`eta5')*`pi1'
    replace `lnf'=($ML_y1==1)*ln(`pi1')+ /*
               */ ($ML_y1==2)*ln(`pi2')+ /*
               */ ($ML_y1==3)*ln(`pi3')+ /*
               */ ($ML_y1==4)*ln(`pi4')+ /*
               */ ($ML_y1==5)*ln(`pi5')
  }
end

ml model lf mlr (occ2: educ black) /*
*/ (occ3: educ black) (occ4: educ black) (occ5: occ=educ black)
ml maximize 


* First I create the indicator variable
tempvar i1 i2 i3 i4 i5
forvalues x=1/5 {
  gen i`x'=0
  replace i`x'=1 if `x'==rep78
}

**************************************
***                  PROGRAM 1                      ***
**************************************
capture program drop jologit
program define jologit
  args lnf k1 k2 k3 k4
  tempvar p1 p2 p3 p4 d1 d2 d3 d4
  forvalues z=1/4 {
    gen double `p`z''=1+exp(`k`z'')
    gen double `d`z''=1/`p`z''
  }
  replace
`lnf'=$ML_y1*log(`d1')+$ML_y2*log(`d2'-`d1')+$ML_y3*log(`d3'-`d2')+$ML_y4*log(`d4'-`d3')+$ML_y5*log(1-`d4')
end

ml model lf jologit (i1 i2 i3 i4 i5= price mpg foreign) () () ()
ml check
ml maximize

recode rep78 1/2=3
mlogit rep78 price mpg foreign
 
gen rep3 = rep78==3 if rep78 <.
gen rep4 = rep78==4 if rep78 <.
gen rep5 = rep78==5 if rep78 <.

global y3 "rep3"
global y4 "rep4"
global y5 "rep5"

capture program drop fmlogit_lf
program define fmlogit_lf
     *! 1.0.0 MLB 23 Apr 2007
      version 8.2
      args lnf xb4 xb5 
      tempvar p3 p4 p5

      quietly {
            gen double `p3' = 1/(1+exp(`xb4')+exp(`xb5'))
            gen double `p4' = exp(`xb4')/(1+exp(`xb4')+exp(`xb5'))
            gen double `p5' = exp(`xb5')/(1+exp(`xb4')+exp(`xb5'))
            replace `lnf' = $y3*ln(`p3') + $y4*ln(`p4') + $y5*ln(`p5')
      }
end

ml model lf fmlogit_lf (xb4:rep78 = price mpg foreign) /*
*/ (xb5:price mpg foreign)
ml check
ml search
ml maximize




sysuse auto

capture program drop mymle1
program define mymle1
       version 8.0
       args lnf  theta1 th2 th3
       quietly replace `lnf' = ln(exp(`theta1' ^ (`th2' / `th3'))/       /*
                               */(1+exp(`theta1' ^ (`th2' / `th3'))))    /*
                     */ if $ML_y1 == 1
       quietly replace `lnf' = ln(1/(1+exp(`theta1' ^ (`th2' / `th3')))) /*
                     */ if $ML_y1  == 0

end

ml model lf mymle1 (for  = pr mpg wei) (h = headroom) (g = gear_ratio)
ml search
ml maximize



logit for pri mpg wei
