*** Settings ***
Resource         ../../../resources/common/session.resource
Resource         ../../../resources/clients/users.resource
Resource         ../../../resources/keywords/validators.resource
Suite Setup      Open API Session
Suite Teardown   Close API Session

# DataDriver:
# - dialect=excel -> separador vírgula
# - NADA de "arguments=" aqui.
Library          DataDriver    file=../../../data/datasets/users_create.csv    dialect=excel    encoding=utf-8

# Template recebe ${name} e ${job} (nomes batem com cabeçalhos do CSV)
Test Template    Create-Update-Delete User Flow
Test Tags        users    crud    regression

*** Test Cases ***
# Caso "semente" — DataDriver vai gerar um por linha do CSV
DDT

*** Keywords ***
Create-Update-Delete User Flow
    [Arguments]    ${name}    ${job}
    # CREATE
    ${create}=    Create User    ${name}    ${job}
    Status Should Be    ${create}    201
    ${cjson}=    Set Variable    ${create.json()}
    ${user_id}=    Set Variable    ${cjson}[id]

    # UPDATE (PUT)
    ${update}=    Update User    ${user_id}    ${name}    ${job} Engineer
    Status Should Be    ${update}    200
    ${ujson}=    Set Variable    ${update.json()}
    Should Be Equal    ${ujson}[name]    ${name}
    Should Contain     ${ujson}[job]     Engineer

    # DELETE
    ${delete}=    Delete User    ${user_id}
    Status Should Be    ${delete}    204
