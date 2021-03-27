! Copyright (C) 2021 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel tools.test words.constant steam-table ;
IN: steam-table.tests

{ t } [ \ T-CRIT constant? ] unit-test
{ t } [ T-CRIT 647.096 = ] unit-test

{ t } [ \ P-CRIT constant? ] unit-test
{ t } [ P-CRIT 22.064 = ] unit-test

{ t } [ \ RHO-CRIT constant? ] unit-test
{ t } [ RHO-CRIT 322. = ] unit-test

{ t } [ \ R constant? ] unit-test
{ t } [ R 0.461526 = ] unit-test




