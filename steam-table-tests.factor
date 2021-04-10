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


! verification region 1

! verification region 2

! verification region 3

! verification region 5





