*** Settings ***
Library     RPA.Browser.Playwright
# Library    CustomLogListener
Resource    ./robots/functions/commons/CommonUtilities.robot
Resource    ./robots/functions/commons/LogUtilities.robot
Resource    ./robots/components/ButtonComponent.robot
Resource    ./robots/pages/LoginPage.robot


*** Tasks ***
click_logout
    LoginPage.load-selectors
    CommonUtilities.launch
    LoginPage.set-username    E5Bot1
    LoginPage.set-password
    LoginPage.perform-login
    click-logout


*** Keywords ***
get-logout-selector
    [Documentation]    fetches devero home page logout selector
    RETURN    ${selectors}[e5][wellsky][homepage][logout]

click-logout
    [Documentation]    Checks and clicks logout button
    TRY
        ${logout-selector}=    get-logout-selector
        #${logout-selector}    Set Variable    xpath=//div[@class="right"]//a[@href]
        ButtonComponent.left-click    ${logout-selector}
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${WELLSKY_BUSINESS_LOGOUT_BUTTON_NOT_ATTACHED}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${WELLSKY_BUSINESS_LOGOUT_BUTTON_NOT_ENABLED}
    END
    ${is_valid_landing_page}=    CommonUtilities.check-page-title-and-data-form-name    //title    form[id="loginform"]
    IF    ${is_valid_landing_page} == ${False}
        exception.custom-fail    ${FAILED_TO_LOGOUT}
        
    END
