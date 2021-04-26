! Copyright (C) 2021 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors kernel math namespaces sequences tools.test words.constant words.symbol ;
USE: steam-table
IN: steam-table.tests

! CONSTANTS
{ t } [ \ T-CRIT constant? ] unit-test
{ t } [ T-CRIT 647.096 = ] unit-test

{ t } [ \ P-CRIT constant? ] unit-test
{ t } [ P-CRIT 22.064 = ] unit-test

{ t } [ \ RHO-CRIT constant? ] unit-test
{ t } [ RHO-CRIT 322. = ] unit-test

{ t } [ \ R constant? ] unit-test
{ t } [ R 0.461526 = ] unit-test

{ t } [ 0.165291643e2 B23-temperature 0.623150000e3 1e-6 fp-= ] unit-test

{ t } [ 0.623150000e3 B23-pressure 0.165291643e2 1e-7 fp-= ] unit-test

! TABLES
{ t } [ Table2 symbol? ] unit-test
{ t } [ Table2 get length 34 = ] unit-test

! TUPLES
{ t } [ pT new pT? ] unit-test
{ t } [ P-CRIT T-CRIT <pT> pT? ] unit-test
! issue #3:
{ t } [ pT new p>> float? ] unit-test
{ t } [ pT new T>> float? ] unit-test
! issue #3:end
{ t } [ P-CRIT T-CRIT <pT> p>> P-CRIT = ] unit-test
{ t } [ P-CRIT T-CRIT <pT> T>> T-CRIT = ] unit-test

! AUXILIARY FUNCTIONS
{ t } [ 1. 1. 2. [in-range?] ] unit-test
{ t } [ 2. 1. 2. [in-range?] ] unit-test
{ f } [ 1. 1. 2. (in-range?] ] unit-test
{ t } [ 2. 1. 2. (in-range?] ] unit-test
{ t } [ 1. 1. 2. [in-range?) ] unit-test
{ f } [ 2. 1. 2. [in-range?) ] unit-test
{ f } [ 1. 1. 2. (in-range?) ] unit-test
{ f } [ 2. 1. 2. (in-range?) ] unit-test

! SATURATION PRESSURE CURVE 
{ t } [ 300 p-sat 0.353658941e-2 1.e-11 fp-= ] unit-test
{ t } [ 500 p-sat 0.263889776e1  1.e-8  fp-= ] unit-test
{ t } [ 600 p-sat 0.123443146e2  1.e-7  fp-= ] unit-test


! SATURATION TEMPERATURE
{ t } [ 0.1 T-sat 0.372755919e3 1.e-6 fp-= ] unit-test
{ t } [ 1.0 T-sat 0.453035632e3 1.e-6 fp-= ] unit-test
{ t } [ 10. T-sat 0.584149488e3 1.e-6 fp-= ] unit-test

! regions (figure 1)
! region1?
{ t } [ 273.15 p-sat 273.15 <pT> region1? ] unit-test
{ t } [ 100. 273.15 <pT> region1? ] unit-test
{ t } [ 100. 623.15 <pT> region1? ] unit-test
{ t } [  623.15 p-sat 623.15 <pT> region1? ] unit-test
{ f } [ 50. 273.00 <pT> region1? ] unit-test
{ f } [ 400. 101. <pT> region1? ] unit-test
{ f } [ 50. 624. <pT> region1? ] unit-test
{ f } [ 623.15 p-sat 1 - 623.15 <pT> region1? ] unit-test
! region2a?
{ t } [ 273.15 p-sat 273.15 <pT> region2a? ] unit-test
{ f } [ 273.15 p-sat 1.001 * 273.15 <pT> region2a? ] unit-test
{ t } [ 623.15 p-sat 623.15 <pT> region2a? ] unit-test
{ f } [ 623.15 p-sat 1.001 * 623.15 <pT> region2a? ] unit-test
{ f } [ 0. 273.15 <pT> region2a? ] unit-test
{ f } [ 0 623.15 <pT> region2a? ] unit-test
! region2b?
{ f } [ 623.15 B23-pressure 623.15 <pT> region2b? ] unit-test
{ t } [ 624. B23-pressure 624. <pT> region2b? ] unit-test
{ f } [ 623.15 B23-pressure 1.001 * 623.15 <pT> region2b? ] unit-test
{ t } [ 863.15 B23-pressure 863.15 <pT> region2b? ] unit-test
{ f } [ 623.15 B23-pressure 1.001 * 623.15 <pT> region2b? ] unit-test
{ f } [ 0. 623.15 <pT> region2b? ] unit-test
{ f } [ 0. 863.15 <pT> region2b? ] unit-test
! region2c?
{ t } [ 100. 864. <pT> region2c? ] unit-test
{ f } [ 100.1 863.15 <pT> region2c? ] unit-test
{ t } [ 100. 1073.15 <pT> region2c? ] unit-test
{ f } [ 100.1 1073.15 <pT> region2c? ] unit-test
{ f } [ 0. 863.15 <pT> region2c? ] unit-test
{ f } [ 0. 1073.15 <pT> region2c? ] unit-test
! region3? 
{ t } [ 623.15 B23-pressure 623.15 <pT> region3? ] unit-test
{ f } [ 623.15 B23-pressure 620. <pT> region3? ] unit-test
{ t } [ 100. 623.15 <pT> region3? ] unit-test
{ f } [ 101. 623.15 <pT> region3? ] unit-test
! the following rounding is needed as the value is only stated to 6dp accuracy
{ t } [ 100. 100. B23-temperature 6 fp-round <pT> region3? ] unit-test
{ f } [ 100. 100. B23-temperature 1 + <pT> region3? ] unit-test
! region4?
! tests are identical to the tests for T-sat and p-sat (see above)
{ t } [ 0.353658941e-2 300. <pT> region4? ] unit-test
{ t } [ 0.263889776e1  500. <pT> region4? ] unit-test
{ t } [ 0.123443146e2  600. <pT> region4? ] unit-test
{ t } [ 0.1  0.372755919e3  <pT> region4? ] unit-test
{ t } [ 1.0  0.453035632e3  <pT> region4? ] unit-test
{ t } [ 10.  0.584149488e3  <pT> region4? ] unit-test
! region5?
{ f } [ 0 1073.15 <pT> region5? ] unit-test
{ t } [ 0.1 1073.15 <pT> region5? ] unit-test
{ f } [ 0 2273.15 <pT> region5? ] unit-test
{ t } [ 0.1 2273.15 <pT> region5? ] unit-test
{ t } [ 50. 1073.15 <pT> region5? ] unit-test
{ f } [ 50.1 1073.15 <pT> region5? ] unit-test
{ t } [ 50. 2273.15 <pT> region5? ] unit-test
{ f } [ 50.1 2273.15 <pT> region5? ] unit-test

! verification of equations for region 1, table 4
{ t } [ 0 { 1 0 0 0 } 1 2 (gamma) = ] unit-test
{ t } [ 2 { 1 0 0 2 } 1 2 (gamma) = ] unit-test
{ t } [ 6.1 0.778 *  { 1 1 1 1 } 1 2 (gamma) = ] unit-test 

! { t } [ 0  { 1 0 0 0 } 1 2 (gamma_pi) = ] unit-test
! { t } [ -2 { 1 1 0 2 } 1 2 (gamma_pi) = ] unit-test
! { t } [ -2 0.778 *  { 1 1 1 2 } 1 2 (gamma_pi) = ] unit-test
! { t } [ 6.1 0.778 *  { 1 1 1 1 } 1 2 (gamma_pi) = ] unit-test 

! { t } [ 0 { 1 0 0 0 } 1 2 (gamma_pi_pi) = ] unit-test
! { t } [ -2 { 1 1 0 2 } 1 2 (gamma_pi_pi) = ] unit-test

! { t } [ 6.1 0.778 *  { 1 1 1 1 } 1 2 (gamma_pi_pi) = ] unit-test 

!  { t } [ 0 { 1 0 0 0 } 1 2 (gamma_tau) = ] unit-test
! { t } [ 2 { 1 0 0 2 } 1 2 (gamma_tau) = ] unit-test
! { t } [ 6.1 0.778 *  { 1 1 1 1 } 1 2 (gamma_tau) = ] unit-test 

! { t } [ 0 { 1 0 0 0 } 1 2 (gamma_tau_tau) = ] unit-test
! { t } [ 2 { 1 0 0 2 } 1 2 (gamma_tau_tau) = ] unit-test
! { t } [ 6.1 0.778 *  { 1 1 1 1 } 1 2 (gamma_tau_tau) = ] unit-test 

! { t } [ 0 { 1 0 0 0 } 1 2 (gamma_pi_tau) = ] unit-test
! { t } [ 2 { 1 0 0 2 } 1 2 (gamma_pi_tau) = ] unit-test
! { t } [ 6.1 0.778 *  { 1 1 1 1 } 1 2 (gamma_pi_tau) = ] unit-test 


! verification region 1 [ref.1 table 5]
{ t } [ 0.100215168e-2  3. 300. <pT> speed-of-sound  1e-11 fp-= ] unit-test
{ t } [ 0.971180894e-3 80. 300. <pT> speed-of-sound  1e-12 fp-= ] unit-test
{ t } [ 0.120241800e-2  3. 500. <pT> speed-of-sound  1e-11 fp-= ] unit-test
{ t } [ 0.115331273e3   3. 300. <pT> enthalpy        1e-6  fp-= ] unit-test
{ t } [ 0.184142828e3  80. 300. <pT> enthalpy        1e-6  fp-= ] unit-test
{ t } [ 0.975542239e3   3. 500. <pT> enthalpy        1e-6  fp-= ] unit-test
{ t } [ 0.112324818e3   3. 300. <pT> internal-energy 1e-6  fp-= ] unit-test
{ t } [ 0.106448356e3  80. 300. <pT> internal-energy 1e-6  fp-= ] unit-test
{ t } [ 0.971934985e3   3. 500. <pT> internal-energy 1e-6  fp-= ] unit-test
{ t } [ 0.392294792     3. 300. <pT> entropy         1e-9  fp-= ] unit-test
{ t } [ 0.368563852    80. 300. <pT> entropy         1e-9  fp-= ] unit-test
{ t } [ 0.258041912e1   3. 500. <pT> entropy         1e-8  fp-= ] unit-test
{ t } [ 0.417301218e1   3. 300. <pT> Cp              1e-8  fp-= ] unit-test
{ t } [ 0.401008987e1  80. 300. <pT> Cp              1e-8  fp-= ] unit-test
{ t } [ 0.465580682e1   3. 500. <pT> Cp              1e-8  fp-= ] unit-test
{ t } [ 0.150773921e4   3. 300. <pT> speed-of-sound  1e-5  fp-= ] unit-test
{ t } [ 0.163469054e4  80. 300. <pT> speed-of-sound  1e-5  fp-= ] unit-test
{ t } [ 0.124071337e4   3. 500. <pT> speed-of-sound  1e-5  fp-= ] unit-test


! verification T(p,h) for region 1 [ref.1 table 7]
{ t } [ 0.391798509e3  3.  500. T(p,h) 1e-6 fp-= ] unit-test
{ t } [ 0.378108626e3 80.  500. T(p,h) 1e-6 fp-= ] unit-test
{ t } [ 0.611041229e3 80. 1500  T(p,h) 1e-6 fp-= ] unit-test

! verification T(p,s) for region 1 [ref.1 table 9]
{ t } [ 0.307842258e3  3. 0.5 T(p,s) 1e-6 fp-= ] unit-test
{ t } [ 0.309979785e3 80. 0.5 T(p,s) 1e-6 fp-= ] unit-test
{ t } [ 0.565899909e3 80. 3.0 T(p,s) 1e-6 fp-= ] unit-test


! verification region 2 [ref.1 table 15]
{ t } [ 0.394913866e2   0.0035 300. <pT> speed-of-sound  1e-7  fp-= ] unit-test
{ t } [ 0.923015898e2   0.0035 700. <pT> speed-of-sound  1e-7  fp-= ] unit-test
{ t } [ 0.542946619e-2 30.     700. <pT> speed-of-sound  1e-11 fp-= ] unit-test
{ t } [ 0.254991145e4   0.0035 300. <pT> enthalpy        1e-5  fp-= ] unit-test
{ t } [ 0.333568375e4   0.0035 700. <pT> enthalpy        1e-5  fp-= ] unit-test
{ t } [ 0.263149474e4  30.     700. <pT> enthalpy        1e-5  fp-= ] unit-test
{ t } [ 0.241169160e4   0.0035 300. <pT> internal-energy 1e-5  fp-= ] unit-test
{ t } [ 0.301262819e4   0.0035 700. <pT> internal-energy 1e-5  fp-= ] unit-test
{ t } [ 0.246861076e4  30.     700. <pT> internal-energy 1e-5  fp-= ] unit-test
{ t } [ 0.852238967e1   0.0035 300. <pT> entropy         1e-8  fp-= ] unit-test
{ t } [ 0.101749996e2   0.0035 700. <pT> entropy         1e-7  fp-= ] unit-test
{ t } [ 0.517540298e1  30.     700. <pT> entropy         1e-8  fp-= ] unit-test
{ t } [ 0.191300162e1   0.0035 300. <pT> Cp              1e-8  fp-= ] unit-test
{ t } [ 0.208141274e1   0.0035 700. <pT> Cp              1e-8  fp-= ] unit-test
{ t } [ 0.103505092e2  30.     700. <pT> Cp              1e-7  fp-= ] unit-test
{ t } [ 0.427920172e3   0.0035 300. <pT> speed-of-sound  1e-6  fp-= ] unit-test
{ t } [ 0.644289068e3   0.0035 700. <pT> speed-of-sound  1e-6  fp-= ] unit-test
{ t } [ 0.480386523e3  30.     700. <pT> speed-of-sound  1e-6  fp-= ] unit-test

! verification region 2 [ref.1 table 18]
! !!!
{ t } [ 0.192516540e0   1.  450. <pT> speed-of-sound  1e-9  fp-= ] unit-test
{ t } [ 0.186212297e0   1.  440. <pT> speed-of-sound  1e-9  fp-= ] unit-test
{ t } [ 0.121685206e0   1.5 450. <pT> speed-of-sound  1e-9  fp-= ] unit-test
{ t } [ 0.276881115e4   1.  450. <pT> enthalpy        1e-5  fp-= ] unit-test
{ t } [ 0.274015123e4   1.  440. <pT> enthalpy        1e-5  fp-= ] unit-test
{ t } [ 0.272134539e4   1.5 450. <pT> enthalpy        1e-5  fp-= ] unit-test
{ t } [ 0.257629461e4   1.  450. <pT> internal-energy 1e-5  fp-= ] unit-test
{ t } [ 0.255393894e4   1.  440. <pT> internal-energy 1e-5  fp-= ] unit-test
{ t } [ 0.253881758e4   1.5 450. <pT> internal-energy 1e-5  fp-= ] unit-test
{ t } [ 0.656660377e1   1.  450. <pT> entropy         1e-8  fp-= ] unit-test
{ t } [ 0.650218759e1   1.  440. <pT> entropy         1e-8  fp-= ] unit-test
{ t } [ 0.629170440e1   1.5 450. <pT> entropy         1e-8  fp-= ] unit-test
{ t } [ 0.276349265e1   1.  450. <pT> Cp              1e-8  fp-= ] unit-test
{ t } [ 0.298166443e1   1.  440. <pT> Cp              1e-8  fp-= ] unit-test
{ t } [ 0.362795578e1   1.5 450. <pT> Cp              1e-7  fp-= ] unit-test
{ t } [ 0.498408101e3   1.  450. <pT> speed-of-sound  1e-6  fp-= ] unit-test
{ t } [ 0.489363295e3   1.  440. <pT> speed-of-sound  1e-6  fp-= ] unit-test
{ t } [ 0.481941819e3   1.5 450. <pT> speed-of-sound  1e-6  fp-= ] unit-test

! verification B2bc equation [ref.1 eq.20 and eq.21]
{ t } [ 0.100000000e3  0.3516004323e4 B2bc-pressure 1e-6 fp-= ] unit-test
{ t } [ 0.3516004323e4 0.100000000e3  B2bc-enthalpy 1e-6 fp-= ] unit-test

! verification [eq. 22, 23 and 24]
{ t } [ 0.534433241e3  0.001 3000. T2a(p,h) 1e-6 fp-= ] unit-test
{ t } [ 0.575373370e3  3.    3000. T2a(p,h) 1e-6 fp-= ] unit-test
{ t } [ 0.101077577e4  3.    4000. T2a(p,h) 1e-5 fp-= ] unit-test
{ t } [ 0.801299102e3  5.    3500. T2b(p,h) 1e-6 fp-= ] unit-test
{ t } [ 0.101531583e4  5.    4000. T2b(p,h) 1e-5 fp-= ] unit-test
{ t } [ 0.875279054e3 25.    3500. T2b(p,h) 1e-6 fp-= ] unit-test
{ t } [ 0.743056411e3 40.    2700. T2c(p,h) 1e-6 fp-= ] unit-test
{ t } [ 0.791137067e3 60.    2700. T2c(p,h) 1e-6 fp-= ] unit-test
{ t } [ 0.882756860e3 60.    3200. T2c(p,h) 1e-6 fp-= ] unit-test

! verification [eq. 25,26 and 27]
{ t } [ 0.399517097e3  0.1 7.5  T2a(p,s) 1e-6 fp-= ] unit-test
{ t } [ 0.514127081e3  0.1 8.   T2a(p,s) 1e-6 fp-= ] unit-test
{ t } [ 0.103984917e4  2.5 8.   T2a(p,s) 1e-5 fp-= ] unit-test
{ t } [ 0.600484040e3  8.  6.   T2b(p,s) 1e-6 fp-= ] unit-test
{ t } [ 0.106495556e4  8.  7.5  T2b(p,s) 1e-5 fp-= ] unit-test
{ t } [ 0.103801126e4 90.  6.   T2b(p,s) 1e-5 fp-= ] unit-test
{ t } [ 0.697992849e3 20.  5.75 T2c(p,s) 1e-6 fp-= ] unit-test
{ t } [ 0.854011484e3 80.  5.25 T2c(p,s) 1e-6 fp-= ] unit-test
{ t } [ 0.949017998e3 80.  5.75 T2c(p,s) 1e-6 fp-= ] unit-test


! verification region 3

! verification region 5





