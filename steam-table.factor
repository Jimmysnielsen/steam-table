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

SYMBOL: Table20 ! [ref.1 coeffs for eq.22, backwards equation T(p,H) region2]
!   i Ii Ji ni
{   {  1 0  0  0.10898952318288e4 }
    {  2 0  1  0.84951654495535e3 }
    {  3 0  2 -0.10781748091826e3 }
    {  4 0  3  0.33153654801263e2 }
    {  5 0  7 -0.74232016790248e1 }
    {  6 0 20  0.11765048724356e2 }
    {  7 1  0  0.18445749355790e1 }
    {  8 1  1 -0.41792700549624e1 }
    {  9 1  2  0.62478196935812e1 }
    { 10 1  3 -0.17344563108114e2 }
    { 11 1  7 -0.20058176862096e3 }
    { 12 1  9  0.27196065473796e3 }
    { 13 1 11 -0.45511318285818e3 }
    { 14 1 18  0.30919688604755e4 }
    { 15 1 44  0.25226640357872e6 }
    { 16 2  0 -0.61707422868339e-2 }
    { 17 2  2 -0.31078046629583 }
    { 18 2  7  0.11670873077107e2 }
    { 19 2 26  0.12812798404046e9 }
    { 20 2 38 -0.98554909623276e9 }
    { 21 2 40  0.28224546973002e10 }
    { 22 2 42 -0.35948971410703e10 }
    { 23 2 44  0.17227349913197e10 }
    { 24 3 24 -0.13551334340775e5 }
    { 25 3 44  0.12848734664650e8 }
    { 26 4 12  0.13865724283226e1 }
    { 27 4 32  0.23598832556514e6 }
    { 28 4 44 -0.13105236545054e8 }
    { 29 5 32  0.73999835474766e4 }
    { 30 5 36 -0.55196697030060e6 }
    { 31 5 42  0.37154085996233e7 }
    { 32 6 34  0.19127729239660e5 }
    { 33 6 44 -0.41535164835634e6 }
    { 34 7 28 -0.62459855192507e2 } } Table20 set

SYMBOL: Table21 ! [ref.1 coeffs for eq. 23]
! i Ii Ji ni
{ 
   {  1 0  0  0.14895041079516e4 }
   {  2 0  1  0.74307798314034e3 }
   {  3 0  2 -0.97708318797837e2 }
   {  4 0 12  0.24742464705674e1 }
   {  5 0 18 -0.63281320016026 }
   {  6 0 24  0.11385952129658e1 }
   {  7 0 28 -0.47811863648625 }
   {  8 0 40  0.85208123431544e-2 }
   {  9 1  0  0.93747147377932 }
   { 10 1  2  0.33593118604916e1 }
   { 11 1  6  0.33809355601454e1 }
   { 12 1 12  0.16844539671904 }
   { 13 1 18  0.73875745236695 }
   { 14 1 24 -0.47128737436186 }
   { 15 1 28  0.15020273139707 }
   { 16 1 40 -0.21764114219750e-2 }
   { 17 2  2 -.21810755324761e-1 }
   { 18 2  8 -0.10829784403677 }
   { 19 2 18 -0.46333324635812e-1 }
   { 20 2 40  0.71280351959551e-4 }
   { 21 3  1  0.11032831789999e-3 }
   { 22 3  2  0.18955248387902e-3 }
   { 23 3 12  0.30891541160537e-2 }
   { 24 3 24  0.13555504554949e-2 }
   { 25 4  2  0.28640237477456e-6 }
   { 26 4 12 -0.10779857357512e-4 }
   { 27 4 18 -0.76462712454814e-4 }
   { 28 4 24  0.14052392818316e-4 }
   { 29 4 28 -0.31083814331434e-4 }
   { 30 4 40 -0.10302738212103e-5 }
   { 31 5 18  0.28217281635040e-6 }
   { 32 5 24  0.12704902271945e-5 }
   { 33 5 40  0.73803353468292e-7 }
   { 34 6 28 -0.11030139238909e-7 }
   { 35 7  2 -0.81456365207833e-13 }
   { 36 7 28 -0.25180545682962e-10 }
   { 37 9  1 -0.17565233969407e-17 }
   { 38 9 40  0.86934156344163e-14 } } Table21 set

SYMBOL: Table22 ! [ref.1 coeffs for eq. 24]
!   i Ii  Ji ni
{   {  1 -7  0 -0.32368398555242e13 }
    {  2 -7  4  0.73263350902181e13 }
    {  3 -6  0  0.35825089945447e12 }
    {  4 -6  2 -0.58340131851590e12 }
    {  5 -5  0 -0.10783068217470e11 }
    {  6 -5  2  0.20825544563171e11 }
    {  7 -2  0  0.61074783564516e6 }
    {  8 -2  1  0.85977722535580e6 }
    {  9 -1  0 -0.25745723604170e5 }
    { 10 -1  2  0.31081088422714e5 }
    { 11  0  0  0.12082315865936e4 }
    { 12  0  1  0.48219755109255e3 }
    { 13  1  4  0.37966001272486e1 }
    { 14  1  8 -0.10842984880077e2 }
    { 15  2  4 -0.45364172676660e-1 }
    { 16  6  0  0.14559115658698e-12 }
    { 17  6  1  0.11261597407230e-11 }
    { 18  6  4 -0.17804982240686e-10 }
    { 19  6 10  0.12306979690832e-6 }   
    { 20  6 12 -0.11606921130984e-5 }
    { 21  6 16  0.27846367088554e-4 }
    { 22  6 20 -0.59270038474176e-3 }
    { 23  6 22  0.12918582991878e-2 } } Table22 set

SYMBOL: Table25 ! [ref.1 coeffs for eq.25]
! i Ii Ji ni
{   {  1 -1.5  -24 -0.39235983861984e6 }
    {  2 -1.5  -23  0.51526573827270e6 }
    {  3 -1.5  -19  0.40482443161048e5 }
    {  4 -1.5  -13 -0.32193790923902e3 }
    {  5 -1.5  -11  0.96961424218694e2 }
    {  6 -1.5  -10 -0.22867846371773e2 }
    {  7 -1.25 -19 -0.44942914124357e6 }
    {  8 -1.25 -15 -0.50118336020166e4 }
    {  9 -1.25  -6  0.35684463560015 }
    { 10 -1.0  -26  0.44235335848190e5 }
    { 11 -1.0  -21 -0.13673388811708e5 }
    { 12 -1.0  -17  0.42163260207864e6 }
    { 13 -1.0  -16  0.22516925837475e5 }
    { 14 -1.0   -9  0.47442144865646e3 }
    { 15 -1.0   -8 -0.14931130797647e3 }
    { 16 -0.75 -15 -0.19781126320452e6 }
    { 17 -0.75 -14 -0.23554399470760e5 }
    { 18 -0.5  -26 -0.19070616302076e5 }
    { 19 -0.5  -13  0.55375669883164e5 }
    { 20 -0.5   -9  0.38293691437363e4 }
    { 21 -0.5   -7 -0.60291860580567e3 }
    { 22 -0.25 -27  0.19363102620331e4 }
    { 23 -0.25 -25  0.42660643698610e4 }
    { 24 -0.25 -11 -0.59780638872718e4 }
    { 25 -0.25  -6 -0.70401463926862e3 }
    { 26  0.25   1  0.33836784107553e3 }
    { 27  0.25   4  0.20862786635187e2 }
    { 28  0.25   8  0.33834172656196e-1 }
    { 29  0.25  11 -0.43124414893e-4 }
    { 30  0.5    0  0.11653791356412e3 }
    { 31  0.5    1 -0.13986292055898e3 }
    { 32  0.5    5 -0.78849547999872 }
    { 33  0.5    6  0.72132411753872e-1 }
    { 34  0.5   10 -0.59754839398283e-2 }
    { 35  0.5   14 -0.12141358953904e-4 }
    { 36  0.5   16  0.23227096733871e-6 }
    { 37  0.75   0 -0.10538463566194e2 }
    { 38  0.75   4  0.20718925496502e1 }
    { 39  0.75   9 -0.72193155260427e-1 }
    { 40  0.75  17  0.20749887081120e-6 }
    { 41  1.0    7 -0.18340657911379e-1 }
    { 42  1.0   18  0.29036272348696e-6 }
    { 43  1.25   3  0.21037527893619 }
    { 44  1.25  15  0.25681239729999e-3 }
    { 45  1.5    5 -0.12799002933781e-1 }
    { 46  1.5   18 -0.82198102652018e-5 } } Table25 set

SYMBOL: Table26
! i I J n
{   {  1 -6  0  0.31687665083497e6 }
    {  2 -6 11  0.20864175881858e2 }
    {  3 -5  0 -0.39859399803599e6 }
    {  4 -5 11 -0.21816058518877e2 }
    {  5 -4  0  0.22369785194242e6 }
    {  6 -4  1 -0.27841703445817e4 }
    {  7 -4 11  0.99207436071480e1 }
    {  8 -3  0 -0.75197512299157e5 }
    {  9 -3  1  0.29708605951158e4 }
    { 10 -3 11 -0.34406878548526e1 }
    { 11 -3 12  0.38815564249115 }
    { 12 -2  0  0.17511295085750e5 }
    { 13 -2  1 -0.14237112854449e4 }
    { 14 -2  6  0.10943803364167e1 }
    { 15 -2 10  0.89971619308495 }
    { 16 -1  0 -0.33759740098958e4 }
    { 17 -1  1  0.47162885818355e3 }
    { 18 -1  5 -0.19188241993679e1 }
    { 19 -1  8  0.41078580492196  }
    { 20 -1  9 -0.33465378172097 }
    { 21  0  0  0.13870034777505e4 }
    { 22  0  1 -0.40663326195838e3 }
    { 23  0  2  0.41727347159610e2 }
    { 24  0  4  0.21932549434532e1 }
    { 25  0  5 -0.10320050009077e1 }
    { 26  0  6  0.35882943516703 }
    { 27  0  9  0.52511453726066e-2 }
    { 28  1  0  0.12838916450705e2 }
    { 29  1  1 -0.28642437219381e1 }
    { 30  1  2  0.56912683664855 }
    { 31  1  3 -0.9962954584931e-1 }
    { 32  1  7 -0.32632037778459e-2 }
    { 33  1  8  0.23320922576723e-1 }
    { 34  2  0 -0.15334809857450 }
    { 35  2  1  0.29072288239902e-1 }
    { 36  2  5  0.37534702741167e-3 }
    { 37  3  0  0.17296691702411e-2 }
    { 38  3  1 -0.38556050844504e-3 }
    { 39  3  3 -0.35017712292608e-4 }
    { 40  4  0 -0.14566393631492e-4 }
    { 41  4  1  0.56420857267269e-5 }
    { 42  5  0  0.41286150074605e-7 }
    { 43  5  1 -0.20684671118824e-7 }
    { 44  5  2  0.16409393674725e-8 } } Table26 set

SYMBOL: Table27
! i I J n
{
    {  1 -2 0  0.90968501005365e3 }
    {  2 -2 1  0.24045667088420e4 }
    {  3 -1 0 -0.59162326387130e3 }
    {  4  0 0  0.54145404128074e3 }
    {  5  0 1 -0.27098308411192e3 }
    {  6  0 2  0.97976525097926e3 }
    {  7  0 3 -0.46966772959435e3 }
    {  8  1 0  0.14399274604723e2 }
    {  9  1 1 -0.19104204230429e2 }
    { 10  1 3  0.53299167111971e1 }
    { 11  1 4 -0.21252975375934e2 }
    { 12  2 0 -0.31147334413760 }
    { 13  2 1  0.60334840894623 }
    { 14  2 2 -0.42764839702509e-1 }
    { 15  3 0  0.58185597255259e-2 }
    { 16  3 1 -0.14597008284753e-1 }
    { 17  3 5  0.56631175631027e-2 }
    { 18  4 0 -0.76155864584577e-4 }
    { 19  4 1  0.22440342919332e-3 }
    { 20  4 4 -0.12561095013413e-4 }
    { 21  5 0  0.63323132660934e-6 }
    { 22  5 1 -0.20541989675375e-5 }
    { 23  5 2  0.36405370390082e-7 }
    { 24  6 0 -0.29759897789215e-8 }
    { 25  6 1  0.10136618529763e-7 }
    { 26  7 0  0.59925719692351e-11 }
    { 27  7 1 -0.20677870105164e-10 }
    { 28  7 3 -0.20874278181886e-10 }
    { 29  7 4  0.10162166825089e-9 }
    { 30  7 5 -0.16429828281347e-9 } } Table27 set

SYMBOL: Table30
! i I J n
{   {  1  0  0  0.10658070028513e1 } ! I and J are dummies, not used - see eq.28
    {  2  0  0 -0.15732845290239e2 }
    {  3  0  1  0.20944396974307e2 }
    {  4  0  2 -0.76867707878716e1 }
    {  5  0  7  0.26185947787954e1 }
    {  6  0 10 -0.28080781148620e1 }
    {  7  0 12  0.12053369696517e1 }
    {  8  0 23 -0.84566812812502e-2 }
    {  9  1  2 -0.12654315477714e1 }
    { 10  1  6 -0.11524407806681e1 }
    { 11  1 15  0.88521043984318 }
    { 12  1 17 -0.64207765181607 }
    { 13  2  0  0.38493460186671 }
    { 14  2  2 -0.85214708824206 }
    { 15  2  6  0.48972281541877e1 }
    { 16  2  7 -0.30502617256965e1 }
    { 17  2 22  0.39420536879154e-1 }
    { 18  2 26  0.12558408424308 }
    { 19  3  0 -0.27999329698710 }
    { 20  3  2  0.13899799569460e1 }
    { 21  3  4 -0.20189915023570e1 }
    { 22  3 16 -0.82147637173963e-2 }
    { 23  3 26 -0.47596035734923 }
    { 24  4  0  0.43984074473500e-1 }
    { 25  4  2 -0.44476435428739 }
    { 26  4  4  0.90572070719733 }
    { 27  4 26  0.70522450087967 }
    { 28  5  1  0.10770512626332 }
    { 29  5  3 -0.32913623258954 }
    { 30  5 26 -0.50871062041158 }
    { 31  6  0 -0.22175400873096e-1 }
    { 32  6  2  0.94260751665092e-1 }
    { 33  6 26  0.16436278447961 }
    { 34  7  2 -0.13503372241348e-1 }
    { 35  8 26 -0.14834345352472e-1 }
    { 36  9  2  0.57922953628084e-3 }
    { 37  9 26  0.32308904703711e-2 }
    { 38 10  0  0.80964802996215e-4 }
    { 39 10  1 -0.16557679795037e-3 }
    { 40 11 26 -0.44923899061815e-4 } } Table30 set

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


! !!!
! boundary between region 2b and 2c [ref.1 fig.2]

! : B2bc-pressure ( h -- p ) 1 ; ! stub
:: B2bc-pressure ( h -- p ) 
         0.90584278514723e3  :> n1
        -0.67955786399241    :> n2
         0.12809002730136e-3 :> n3
        n1 n2 h * + n3 h sq * + ;

! : B2bc-enthalpy ( p -- h ) 1 ; ! stub
:: B2bc-enthalpy ( p -- h ) 
        0.12809002730136e-3 :> n3
        0.26526571908428e4  :> n4
        0.45257578905948e1  :> n5
        n4 p n5 - n3 / sqrt + ;

! [ref.1 eq. 22]
: T2a(p,h) ( p h -- T ) 1 ; ! stub 
! !!!

! [ref.1 eq. 23]
: T2b(p,h) ( p h -- T ) 1 ; ! stub
! !!!

! [ref.1 eq. 24]
: T2c(p,h) ( p h -- T ) 1 ; ! stub
! !!!

! !!!
: T2(p,h) ( p h -- T ) 1 ; ! stub
! tie together equations 22-23-24 


! the backward equations T2(p,s) for regions 2a, 2b and 2c
! [ref.1 eq. 25,26,27]
! !!!
:: f25 ( seq p s -- T ) 1 ; ! stub !!!

:: f26 ( seq p s -- T ) 1 ; ! stub !!!

:: f27 ( seq p s -- T ) 1 ; ! stub !!!

! [ref.1 eq. 25]
: T2a(p,s) ( p s -- T ) 1 ; ! stub 
! !!!

! [ref.1 eq. 26]
: T2b(p,s) ( p s -- T ) 1 ; ! stub
! !!!

! [ref.1 eq. 27]
: T2c(p,s) ( p s -- T ) 1 ; ! stub
! !!!

:: T2(p,s) ( p s -- T ) 1 ; ! stub !!!
! !!! tie together equations 25,26,27




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









