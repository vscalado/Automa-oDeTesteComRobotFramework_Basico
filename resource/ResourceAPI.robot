*** Settings ***
Documentation   Documentação da API:  https://fakerestapi.azurewebsites.net/swagger/ui/index
Library         RequestsLibrary
Library         Collections
Library         BuiltIn

*** Variables ***
${URL_API}      https://fakerestapi.azurewebsites.net/api/
&{BOOK_15}      ID=15
...             Title=Book 15
...             PageCount=1500

*** Keywords ***
#### SETUP AND TEARDOWNS
Conectar a minha API
    Create Session  fakeAPI  ${URL_API}

###Actions
Requisitar todos os livros
    ${RESPOSTA}         Get Request         fakeAPI     Books
    Log                 ${RESPOSTA.text}
    Set Test Variable   ${RESPOSTA}

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}         Get Request         fakeAPI     Books/${ID_LIVRO}
    Log                 ${RESPOSTA.text}
    Set Test Variable   ${RESPOSTA}

Cadastrar um livro
    ${HEADERS}          Create Dictionary       content-type=application/json
    ${RESPOSTA}         Post Request        fakeAPI     Books
    ...                                     data={"ID": 2323,"Title": "Teste","Description": "Teste","PageCount": 200,"Excerpt": "Teste","PublishDate": "2020-03-30T16:35:47.029Z"}
    ...                                     headers=${HEADERS}
    Log                 ${RESPOSTA.text}
    Set Test Variable   ${RESPOSTA}
###Conferências
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

Conferir se retorna todos os dados corretos do livro 15
    Dictionary Should Contain Item      ${RESPOSTA.json()}       ID              ${BOOK_15.ID}
    Dictionary Should Contain Item      ${RESPOSTA.json()}       Title           ${BOOK_15.Title}
    Dictionary Should Contain Item      ${RESPOSTA.json()}       PageCount       ${BOOK_15.PageCount}
    Should Not Be Empty                 ${RESPOSTA.json()["Description"]}
    Should Not Be Empty                 ${RESPOSTA.json()["Excerpt"]}
    Should Not Be Empty                 ${RESPOSTA.json()["PublishDate"]}

