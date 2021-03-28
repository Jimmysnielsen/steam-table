! Copyright (C) 2021 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors kernel tools.test words.constant steam-table ;
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
{ t } [ P-CRIT T-CRIT <pT> p>> P-CRIT = ] unit-test
{ t } [ P-CRIT T-CRIT <pT> T>> T-CRIT = ] unit-test


