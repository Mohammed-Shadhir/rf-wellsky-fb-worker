*** Settings ***
Library    RPA.Browser.Playwright
Resource    ./robots/exceptions/Exception.robot
Resource    ./robots/resources/variables.resource
Resource    ./robots/functions/commons/CommonUtilities.robot
Resource    ./robots/components/commons/Validation.robot

*** Keywords ***
set-value
    [Documentation]    Updates Field Value and checks for post condition
    ...    And retries if the retry value is provided
    [Arguments]    ${selector}    ${value}    ${retry_count}
    [Tags]    component

    Validation.fail-if-not-attached    ${selector}
    Validation.fail-if-not-editable    ${selector}
    TRY
        Wait Until Keyword Succeeds
        ...    ${retry_count}
        ...    1s
        ...    fill-text-and-validate-post-condition
        ...    ${selector}
        ...    ${value}
    EXCEPT    AS    ${err_msg}
        ${actual_err_msg}=    Exception.get-error-message-from-retry-exception-template    ${err_msg}
        Exception.custom-fail    ${actual_err_msg}
    END
set-password-secret
    [Documentation]    Updates Password Field
    [Arguments]    ${selector}    ${retry_count}
    [Tags]    component

    Validation.fail-if-not-attached    ${selector}
    Validation.fail-if-not-editable    ${selector}
    TRY
        Wait Until Keyword Succeeds
        ...    ${retry_count}
        ...    1s
        ...    fill-password-and-validate-post-condition
        ...    ${selector}
    EXCEPT    AS    ${err_msg}
        ${actual_err_msg}=    Exception.get-error-message-from-retry-exception-template    ${err_msg}
        Exception.custom-fail    ${actual_err_msg}
    END
fill-text-and-validate-post-condition
    [Documentation]    Updates the Field value and checks for post condition
    ...    And retries if the retry value is provided
    [Tags]    robot:private     component
    [Arguments]    ${selector}    ${value}
    Scroll To Element    ${selector}
    Fill Text    ${selector}    ${value}
    # Postcondition
    InputTextComponent.fail-if-value-not-populated    ${selector}    ${value}
fail-if-value-not-populated
    [Documentation]    Fails if the value is not populated in the given input field
    [Tags]    robot:private     component
    [Arguments]    ${selector}    ${value}
    ${populated_value}=    InputTextComponent.get-value    ${selector}
    ${matches}=    CommonUtilities.compare-strings    ${populated_value}    ${value}
    IF    "${matches}" == "${False}"    Fail    ${POSTCONDITION_FAILED}
get-value
    [Documentation]    Reads Field Value
    [Arguments]    ${selector}
    [Tags]    component
    Validation.fail-if-not-attached    ${selector}
    ${fieldTextElement}=    RPA.Browser.Playwright.Get Element    ${selector}
    ${fieldTextValue}=    Get Property    ${fieldTextElement}    value
    RETURN    ${fieldTextValue}
fill-password-and-validate-post-condition
    [Documentation]    Updates the Field value and checks for post condition
    ...    And retries if the retry value is provided
    [Tags]    robot:private     secret
    [Arguments]    ${selector}
    #Fill Secret    ${selector}    %MYUNITY_PASSWORD
    Fill Secret    ${selector}    http://a3F@ns7/#Z

