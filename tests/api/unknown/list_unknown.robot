*** Settings ***
Resource         ../../../resources/common/session.resource
Resource         ../../../resources/clients/unknown.resource
Resource         ../../../resources/keywords/validators.resource
Suite Setup      Open API Session
Suite Teardown   Close API Session
Test Tags        unknown    list    contract

*** Test Cases ***
List Unknown - Page 1 Should Return Data
    [Tags]    positive    smoke
    ${resp}=    List Resources    1    6
    Status Should Be    ${resp}    200
    ${json}=    Set Variable    ${resp.json()}
    Dictionary Should Contain Key    ${json}    data
    Should Be True    len(${json}[data]) > 0

List Unknown - High Page Returns 200 With Possibly Empty Data
    [Tags]    edge
    ${resp}=    List Resources    999    6
    Status Should Be    ${resp}    200
    ${json}=    Set Variable    ${resp.json()}
    Dictionary Should Contain Key    ${json}    data
