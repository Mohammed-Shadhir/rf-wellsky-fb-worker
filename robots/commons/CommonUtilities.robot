*** Settings ***
Library     RPA.Browser.Playwright
Resource    ./robots/resources/variables.resource


*** Keywords ***
check-page-title-and-data-form-name
    [Documentation]    validates page title and data form name
    [Tags]    function
    [Arguments]    ${title}    ${data_form}
    ${has_precondition_passed}=    Set Variable    ${False}
    ${login_form_name}=    RPA.Browser.Playwright.Get Element    ${data_form}
    ${form_name}=    Get Attribute    ${login_form_name}    data-form-name
    ${title_element}=    RPA.Browser.Playwright.Get Element    ${title}
    ${page_title}=    Get Property    ${title_element}    innerText
    IF    "${form_name}" == "Login Page" and "${page_title.strip()}" == "myUnity"
        ${has_precondition_passed}=    Set Variable    ${True}
    END
    RETURN    ${has_precondition_passed}
