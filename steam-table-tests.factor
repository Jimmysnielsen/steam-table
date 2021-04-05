! Copyright (C) 2021 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors kernel math tools.test words.constant steam-table ;
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

! SATURATION PRESSURE CURVE 
{ t } [ 300 p-sat 0.353658941e-2 1.e-11 fp-= ] unit-test
{ t } [ 500 p-sat 0.263889776e1  1.e-8  fp-= ] unit-test
{ t } [ 600 p-sat 0.123443146e2  1.e-7  fp-= ] unit-test


! SATURATION TEMPERATURE
{ t } [ 0.1 T-sat 0.372755919e3 1.e-6 fp-= ] unit-test
{ t } [ 1.0 T-sat 0.453035632e3 1.e-6 fp-= ] unit-test
{ t } [ 10. T-sat 0.584149488e3 1.e-6 fp-= ] unit-test

! region1?
{ t } [ 273.15 p-sat 273.15 <pT> region1? ] unit-test
{ t } [ 100. 273.15 <pT> region1? ] unit-test
{ t } [ 100. 623.15 <pT> region1? ] unit-test
{ t } [  623.15 p-sat 623.15 <pT> region1? ] unit-test
{ f } [ 50. 273.00 <pT> region1? ] unit-test
{ f } [ 400. 101. <pT> region1? ] unit-test
{ f } [ 50. 624. <pT> region1? ] unit-test
{ f } [ 623.15 p-sat 1 - 623.15 <pT> region1? ] unit-test
