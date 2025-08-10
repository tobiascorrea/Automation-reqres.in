*** Settings ***
Resource         ../../../resources/common/session.resource
Resource         ../../../resources/clients/auth.resource
Resource         ../../../resources/keywords/validators.resource
Suite Setup      Open API Session
Suite Teardown   Close API Session
Test Tags        auth    login    negative

*** Variables ***
${EMAIL}      eve.holt@reqres.in
${PASSWORD}   cityslicka

*** Test Cases ***
Login Should Fail Without Password
    ${resp}=    Login User    ${EMAIL}    ${None}
    Status Should Be    ${resp}    400
    # Mensagens podem variar; se quiser, valide só o status

Login Should Fail Without Email
    ${resp}=    Login User    ${None}    ${PASSWORD}
    Status Should Be    ${resp}    400
