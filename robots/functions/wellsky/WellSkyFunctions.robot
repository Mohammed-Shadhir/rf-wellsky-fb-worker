*** Settings ***
Library     RPA.Browser.Playwright
Library     Collections
Library     json
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
    LoginPage.set-username    ${username}
    LoginPage.set-password
    LoginPage.perform-login

navigate-through-tab
    [Documentation]    Clicks tab and sub-tab
    [Tags]    function
    [Arguments]    ${tab}    ${sub_tab}
    Navbar.navigate    ${tab}    ${sub_tab}

navigate-to-claims-manager-page
    [Documentation]    Clicks the claim button and clicks the claim status
    [Tags]    function
    [Arguments]    ${section_name}    ${claim_name}    ${claim_status}
    BillingManagerPage.open-claims-manager    ${section_name}    ${claim_name}    ${claim_status}

get-payers-list-from-claims-manager-page
    [Documentation]    Navigates to claims manager page for each item
    ...    Gets the list of payers available in the page
    [Tags]    function
    [Arguments]    ${billing_managers}

    FOR    ${item}    IN    @{billing_managers}
        navigate-through-tab    Go To    Billing Manager
        ${section_name}=    Set Variable    ${item}[section_name]
        ${claim_name}=    Set Variable    ${item}[claim_name]
        ${claim_status}=    Set Variable    ${item}[claim_status]
        Log To Console    <== Fetching payers list: ${section_name}, ${claim_name}, ${claim_status} ==>
        navigate-to-claims-manager-page    ${section_name}    ${claim_name}    ${claim_status}
        # location change will happen here if found multiple locations
        ${payers}=    ClaimsManagerPage.get-payers-list
        Set To Dictionary    ${item}    payers=${payers}
    END
    RETURN    ${billing_managers}

select-payer-and-send-claim-in-claims-manager-page
    [Documentation]    Sets the payer and sends claim
    [Arguments]    ${payer_value}    ${payer_name}    ${action}
    ClaimsManagerPage.select-payer-by-value    ${payer_value}    ${payer_name}
    ClaimsManagerPage.select-all-patients
    ClaimsManagerPage.get-table-row-count
    ClaimsManagerPage.send-claims    ${action}

    # check select all checkbox and send claim action here
