*** Settings ***
Resource         ../../../resources/common/session.resource
Resource         ../../../resources/clients/users.resource
Resource         ../../../resources/keywords/validators.resource
Suite Setup      Open API Session
Suite Teardown   Close API Session
Test Tags        users    get

*** Variables ***
${KNOWN_ID}      2

*** Test Cases ***
Get Single User Should Return User
    [Tags]    positive    smoke
    ${resp}=    Get Single User    ${KNOWN_ID}
    Status Should Be    ${resp}    200
    ${json}=    Set Variable    ${resp.json()}
    Should Be Equal As Integers    ${json}[data][id]    ${KNOWN_ID}
    Dictionary Should Contain Key    ${json}[data]    email
    Dictionary Should Contain Key    ${json}[data]    first_name
    Dictionary Should Contain Key    ${json}[data]    last_name
