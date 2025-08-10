*** Settings ***
Resource    ../common/session.resource
Library     JSONLibrary

*** Keywords ***
Register User
    [Arguments]    ${email}    ${password}=None
    ${payload}=    Create Dictionary    email=${email}
    Run Keyword If    '${password}'!='None'    Set To Dictionary    ${payload}    password=${password}
    ${resp}=    POST    /api/register    ${payload}
    RETURN    ${resp}

Login User
    [Arguments]    ${email}    ${password}
    ${payload}=    Create Dictionary    email=${email}    password=${password}
    ${resp}=    POST    /api/login    ${payload}
    RETURN    ${resp}
