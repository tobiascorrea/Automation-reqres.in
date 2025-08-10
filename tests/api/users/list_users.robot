*** Settings ***
Resource         ../../../resources/common/session.resource
Resource         ../../../resources/clients/users.resource
Resource         ../../../resources/keywords/validators.resource
Suite Setup      Open API Session
Suite Teardown   Close API Session
Test Tags        users    list    contract

*** Test Cases ***
SCRUM-T4 List Users - Page 2 Should Return Data
    [Tags]    smoke
    ${resp}=    List Users    2
    Status Should Be    ${resp}    200
    ${json}=    Set Variable    ${resp.json()}
    Dictionary Should Contain Key    ${json}    data
    Should Be True    ${json}[page] == 2
    ${first}=    Set Variable    ${json}[data][0]
    Dictionary Should Contain Key    ${first}    id
    Dictionary Should Contain Key    ${first}    email
    Dictionary Should Contain Key    ${first}    first_name
    Dictionary Should Contain Key    ${first}    last_name
