*** Settings ***
Library         SeleniumLibrary
Resource        ../resource/Resource.robot

Test Setup      Abrir navegador

Test Teardown   Fechar navegador
### SETUP roda Keyword antes da  suite ou antes de um teste
### TEARDOWN roda Keyword depois da  suite ou depois de um teste
*** Variables ***
${URL}          http://automationpractice.com/
${BRAOWSER}     chrome

*** Test Cases ***
Caso de Teste 01: Pesquisar Produtos Existentes

    Acessar a página home do site
    Digitar o nome do produto "Blouse" no campo de Pesquisa
    Clicar no botão Pesquisar
    Conferir se o produto "Blouse" foi listado no site
    

Caso de Teste 02: Pesquisar Produtos Inexistentes
    Acessar a página home do site
    Digitar o nome do produto "produtoNãoExistente" no campo de Pesquisa
    Clicar no botão Pesquisar
    Conferir mensagem No results were found for your search ""produtoNãoExistente""

#*** Keywords ****