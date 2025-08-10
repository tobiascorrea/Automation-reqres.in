*** Settings ***
Resource         ../../../resources/common/session.resource
Resource         ../../../resources/clients/auth.resource
Resource         ../../../resources/keywords/validators.resource
Suite Setup      Open API Session
Suite Teardown   Close API Session
Test Tags        auth    login

*** Variables ***
${EMAIL}      eve.holt@reqres.in
${PASSWORD}   cityslicka

*** Test Cases ***
SCRUM-T1 Login Should Return Token
    [Tags]    smoke    positive
    ${resp}=    Login User    ${EMAIL}    ${PASSWORD}
    Status Should Be    ${resp}    200
    Response Should Contain Keys    ${resp}    token
    Field Should Not Be Empty       ${resp}    token
