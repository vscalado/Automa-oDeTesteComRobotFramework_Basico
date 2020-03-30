*** Settings ***
Documentation   Documentação da API:  https://fakerestapi.azurewebsites.net/swagger/ui/index
Library         RequestsLibrary
Library         Collections

*** Variables ***
${URL_API}      https://fakerestapi.azurewebsites.net/api/

*** Keywords ***
#### SETUP AND TEARDOWNS
Conectar a minha API
    Create Session  fakeAPI  ${URL_API}

###Actions
Requisitar todos os livros
    ${RESPOSTA}     Get Request     fakeAPI     Books
    Log             ${RESPOSTA}