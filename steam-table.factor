! Copyright (C) 2021 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel locals math math.functions math.parser ;
IN: steam-table

! CONSTANTS
CONSTANT: T-CRIT 647.096 ! [K]
CONSTANT: P-CRIT 22.064  ! [MPa]
CONSTANT: RHO-CRIT 322.  ! [kg/m3]
CONSTANT: R 0.461526     ! [kJ/kg/K]

! TUPLES
TUPLE: pT p T ;
: <pT> ( p T -- pT ) pT boa ;

! auxiliary
! compare two floats to = within eps
:: fp-= ( a b eps -- ? )
        a b - abs eps < ;

! boundary between region 2 and 3
! : B23-pressure ( T -- p ) 1 ; ! stub
:: B23-pressure ( T -- p ) 
         0.34805185628969e3  :> n1
        -0.11671859879975e1  :> n2
         0.10192970039326e-2 :> n3
        n1 n2 T * + n3 T sq * + ;

! : B23-temperature ( p -- T ) 1 ; ! stub
:: B23-temperature ( p -- T ) 
        0.10192970039326e-2 :> n3
        0.57254459862746e3  :> n4
        0.13918839778870e2  :> n5
        n4 p n5 - n3 / sqrt + ;
 
! saturation line region 4
! equation (29), solved for saturation pressure:
! :: p-sat ( T -- p ) T ; ! stub
:: p-sat ( T-sat -- P-sat ) 
         0.11670521452767e4 :> n1
        -0.72421316703206e6 :> n2
        -0.17073846940092e2 :> n3
         0.12020824702470e5 :> n4
        -0.32325550323333e7 :> n5
         0.14915108613530e2 :> n6
        -0.48232657361591e4 :> n7
         0.40511340542057e6 :> n8
        -0.23855557567849   :> n9
         0.65017534844798e3 :> n10

        T-sat n9 T-sat n10 - / + :> ny
        ny sq n1 ny * + n2 + :> A
        ny sq n3 * n4 ny * + n5 + :> B
        n6 ny sq * n7 ny * + n8 + :> C

        2 C * 
        B neg 
          B sq 4 A C * * - .5 ^ + / 4 ^ ; ! p-sat
        
