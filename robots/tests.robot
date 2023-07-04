*** Settings ***
Library     Config
Library    RPA.Browser.Playwright
Resource    ./robots/functions/wellsky/WellSkyFunctions.robot
Suite Setup         init

*** Test Cases ***
Login function success
    New Page    https://dopple-dev.e5.ai/player/flow/216
    WellSkyFunctions.perform-login-process    E5bot3
    Log To Console    Login function success => Finished

Login function - home not found 1
    New Page    https://dopple-dev.e5.ai/player/flow/217
    TRY
        WellSkyFunctions.perform-login-process    E5bot3
    EXCEPT    AS    ${error_msg}
        Log To Console    Inside 2nd test case: ${error_msg}
        Should Be True	'${error_msg}' == 'HOME_PAGE_NOT_FOUND_ERROR'
    END
    Log To Console    Login function - home not found => Finished
    
Login function - home not found 2
    New Page    https://dopple-dev.e5.ai/player/flow/217
    TRY
        WellSkyFunctions.perform-login-process    E5bot3
    EXCEPT    AS    ${error_msg}
        Log To Console    Inside 2nd test case: ${error_msg}
        Should Be True	'${error_msg}' == 'HOME_PAGE_NOT_FOUND_ERROR_dummy'
    END
    Log To Console    Login function - home not found => Finished
    
Navigate to billing manager page
    New Page    https://dopple-dev.e5.ai/player/flow/218
    TRY
        WellSkyFunctions.navigate-through-tab    Go To    Billing Manager
    EXCEPT    AS    ${error_msg}
        Log To Console    Inside 2nd test case: ${error_msg}
    END
    Log To Console    Navigate to billing manager page => Finished
    
Navigate to billing manager page - Sub menu not found
    New Page    https://dopple-dev.e5.ai/player/flow/219
    TRY
        WellSkyFunctions.navigate-through-tab    Go To    Billing Manager
    EXCEPT    AS    ${error_msg}
        Log To Console    Inside 2nd test case: ${error_msg}
    END
    Log To Console    Navigate to billing manager page => Finished
    
*** Keywords ***
init
    load-selectors
    launch-browser

load-selectors
    ${selectors}=    Config.Initialize Selectors    ./yamls/selectors.yaml
    Set Global Variable    ${selectors}

launch-browser
    # [Arguments]    ${url}
    ${launch_args}=  Create List    
    ...    --disable-extensions-except=D:${/}Users${/}bharani.deepan${/}Documents${/}dopple-projects${/}dopple-web-agent${/}dist_dev    
    ...    --load-extension=D:${/}Users${/}bharani.deepan${/}Documents${/}dopple-projects${/}dopple-web-agent${/}dist_dev
    New Persistent Context    
    ...    browser=chromium  
    ...    headless=False  
    # ...    url=https://www.kinnser.net
    # ...    url=${url}
    ...    args=${launch_args}