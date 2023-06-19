*** Settings ***
Library     RPA.Browser.Playwright
Library     String
Resource    ./robots/exceptions/Exception.robot
Resource    ./robots/functions/commons/CommonUtilities.robot
Resource    ./robots/components/InputTextComponent.robot
Resource    ./robots/components/SelectComponent.robot
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
    TRY
        ${payer_options}=    SelectComponent.get-options    ${payers_selector}[payers-select]
        RETURN    ${payer_options}
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${PRECONDITION_PAYER_SELECT_BOX_NOT_ATTACHED}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${PRECONDITION_PAYER_SELECT_BOX_NOT_ENABLED}
    END

select-payer-by-value
    [Documentation]    Sets payer in te payer select box using payer value
    [Arguments]    ${payer_value}    ${payer_name}
    ${payers_selector}=    get-claims-manager-selectors
    TRY
        SelectComponent.select-single-option    ${payers_selector}[payers-select]    value    ${payer_value}
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${PRECONDITION_PAYER_SELECT_BOX_NOT_ATTACHED}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${PRECONDITION_PAYER_SELECT_BOX_NOT_ENABLED}
    EXCEPT    ${POSTCONDITION_FAILED}
        Exception.custom-fail    ${POSTCONDITION_UNABLE_TO_SELECT_PAYER}
    END
