*** Settings ***
Library     RPA.Browser.Playwright
Library     XML
Resource    ./robots/exceptions/Exception.robot
Resource    ./robots/functions/commons/CommonUtilities.robot
Resource    ./robots/components/InputTextComponent.robot
Resource    ./robots/components/ButtonComponent.robot
Resource    ./robots/components/commons/ComponentStatus.robot


*** Variables ***
${login_page_xpath}=        //title
${login_page_css}=          form[id="loginform"]
${global-retry-count}=      3


*** Keywords ***
launch
    New Browser    chromium    headless=False
    New Context    viewport={'width': 1280, 'height': 720}    acceptDownloads=True    ignoreHTTPSErrors=False
    New Page    https://www.kinnser.net

set-username
    [Arguments]    ${username}
# checking for valid lnding page
    ${is_valid_landing_page}=    CommonUtilities.check-page-title-and-data-form-name
    ...    xpath=${login_page_xpath}
    ...    css=${login_page_css}
    IF    ${is_valid_landing_page} == ${false}
        Exception.custom-fail    ${LOGIN_PAGE_NOT_LOADED_ERROR}
    END
    TRY
        ${user-name-selector}=    get-loginform-selector    username
        Log To Console    ${user-name-selector}
        InputTextComponent.set-value    ${user-name-selector}    ${username}    ${global-retry-count}    # id=username
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${USERNAME_FIELD_NOT_ATTACHED}
    EXCEPT    ${ELEMENT_NOT_EDITABLE}
        Exception.custom-fail    ${USERNAME_FIELD_NOT_EDITABLE}
    EXCEPT    ${POSTCONDITION_FAILED}
        Exception.custom-fail    ${USERNAME_FIELD_VALUE_NOT_POPULATED}
    END

set-password
    # PreCondition guard
    ${has_precondition_passed}=    CommonUtilities.check-page-title-and-data-form-name
    ...    xpath=${login_page_xpath}
    ...    css=${login_page_css}
    IF    ${has_precondition_passed} == ${False}
        Exception.custom-fail    ${LOGIN_PAGE_NOT_LOADED_ERROR}
    END

    TRY
        ${password-selector}=    get-loginform-selector    password
        InputTextComponent.set-password-secret    ${password-selector}    ${global-retry-count}    # id=password
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${PASSWORD_FIELD_NOT_ATTACHED}
    EXCEPT    ${ELEMENT_NOT_EDITABLE}
        Exception.custom-fail    ${PASSWORD_FIELD_NOT_EDITABLE}
    EXCEPT    ${POSTCONDITION_FAILED}
        # PostCondition guard
        Exception.custom-fail    ${PASSWORD_FIELD_VALUE_NOT_POPULATED}
    END

perform-login
    Sleep    1s
    # PreCondition guard
    ${has_precondition_passed}=    CommonUtilities.check-page-title-and-data-form-name
    ...    xpath=${login_page_xpath}
    ...    css=${login_page_css}
    IF    ${has_precondition_passed} == ${False}
        Exception.custom-fail    ${LOGIN_PAGE_NOT_LOADED_ERROR}
    END

    TRY
        ${login-button-selector}=    get-loginform-selector    login-btn
        Handle Future Dialogs    action=accept
        ButtonComponent.left-click    ${login-button-selector}    # xpath=//button[@id='login_btn']
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${LOGIN_BUTTON_NOT_ATTACHED}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${LOGIN_BUTTON_NOT_ENABLED}
    END

    ${error-message-selector}=    get-loginform-selector    error-message
    Sleep    1s
    ${is-attached}=    ComponentStatus.is-attached    ${error-message-selector}
    IF    ${is-attached} == ${True}
        ${error-message-selector-element}=    RPA.Browser.Playwright.Get Element    ${error-message-selector}
        ${login-error-message}=    Get Property    ${error-message-selector-element}    innerHTML
        ${is_invalid_credential}=    CommonUtilities.check-string-contains
        ...    ${login-error-message}
        ...    You have entered an invalid username or password
        IF    ${is_invalid_credential}
            Exception.custom-fail    ${INVALID_CREDENTIALS_ERROR}
        END
    END

    # PostCondition guard
    # ${headermenu-selector}=    get-headermenu-selector
    ${login_postcondition_flag}=    ComponentStatus.is-visible    xpath=//tbody//div[@class="menuBar"]
    IF    ${login_postcondition_flag} == ${False}
        ${has_precondition_passed}=    CommonUtilities.check-page-title-and-data-form-name
        ...    xpath=${login_page_xpath}
        ...    css=${login_page_css}
        IF    ${has_precondition_passed} == ${False}
            Log To Console    <== Found blank page after clicking the login button, Reloading the page ==>
            Reload
            ${login_postcondition_flag}=    ComponentStatus.is-visible    xpath=//tbody//div[@class="menuBar"]
        ELSE
            Log To Console    <== After clicking the login button, still in the login page ==>
        END
        Exception.custom-fail    ${HOME_PAGE_NOT_FOUND_ERROR}
    END

get-loginform-selector
    [Arguments]    ${field-selector}
    RETURN    ${selectors}[e5][wellsky][loginpage][loginform][${field-selector}]
