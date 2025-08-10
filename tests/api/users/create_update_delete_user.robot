*** Settings ***
Resource         ../../../resources/common/session.resource
Resource         ../../../resources/clients/users.resource
Resource         ../../../resources/keywords/validators.resource
Suite Setup      Open API Session
Suite Teardown   Close API Session
Test Tags        users    crud    ddt
Library          DataDriver    file=../../../data/datasets/users_create.csv    dialect=excel    encoding=utf-8
Test Template    Create-Update-Delete User Flow

*** Test Cases ***
# Caso semente — DataDriver gera um por linha do CSV e substitui {name}/{job}
SCRUM-T6 Create-Update-Delete User Flow - {name}/{job}

*** Keywords ***
Create-Update-Delete User Flow
    [Arguments]    ${name}    ${job}

    # CREATE
    ${create}=    Create User    ${name}    ${job}
    Status Should Be    ${create}    201
    ${cjson}=    Set Variable    ${create.json()}
    ${user_id}=  Set Variable    ${cjson}[id]

    # UPDATE (PUT)
    ${updated_job}=    Catenate    SEPARATOR=    ${job}    Engineer
    ${update}=    Update User    ${user_id}    ${name}    ${updated_job}
    Status Should Be    ${update}    200
    ${ujson}=    Set Variable    ${update.json()}
    Should Be Equal    ${ujson}[name]    ${name}
    Should Contain     ${ujson}[job]     Engineer

    # DELETE
    ${delete}=    Delete User    ${user_id}
    Status Should Be    ${delete}    204
