*** Settings ***
Library     RPA.Browser.Playwright
Library     String


*** Keywords ***
custom-fail
    [Documentation]    wrapper over the builtin Fail keyword, to support additional operations during failure
    [Tags]    exception
    [Arguments]    ${error_msg}
    Log    <===Custom exception:${error_msg}===>    ERROR
    Fail    ${error_msg}

get-error-message-from-retry-exception-template
    [Documentation]    Method used to get the actual error message from string(Error msg from retry)
    [Tags]    exception
    [Arguments]    ${error_msg}

    @{error_msg_slip}=    String.Split String    ${error_msg}    separator=The last error was:
    RETURN    ${error_msg_slip[1].strip()}
