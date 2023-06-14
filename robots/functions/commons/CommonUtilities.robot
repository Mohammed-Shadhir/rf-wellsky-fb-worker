*** Settings ***
Library     RPA.Browser.Playwright
Resource    ./robots/resources/variables.resource


*** Keywords ***
launch
    New Browser    chromium    headless=False
    New Context    viewport={'width': 1280, 'height': 720}    acceptDownloads=True    ignoreHTTPSErrors=False
    New Page    https://www.kinnser.net

check-page-title-and-data-form-name
    [Documentation]    validates page title and data form name
    [Tags]    function
    [Arguments]    ${title}    ${data_form}
    ${has_precondition_passed}=    Set Variable    ${False}
    ${login_form_name}=    RPA.Browser.Playwright.Get Element    ${data_form}
    ${form_name}=    Get Attribute    ${login_form_name}    id
    ${title_element}=    RPA.Browser.Playwright.Get Element    ${title}
    ${page_title}=    Get Property    ${title_element}    innerHTML
    IF    "${form_name}" == "loginform" and "${page_title}" == "Kinnser Software"
        ${has_precondition_passed}=    Set Variable    ${True}
    END
    RETURN    ${has_precondition_passed}

compare-strings
    [Documentation]    Method used to compare the strings
    [Tags]    function
    [Arguments]    ${string1}    ${string2}
    ${result}=    RPA.Browser.Playwright.Evaluate JavaScript
    ...    ${None}
    ...    () => `${string1}` === `${string2}`
    RETURN    ${result}

check-string-contains
    [Documentation]    Method used to check if string1 contains string2
    [Tags]    function
    [Arguments]    ${string1}    ${string2}
    ${result}=    RPA.Browser.Playwright.Evaluate JavaScript
    ...    ${None}
    ...    () => `${string1}`.includes(`${string2}`)
    RETURN    ${result}
