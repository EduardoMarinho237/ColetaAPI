# Projeto Estágio - API Back-End usando Ruby On Rails

## Descrição do Projeto
Este projeto simula o fluxo de um sistema de coleta em campo. A API permite gerenciar usuários, visitas, formulários, perguntas e respostas. A principal finalidade é organizar e estruturar os dados coletados e fornecer uma saída em JSON para um servidor externo ou front-end requisitando dados.

### Entidades Principais
- **Usuário:** Autentica a pessoa no sistema para que saiba quais visitas estão direcionadas a ela.
- **Visita:** Consiste em uma tarefa com data agendada para coletar as informações.
- **Formulário:** Questionários que englobam várias perguntas específicas feitas por visita.
- **Pergunta:** São as perguntas dentro de um formulário.
- **Resposta:** São as respostas das perguntas.

## Instalação
1. Baixe e instale a linguagem Ruby 3.0.6 na sua máquina:
   ```bash
   sudo apt install ruby
   ```
   
2. Verifique a versão do Ruby:
   ```bash
   ruby -v
   ```
   
3. Instale o Rails:
   ```bash
   gem install rails -v 7.1.3
   ```
   
4. Clone o repositório e navegue até a pasta do projeto:
   ```bash
   git clone https://github.com/EduardoMarinho237/ColetaAPI
   cd ColetaAPI
   ```
   
5. Instale as dependências e gems descritas no Gemfile:
   ```bash
   bundle install
   ```

6. Configure o banco de dados:
   ```bash
   rails db:create
   rails db:migrate
   ```

7. Inicie o servidor Rails:
   ```bash
   rails server
   ```

A API estará disponível em: `http://localhost:3000`

## Testes
Este projeto utiliza RSpec para testes. Para executar os testes, utilize o comando:
```bash
bundle exec rspec
```

### Testes Implementados
- **Autenticação:** Verifica se o token JWT é válido.
- **Controladores:** Testa os métodos `index`, `login`, `show`, `create`, `update` e `delete` dos controladores e seus modelos.

## Arquitetura
O projeto segue a arquitetura RESTful, dividindo a funcionalidade da API em recursos bem definidos:
- **Usuários**
- **Visitas**
- **Formulários**
- **Perguntas**
- **Respostas**

### Gems Utilizadas
- `paranoia` para soft delete.
- `paperclip` para manipulação de imagens.
- `rspec` para testes.
- `jwt` para autenticação de usuário usando web token.

## Endpoints da API

### Usuários
- `GET /users`: Lista todos os usuários.
- `POST /users`: Cria um novo usuário.
- `POST /login`: Exibe informações do usuário criando novo token de acesso.
- `GET /users/:id`: Exibe um usuário específico com mais detalhes.
- `PUT /users/:id`: Atualiza um usuário.
- `DELETE /users/:id`: Deleta um usuário.

### Visitas
- `GET /visits`: Lista todas as visitas.
- `POST /visits`: Cria uma nova visita.
- `GET /visits/:id`: Exibe uma visita específica com mais detalhes.
- `PUT /visits/:id`: Atualiza uma visita.
- `DELETE /visits/:id`: Deleta uma visita.

### Formulários
- `GET /formularies`: Lista todos os formulários.
- `POST /formularies`: Cria um novo formulário.
- `GET /formularies/:id`: Exibe um formulário específico com mais detalhes.
- `PUT /formularies/:id`: Atualiza um formulário.
- `DELETE /formularies/:id`: Deleta um formulário.

### Perguntas
- `GET /questions`: Lista todas as perguntas.
- `POST /questions`: Cria uma nova pergunta.
- `GET /questions/:id`: Exibe uma pergunta específica com mais detalhes.
- `PUT /questions/:id`: Atualiza uma pergunta.
- `DELETE /questions/:id`: Deleta uma pergunta.

### Respostas
- `GET /answers`: Lista todas as respostas.
- `POST /answers`: Cria uma nova resposta.
- `GET /answers/:id`: Exibe uma resposta específica com mais detalhes.
- `PUT /answers/:id`: Atualiza uma resposta.
- `DELETE /answers/:id`: Deleta uma resposta.

## Validações de Campos

### Usuário
- **Senha:** Deve ter mais de seis dígitos, variando entre números e letras.
- **E-mail:** Não pode ser repetido.
- **CPF:** Não pode ser repetido e deve ser válido.

### Visita
- **Data:** Deve ser maior ou igual à data atual.
- **Checkin_at:** Não pode ser maior ou igual ao dia atual e deve ser menor que a data de check out.
- **Checkout_at:** Deve ser maior que checkin_at.
- **user_id:** Deve ser um usuário válido.

### Formulário
- **Nome:** Não pode ser repetido.

### Pergunta
- **Nome:** Não pode ser repetido dentro do mesmo formulário.

### Resposta
- **question_id:** Deve existir.
- **formulary_id:** Deve existir.
- **content:** Precisa ser um texto simples ou uma URL de imagem válida.

## Autenticação JWT
A autenticação é feita utilizando JWT. A API valida o token para garantir que o usuário está autenticado e possui as permissões necessárias.

## Tecnologias Utilizadas
- Ruby on Rails
- PostgreSQL
- RSpec
- JWT
- Paranoia
- Paperclip
- Factory Bot
- Database Cleaner
- CpfCnpj
- BCrypt