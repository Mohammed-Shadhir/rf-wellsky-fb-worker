*** Settings ***
Library     RPA.Browser.Playwright
# Library    CustomLogListener
Resource    ./robots/functions/commons/CommonUtilities.robot
Resource    ./robots/functions/commons/LogUtilities.robot
Resource    ./robots/components/ButtonComponent.robot
Resource    ./robots/pages/wellsky/LoginPage.robot
Resource    ./robots/components/commons/ComponentStatus.robot
Resource    ./robots/exceptions/Exception.robot


*** Keywords ***
click-logout
    [Documentation]    Checks and clicks logout button
    TRY
        # ${logout-selector}=    get-logout-selector
        ${logout-selector}=    Set Variable    xpath=//div[@class="right"]//a[@href]
        ButtonComponent.left-click    ${logout-selector}
        CommonUtilities.check-page-title-and-data-form-name    //title    form[id="loginform"]
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${WELLSKY_BUSINESS_LOGOUT_BUTTON_NOT_ATTACHED}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${DEVERO_BUSINESS_LOGOUT_BUTTON_NOT_ENABLED}
    END

get-loader-selector
    [Documentation]    Gets the header selector
    RETURN    ${selectors}[e5][wellsky][header][loader]

wait-for-loader
    [Documentation]    Method waits for the loader to disappear in wellsky
    # [Arguments]    ${loader_selector}
    Wait Until Network Is Idle
    ${loader}=    get-loader-selector
    ${loader_completed}=    ComponentStatus.is-attached    ${loader}
    IF    ${loader_completed}
        Log To Console    Loader completed
    ELSE
        Exception.custom-fail    ${LOADER_STILL_PRESENT}
    END
