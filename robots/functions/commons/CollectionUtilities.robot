*** Settings ***
Library     RPA.Browser.Playwright
Library     Collections


*** Keywords ***
check-key-exists-in-dictionary
    [Documentation]    checks whether the key exists in dicitonary
    [Tags]    function
    [Arguments]    ${dictionary}    ${key}
    ${is_key_exists}=    Run Keyword And Return Status    dictionary should contain key    ${dictionary}    ${key}
    RETURN    ${is_key_exists}
