*** Settings ***
Library     RPA.Browser.Playwright
Resource    ./robots/pages/wellsky/LoginPage.robot
Resource    ./robots/pages/wellsky/WellSkyHomePage.robot
Resource    ./robots/functions/commons/CommonUtilities.robot

*** Keywords ***
perform-login-process
    [Documentation]    Performs Login Process
    [Arguments]    ${username}
    [Tags]    function
    CommonUtilities.launch
    LoginPage.set-username    ${username}
    LoginPage.set-password
    LoginPage.perform-login

navigate-to-billing-manager
    [Documentation]    Clicks GOTO menu and Billing manager
    [Tags]    function
    WellSkyHomePage.open-menu-item    Go To    Billing Manager
    Sleep    5s