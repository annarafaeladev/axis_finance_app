# Axis Finance App

Aplicativo de gestão financeira pessoal desenvolvido em **Flutter**, com autenticação via **Google OAuth** e integração direta com **Google Sheets** como backend de dados.

---

## ✨ Visão Geral

O **Axis Finance App** foi criado pessoas físicas a organizarem suas finanças de forma simples, transparente e sob total controle do usuário.

Diferente de apps tradicionais, os dados **não ficam em um servidor próprio**: cada usuário possui sua **própria planilha no Google Sheets**, criada automaticamente no primeiro login.

---

## 🧱 Arquitetura

O projeto segue **Clean Architecture**, separando responsabilidades e facilitando manutenção, testes e evolução.

```
lib/
├── core/                # Infraestrutura compartilhada
│   ├── auth/            # Providers de autenticação
│   ├── di/              # Injeção de dependências
│   └── storage/         # Persistência local
│
├── features/
│   ├── auth/            # Login, logout e usuário
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── finance/         # Financeiro (Sheets)
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── main.dart

├── core/                # Infraestrutura compartilhada
│   ├── auth/            # Providers de autenticação
│   ├── di/              # Injeção de dependências
│   └── storage/         # Persistência local
├───features
│   ├───auth            # Dominio da autenticacao e dados do usuario
│   │   ├───data
│   │   │   ├───datasource
│   │   │   ├───models
│   │   │   └───respositories
│   │   ├───domain
│   │   │   ├───entities
│   │   │   ├───repositories
│   │   │   └───usecases
│   │   └───presentation
│   └───finance                # Dominio da orquestraçaõ de dados das planilhas
│       ├───data
│       │   ├───datasources
│       │   └───repositories
│       ├───domain
│       │   ├───entities
│       │   ├───repositories
│       │   └───usecases
│       │       └───entries
│       └───presentation
│           └───controllers
├───models                      # Modelo para a UI
├───navigation                  
├───pages                      # Paginas do app
└───widgets                    # Componente da UI
```

---

## 🔐 Autenticação

* Login via **Google Sign-In** (sem Firebase)
* OAuth configurado no Google Cloud Console
* Access Token armazenado localmente
* Provider centralizado para consumo por APIs

### Fluxo

1. Usuário faz login com Google
2. Access Token é salvo localmente
3. `UserAccessTokenProvider` fornece token sob demanda
4. APIs (Sheets / Drive) consomem esse provider

---

## 📊 Google Sheets como Backend

Ao logar pela primeira vez:

* O app procura uma planilha chamada:
  **`Finance Dashboard 50-30-20`**
* Caso não exista, cria automaticamente
* Abas criadas:

```
Dashboard
Entradas
Saidas
Fixas
Cartao
Investimentos
Reserva
Relatorios
Configuracoes
```

Cada aba possui cabeçalhos padronizados.

---

## 🧠 Regra Financeira (50-30-20)

* **50%** Essenciais
* **30%** Qualidade de vida
* **20%** Futuro / investimentos

Esses valores são configuráveis na aba `Configuracoes`.

---

## 🔌 Injeção de Dependência

Utilizado **GetIt** para desacoplamento total.

### Exemplo

```dart
getIt.registerLazySingleton(() => Dio());
getIt.registerLazySingleton<AccessTokenProvider>(
  () => UserAccessTokenProvider(getIt()),
);
```

Cada feature possui seu próprio arquivo de DI:

* `auth_di.dart`
* `finance_di.dart`

---

## 🌐 Flutter Web

* Porta fixa configurável:

```bash
flutter run -d chrome --web-port=5000
```

* Necessário configurar no Google Cloud:

  * **Authorized JavaScript origins**
  * **Authorized redirect URIs**

---

## 🚀 Objetivos do Projeto

* Estudo avançado de Flutter
* Arquitetura limpa e escalável
* Integração real com APIs externas
* Projeto de portfólio profissional
* App open-source no futuro

---

## 🛠 Tecnologias

* Flutter
* Dart
* Google OAuth 2.0
* Google Sheets API
* Google Drive API
* Dio
* GetIt

---

## 📌 Status

🚧 Em desenvolvimento

Próximos passos:

* Dashboard visual
* Gráficos
* Modo offline
* Exportação de relatórios

---

## 👩‍💻 Autora

**Anna Rafaela**
Software Engineer

---

Se você chegou até aqui: ⭐ o repositório 😉
