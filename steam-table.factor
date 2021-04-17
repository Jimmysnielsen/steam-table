! Copyright (C) 2021 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors combinators kernel locals math math.functions math.parser namespaces sequences ;


IN: steam-table

! REFERENCE DOCUMENT 1: IAPWS R7-97(2012)
! equation numbers and tables; ref.1

! CONSTANTS [ref. section 3]
CONSTANT: T-CRIT 647.096 ! [K]
CONSTANT: P-CRIT 22.064  ! [MPa]
CONSTANT: RHO-CRIT 322.  ! [kg/m3]
CONSTANT: R 0.461526     ! [kJ/kg/K]

! TABLES for data
SYMBOL: Table2 ! [ref. 1, calculation of Gibbs free energy for region 1] 
!      i  Ii  Ji  ni
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

SYMBOL: Table6 ! [ref. 1, backwards equation T(p,h) for region 1]
!   i Ii Ji
{   {  1 0  0 -0.23872489924521e3  }
    {  2 0  1  0.40421188637945e3  }
    {  3 0  2  0.11349746881718e3  } 
    {  4 0  6 -0.58457616048039e1  } 
    {  5 0 22 -0.15285482413140e-3 } 
    {  6 0 32 -0.10866707695377e-5 } 
    {  7 1  0 -0.13391744872602e2  } 
    {  8 1  1  0.43211039183559e2  } 
    {  9 1  2 -0.54010067170506e2  } 
    { 10 1  3  0.30535892203916e2  } 
    { 11 1  4 -0.65964749423638e1  } 
    { 12 1 10  0.93965400878363e-2 } 
    { 13 1 32  0.11573647505340e-6 } 
    { 14 2 10 -0.25858641282073e-4 } 
    { 15 2 32 -0.40644363084799e-8 } 
    { 16 3 10  0.66456186191635e-7 } 
    { 17 3 32  0.80670734103027e-10 } 
    { 18 4 32 -0.93477771213947e-12 } 
    { 19 5 32  0.58265442020601e-14 } 
    { 20 6 32 -0.15020185953503e-16 } } Table6 set

SYMBOL: Table8 ! [ ref.1, backwards equation T(p,s) for region 1]
!   i Ii Ji ni
{   {  1 0  0  0.17478268058307e3 } 
    {  2 0  1  0.34806930892873e2 } 
    {  3 0  2  0.65292584978455e1 } 
    {  4 0  3  0.33039981775489 } 
    {  5 0 11 -0.19281382923196e-6 } 
    {  6 0 31 -0.24909197244573e-22 } 
    {  7 1  0 -0.26107636489332 } 
    {  8 1  1  0.22592965981586 } 
    {  9 1  2 -0.64256463395226e-1 } 
    { 10 1  3  0.78876289270526e-2 } 
    { 11 1 12  0.35672110607366e-9 } 
    { 12 1 31  0.17332496994895e-23 } 
    { 13 2  0  0.56608900654837e-3 } 
    { 14 2  1 -0.32635483139717e-3 } 
    { 15 2  2  0.44778286690632e-4 } 
    { 16 2  9 -0.51322156908507e-9 } 
    { 17 2 31 -0.42522657042207e-25 } 
    { 18 3 10  0.26400441360689e-12 } 
    { 19 3 32  0.78124600459723e-28 } 
    { 20 4 32 -0.30732199903668e-30 } } Table8 set

SYMBOL: Table10 ! [ref.1, coeffs for gamma_ideal region2]
! i Ji ni
{   { 1  0 -0.96927686500217e1 }
    { 2  1  0.10086655968018e2 }
    { 3 -5 -0.56087911283020e-2 }
    { 4 -4  0.71452738081455e-1 }
    { 5 -3 -0.40710498223928 }
    { 6 -2  0.14240819171444e1 }
    { 7 -1 -0.43839511319450e1 }
    { 8  2 -0.28408632460772 }
    { 9  3  0.21268463753307e-1 } } Table10 set 

SYMBOL: Table11 ! [ref.1 coeffs for gamma_residual region2]
!   i Ii Ji ni
{  {  1  1  0 -0.17731742473213e-2 } 
   {  2  1  1 -0.17834862292358e-1 } 
   {  3  1  2 -0.45996013696365e-1 } 
   {  4  1  3 -0.57581259083432e-1 } 
   {  5  1  6 -0.50325278727930e-1 } 
   {  6  2  1 -0.33032641670203e-4 } 
   {  7  2  2 -0.18948987516315e-3 } 
   {  8  2  4 -0.39392777243355e-2 } 
   {  9  2  7 -0.43797295650573e-1 } 
   { 10  2 36 -0.26674547914087e-4 } 
   { 11  3  0  0.20481737692309e-7 } 
   { 12  3  1  0.43870667284435e-6 } 
   { 13  3  3 -0.32277677238570e-4 } 
   { 14  3  6 -0.15033924542148e-2 } 
   { 15  3 35 -0.40668253562649e-1 } 
   { 16  4  1 -0.78847309559367e-9 } 
   { 17  4  2  0.12790717852285e-7 } 
   { 18  4  3  0.48225372718507e-6 } 
   { 19  5  7  0.22922076337661e-5 } 
   { 20  6  3 -0.16714766451061e-10 } 
   { 21  6 16 -0.21171472321355e-2 } 
   { 22  6 35 -0.23895741934104e2 }  ! !!! should this be e-2 ??
   { 23  7  0 -0.59059564324270e-17 } 
   { 24  7 11 -0.12621808899101e-5 } 
   { 25  7 25 -0.38946842435739e-1 } 
   { 26  8  8  0.11256211360459e-10 } 
   { 27  8 36 -0.82311340897998e1 } ! !!! should this be e-1 ?? 
   { 28  9 13  0.19809712802088e-7 } 
   { 29 10  4  0.10406965210174e-18 } 
   { 30 10 10 -0.10234747095929e-12 } 
   { 31 10 14 -0.10018179379511e-8 } 
   { 32 16 29 -0.80882908646985e-10 } 
   { 33 16 50  0.10693031879409 } 
   { 34 18 57 -0.33662250574171 } 
   { 35 20 20  0.89185845355421e-24 } 
   { 36 20 35  0.30629316876232e-12 } 
   { 37 20 48 -0.42002467698208e-5 } 
   { 38 21 21 -0.59056029685639e-25 } 
   { 39 22 53  0.37826947613457e-5 } 
   { 40 23 39 -0.12768608934681e-14 } 
   { 41 24 26  0.73087610595061e-28 } 
   { 42 24 40  0.55414715350778e-16 } 
   { 43 24 58 -0.94369707241210e-6 } } Table11 set

SYMBOL: Table16 ! [ref.1 coeffs for eq.19, metastable region2]
!   i Ii Ji ni
{  {  1 1  0 -0.73362260186506e-2 }
   {  2 1  2 -0.88223831943146e-1 }
   {  3 1  5 -0.72334555213245e-1 }
   {  4 1 11 -0.40813178534455e-2 }
   {  5 2  1  0.20097803380207e-2 }
   {  6 2  7 -0.53045921898642e-1 }
   {  7 2 16 -0.76190409086970e-2 }
   {  8 3  4 -0.63498037657313e-2 }
   {  9 3 16 -0.86043093028588e-1 }
   { 10 4  7  0.75321581522770e-2 }
   { 11 4 10 -0.79238375446139e-2 }
   { 12 5  9 -0.22888160778447e-3 }
   { 13 5 10 -0.26456501482810e-2 } } Table16 set

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
    




! Region 1 basic equation

! :: (gibbs1) ( seq p' T' -- n ) 1 ; ! stub 
:: (gibbs1) ( seq p' T' -- n )  ! [ref.1 equation 7 right hand side]
    seq first4 :> ( i Ii Ji ni )
    ni 7.1 p' - Ii ^ * T' 1.222 - Ji ^ * ;

:: gibbs1 ( pT -- n ) ! [ref.1 equation 7 and table 4]
    pT p>> 16.53 / :> p' 
    1386. pT T>> / :> T'
    Table2 get [ p' T' (gibbs1) ] [ + ] map-reduce R * pT T>> * ; ! [ref.1 equation 7]

! table 4, gamma
:: (gamma) ( seq p' T' -- n )
    seq first4 :> ( n Ii Ji ni )
    ni 7.1 p' - Ii ^ * T' 1.222 - Ji ^ * ;

:: gamma ( p' T' -- n )
    Table2 get [ p' T' (gamma) ] [ + ] map-reduce ;

! table 4, gamma_pi
:: (gamma_pi) ( seq p' T' -- n )
    seq first4 :> ( n Ii Ji ni )
    ni neg Ii * 7.1 p' - Ii 1 - ^ * T' 1.222 - Ji ^ * ; 

:: gamma_pi ( p' T' -- n )
    Table2 get [ p' T' (gamma_pi) ] [ + ] map-reduce ;

! table 4, gamma_pi_pi
:: (gamma_pi_pi) ( seq p' T' -- n )
    seq first4 :> ( n Ii Ji ni )
    ni Ii * Ii 1 - * 7.1 p' - Ii 2 - ^ * T' 1.222 - Ji ^ * ;

:: gamma_pi_pi ( p' T' -- n )
    Table2 get [ p' T' (gamma_pi_pi) ] [ + ] map-reduce ;

! table 4, gamma_tau
:: (gamma_tau) ( seq p' T' -- n )
    seq first4 :> ( n Ii Ji ni )
    ni 7.1 p' - Ii ^ * Ji * T' 1.222 - Ji 1 - ^ * ;

:: gamma_tau ( p' T' -- n )
    Table2 get [ p' T' (gamma_tau) ] [ + ] map-reduce ;

! table 4, gamma_tau_tau
:: (gamma_tau_tau) ( seq p' T' -- n )
    seq first4 :> ( n Ii Ji ni )
    ni 7.1 p' - Ii ^ * Ji * Ji 1 - * T' 1.222 - Ji 2 - ^ * ;

:: gamma_tau_tau ( p' T' -- n )
    Table2 get [ p' T' (gamma_tau_tau) ] [ + ] map-reduce ;

! table 4, gamma_pi_tau
:: (gamma_pi_tau) ( seq p' T' -- n )
    seq first4 :> ( n Ii Ji ni )
    ni neg Ii * 7.1 p' - Ii 1 - ^ * Ji * T' 1.222 - Ji 1 - ^ * ;

:: gamma_pi_tau ( p' T' -- n )
    Table2 get [ p' T' (gamma_pi_tau) ] [ + ] map-reduce ;

! calculate properties for region1
! !!! volume
! :: volume-region1 ( <pT> -- n )
  !  pT p>> 16.53 / :> p'
  !  1386. pT T>> / :> T'


! !!! enthalpy

! !!! internal energy

! !!! entropy

! !!! Cp

! !!! Cv

! speed of sound


! Region 1 backward equation T(p,h) [ref.1 equation 11]
:: (T(p,h)) ( seq p' h' -- T )
    seq first4 :> ( i Ii Ji ni )
    ni p' Ii ^ *  h' 1 + Ji ^ * ;

:: T(p,h) ( p h -- n )
    p 1. / :> p' 
    h 2500. / :> h'
    Table6 get [ p' h' (T(p,h)) ] [ + ] map-reduce ;

! Region 1 backward equation T(p,s) [ref.1 eqaution 13]

:: (T(p,s)) ( seq p' s' -- n )
    seq first4 :> ( i Ii Ji ni )
    ni p' Ii ^ * s' 2 + Ji ^ * ; 

:: T(p,s) ( p s -- T ) 
    p 1. / :> p'
    s 1. / :> s'
    Table8 get [ p' s' (T(p,s)) ] [ + ] map-reduce ;




! Region 2 basic equation

:: (gamma2_ideal) ( seq p' T' -- n ) ! [ref.1 eq.16]
    seq first3 :> ( i Ji ni )
    ni T' Ji ^ * ;
! :: gamma2_ideal ( p' T' -- n ) p' T' * ; ! stub !!! [ref.1 eq.16]
:: gamma2_ideal ( p' T' -- n ) 
    Table2 get [ p' T' (gamma2_ideal) ] [ + ] map-reduce 
    p' log + ;

:: (gamma2_residual)  ( seq p' T' -- n )
    seq first4 :> ( i Ii Ji ni )
    ni p' Ii ^ * T' 0.5 - Ji ^ * ; ! [reef.1 eq.17]

! :: gamma2_residual ( p' T' -- n ) p' T' * ; ! stub !!! [ref.1 eq.17]
:: gamma2_residual ( p' T' -- n )
    Table11 get [ p' T' (gamma2_residual) ] [ + ] map-reduce ;

:: gamma2 ( p' T' -- n ) [ gamma2_ideal ] [ gamma2_residual ] bi + ; ! stub [ref.1 eq.15]

! :: gibbs2 ( -- ) ; !!! [ref.1 eq.15]


! Region 3 basic equation



! Region 5 basic equation







! !!! todo 
:: Cp-region1 ( pT -- n ) <pT> p>> ; ! stub !!!
:: Cp-region2 ( pT -- n ) <pT> p>> ; ! stub !!!
:: Cp-region3 ( pT -- n ) <pT> p>> ; ! stub !!!
:: Cp-region5 ( pT -- n ) <pT> p>> ; ! stub !!!
! :: Cp ( pT -- n ) pT p>> pT T>> * ; ! stub
:: Cp ( pT -- n )
    {   { [ pT region1? ] [ pT Cp-region1 ] } 
        { [ pT region2? ] [ pT Cp-region2 ] }
        { [ pT region3? ] [ pT Cp-region3 ] }
        { [ pT region5? ] [ pT Cp-region5 ] } } cond ;

:: Cv-region1 ( pT -- n ) <pT> p>> ; ! stub !!!
:: Cv-region2 ( pT -- n ) <pT> p>> ; ! stub !!!
:: Cv-region3 ( pT -- n ) <pT> p>> ; ! stub !!!
:: Cv-region5 ( pT -- n ) <pT> p>> ; ! stub !!!
! :: Cv ( pT -- n ) pT p>> pT T>> * ; ! stub 
:: Cv ( pT -- n ) 
    {   { [ pT region1? ] [ pT Cv-region1 ] } 
        { [ pT region2? ] [ pT Cv-region2 ] }
        { [ pT region3? ] [ pT Cv-region3 ] }
        { [ pT region5? ] [ pT Cv-region5 ] } } cond ;

:: enthalpy-region1 ( pT -- n ) <pT> p>> ; ! stub !!!
:: enthalpy-region2 ( pT -- n ) <pT> p>> ; ! stub !!!
:: enthalpy-region3 ( pT -- n ) <pT> p>> ; ! stub !!!
:: enthalpy-region5 ( pT -- n ) <pT> p>> ; ! stub !!!
! :: enthalpy ( pT -- n ) pT p>> pT T>> * ; ! stub
:: enthalpy ( pT -- n )
    {   { [ pT region1? ] [ pT enthalpy-region1 ] } 
        { [ pT region2? ] [ pT enthalpy-region2 ] }
        { [ pT region3? ] [ pT enthalpy-region3 ] }
        { [ pT region5? ] [ pT enthalpy-region5 ] } } cond ;

:: volume-region1 ( pT -- n ) <pT> p>> ; ! stub !!!
:: volume-region2 ( pT -- n ) <pT> p>> ; ! stub !!!
:: volume-region3 ( pT -- n ) <pT> p>> ; ! stub !!!
:: volume-region5 ( pT -- n ) <pT> p>> ; ! stub !!!
! :: volume ( pT -- n ) pT >boolean ; ! stub
:: volume ( pT -- n )
    {   { [ pT region1? ] [ pT volume-region1 ] } 
        { [ pT region2? ] [ pT volume-region2 ] }
        { [ pT region3? ] [ pT volume-region3 ] }
        { [ pT region5? ] [ pT volume-region5 ] } } cond ;

:: internal-energy-region1 ( pT -- n ) <pT> p>> ; ! stub !!!
:: internal-energy-region2 ( pT -- n ) <pT> p>> ; ! stub !!!
:: internal-energy-region3 ( pT -- n ) <pT> p>> ; ! stub !!!
:: internal-energy-region5 ( pT -- n ) <pT> p>> ; ! stub !!!
! :: internal-energy ( pT -- n ) pT p>> pT T>> * ; ! stub
:: internal-energy ( pT -- n )
    {   { [ pT region1? ] [ pT internal-energy-region1 ] } 
        { [ pT region2? ] [ pT internal-energy-region2 ] }
        { [ pT region3? ] [ pT internal-energy-region3 ] }
        { [ pT region5? ] [ pT internal-energy-region5 ] } } cond ;

:: entropy-region1 ( pT -- n ) <pT> p>> ; ! stub !!!
:: entropy-region2 ( pT -- n ) <pT> p>> ; ! stub !!!
:: entropy-region3 ( pT -- n ) <pT> p>> ; ! stub !!!
:: entropy-region5 ( pT -- n ) <pT> p>> ; ! stub !!!
! :: entropy ( pT -- n ) pT p>> pT T>> * ; ! stub
:: entropy ( pT -- n )
    {   { [ pT region1? ] [ pT entropy-region1 ] } 
        { [ pT region2? ] [ pT entropy-region2 ] }
        { [ pT region3? ] [ pT entropy-region3 ] }
        { [ pT region5? ] [ pT entropy-region5 ] } } cond ;

:: speed-of-sound-region1 ( pT -- n ) <pT> p>> ; ! stub !!!
:: speed-of-sound-region2 ( pT -- n ) <pT> p>> ; ! stub !!!
:: speed-of-sound-region3 ( pT -- n ) <pT> p>> ; ! stub !!!
:: speed-of-sound-region5 ( pT -- n ) <pT> p>> ; ! stub !!!
! :: speed-of-sound ( pT -- n ) pT p>> pT T>> * ; ! stub
:: speed-of-sound ( pT -- n )
    {   { [ pT region1? ] [ pT speed-of-sound-region1 ] } 
        { [ pT region2? ] [ pT speed-of-sound-region2 ] }
        { [ pT region3? ] [ pT speed-of-sound-region3 ] }
        { [ pT region5? ] [ pT speed-of-sound-region5 ] } } cond ;









