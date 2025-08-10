*** Settings ***
Resource         ../../../resources/common/session.resource
Resource         ../../../resources/keywords/validators.resource
Library          DateTime
Suite Setup      Open API Session
Suite Teardown   Close API Session
Test Tags        misc    performance-lite

*** Variables ***
${DELAY_SECONDS}    3

*** Test Cases ***
Users Endpoint Should Respect Artificial Delay
    ${start}=    Get Time    epoch
    ${params}=   Create Dictionary    delay=${DELAY_SECONDS}
    ${resp}=     GET    /api/users    ${params}
    ${end}=      Get Time    epoch
    Status Should Be    ${resp}    200
    ${elapsed}=    Evaluate    ${end} - ${start}
    Should Be True    ${elapsed} >= ${DELAY_SECONDS} - 0.2
