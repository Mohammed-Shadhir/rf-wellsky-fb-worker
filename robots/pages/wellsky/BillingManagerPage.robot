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
get-billing-manager-selectors
    [Documentation]    Gets all selectors for billing manager page
    ${billing_manager_selectors}=    Set Variable    ${selectors}[e5][wellsky][billing-manager]
    RETURN    ${billing_manager_selectors}

open-claims-manager
    [Documentation]    Check whether the section is present
    ...    Clicks the claims button having given text and selects the given status
    [Arguments]    ${section}    ${claim_name}    ${claim_status}

    ${billing_manager_selectors}=    get-billing-manager-selectors
    ${section_selectors}=    Set Variable    ${billing_manager_selectors}[sections][${section}]

    # Pre-condition
    ${is-section-attached}=    ComponentStatus.is-attached    ${section_selectors}[heading]
    IF    ${is-section-attached} == ${False}
        Exception.custom-fail    ${SECTION_NOT_FOUND_IN_BILLING_MANAGER_PAGE}
    END

    ${claim_selectors}=    Set Variable    ${section_selectors}[menu-list][${claim_name}]
    TRY
        ButtonComponent.left-click    ${claim_selectors}[selector]
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${CLAIM_BUTTON_NOT_FOUND_IN_BILLING_MANAGER_PAGE}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${CLAIM_BUTTON_NOT_ENABLED_IN_BILLING_MANAGER_PAGE}
    END
    Sleep    2s
    TRY
        ButtonComponent.left-click    ${claim_selectors}[options][${claim_status}]
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${CLAIM_STATUS_NOT_FOUND_IN_BILLING_MANAGER_PAGE}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${CLAIM_STATUS_NOT_ENABLED_IN_BILLING_MANAGER_PAGE}
    END

    # Post-condition
    ${claims_manager_heading}=    Catenate    Claims Manager:    ${claim_name}
    ${is_patient_section}=    CommonUtilities.compare-strings    ${section}    Patients
    IF  ${is_patient_section} == ${True}
        ${claims_manager_heading}=    Set Variable    Outstanding Patient Balances
    END
    
    ${actual_claims_manager_heading}=    Get Property    ${billing_manager_selectors}[post-condition-header]    innerText
    ${is_heading_matches}=    CommonUtilities.compare-strings    ${claims_manager_heading}    ${actual_claims_manager_heading}
    IF  ${is_heading_matches} == ${False}
        Exception.custom-fail    ${POST_CONDITION_CLAIMS_MANAGER_PAGE_NOT_FOUND}
    END
    Log To Console    Postcondition passed