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
open-claims-manager
    [Documentation]    Check whether the section is present
    ...    Clicks the claims button having given text and selects the given status
    [Arguments]    ${section}    ${claim_name}    ${claim_status}

    # Pre-condition
    ${is-section-attached}=    ComponentStatus.is-attached    //div[@id="claimsManager"]/h3[text()="${section}"]
    IF    ${is-section-attached} == ${False}
        Exception.custom-fail    ${SECTION_NOT_FOUND_IN_BILLING_MANAGER_PAGE}
    END

    ${selector_for_button}=    Set Variable
    ...    //h3[text()="${section}"]/following-sibling::div[1]//button[contains(text(),"${claim_name}")]
    TRY
        ButtonComponent.left-click    ${selector_for_button}
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${CLAIM_BUTTON_NOT_FOUND_IN_BILLING_MANAGER_PAGE}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${CLAIM_BUTTON_NOT_ENABLED_IN_BILLING_MANAGER_PAGE}
    END
    Sleep    2s
    ${selector_for_status}=    Set Variable    ${selector_for_button}/parent::div/ul/li/a[text()="${claim_status}"]

    TRY
        ButtonComponent.left-click    ${selector_for_status}
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${CLAIM_STATUS_NOT_FOUND_IN_BILLING_MANAGER_PAGE}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${CLAIM_STATUS_NOT_ENABLED_IN_BILLING_MANAGER_PAGE}
    END

    # Post-condition
    ${claims_manager_heading}=    Catenate    Claims Manager :    ${claim_name}
    ${is_patient_section}=    CommonUtilities.compare-strings    ${section}    Patients
    IF  ${is_patient_section} == ${True}
        ${claims_manager_heading}=    Set Variable    Outstanding Patient Balances
    END
    
    ${actual_claims_manager_heading}=    Get Property    //h1[@class="ng-binding"]    innerText
    Log To Console    ${actual_claims_manager_heading}, ${claims_manager_heading}
    ${is_heading_matches}=    CommonUtilities.compare-strings    ${claims_manager_heading}    ${actual_claims_manager_heading}
    IF  ${is_heading_matches} == ${False}
        Exception.custom-fail    ${POST_CONDITION_CLAIMS_MANAGER_PAGE_NOT_FOUND}
    END
    Log To Console    Postcondition passed