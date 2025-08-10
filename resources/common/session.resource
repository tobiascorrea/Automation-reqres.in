*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Variables  ../../config/variables.py

*** Variables ***
${SESSION_ALIAS}    reqres

*** Keywords ***
Open API Session
    [Documentation]    Cria sessão HTTP com base url e headers globais.
    Create Session    ${SESSION_ALIAS}    ${BASE_URL}    headers=${DEFAULT_HEADERS}    timeout=${DEFAULT_TIMEOUT}    verify=${True}

Close API Session
    [Documentation]    Encerra todas as sessões HTTP abertas.
    Delete All Sessions

GET
    [Arguments]    ${endpoint}    ${params}={}
    ${is_empty}=    Evaluate    isinstance($params, dict) and len($params)==0
    ${resp}=    Run Keyword If    ${is_empty}    Get On Session    ${SESSION_ALIAS}    ${endpoint}    expected_status=any
    ...         ELSE    Get On Session    ${SESSION_ALIAS}    ${endpoint}    params=${params}    expected_status=any
    RETURN    ${resp}

POST
    [Arguments]    ${endpoint}    ${payload}={}
    ${resp}=    Post On Session   ${SESSION_ALIAS}    ${endpoint}    json=${payload}    expected_status=any
    RETURN    ${resp}

PUT
    [Arguments]    ${endpoint}    ${payload}={}
    ${resp}=    Put On Session    ${SESSION_ALIAS}    ${endpoint}    json=${payload}    expected_status=any
    RETURN    ${resp}

PATCH
    [Arguments]    ${endpoint}    ${payload}={}
    ${resp}=    Patch On Session  ${SESSION_ALIAS}    ${endpoint}    json=${payload}    expected_status=any
    RETURN    ${resp}

DELETE
    [Arguments]    ${endpoint}
    ${resp}=    Delete On Session    ${SESSION_ALIAS}    ${endpoint}    expected_status=any
    RETURN    ${resp}
