*** Settings ***
Documentation    Cobertura de /api/register (feliz e negativos).
Resource         ../../../resources/common/session.resource
Resource         ../../../resources/clients/auth.resource
Resource         ../../../resources/keywords/validators.resource
Suite Setup      Open API Session
Suite Teardown   Close API Session
Test Tags        auth    register

*** Variables ***
${VALID_EMAIL}      eve.holt@reqres.in
${VALID_PASSWORD}   pistol
${MISSING_PASSWORD}    None

*** Test Cases ***
Register Should Succeed
    [Tags]    smoke    positive
    ${resp}=    Register User    ${VALID_EMAIL}    ${VALID_PASSWORD}
    Status Should Be    ${resp}    200
    Response Should Contain Keys    ${resp}    id    token
    Field Should Not Be Empty       ${resp}    token

Register Should Fail Without Password
    [Tags]    negative
    ${resp}=    Register User    ${VALID_EMAIL}    ${MISSING_PASSWORD}
    Status Should Be    ${resp}    400
    Assert Error Message    ${resp}    Missing password
