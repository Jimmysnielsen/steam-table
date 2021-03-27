! Copyright (C) 2021 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: locals math math.functions math.parser ;
IN: steam-table

! CONSTANTS
CONSTANT: T-CRIT 647.096 ! [K]
CONSTANT: P-CRIT 22.064  ! [MPa]
CONSTANT: RHO-CRIT 322.  ! [kg/m3]
CONSTANT: R 0.461526     ! [kJ/kg/K]

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
 


