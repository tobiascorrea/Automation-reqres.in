*** Settings ***
Resource         ../../../resources/common/session.resource
Resource         ../../../resources/clients/users.resource
Resource         ../../../resources/keywords/validators.resource
Suite Setup      Open API Session
Suite Teardown   Close API Session
Test Tags        users    update

*** Test Cases ***
Update User With Put Should Return UpdatedAt
    ${create}=    Create User    Morpheus    Leader
    Status Should Be    ${create}    201
    ${id}=    Set Variable    ${create.json()}[id]

    ${update}=    Update User    ${id}    Morpheus    Zion Resident
    Status Should Be    ${update}    200
    ${json}=    Set Variable    ${update.json()}
    Response Should Contain Keys    ${update}    name    job    updatedAt
    Should Be Equal    ${json}[name]    Morpheus
    Should Contain     ${json}[job]     Zion

Patch User Should Return UpdatedAt
    ${create}=    Create User    Leia    Princess
    Status Should Be    ${create}    201
    ${id}=    Set Variable    ${create.json()}[id]

    ${patch}=    Patch User    ${id}    General
    Status Should Be    ${patch}    200
    Response Should Contain Keys    ${patch}    job    updatedAt
