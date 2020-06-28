# Looking for Talents

O intuito deste projeto é criar uma plataforma de divulgação de vagas, onde empresas possam buscar profissionais para integrar suas equipes e interagir com estes durante o processo de candidatura e contratação

## Pré-Requisitos

`Ruby 2.5`

`Postgres`

Sistema operacional recomendado: `Linux`

## Iniciando o Projeto

Clone o projeto:

`https://github.com/yosh1tsune/looking-for-talents.git`

Acesse a pasta raiz:

`cd looking-for-talents`

Rode o seguinte comando para instalar as gems necessárias e iniciar o banco de dados:

`bin/setup`

Este projeto conta com dados pré-editados, para popular o banco com eles rode o seguinte comando:

`rails db:seed`

Finalmente, para observar a aplicação em funcionamento, rode o comando:

`rails server`

Por padrão, a aplicação ficará hospedada na porta `localhost:3000`

## Funcionalidades

### Headhunter

- Um headhunter inicia a utilização do sistema criando uma conta, informando email, senha, nome e sobrenome.

- Para publicar uma vaga os headhunters precisam estar vinculados a uma empresa. Os perfis de empresas são criados pelos próprios headhunters e o vinculo de um headhunter pode ser feito apenas pelo 'dono' da empresa.

- Candidatos inscritos em vagas podem ter seus perfis destacados e receber propostas de emprego baseados na inscrição.

- Headhunters podem visualizar apenas vagas e propostas próprias; os perfis de todos os candidatos candidatos cadastrados na plataforma estarão visíveis.

### Candidatos

- Um candidato inicia a utilização do sistema da mesma forma, criando uma conta informando email e senha.

- Após cadastrados, candidatos precisam completar seu perfil com dados pessoais e profissionais, só assim podem se candidatar a vagas.

- Candidatos podem visualizar todas as vagas cadastradas na plataforma, e apenas os seus próprios perfis.

- Após inscritos em alguma vaga, os candidatos receberão avaliação e feedback dos headhunters além de eventuais propostas constando todos os termos envolvidos numa possível contratação, podendo aceitar ou recusar as mesmas.
