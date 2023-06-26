*** Settings ***
Library     RPA.Browser.Playwright
Library     String
Resource    ./robots/exceptions/Exception.robot
Resource    ./robots/functions/commons/CommonUtilities.robot
Resource    ./robots/components/InputTextComponent.robot
Resource    ./robots/components/ButtonComponent.robot
Resource    ./robots/components/commons/ComponentStatus.robot
Resource    ./robots/pages/wellsky/ClaimsManagerPage.robot
Resource    ./robots/resources/variables.resource
Resource    ./robots/pages/wellsky/common/Header.robot


*** Keywords ***
get-selector-in-billing-manager
    [Documentation]    Gets selector for given key
    [Arguments]    ${key}
    RETURN    ${selectors}[e5][wellsky][billing-manager][${key}]

open-claims-manager
    [Documentation]    Check whether the section is present
    ...    Clicks the claims button having given text and selects the given status
    [Arguments]    ${section}    ${claim_name}    ${claim_status}

    ${section_selector}=    get-selector-in-billing-manager    section-header
    ${claim_name_selector}=    get-selector-in-billing-manager    claim-dropdown
    ${claim_status_selector}=    get-selector-in-billing-manager    claim-option

    ${placeholder_dict}=    Create Dictionary
    ...    $SECTION_HEADER$=${section}
    ...    $CLAIM_DROPDOWN$=${claim_name}
    ...    $CLAIM_OPTION$=${claim_status}
    ${section_selector}=    CommonUtilities.replace-dynamic-values-in-selector
    ...    ${section_selector}
    ...    ${placeholder_dict}
    ${claim_name_selector}=    CommonUtilities.replace-dynamic-values-in-selector
    ...    ${claim_name_selector}
    ...    ${placeholder_dict}
    ${claim_status_selector}=    CommonUtilities.replace-dynamic-values-in-selector
    ...    ${claim_status_selector}
    ...    ${placeholder_dict}
    Header.wait-for-loader
    # Pre-condition
    ${is-section-attached}=    ComponentStatus.is-attached    ${section_selector}
    IF    ${is-section-attached} == ${False}
        Exception.custom-fail    ${SECTION_NOT_FOUND_IN_BILLING_MANAGER_PAGE}
    END
    TRY
        ButtonComponent.left-click    ${claim_name_selector}
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${CLAIM_BUTTON_NOT_FOUND_IN_BILLING_MANAGER_PAGE}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${CLAIM_BUTTON_NOT_ENABLED_IN_BILLING_MANAGER_PAGE}
    END
    Sleep    0.5s
    TRY
        ButtonComponent.left-click    ${claim_status_selector}
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${CLAIM_STATUS_NOT_FOUND_IN_BILLING_MANAGER_PAGE}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${CLAIM_STATUS_NOT_ENABLED_IN_BILLING_MANAGER_PAGE}
    END
    Header.wait-for-loader
    # Post-condition
    ${claims_manager_heading}=    Set Variable    Claims Manager:
    ${is_patient_section}=    CommonUtilities.compare-strings    ${section}    Patients
    IF    ${is_patient_section} == ${True}
        ${claims_manager_heading}=    Set Variable    Outstanding Patient Balances
    END

    ${claims_manager_page_header_selector}=    ClaimsManagerPage.get-header-selector

    ${actual_claims_manager_heading}=    Get Property    ${claims_manager_page_header_selector}    innerText
    ${is_heading_matches}=    CommonUtilities.check-string-contains
    ...    ${actual_claims_manager_heading}
    ...    ${claims_manager_heading}
    IF    ${is_heading_matches} == ${False}
        Exception.custom-fail    ${POST_CONDITION_CLAIMS_MANAGER_PAGE_NOT_FOUND}
    END

    ${claim_status_tab_selector}=    ClaimsManagerPage.get-selectors-for-tab    ${claim_status}
    ${class_attribute}=    Get Attribute    ${claim_status_tab_selector}[container]    class
    IF    "'active' in ${class_attribute}" == ${False}
        Exception.custom-fail    ${POST_CONDITION_CLAIM_STATUS_NOT_ACTIVE}
    END
    Log To Console    Postcondition ==${class_attribute}== passed
