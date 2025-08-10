# Projeto de Automação de Testes de API – Reqres.in

Automação de testes de API desenvolvida com **Robot Framework**, utilizando **RequestsLibrary**, **DataDriver**, **JSONSchemaLibrary** e seguindo boas práticas de arquitetura modular, código limpo e reutilizável.

---

## Tecnologias Utilizadas

<a href="https://www.python.org/" target="_blank">
    <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python">
</a>
<a href="https://robotframework.org/" target="_blank">
    <img src="https://img.shields.io/badge/Robot%20Framework-000000?style=for-the-badge&logo=robotframework&logoColor=white" alt="Robot Framework">
</a>

- [Robot Framework](https://robotframework.org/) – Framework principal de automação
- [RequestsLibrary](https://marketsquare.github.io/robotframework-requests/) – Execução de requisições HTTP
- [JSONSchemaLibrary](https://github.com/robocorp/JSONSchemaLibrary) – Validação de respostas com JSON Schema
- [DataDriver](https://github.com/Snooz82/robotframework-datadriver) – Parametrização de testes com dados externos (CSV)
- Python 3.x – Linguagem base
- Pip – Gerenciador de pacotes
- .env – Configuração de variáveis de ambiente

---

## Estrutura do Projeto

```plaintext
robot-reqres/
│
├── tests/api/                   # Suítes de teste
│   ├── auth/                    # Testes de autenticação
│   │   ├── register.robot
│   │   └── login.robot
│   ├── users/                   # Testes de usuários
│   │   ├── list_users.robot
│   │   ├── single_user.robot
│   │   └── create_update_delete_user.robot
│   ├── misc/                    # Testes diversos
│   │   └── delayed.robot
│   └── unknown/                 # Testes de recursos desconhecidos
│       ├── list_unknown.robot
│       └── single_unknown.robot
│
├── resources/                   # Recursos compartilhados
│   ├── common/                  # Sessões e helpers
│   │   ├── session.resource
│   │   └── helpers.resource
│   ├── clients/                 # Clientes para chamadas HTTP
│   │   ├── auth.resource
│   │   └── users.resource
│   └── keywords/                # Palavras-chave de validação e fluxos
│       ├── validators.resource
│       └── flows.resource
│
├── data/                        # Dados de teste
│   ├── fixtures/                # JSONs de entrada
│   │   ├── auth_register_ok.json
│   │   ├── auth_register_missing_password.json
│   │   └── auth_login_ok.json
│   └── datasets/                # Massa de dados parametrizada
│       └── users_create.csv
│
├── schemas/                     # Schemas de validação JSON
│   ├── auth_register_200.json
│   ├── auth_register_400.json
│   ├── users_list_200.json
│   └── user_single_200.json
│
├── config/                      # Configurações do projeto
│   ├── variables.py
│   └── headers.json
│
├── tools/                       # Scripts utilitários
│   └── make_token.py
│
├── .env.example                 # Exemplo de variáveis de ambiente
├── requirements.txt             # Dependências do projeto
└── README.md                    # Documentação
```

---

## Cobertura de Testes

A automação cobre os seguintes endpoints da API [Reqres.in](https://reqres.in/api-docs/):

### Auth
- `POST /api/register` – Registro de usuário (positivo e negativo)
- `POST /api/login` – Login de usuário (positivo e negativo)

### Users
- `GET /api/users` – Lista de usuários com paginação
- `GET /api/users/{id}` – Consulta de usuário específico (positivo e negativo)
- `POST /api/users`, `PUT /api/users/{id}`, `DELETE /api/users/{id}` – Fluxo de criar, atualizar e deletar usuário (parametrizado via CSV)

### Misc
- `GET /api/users?delay={n}` – Simulação de delay na resposta

### Unknown
- `GET /api/unknown` – Lista de recursos desconhecidos
- `GET /api/unknown/{id}` – Consulta de recurso específico (positivo e negativo)

---

## Instalação e Configuração

### 1. Clone o repositório

```bash
git clone https://github.com/seuusuario/robot-reqres.git
cd robot-reqres
```

### 2. Criação e Ativação de Ambiente Virtual (opcional, recomendado)

**Linux/Mac:**
```bash
python -m venv venv
source venv/bin/activate
```

**Windows:**
```bash
python -m venv venv
venv\Scripts\activate
```

### 3. Instalação das Dependências

```bash
pip install -r requirements.txt
```

### 4. Configuração do Arquivo `.env`

```bash
cp .env.example .env
```

Edite o arquivo `.env` conforme necessário para o seu ambiente.

---

## Execução dos Testes

### Executar todos os testes

```bash
ENV=dev robot -d reports tests/api
```

### Executar uma suíte específica

```bash
ENV=dev robot -d reports tests/api/auth/register.robot
```

---

## Relatórios

Após a execução, os relatórios estarão disponíveis em:

- `reports/log.html`
- `reports/report.html`

---

## Boas Práticas Aplicadas

- **Arquitetura Modular:** Separação clara entre testes, recursos, dados e schemas.
- **Reuso de Código:** Keywords centralizadas em `resources/keywords` e `resources/clients`.
- **Validação Estrita:** Uso de JSON Schema para garantir integridade das respostas.
- **Parametrização:** Dados dinâmicos via CSV com DataDriver.
- **Escalabilidade:** Suporte a múltiplos ambientes via variável `ENV`.


