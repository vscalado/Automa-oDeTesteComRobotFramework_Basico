*** Settings ***
Library         SeleniumLibrary
Library         String
Library         BuiltIn

*** Variables ***
${URL}          http://automationpractice.com/
${BROWSER}      chrome
&{CLIENTE}      cfirstname=Vitor  clastname=Borges  passwd=123456  firstname=Roberta  lastname=Silva  address1=12345-123  city=Limeira  id_state=California  postcode=95032  phone=19 123456789  alias=Spiderman  email=vitor.calado@outlook.com.br

*** Keywords ****
###Setup Teardown
Abrir navegador
    Open Browser    ${URL}      ${BROWSER}

Fechar navegador
    Close Browser

###Passo - Passo
Acessar a página home do site
    Title Should Be     My Store

Digitar o nome do produto ${PRODUTO} no campo de Pesquisa
    input Text      id:search_query_top    ${PRODUTO}

Clicar no botão Pesquisar
    Click Element   name:submit_search

Conferir se o produto "${PRODUTO}" foi listado no site
    Wait Until Element Is Visible   css:#center_column > h1
    Title Should Be                 Search - My Store
    Page Should Contain Image       xpath=//*[@id="center_column"]//*[@src="http://automationpractice.com/img/p/7/7-home_default.jpg"]
    Page Should Contain Link        xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),"${PRODUTO}")]

Conferir mensagem ${MENSAGEM_ALERTA}
    Wait Until Element Is Visible   css:#center_column > h1
    Title Should Be                 Search - My Store
    Element Text Should Be          xpath=//*[@id="center_column"]/p[@class="alert alert-warning"]      ${MENSAGEM_ALERTA}

Dado que estou na pagina home do site
    Title Should Be     My Store

Quando eu pesquisar pelo produto ${PRODUTO}
    Digitar o nome do produto ${PRODUTO} no campo de Pesquisa
    Clicar no botão Pesquisar

Então o produto "${PRODUTO}" deve ser listado na pagina de resultado da busca
    Conferir se o produto "${PRODUTO}" foi listado no site

Então a pagina deve exibir a mensagem ${MENSAGEM_ALERTA}
    Conferir mensagem ${MENSAGEM_ALERTA}

Quando passo o mouse por cima da categoria "${CATEGORIA}"" no menu principal superior de categorias clicar na sub Categoria "${OPTION}"
    Wait Until Element Is Visible   xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORIA}"]
    Mouse Over                      xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORIA}"]
    Set Suite Variable              ${OPTION}
    Log                             ${OPTION}
    Click Element                   xpath=//*[@id="block_top_menu"]//a[@title="${OPTION}"]

Então uma página com os produtos da categoria selecionada deve ser exibida.
    Wait Until Element Is Visible   css:#page > div.columns-container
    Title Should Be                 Summer Dresses - My Store
    Element Text Should Be          xpath=//*[@id="center_column"]/div[1]/div/div/span      Summer Dresses

Quando digito o nome do produto ${PRODUTO} no campo pesquisa e clico nos botões "${ADDCART}" e "${CHECKOUT}"
    Digitar o nome do produto ${PRODUTO} no campo de Pesquisa
    Clicar no botão Pesquisar
    Page Should Contain Link        xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),${PRODUTO})]
    Mouse Over                      xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),${PRODUTO})]
    Click Element                   xpath=//*[@id="center_column"]//span[contains(text(),'${ADDCART}')]
    Wait Until Element Is Visible   css:#layer_cart > div.clearfix
    Click Element                   xpath=//*[@id="layer_cart"]//span[contains(text(),'${CHECKOUT}')]

Então A tela do carrinho de compras deve ser exibido, juntamente com os dados do produto adicionado e os devidos valores
    Wait Until Element Is Visible   id:cart_title
    Page Should Contain Image       xpath=//*[@id="product_1_1_0_0"]//img[@src='http://automationpractice.com/img/p/1/1-small_default.jpg']
    ${PRECO}=                       Get Text        xpath=//*[@id="product_price_1_1_0"]/span[@class="price"]
    @{PRECOS}                       Split String    ${PRECO}            $
    ${TOTAL_ITEM}=                  Get Text        id=total_product
    Run Keyword If                  '${TOTAL_ITEM}' == '${PRECO}'       Log     O Preço do produto é igual a $16.51
    ${FRETE}=                       Get text        id=total_shipping
    @{FRETES}                       Split String    ${FRETE}            $
    ${TOTAL}=                       Evaluate        ${PRECOS[1]}+${FRETES[1]}
    Log                             ${TOTAL}
    ${VALORFINAL}=                  Get Text        id=total_price
    @{VALORFINALS}                  Split String    ${VALORFINAL}       $
    Run Keyword If                  '${TOTAL}' == '${VALORFINALS[1]}'       Log     A soma do produto com o Frete é $18.51

Quando clicar no icone do carrinho de compras e no botão de remoção de produtod(delete) no produto do carrinho
    Quando digito o nome do produto T-shirt no campo pesquisa e clico nos botões "Add to cart" e "Proceed to checkout"
    Click Element                   id=1_1_0_0

Então o sistema deve exibir a mensagem ${MENSAGEM_ALERTA}
    Wait Until Element Is Visible   xpath=//*[@id="center_column"]/p
    Log                             ${MENSAGEM_ALERTA}
    Element Text Should Be          xpath=//*[@id="center_column"]/p[contains(text(),'${MENSAGEM_ALERTA}')]      ${MENSAGEM_ALERTA}

Quando adiciono um novo cliente
    #Clicar no botão superior direito “Sign in”.
    Click Element                   xpath=//*[@id="header"]//a[@class="login"][@title="Log in to your customer account"]
    Wait Until Element Is Visible   css:h1[class='page-heading']
    Element Text Should Be          css:h3[class='page-subheading']         CREATE AN ACCOUNT
    Input Text                      id=email_create                         ${CLIENTE.email}
    Click Element                   id=SubmitCreate
    Preenche os campos obrigatórios
    Click Element                   id=submitAccount

Preenche os campos obrigatórios
    Wait Until Element Is Visible     xpath=//*[@id="account-creation_form"]/div[1]/h3
    #Element Text Should Be           xpath=//*[@id="account-creation_form"]/div[1]/h3[@class='page-subheading']      YOUR PERSONAL INFORMATION
    Select Radio Button               id_gender                             1
    Radio Button Should Be Set To     id_gender                             1
    Input Text                        id=customer_firstname                 ${CLIENTE.cfirstname}
    Input Text                        id=customer_lastname                  ${CLIENTE.clastname}
    Input Text                        id=passwd                             ${CLIENTE.passwd}
    Input Text                        id=firstname                          ${CLIENTE.firstname}
    Input Text                        id=lastname                           ${CLIENTE.lastname}
    Input Text                        id=address1                           ${CLIENTE.address1}
    Input Text                        id=city                               ${CLIENTE.city}
    Select From List By Label         id=id_state                           ${CLIENTE.id_state}
    Input Text                        id=postcode                           ${CLIENTE.postcode}
    Input Text                        id=phone_mobile                       ${CLIENTE.phone}
    Input Text                        id=alias                              ${CLIENTE.alias}

Então a página de gerenciamento da conta deve ser exibia
    Wait Until Element Is Visible     xpath=//*[@id="center_column"]/h1[contains(text(),'My account')]
    Element Text Should Be            //*[@id="header"]//a/span[contains(text(),'Vitor Silva')]            Vitor Silva


