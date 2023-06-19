*** Settings ***
Library     RPA.Browser.Playwright
Resource    ./robots/pages/wellsky/LoginPage.robot
Resource    ./robots/pages/wellsky/common/Navbar.robot
Resource    ./robots/pages/wellsky/BillingManagerPage.robot
Resource    ./robots/pages/wellsky/ClaimsManagerPage.robot
Resource    ./robots/functions/commons/CommonUtilities.robot
Resource    ./robots/functions/commons/CollectionUtilities.robot


*** Keywords ***
perform-login-process
    [Documentation]    Performs Login Process
    [Tags]    function
    [Arguments]    ${username}
    CommonUtilities.launch
    LoginPage.set-username    ${username}
    LoginPage.set-password
    LoginPage.perform-login

navigate-through-tab
    [Documentation]    Clicks tab and sub-tab
    [Tags]    function
    [Arguments]    ${tab}    ${sub_tab}
    Navbar.open-menu-item    ${tab}    ${sub_tab}

navigate-to-claims-manager-page
    [Documentation]    Clicks the claim button and clicks the claim status
    [Tags]    function
    [Arguments]    ${section}    ${claim_name}    ${claim_status}
    BillingManagerPage.open-claims-manager    ${section}    ${claim_name}    ${claim_status}

get-payers-list-from-claims-manager-page
    [Documentation]    Gets the list of payers available in the page
    ${payers}=    ClaimsManagerPage.get-payers-list
    RETURN    ${payers}

select-payer-and-send-claim-in-claims-manager-page
    [Documentation]    Sets the payer and sends claim
    [Arguments]    ${payer_value}    ${payer_name}    ${action}
    ClaimsManagerPage.select-payer-by-value    ${payer_value}    ${payer_name}

    # check select all checkbox and send claim action here
