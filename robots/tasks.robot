*** Settings ***
Library     Config
Resource    ./robots/functions/wellsky/WellSkyFunctions.robot
Resource    ./robots/functionblocks/ExportPayersList.robot
Resource    ./robots/functions/commons/CommonUtilities.robot


*** Tasks ***
Start
    Init


*** Keywords ***
Init
    load-selectors
    CommonUtilities.launch
    WellSkyFunctions.perform-login-process    E5bot3
    Set Browser Timeout    1m 30 seconds
    ExportPayersList.export-payers-list    ${EMPTY}
    # WellSkyFunctions.navigate-through-tab    Go To    Billing Manager
    # WellSkyFunctions.navigate-to-claims-manager-page    Medicare    EOE    Ready to Send
    # ${payers}=    WellSkyFunctions.get-payers-list-from-claims-manager-page
    # Log To Console    ${payers}
    # WellSkyFunctions.select-payer-and-send-claim-in-claims-manager-page    2    Medicare Traditional    Send Manually

    Sleep    5s

load-selectors
    ${selectors}=    Config.Initialize Selectors    ./yamls/selectors.yaml
    Set Global Variable    ${selectors}
