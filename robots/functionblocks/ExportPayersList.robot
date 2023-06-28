*** Settings ***
Library     RPA.Browser.Playwright
Library     Collections
Resource    ../resources/variables.resource
Resource    ../functions/commons/CollectionUtilities.robot
Resource    ../functions/commons/CommonUtilities.robot
Resource    ../functions/commons/LogUtilities.robot
Resource    ../functions/wellsky/WellSkyFunctions.robot


*** Keywords ***
execute
    [Documentation]    FunctionBlock: Export payers list
    [Tags]    function-block
    [Arguments]    ${fb_payload}
    TRY
        Log To Console    <=====Function block execution: Export payers list=====>
        ${task}=    Set Variable    ${fb_payload["task"]}
        ${fbName}=    Set Variable    ${fb_payload["task"]["fbName"]}

        FOR    ${payload}    IN    @{task["fbPayload"]}
            TRY
                Log To Console    <=====Function block payload start=====>
                ${handshakeInfo}=    Set Variable    ${payload["handshakeInfo"]}

                ${result}=    export-payers-list    ${payload}
                Log To Console    ${result}
                # ${logs}=    CommonUtilities.chunk-or-compress-response
                # ...    ${fbName}
                # ...    ${handshakeInfo}
                # ...    ${report_records}
                # ...    ECR
            EXCEPT    AS    ${err_msg}
                Log To Console    ${err_msg}
                # ${error-response-details}=    Exception.transform-fb-error-message
                # ...    ${err_msg}
                # ...    MyUnity.ExportCustomReportFromDevero
                # ...    ${handshakeInfo}
                # Log    FB Exception:${error-response-details}    ERROR
                # Exception.generate-error-message-and-send-response-to-kafka    ${error-response-details}
            FINALLY
                Log To Console    ${err_msg}
                # go-to-dashboard
            END
            Log To Console    <=====Function block payload end=====>
            # push response message to event_topic in kafka
        END

        ${fbName}=    Set Variable    ${EMPTY}

        Log To Console    <=====End of Function block: Export payers list=====>
    EXCEPT    AS    ${errorMessage}
        FAIL    ${errorMessage}
    END

export-payers-list
    [Documentation]    FunctionalBlock - Export payers list
    [Tags]    robot:private
    [Arguments]    ${payload}

    ${dict}=    Create Dictionary    claim_name=EOE    claim_status=Ready to Send    section_name=Medicare
    ${dict2}=    Create Dictionary
    ...    claim_name=Primary Payer
    ...    claim_status=Ready to Send
    ...    section_name=Managed Care
    ${arr}=    Create List    ${dict}    ${dict2}

    ${json_response}=    WellSkyFunctions.get-payers-list-from-claims-manager-page    ${arr}
    RETURN    ${json_response}
