*** Settings ***
Library     RPA.Browser.Playwright
Library     String
Resource    ./robots/exceptions/Exception.robot
Resource    ./robots/functions/commons/CommonUtilities.robot
Resource    ./robots/components/InputTextComponent.robot
Resource    ./robots/components/ButtonComponent.robot
Resource    ./robots/components/commons/ComponentStatus.robot
Resource    ./robots/resources/variables.resource


*** Variables ***
# ${tab_name}=    Go To
# ${sub_tab_name}=    Billing Manager


*** Keywords ***
get-nav-bar-selectors
    [Documentation]    Gets selectors of particular tab
    ${dictionary}=    Set Variable    ${selectors}[e5][wellsky][nav-bar]
    RETURN    ${dictionary}

open-menu-item
    [Documentation]    This is used to open the menu item in the wellsky home page. SUB_TAB_NAME is an optional argument.
    [Arguments]    ${tab_name}    ${sub_tab_name}
    ${navbar_selectors}=    get-nav-bar-selectors
    ${is-menu-attached}=    ComponentStatus.is-attached    ${navbar_selectors}[container]
    ${navbar_tabs_selectors}=    Set Variable    ${navbar_selectors}[tabs][${tab_name}]
    IF    ${is-menu-attached} == ${False}
        Exception.custom-fail    ${MENU_BAR_NOT_FOUND}
    END
    ${is_search}=    CommonUtilities.compare-strings    ${tab_name}    Search
    IF    ${is_search}
        search-Keyword    ${navbar_tabs_selectors}[name]    ${sub_tab_name}
    ELSE
        select-menu-dropdown    ${navbar_tabs_selectors}[name]    ${navbar_tabs_selectors}[sub-tabs][${sub_tab_name}]
        
    END

search-Keyword
    [Documentation]    This method is exclusive for the search function in the wellsky menu bar
    [Arguments]    ${tab_selector}    ${keyword}
    TRY
        ${navbar_selector}=    get-nav-bar-selectors
        ButtonComponent.left-click    ${tab_selector}
        ${keyword}=    Convert To String    ${keyword}
        InputTextComponent.set-value    ${navbar_selector}[tabs][Search][sub-tabs][search]        ${keyword}    3
        Press Keys    ${navbar_selector}[tabs][Search][sub-tabs][search]    Enter
        ${search_value}=    Replace String    ${navbar_selector}[tabs][Search][sub-tabs][value]    $VALUE$    ${keyword}
        Sleep    3s
        ButtonComponent.left-click    ${search_value}

    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${MENU_BUTTON_NOT_ATTACHED}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${MENU_BUTTON_NOT_ENABLED}
    END

    Sleep    2s

select-menu-dropdown
    [Documentation]    This method selects the tab and sub tab from the dropdown in wellsky
    [Arguments]    ${tab_selector}    ${sub_tab_selector}
    TRY
        ButtonComponent.left-click    ${tab_selector}
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${MENU_BUTTON_NOT_ATTACHED}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${MENU_BUTTON_NOT_ENABLED}
    END

    Sleep    2s

    TRY
        ButtonComponent.left-click    ${sub_tab_selector}
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${SUB_MENU_BUTTON_NOT_ATTACHED}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${SUB_MENU_BUTTON_NOT_ENABLED}
    END
