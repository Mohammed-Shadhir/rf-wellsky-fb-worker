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
Resource    ./robots/components/CheckboxComponent.robot
Resource    ./robots/pages/wellsky/common/Header.robot


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
        Header.wait-for-loader
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${PRECONDITION_PAYER_SELECT_BOX_NOT_ATTACHED}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${PRECONDITION_PAYER_SELECT_BOX_NOT_ENABLED}
    EXCEPT    ${POSTCONDITION_FAILED}
        Exception.custom-fail    ${POSTCONDITION_UNABLE_TO_SELECT_PAYER}
    END
    ${payer_options}=    Get Select Options    ${payers_selector}[payers-select]
    RETURN    ${payer_options}

select-patients-checkbox
    [Documentation]    Checks the checkbox in the header in the page
    ${checkbox_selector}=    get-claims-manager-selectors
    TRY
        CheckboxComponent.set-checkbox-value-and-validate-post-condition
        ...    ${checkbox_selector}[checkbox][header-checkbox]
        ...    ${True}
        ...    ${checkbox_selector}[checkbox][post-validation]
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${PRECONDITION_HEADER_CHECKBOX_NOT_ATTACHED}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${PRECONDITION_HEADER_CHECKBOX_NOT_ENABLED}
    EXCEPT    ${POSTCONDITION_FAILED}
        Exception.custom-fail    ${POST_CONDITION_UNABLE_TO_CHECK_CHECKBOX}
    END

click-claim-action-button
    [Documentation]    Clicks on the claim action button in the page
    ${claim_action_selector}=    get-claims-manager-selectors
    TRY
        ButtonComponent.left-click    ${claim_action_selector}[tabs][Ready to Send][claim-button]
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${PRECONDITION_CLAIM_BUTTON_NOT_ATTACHED}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${PRECONDITION_CLAIM_BUTTON_NOT_ENABLED}
    END
    # Postcondition checks if the dropdown is open
    Validation.fail-if-not-attached    ${claim_action_selector}[tabs][Ready to Send][claim-dropdown]

select-claim-action-dropdown
    [Documentation]    Selects the claim action in the dropdown
    [Arguments]    ${claim_action}
    ${claim_action_dropdown_selector}=    get-claims-manager-selectors
    TRY
        ${action}=    Create Dictionary    $CLAIM_ACTION$=${claim_action}
        ${dropdown_selector}=    CommonUtilities.replace-dynamic-values-in-selector
        ...    ${claim_action_dropdown_selector}[tabs][Ready to Send][claim-action]
        ...    ${action}
        ButtonComponent.left-click    ${dropdown_selector}
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${PRECONDITION_ACTION_SELECT_BOX_NOT_ATTACHED}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${PRECONDITION_ACTION_SELECT_BOX_NOT_ENABLED}
    EXCEPT    ${POSTCONDITION_FAILED}
        Exception.custom-fail    ${POSTCONDITION_ACTION_TO_SELECT_PAYER}
    END

get-table-row-count
    [Documentation]    Returns the number of rows in the table and returns the
    ...    count with type integer
    ${table_selector}=    get-claims-manager-selectors
    ${row_count}=    Get Element Count    ${table_selector}[table-container]
    ${row_count}=    Convert To Integer    ${row_count}
    ${no_records}=    ComponentStatus.is-attached    ${table_selector}[table-container]/td[ contains(. , "no records")]
    IF    ${row_count} == 1 and ${no_records}
        ${row_count}=    Set Variable    0
    END
    Log To Console    <========Log message::The number of rows are: ${row_count}==========>
    RETURN    ${row_count}
