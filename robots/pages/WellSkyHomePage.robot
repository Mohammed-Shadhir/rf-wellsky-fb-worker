*** Settings ***
Library    RPA.Browser.Playwright
Library    String
Resource    ./robots/exceptions/Exception.robot
Resource    ./robots/functions/commons/CommonUtilities.robot
Resource    ./robots/components/InputTextComponent.robot
Resource    ./robots/components/ButtonComponent.robot
Resource    ./robots/components/commons/ComponentStatus.robot
Resource    ./robots/resources/variables.resource
*** Variables ***
${tab_name}=    Go To
${sub_tab_name}=    Billing Manager

*** Keywords ***
open-menu-item
    [Documentation]    This is used to open the menu item in the wellsky home page. SUB_TAB_NAME is an optional argument.
    [Arguments]    ${tab_name}    ${sub_tab_name}=${None}
    ${is-menu-attached}=    ComponentStatus.is-attached    xpath=//tbody//div[@class="menuBar"]
    IF    ${is-menu-attached} == ${False}
        Exception.custom-fail    ${MENU_BAR_NOT_FOUND}
    END
    IF    ${TAB_NAME} == Search
        search-Keyword    ${tab_name}    ${sub_tab_name}
    ELSE
       select-menu-dropdown    ${tab_name}    ${sub_tab_name} 
    END
search-Keyword
    [Documentation]    This method is exclusive for the search function in the wellsky menu bar
    [Arguments]    ${tab}    ${keyword}
select-menu-dropdown
    [Documentation]    This method selects the tab and sub tab from the dropdown in wellsky
    [Arguments]    ${tab}    ${sub_tab}
    ${is-menu-attached}=    ComponentStatus.is-attached    xpath=//tbody//div[@class="menuBar"]
    IF    ${is-menu-attached} == ${False}
        Exception.custom-fail    ${MENU_BAR_NOT_FOUND}
    END
    TRY
        ButtonComponent.left-click    xpath=//div[@class="menuBar"]/a[contains(@class, "menuButton") and text()="${tab}"]
        
    EXCEPT    ${ELEMENT_NOT_ATTACHED}
        Exception.custom-fail    ${MENU_BUTTON_NOT_ATTACHED}
    EXCEPT    ${ELEMENT_NOT_ENABLED}
        Exception.custom-fail    ${MENU_BUTTON_NOT_ENABLED}
        
    END
    

