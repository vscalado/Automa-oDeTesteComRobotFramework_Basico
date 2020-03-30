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
&{BOOK_201}     ID=202
...             Title=Book 201
...             Description=Teste
...             PageCount=1500
...             Excerpt=Teste
...             PublishDate=2020-03-30T16:35:47.029Z
&{BOOK_130}     ID=130
...             Title=Book 130
...             Description=Teste ROBOT
...             PageCount=100
...             Excerpt=TesteROBOT
...             PublishDate=2020-03-30T16:35:47.029Z
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
    ...                                     data={"ID": ${BOOK_201.ID},"Title": "${BOOK_201.Title}","Description": "${BOOK_201.Description}","PageCount": ${BOOK_201.PageCount},"Excerpt": "${BOOK_201.Excerpt}","PublishDate": "${BOOK_201.PublishDate}"}
    ...                                     headers=${HEADERS}
    Log                 ${RESPOSTA.text}
    Set Test Variable   ${RESPOSTA}

Alterar o livro "${ID_LIVRO}"
    ${HEADERS}          Create Dictionary       content-type=application/json
    ${RESPOSTA}         Put Request        fakeAPI     Books/${ID_LIVRO}
    ...                                     data={"ID": ${BOOK_130.ID},"Title": "${BOOK_130.Title}","Description": "${BOOK_130.Description}","PageCount": ${BOOK_130.PageCount},"Excerpt": "${BOOK_130.Excerpt}","PublishDate": "${BOOK_130.PublishDate}"}
    ...                                     headers=${HEADERS}
    Log                 ${RESPOSTA.text}
    Set Test Variable   ${RESPOSTA}

Excluir o livro "${ID_LIVRO}"
    ${RESPOSTA}         Delete Request         fakeAPI     Books/${ID_LIVRO}
    Log                 ${ID_LIVRO}
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

Conferir se retorna todos os dados cadastrados do livro "${ID_LIVRO}"
    Conferir Livro  ${ID_LIVRO}

Conferir se retorna todos os dados alterados do livro "${ID_LIVRO}"
    Conferir Livro  ${ID_LIVRO}
Conferir Livro
    [Arguments]     ${ID_LIVRO}
    Dictionary Should Contain Item      ${RESPOSTA.json()}       ID              ${BOOK_${ID_LIVRO}.ID}
    Dictionary Should Contain Item      ${RESPOSTA.json()}       Title           ${BOOK_${ID_LIVRO}.Title}
    Dictionary Should Contain Item      ${RESPOSTA.json()}       Description     ${BOOK_${ID_LIVRO}.Description}
    Dictionary Should Contain Item      ${RESPOSTA.json()}       PageCount       ${BOOK_${ID_LIVRO}.PageCount}
    Dictionary Should Contain Item      ${RESPOSTA.json()}       Excerpt         ${BOOK_${ID_LIVRO}.Excerpt}
    Dictionary Should Contain Item      ${RESPOSTA.json()}       PublishDate     ${BOOK_${ID_LIVRO}.PublishDate}

Conferir se excluiu o livro "${ID_LIVRO}"
    Should Be Empty                     ${RESPOSTA.content}

