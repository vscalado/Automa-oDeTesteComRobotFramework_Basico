***Settings***
Documentation       Documentação da API:
Resource            ../resource/ResourceAPI.robot
Suite Setup         Conectar a minha API

***Test Cases***
Requisitar a listagem de todos os livres(GET em todos os Livros)
    Requisitar todos os livros
    Conferir STATUS CODE        200
    Conferir o reason           OK
    Conferir se retornou uma lista com "200" livro

Buscar um livro especifico(GET em um livro especifico)
    Requisitar o livro "15"
    Conferir STATUS CODE        200
    Conferir o reason           OK
    Conferir se retorna todos os dados corretos do livro 15

Cadastrar um livro(POST)
    Cadastrar um livro
    Conferir STATUS CODE        200
    Conferir o reason           OK
    Conferir se retorna todos os dados cadastrados do livro "201"

Alterar um livro (PUT)
    Alterar o livro "150"
    Conferir STATUS CODE    200
    Conferir o reason   OK
    Conferir se retorna todos os dados alterados do livro "130"

Deletar um livro (DELETE)
    Excluir o livro "201"
    Conferir STATUS CODE    200
    Conferir o reason   OK
    Conferir se excluiu o livro "200"