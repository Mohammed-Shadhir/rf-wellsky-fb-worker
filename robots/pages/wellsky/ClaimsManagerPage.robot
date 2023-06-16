*** Settings ***
Library     RPA.Browser.Playwright
Library     String
Resource    ./robots/exceptions/Exception.robot
Resource    ./robots/functions/commons/CommonUtilities.robot
Resource    ./robots/components/InputTextComponent.robot
Resource    ./robots/components/ButtonComponent.robot
Resource    ./robots/components/commons/ComponentStatus.robot
Resource    ./robots/resources/variables.resource


*** Keywords ***
get-claims-manager-selectors
    [Documentation]    Gets all selectors for claims manager page
    RETURN    ${selectors}[e5][wellsky][claims-manager]

get-header-selector
    [Documentation]    Gets the header selector
    RETURN    ${selectors}[e5][wellsky][claims-manager][heading]

get-selectors-for-tab
    [Documentation]    Gets selectors for the particular tab
    [Arguments]    ${tab}
    RETURN    ${selectors}[e5][wellsky][claims-manager][tabs][${tab}]
