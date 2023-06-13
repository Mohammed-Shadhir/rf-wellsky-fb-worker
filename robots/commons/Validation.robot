*** Settings ***
Resource    ./robots/components/ComponentStatus.robot
Resource    ./robots/resources/variables.resource


*** Keywords ***
fail-if-not-attached
    [Documentation]    Throws error if the element is not attanched to the DOM
    [Tags]    validation
    [Arguments]    ${selector}
    ${is-attached}=    ComponentStatus.is-attached    ${selector}
    IF    ${is-attached} == ${False}    Fail    ${ELEMENT_NOT_ATTACHED}

fail-if-not-enabled
    [Documentation]    Throws error if the element is not enabled
    [Tags]    validation
    [Arguments]    ${selector}
    ${is-enabled}=    ComponentStatus.is-enabled    ${selector}
    IF    ${is-enabled} == ${False}    Fail    ${ELEMENT_NOT_ENABLED}

fail-if-not-editable
    [Documentation]    Throws error if the element is not editable
    [Tags]    validation
    [Arguments]    ${selector}
    ${is-editable}=    ComponentStatus.is-editable    ${selector}
    IF    ${is-editable} == ${False}    Fail    ${ELEMENT_NOT_EDITABLE}
