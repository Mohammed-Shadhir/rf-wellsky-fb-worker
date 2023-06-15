*** Settings ***
Library     RPA.Browser.Playwright
Resource    ./robots/pages/wellsky/LoginPage.robot
Resource    ./robots/pages/wellsky/common/Navbar.robot
Resource    ./robots/pages/wellsky/BillingManagerPage.robot
Resource    ./robots/functions/commons/CommonUtilities.robot


*** Keywords ***
perform-login-process
    [Documentation]    Performs Login Process
    [Tags]    function
    [Arguments]    ${username}
    CommonUtilities.launch
    LoginPage.set-username    ${username}
    LoginPage.set-password
    LoginPage.perform-login

navigate-to-billing-manager
    [Documentation]    Clicks GOTO menu and Billing manager
    [Tags]    function
    Navbar.open-menu-item    Go To    Billing Manager

navigate-to-Eoe
    [Documentation]    Clicks EOE menu and Ready to send
    [Tags]    function
    BillingManagerPage.open-claims-manager    Medicare    EOE    Ready to Send
