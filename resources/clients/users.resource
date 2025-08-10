*** Settings ***
Resource    ../common/session.resource
Library     JSONLibrary

*** Keywords ***
List Users
    [Arguments]    ${page}=1
    ${params}=    Create Dictionary    page=${page}
    ${resp}=      GET    /api/users    ${params}
    RETURN    ${resp}

Get Single User
    [Arguments]    ${user_id}
    ${resp}=    GET    /api/users/${user_id}
    RETURN    ${resp}

Create User
    [Arguments]    ${name}    ${job}
    ${payload}=    Create Dictionary    name=${name}    job=${job}
    ${resp}=       POST    /api/users    ${payload}
    RETURN    ${resp}

Update User
    [Arguments]    ${user_id}    ${name}    ${job}
    ${payload}=    Create Dictionary    name=${name}    job=${job}
    ${resp}=       PUT    /api/users/${user_id}    ${payload}
    RETURN    ${resp}

Patch User
    [Arguments]    ${user_id}    ${job}
    ${payload}=    Create Dictionary    job=${job}
    ${resp}=       PATCH    /api/users/${user_id}    ${payload}
    RETURN    ${resp}

Delete User
    [Arguments]    ${user_id}
    ${resp}=    DELETE    /api/users/${user_id}
    RETURN    ${resp}
