*** Settings ***
Library         SeleniumLibrary
Resource        ../resource/ResourceBDD.robot

Test Setup      Abrir navegador

Test Teardown   Fechar navegador

*** Test Cases ***
Caso de Teste 01: Pesquisar Produtos Existentes
    Dado que estou na pagina home do site
    Quando eu pesquisar pelo produto "Blouse"
    Então o produto "Blouse" deve ser listado na pagina de resultado da busca

Caso de Teste 02: Pesquisar Produtos Inexistentes
    Dado que estou na pagina home do site
    Quando eu pesquisar pelo produto "produtoNãoExistente"
    Então a pagina deve exibir a mensagem No results were found for your search ""produtoNãoExistente""

Caso de Teste 03: Listar Produtos
    Dado que estou na pagina home do site
    Quando passo o mouse por cima da categoria "Women"" no menu principal superior de categorias clicar na sub Categoria "Summer Dresses"
    Então uma página com os produtos da categoria selecionada deve ser exibida.

Caso de Teste 04: Adicioanr Produtos no Carrinho
    Dado que estou na pagina home do site
    Quando digito o nome do produto "T-shirt" no campo pesquisa e clico nos botões "Add to cart" e "Proceed to checkout" 
    Então A tela do carrinho de compras deve ser exibido, juntamente com os dados do produto adicionado e os devidos valores

Caso de Teste 05: Remover Produtos
    Dado que estou na pagina home do site
    Quando clicar no icone do carrinho de compras e no botão de remoção de produtod(delete) no produto do carrinho
    Então o sistema deve exibir a mensagem Your shopping cart is empty.

Caso de Teste 06: Adicionar Cliente
    Dado que estou na pagina home do site
    Quando adiciono um novo cliente
    Então a página de gerenciamento da conta deve ser exibia
