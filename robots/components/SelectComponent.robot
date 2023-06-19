*** Settings ***
Library     RPA.Browser.Playwright
Library     Collections
Resource    ./robots/components/commons/Validation.robot


*** Keywords ***
get-options
    [Documentation]    Gets select options
    [Tags]    component
    [Arguments]    ${selector}

    Validation.fail-if-not-attached    ${selector}
    Validation.fail-if-not-enabled    ${selector}

    ${select_options}=    Get Select Options    ${selector}
    RETURN    ${select_options}

select-single-option
    [Documentation]    Selects the option by given attribute
    [Tags]    component
    [Arguments]    ${selector}    ${field}    ${value}

    Validation.fail-if-not-attached    ${selector}
    Validation.fail-if-not-enabled    ${selector}
    check-option-status    ${selector}/option[@${field}="${value}"]

    ${selected}=    Select Options By    ${selector}    ${field}    ${value}
    Log To Console    ==Selected: ${selected}==
    # postcondition
    List Should Contain Value    ${selected}    ${value}    ${POSTCONDITION_FAILED}

check-option-status
    [Documentation]    Checks if the option is attached and enabled
    [Arguments]    ${selector}
    TRY
        Validation.fail-if-not-attached    ${selector}
        Validation.fail-if-not-enabled    ${selector}
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${SELECT_OPTION_NOT_ATTACHED}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${SELECT_OPTION_NOT_ENABLED}
    END
