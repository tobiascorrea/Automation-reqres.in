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
    [Arguments]    ${endpoint}    ${params}={}    ${expected_status}=any
    [Documentation]    Realiza GET genérico. Se quiser validar automaticamente o status, informe ${expected_status} (ex.: 200, 404, 204 ou lista: 200,201).  
    ...                Padrão 'any' mantém comportamento anterior (não falha por status) permitindo validar depois com 'Status Should Be'.
    ${is_empty}=    Evaluate    isinstance($params, dict) and len($params)==0
    ${resp}=    Run Keyword If    ${is_empty}    Get On Session    ${SESSION_ALIAS}    ${endpoint}    expected_status=${expected_status}
    ...         ELSE    Get On Session    ${SESSION_ALIAS}    ${endpoint}    params=${params}    expected_status=${expected_status}
    RETURN    ${resp}

POST
    [Arguments]    ${endpoint}    ${payload}={}    ${expected_status}=any
    [Documentation]    Realiza POST genérico. Ajuste ${expected_status} para validação imediata (ex.: 200, 201, 400). Usa 'any' por padrão para retrocompatibilidade.
    ${resp}=    Post On Session   ${SESSION_ALIAS}    ${endpoint}    json=${payload}    expected_status=${expected_status}
    RETURN    ${resp}

PUT
    [Arguments]    ${endpoint}    ${payload}={}    ${expected_status}=any
    [Documentation]    Realiza PUT genérico. Pode validar status imediatamente via ${expected_status}.
    ${resp}=    Put On Session    ${SESSION_ALIAS}    ${endpoint}    json=${payload}    expected_status=${expected_status}
    RETURN    ${resp}

PATCH
    [Arguments]    ${endpoint}    ${payload}={}    ${expected_status}=any
    [Documentation]    Realiza PATCH genérico. Parametriza expected_status para validação automática.
    ${resp}=    Patch On Session  ${SESSION_ALIAS}    ${endpoint}    json=${payload}    expected_status=${expected_status}
    RETURN    ${resp}

DELETE
    [Arguments]    ${endpoint}    ${expected_status}=any
    [Documentation]    Realiza DELETE genérico. Informe expected_status (ex.: 204, 200, 404) para validar diretamente.
    ${resp}=    Delete On Session    ${SESSION_ALIAS}    ${endpoint}    expected_status=${expected_status}
    RETURN    ${resp}
