*** Settings ***
Resource         ../../../resources/common/session.resource
Resource         ../../../resources/clients/unknown.resource
Resource         ../../../resources/keywords/validators.resource
Suite Setup      Open API Session
Suite Teardown   Close API Session
Test Tags        unknown    get

*** Variables ***
${KNOWN_RESOURCE_ID}      2
${UNKNOWN_RESOURCE_ID}    23

*** Test Cases ***
Get Single Resource Should Return Resource
    [Tags]    positive    smoke
    ${resp}=    Get Single Resource    ${KNOWN_RESOURCE_ID}
    Status Should Be    ${resp}    200
    ${json}=    Set Variable    ${resp.json()}
    Dictionary Should Contain Key    ${json}        data
    Dictionary Should Contain Key    ${json}[data]  id
    Should Be Equal As Integers      ${json}[data][id]    ${KNOWN_RESOURCE_ID}

Get Single Resource Should Return 404 When Not Found
    [Tags]    negative
    ${resp}=    Get Single Resource    ${UNKNOWN_RESOURCE_ID}
    Status Should Be    ${resp}    404
    Body Should Be Empty Or Empty Object    ${resp}
