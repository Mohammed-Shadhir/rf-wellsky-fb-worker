*** Settings ***
Resource    ./robots/resources/variables.resource
Resource    ./robots/components/commons/ComponentStatus.robot


*** Keywords ***
fail-if-not-attached
    [Documentation]    Throws error if the element is not attanched to the DOM
    [Arguments]    ${selector}
    [Tags]      validation
    ${is-attached}=    ComponentStatus.is-attached    ${selector}
    IF    ${is-attached} == ${False}    Fail    ${ELEMENT_NOT_ATTACHED}

fail-if-not-enabled
    [Documentation]    Throws error if the element is not enabled
    [Arguments]    ${selector}
    [Tags]      validation
    ${is-enabled}=    ComponentStatus.is-enabled    ${selector}
    IF    ${is-enabled} == ${False}    Fail    ${ELEMENT_NOT_ENABLED}

fail-if-not-editable
    [Documentation]    Throws error if the element is not editable
    [Arguments]    ${selector}
    [Tags]      validation
    ${is-editable}=    ComponentStatus.is-editable    ${selector}
    IF    ${is-editable} == ${False}    Fail    ${ELEMENT_NOT_EDITABLE}
