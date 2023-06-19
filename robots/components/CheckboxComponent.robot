*** Settings ***
Library    RPA.Browser.Playwright
Resource    ./robots/components/commons/ComponentStatus.robot
Resource    ./robots/components/commons/Validation.robot
Resource    ./robots/exceptions/Exception.robot
Resource    ./robots/resources/variables.resource

*** Keywords ***

get-value
    [Documentation]    Gets the current checkbox status
    [Arguments]    ${selector}
    [Tags]    component
    Validation.fail-if-not-attached    ${selector}
    ${is_checked}=    Get Checkbox State    ${selector}
    RETURN    ${is_checked}

set-checkbox-value-and-validate-post-condition
    [Documentation]    Updates the Field value and checks for post condition
    ...    And retries if the retry value is provided
    [Tags]     component
    [Arguments]    ${selector}    ${perform_check}
    Validation.fail-if-not-enabled    ${selector}
    Validation.fail-if-not-attached    ${selector}
    IF    ${perform_check} == ${True}
        ## Performs Check Operation
        Check Checkbox    ${selector}    force=True
    ELSE
        ## Performs Uncheck Operation
        Uncheck Checkbox    ${selector}    force=True
    END
    ${is_checked}=    CheckboxComponent.get-value    ${selector}
    IF    ${is_checked} != ${perform_check}    Fail    ${POSTCONDITION_FAILED}