*** Settings ***
Library     CustomLogListener


*** Keywords ***
info-logger
    [Arguments]    ${message}
    Log    ${message}    INFO

warn-logger
    [Arguments]    ${message}
    Log    ${message}    WARN

debug-logger
    [Arguments]    ${message}
    Log    ${message}    DEBUG

error-logger
    [Arguments]    ${message}
    Log    ${message}    ERROR
