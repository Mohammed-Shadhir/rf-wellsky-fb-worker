*** Settings ***
Library     RPA.Browser.Playwright
Library     String
Resource    ./robots/exceptions/Exception.robot
Resource    ./robots/functions/commons/CommonUtilities.robot
Resource    ./robots/components/InputTextComponent.robot
Resource    ./robots/components/ButtonComponent.robot
Resource    ./robots/components/commons/ComponentStatus.robot
Resource    ./robots/resources/variables.resource


*** Keywords ***
get-claims-manager-selectors
    [Documentation]    Gets all selectors for claims manager page
    RETURN    ${selectors}[e5][wellsky][claims-manager]

get-header-selector
    [Documentation]    Gets the header selector
    RETURN    ${selectors}[e5][wellsky][claims-manager][heading]

get-selectors-for-tab
    [Documentation]    Gets selectors for the particular tab
    [Arguments]    ${tab}
    RETURN    ${selectors}[e5][wellsky][claims-manager][tabs][${tab}]

get-payers-list
    [Documentation]    Gets the list of payers available in the page
    ${payers_selector}=    get-claims-manager-selectors

    # Precondition
    ${is_payers_select_attaced}=    ComponentStatus.is-attached    ${payers_selector}[payers-select]
    IF  ${is_payers_select_attaced} == ${False}
        Exception.custom-fail    ${PRECONDITION_PAYER_SELECT_BOX_NOT_ATTACHED}        
    END
    ${payer_options}=    Get Select Options    ${payers_selector}[payers-select]
    RETURN    ${payer_options}
