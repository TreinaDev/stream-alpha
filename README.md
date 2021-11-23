# Stream Alpha (TreinaDev 7)

Este README normalmente documentaria todas as etapas necessárias para colocar o aplicativo em funcionamento.

Coisas que você pode querer cobrir:

## Versão do Ruby

- Ruby v3.0.2 | Rails >= 6.1.4.1

## Dependências do Sistema

- Tenha o [_NodeJS_](https://nodejs.org/en/) e [_Yarn_](https://classic.yarnpkg.com/lang/en/docs/install) instalados:

### Gems

- rails - Aplicação Web;
- rspec-Rails - Testes Unitários e de Sistema;
- simplecov - Relatório de cobertura de testes;
- devise - Gerenciamento de Login e Autenticação;
- factory_bot_rails - Gerador de seeds automatizado;
- rubocop-rails - Garante que o código cumpra as melhores práticas Rails e convenções de codificação;
- shoulda-matchers - Testes com `Mock`, `Stub`, `Dummy`, `Fake` e `Spy`;

## Configuração

```sh
bin/setup
```

## Criação do Banco de Dados

```sh
rails db:migrate
```

## Inicialização do Banco de Dados

```sh
rails db:seed
```

## Como rodar a suíte de testes

```sh
rspec
rubocop
```

## Serviços (job queues, cache servers, search engines, etc.)

## Instruções de implantação (Deploy)

```sh
rails server
```

## Logins Disponíveis

### Entrar como Admin

| E-mail                   | Password |
| ------------------------ | -------- |
| admin1@gamestream.com.br | 123456   |
| admin2@gamestream.com.br | 123456   |

### Entrar como Cliente

| E-mail           | Password |
| ---------------- | -------- |
| client1@user.com | 123456   |
| client2@user.com | 123456   |
| client3@user.com | 123456   |

### Entrar como Streamer

| E-mail             | Password |
| ------------------ | -------- |
| streamer1@user.com | 123456   |
| streamer2@user.com | 123456   |
| streamer3@user.com | 123456   |
