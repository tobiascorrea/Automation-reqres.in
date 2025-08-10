*** Settings ***
Resource    ../clients/auth.resource
Resource    ./validators.resource

*** Keywords ***
Register And Login Flow
    [Arguments]    ${email}    ${password}
    ${r}=    Register User    ${email}    ${password}
    Status Should Be    ${r}    200
    ${l}=    Login User       ${email}    ${password}
    Status Should Be    ${l}    200
    [Return]    ${r}    ${l}
