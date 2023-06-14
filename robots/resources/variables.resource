*** Variables ***
## Element states
${ELEMENT_STATE_ATTACHED}                           attached
${ELEMENT_STATE_ENABLED}                            enabled
${ELEMENT_STATE_VISIBLE}                            visible
${ELEMENT_STATE_CHECKED}                            checked
${ELEMENT_STATE_UNCHECKED}                          unchecked
${ELEMENT_STATE_EDITABLE}                           editable
${ELEMENT_STATE_HIDDEN}                             hidden

## Element state errors
${ELEMENT_NOT_ATTACHED}                             ELEMENT_NOT_ATTACHED
${ELEMENT_VALUE_NOT_ATTACHED}                       ELEMENT_VALUE_NOT_ATTACHED
${ELEMENT_NOT_ENABLED}                              ELEMENT_NOT_ENABLED
${ELEMENT_NOT_VISIBLE}                              ELEMENT_NOT_VISIBLE
${ELEMENT_NOT_EDITABLE}                             ELEMENT_NOT_EDITABLE
${SOURCE_SELECTOR_NOT_ATTACHED}                     SOURCE_SELECTOR_NOT_ATTACHED
${SOURCE_SELECTOR_NOT_ENABLED}                      SOURCE_SELECTOR_NOT_ENABLED
${TARGET_SELECTOR_NOT_ATTACHED}                     TARGET_SELECTOR_NOT_ATTACHED
${TARGET_SELECTOR_NOT_ENABLED}                      TARGET_SELECTOR_NOT_ENABLED
${ADD_BUTTON_SELECTOR_NOT_ATTACHED}                 ADD_BUTTON_SELECTOR_NOT_ATTACHED
${ADD_BUTTON_SELECTOR_NOT_ENABLED}                  ADD_BUTTON_SELECTOR_NOT_ENABLED
${DUAL_SELECTION_POSTCONDITION_FAILED}              DUAL_SELECTION_POSTCONDITION_FAILED
${POSTCONDITION_FAILED}                             POSTCONDITION_FAILED
## Login page exceptions
${LOGIN_PAGE_NOT_LOADED_ERROR}                      LOGIN_PAGE_NOT_LOADED_ERROR
${USERNAME_FIELD_NOT_ATTACHED}                      USERNAME_FIELD_NOT_ATTACHED
${USERNAME_FIELD_NOT_EDITABLE}                      USERNAME_FIELD_NOT_EDITABLE
${USERNAME_FIELD_VALUE_NOT_POPULATED}               USERNAME_FIELD_VALUE_NOT_POPULATED
${PASSWORD_FIELD_NOT_ATTACHED}                      PASSWORD_FIELD_NOT_ATTACHED
${PASSWORD_FIELD_NOT_EDITABLE}                      PASSWORD_FIELD_NOT_EDITABLE
${PASSWORD_FIELD_VALUE_NOT_POPULATED}               PASSWORD_FIELD_VALUE_NOT_POPULATED
${LOGIN_BUTTON_NOT_ATTACHED}                        LOGIN_BUTTON_NOT_ATTACHED
${LOGIN_BUTTON_NOT_ENABLED}                         LOGIN_BUTTON_NOT_ENABLED
${INVALID_CREDENTIALS_ERROR}                        INVALID_CREDENTIALS_ERROR
${USERNAME_AND_PASSWORD_FIELD_REQUIRED_ERROR}       USERNAME_AND_PASSWORD_FIELD_REQUIRED_ERROR
${ADMIN_PAGE_NOT_FOUND_ERROR}                       ADMIN_PAGE_NOT_FOUND_ERROR
${HOME_PAGE_NOT_FOUND_ERROR}                        HOME_PAGE_NOT_FOUND_ERROR
${LOGOUT_BUTTON_ERROR}                              LOGOUT_BUTTON_ERROR
${LOGOUT_NAVIGATION_ERROR}                          LOGOUT_NAVIGATION_ERROR
${HOME_PAGE_NOT_FOUND}                              HOME_PAGE_NOT_FOUND
${MENU_BAR_NOT_FOUND}                               MENU_BAR_NOT_FOUND
${MENU_BUTTON_NOT_ATTACHED}                         MENU_BUTTON_NOT_ATTACHED
${MENU_BUTTON_NOT_ENABLED}                          MENU_BUTTON_NOT_ENABLED
${SUB_MENU_BUTTON_NOT_ATTACHED}                         SUB_MENU_BUTTON_NOT_ATTACHED
${SUB_MENU_BUTTON_NOT_ENABLED}                          SUB_MENU_BUTTON_NOT_ENABLED
## Common variables
${downloads}                                        downloads
${reportName}                                       reportName
${global-retry-count}                               3x
${global-retry-timeout}                             20s
