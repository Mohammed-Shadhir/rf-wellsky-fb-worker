*** Settings ***
Resource    ./robots/functions/wellsky/WellSkyFunctions.robot

*** Tasks ***
Start
    Init

*** Keywords ***
Init
    WellSkyFunctions.perform-login-process    E5bot1
    WellSkyFunctions.navigate-to-billing-manager
    