*** Settings ***
Resource    ../common/session.resource
Library     JSONLibrary

*** Keywords ***
List Resources
    [Arguments]    ${page}=1    ${per_page}=6
    ${params}=    Create Dictionary    page=${page}    per_page=${per_page}
    ${resp}=      GET    /api/unknown    ${params}
    RETURN    ${resp}

Get Single Resource
    [Arguments]    ${resource_id}
    ${resp}=    GET    /api/unknown/${resource_id}
    RETURN    ${resp}
