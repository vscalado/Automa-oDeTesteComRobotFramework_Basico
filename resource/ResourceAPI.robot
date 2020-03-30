*** Settings ***
Documentation   Documentação da API:  https://fakerestapi.azurewebsites.net/swagger/ui/index
Library         RequestsLibrary
Library         Collections
Library         BuiltIn

*** Variables ***
${URL_API}      https://fakerestapi.azurewebsites.net/api/

*** Keywords ***
#### SETUP AND TEARDOWNS
Conectar a minha API
    Create Session  fakeAPI  ${URL_API}

###Actions
Requisitar todos os livros
    ${RESPOSTA}         Get Request         fakeAPI     Books
    Log                 ${RESPOSTA.text}
    Set Test Variable   ${RESPOSTA}

Conferir STATUS CODE
    [Arguments]         ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings       ${RESPOSTA.status_code}     ${STATUSCODE_DESEJADO}
    Log                 ${STATUSCODE_DESEJADO}
    Log                 ${RESPOSTA.status_code}

Conferir o reason
    [Arguments]         ${REASON_DESEJADO}
    Should Be Equal As Strings       ${RESPOSTA.reason}     ${REASON_DESEJADO}
    Log                 ${REASON_DESEJADO}
    Log                 ${RESPOSTA.reason}

Conferir se retornou uma lista com "${QTDE_LIVROS}" livro
    Length Should Be    ${RESPOSTA.json()}      ${QTDE_LIVROS}