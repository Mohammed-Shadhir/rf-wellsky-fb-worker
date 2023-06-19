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
    WellSkyFunctions.navigate-through-tab    Go To    Billing Manager
    WellSkyFunctions.navigate-to-claims-manager-page    Managed Care    Secondary Payer    Ready to Send
    ${payers}=    WellSkyFunctions.get-payers-list-from-claims-manager-page
    Log To Console    ${payers}
    WellSkyFunctions.select-payer-and-send-claim-in-claims-manager-page    3    Banner    Send Electronically
    Sleep    5s

load-selectors
    ${selectors}=    Config.Initialize Selectors    ./yamls/selectors.yaml
    Set Global Variable    ${selectors}
