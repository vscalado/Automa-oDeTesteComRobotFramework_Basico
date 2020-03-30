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