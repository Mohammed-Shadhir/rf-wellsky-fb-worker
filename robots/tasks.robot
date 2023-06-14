*** Settings ***
Library     Config
Resource    ./robots/functions/wellsky/WellSkyFunctions.robot


*** Tasks ***
Start
    Init


*** Keywords ***
Init
    load-selectors
    WellSkyFunctions.perform-login-process    E5bot1
    WellSkyFunctions.navigate-to-billing-manager
    WellSkyFunctions.navigate-to-Eoe
    Sleep    5s

load-selectors
    ${selectors}=    Config.Initialize Selectors    ./yamls/selectors.yaml
    Set Global Variable    ${selectors}
