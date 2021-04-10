! Copyright (C) 2021 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors combinators kernel locals math math.functions math.parser namespaces ;


IN: steam-table

! REFERENCE DOCUMENT 1: IAPWS R7-97(2012)
! equation numbers and tables; ref.1

! CONSTANTS [ref. section 3]
CONSTANT: T-CRIT 647.096 ! [K]
CONSTANT: P-CRIT 22.064  ! [MPa]
CONSTANT: RHO-CRIT 322.  ! [kg/m3]
CONSTANT: R 0.461526     ! [kJ/kg/K]

! TABLES fo data
SYMBOL: Table2 ! [ref. 1]
{   {  1  0  -2   0.14632971213167     }
    {  2  0  -1  -0.84548187169114     }
    {  3  0   0  -0.37563603672040e1   }
    {  4  0   1   0.33855169168385e1   }
    {  5  0   2  -0.95791963387872     }
    {  6  0   3   0.15772038513228     }
    {  7  0   4  -0.16616417199501e-1  }
    {  8  0   5   0.81214629983568e-3  }
    {  9  1  -9   0.28319080123804e-3  }
    { 10  1  -7  -0.60706301565874e-3  }
    { 11  1  -1  -0.18990068218419e-1  }
    { 12  1   0  -0.32529748770505e-1  }
    { 13  1   1  -0.21841717175414e-1  } 
    { 14  1   3  -0.52838357969930e-4  }
    { 15  2  -3  -0.47184321073267e-3  }
    { 16  2   0  -0.30001780793026e-3  }
    { 17  2   1   0.47661393906987e-4  }
    { 18  2   3  -0.44141845330846e-5  }
    { 19  2  17  -0.72694996297594e-15 }
    { 20  3  -4  -0.31679644845054e-4  }
    { 21  3   0  -0.28270797985312e-5  }
    { 22  3   6  -0.85205128120103e-9  }
    { 23  4  -5  -0.22425281908000e-5  }
    { 24  4  -2  -0.65171222895601e-6  }
    { 25  4  10  -0.14341729937924e-12 }
    { 26  5  -8  -0.40516996860117e-6  }
    { 27  8 -11  -0.12734301741641e-8  }
    { 28  8  -6  -0.17424871230634e-9  }
    { 29 21 -29  -0.68762131295531e-18 }
    { 30 23 -31   0.14478307828521e-19 }
    { 31 29 -38   0.26335781662795e-22 }
    { 32 30 -39  -0.11947622640071e-22 }
    { 33 31 -40   0.18228094581404e-23 }
    { 34 32 -41  -0.93537087292458e-25 } } Table2 set





! TUPLES
TUPLE: pT { p float initial: 0.0 } { T float initial: 0.0 } ;
: <pT> ( p T -- pT ) pT boa ;

! AUXILIARY FUNCTIONS
! compare two floats to = within eps
:: fp-= ( a b eps -- ? )
        a b - abs eps < ;

! between-ranges?
:: [in-range?] ( x x-min x-max -- ? ) 
    x-min x <= 
    x x-max <= and ;

:: (in-range?] ( x x-min x-max -- ? ) 
    x-min x < 
    x x-max <= and ; 

:: [in-range?) ( x x-min x-max -- ? ) 
    x-min x <= 
    x x-max < and ;

:: (in-range?) ( x x-min x-max -- ? ) 
    x-min x < 
    x x-max < and ;

! fp-rounding of x to d decimals
:: fp-round ( x d -- x' )
    x 10 d ^ * round 10 d ^ / ; 

! boundary between region 2 and 3 [ref. section 4]

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
 
 ! table 34, IAPWS 
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
        2 C * B neg B sq 4 A C * * - .5 ^ + / 4 ^ ; ! p-sat

! saturation line region 4
! equation 29, solved for saturation temperature:
! :: T-sat ( p -- T ) p ; ! stub       
:: T-sat ( p -- T ) 
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

        p 0.25 ^ :> beta
        beta sq      n3 beta * + n6 + :> E
        n1 beta sq * n4 beta * + n7 + :> F
        n2 beta sq * n5 beta * + n8 + :> G
        2 G * F neg F sq 4 E * G * - 0.5 ^ - / :> D
        n10 D + 
            n10 D + sq n9 n10 D * + 4 * - 0.5 ^ - 
            2 / ; ! T-sat (eq. 31)

! testing for regions 1 to 5. T=[K] and p=[MPa]
! region 1 (section 5)
! valid range: 273.15 K <= T <= 623.15 K and ps(T) <= p <= 1000 MPa
! :: region1? ( pT -- ? ) pT >boolean ; ! stub
:: region1? ( pT -- ? )
    pT p>> pT T>> pT T>> p-sat :> ( p T ps )
    T 273.15 623.15 [in-range?]
    p ps 100. [in-range?] and ;

! region 2 (section 6) 
!   valid range2a: 273.15 <= T <= 623.15 and 0 < p <= ps(T)
!   valid range2b: 623.15 < T <= 863.15  and 0 < p <= p(T)  (boundary B23)
!   valid range2c: 863.15 < T <= 1073.15 and 0 < p <= 100

! :: region2a? ( pT -- ? ) pT >boolean ; ! stub
:: region2a? ( pT -- ? )
    pT p>> pT T>> pT T>> p-sat :> ( p T ps )
    T 273.15 623.15 [in-range?]
    p 0 ps (in-range?] and ;

! :: region2b? ( pT -- ? ) pT >boolean ; ! stub
:: region2b? ( pT -- ? ) 
    pT p>> pT T>> pT T>> B23-pressure :> ( p T p23 )
    T 623.15 863.15 (in-range?]
    p 0 p23 (in-range?] and ;

! :: region2c? ( pT -- ? ) pT >boolean ; ! stub
:: region2c? ( pT -- ? )
    pT p>> pT T>> :> ( p T )
    T 863.15 1073.15 (in-range?]
    p 0. 100. (in-range?] and ;

! :: region2? ( pT -- ? ) pT >boolean ; ! stub
:: region2? ( pT -- ? )
    pT region2a? 
    pT region2b?
    pT region2c? or or ;

! region 3 (section 7)
! valid range: 623.15 <= T <= T(p) and p(T) <= p <= 100
! :: region3? ( pT -- ? ) pT >boolean ; ! stub
:: region3? ( pT -- ? )
    pT p>> pT T>> 
    pT p>> B23-temperature 6 fp-round 
    pT T>> B23-pressure 6 fp-round :> ( p T T(p) p(T) )
    T 623.15 T(p) [in-range?]
    p p(T) 100. [in-range?] and ;

! region 4 (section 8)
! valid range 273.15 <= T <= 647.096
! :: region4? ( pT -- ?) pT >boolean ; ! stub
:: region4? ( pT -- ? )
    pT p>> pT T>> pT p>> T-sat :> ( p T Ts )
    T 273.15 647.096 [in-range?]
    p 611.213e-6 22.064 [in-range?] and
    T Ts 1e-6 fp-= and ;

! region 5 (section 9)
! valid range: 1073.15 <= T <= 2273.15 and 0 < p < 50
! :: region5? ( pT -- ? ) pT >boolean ; ! stub
:: region5? ( pT -- ? )
    pT p>> pT T>> :> ( p T )
    T 1073.15 2273.15 [in-range?]
    p 0 50 (in-range?] and ;
    

! !!! todo 
:: Cp ( pT -- n ) pT >boolean ; ! stub

:: Cv ( pT -- n ) pT >boolean ; ! stub 

:: Helmholz ( pT -- n ) pT >boolean ; ! stub

:: Gibbs ( pT -- n ) pT >boolean ; ! stub

:: enthalpy ( pT -- n ) pT >boolean ; ! stub

:: volume ( pT -- n ) pT >boolean ; ! stub

:: internal-energy ( pT -- n ) pT >boolean ; ! stub

:: entropy ( pT -- n ) pT >boolean ; ! stub

:: speed-of-sound ( pT -- n ) pT >boolean ; ! stub



! Region 1



! Region 2



! Region 3



! Region 5













