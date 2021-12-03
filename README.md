<div align="center">

<img src="https://img.icons8.com/nolan/36/millenium-eye.png" width="100">

# GameStream (TreinaDev 7 - Stream Alpha)

## *Plataforma de streaming de vídeos de jogos GameStream*

</div>

## 💎 Versão do Ruby

- Ruby v3.0.2 | Rails >= 6.1.4.1

## ❗ Dependências do Sistema

- Tenha o [_NodeJS_](https://nodejs.org/en/) e [_Yarn_](https://classic.yarnpkg.com/lang/en/docs/install) instalados:

### 📦 Gems

- rails - Aplicação Web;
- rspec-rails - Testes de Requisição, Unitários e de Sistema;
- simplecov - Relatório de cobertura de testes;
- devise - Gerenciamento de Login e Autenticação;
- factory_bot_rails - Gerador de seeds automatizado;
- rubocop-rails - Garante que o código cumpra as melhores práticas Rails e convenções de codificação;
- shoulda-matchers - Testes com `Mock`, `Stub`, `Dummy`, `Fake` e `Spy`;
- faraday - Biblioteca para realizar requisições HTTP;
- importmap-rails - Usar JavaScript sem transpilar ou empacotar;
- stimulus-rails - Framework JavaScript que ajuda no Front-End.

**OBS: Tailwind CSS foi utilizado no Front-End.**

## ⚙️ Configuração

```sh
bin/setup
```

## ⚙️ Criação do Banco de Dados

```sh
rails db:migrate
```

## ⚙️ Inicialização do Banco de Dados

```sh
rails db:seed
```

## ✅ Como rodar a suíte de testes

```sh
rspec
rubocop
```

## 🚀 Instruções de implantação (Deploy)

```sh
rails server
```
<div align="center">

## 🎟️ Logins Disponíveis

### 🎟️ Entrar como Admin

| E-mail                   | Senha    |
| :----------------------: | :------: |
| admin1@gamestream.com.br | 123456   |
| admin2@gamestream.com.br | 123456   |

### 🎟️ Entrar como Cliente

| E-mail           | Senha    |
| :--------------: | :------: |
| client1@user.com | 123456   |
| client2@user.com | 123456   |
| client3@user.com | 123456   |

### 🎟️ Entrar como Streamer

| E-mail             | Senha    |
| :----------------: | :------: |
| streamer1@user.com | 123456   |
| streamer2@user.com | 123456   |
| streamer3@user.com | 123456   |

</div>