*** Settings ***
Library     RPA.Browser.Playwright
Resource    ./robots/components/commons/Validation.robot


*** Keywords ***
left-click
    [Documentation]    Performs left click operation on button
    [Tags]    component
    [Arguments]    ${selector}
    Log To Console    ${selector}

    Validation.fail-if-not-attached    ${selector}
    Validation.fail-if-not-enabled    ${selector}
    Scroll To Element    ${selector}
    Click    ${selector}    left    1
