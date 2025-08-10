*** Settings ***
Library    Collections

*** Keywords ***
Status Should Be
    [Arguments]    ${resp}    ${expected}
    Should Be Equal As Integers    ${resp.status_code}    ${expected}

Response Should Contain Keys
    [Arguments]    ${resp}    @{keys}
    ${json}=    Set Variable    ${resp.json()}
    FOR    ${k}    IN    @{keys}
        Dictionary Should Contain Key    ${json}    ${k}
    END

Field Should Not Be Empty
    [Arguments]    ${resp}    ${field}
    ${json}=    Set Variable    ${resp.json()}
    Should Not Be Empty    ${json}[${field}]

Assert Error Message
    [Arguments]    ${resp}    ${message}
    ${json}=    Set Variable    ${resp.json()}
    Should Be Equal    ${json}[error]    ${message}

# Aceita corpo vazio "" OU objeto vazio "{}" (com ou sem espaços/linhas)
Body Should Be Empty Or Empty Object
    [Arguments]    ${resp}
    ${text}=    Set Variable    ${resp.text}
    Should Match Regexp    ${text}    ^\s*(\{\s*\})?\s*$
