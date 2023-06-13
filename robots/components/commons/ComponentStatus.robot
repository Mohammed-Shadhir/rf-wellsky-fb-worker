*** Settings ***
Library     RPA.Browser.Playwright


*** Variables ***
${timeout}      60s


*** Keywords ***
is-checked
    [Documentation]    Checks whether the given selector is checked or not
    [Arguments]    ${selector}
    [Tags]      component
    Sleep    1s
    @{element_states}=    Get Element States    ${selector}
    ${is-checked}=    Set Variable If    '${ELEMENT_STATE_CHECKED}' in ${element_states}    ${True}    ${False}
    RETURN    ${is-checked}

is-unchecked
    [Documentation]    Checks whether the given selector is unchecked or not
    [Arguments]    ${selector}
    [Tags]      component
    Sleep    1s
    @{element_states}=    Get Element States    ${selector}
    ${is-unchecked}=    Set Variable If    '${ELEMENT_STATE_UNCHECKED}' in ${element_states}    ${True}    ${False}
    RETURN    ${is-unchecked}

is-enabled
    [Documentation]    checks whether the given selector is enabled
    [Arguments]    ${selector}
    [Tags]      component
    ${result}=    get-element-state    ${selector}    ${ELEMENT_STATE_ENABLED}
    RETURN    ${result}

is-visible
    [Documentation]    checks whether the given selector is visible
    [Arguments]    ${selector}
    [Tags]      component
    ${result}=    get-element-state    ${selector}    ${ELEMENT_STATE_VISIBLE}
    RETURN    ${result}

is-editable
    [Documentation]    checks whether the given selector is editable
    [Arguments]    ${selector}
    [Tags]      component
    ${result}=    get-element-state    ${selector}    ${ELEMENT_STATE_EDITABLE}
    RETURN    ${result}

is-attached
    [Documentation]    checks whether the given selector is attached to the DOM
    [Arguments]    ${selector}
    [Tags]      component
    ${result}=    get-element-state    ${selector}    ${ELEMENT_STATE_ATTACHED}
    RETURN    ${result}

is-hidden
    [Documentation]    checks whether the given selector is hidden
    [Arguments]    ${selector}
    [Tags]      component
    ${result}=    get-element-state    ${selector}    ${ELEMENT_STATE_HIDDEN}
    RETURN    ${result}

get-element-state
    [Documentation]    Used to get the element state
    [Arguments]    ${selector}    ${state}
    [Tags]      component
    ${result}=    Run Keyword And Return Status    Wait For Elements State    ${selector}    ${state}
    RETURN    ${result}
