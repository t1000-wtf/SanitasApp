# 🩺 Sanitas
### Prontuário da Família e Gestão de Saúde (Focado no Público 50+)

### O Sanitas é uma aplicação mobile e web desenvolvida em Flutter com o objetivo de centralizar o histórico médico, exames, receitas e dados vitais de forma simples, acessível e segura, facilitando o autocuidado da terceira idade e o acompanhamento por familiares ou cuidadores.

# 🏗️ Arquitetura do Projeto
### O projeto adota uma arquitetura modular limpa dentro da pasta src/, separando responsabilidades entre telas, componentes visuais reutilizáveis, controladores e modelos de dados:

graph TD
    A[UI / Screens] -->|Ações do Usuário| B[Controllers / State]
    B -->|Gerencia Dados| C[Models / Entidades]
    C -->|Exibe na Tela| A
    D[Custom Widgets & AppBar] -.->|Reutilizado em| A

### Models (src/models/): Representam as estruturas de dados (Usuários, Exames, Familiares, Notificações).

### Controllers (src/controller/): Centralizam a lógica de negócio e o gerenciamento de estado reativo (como a atualização instantânea de notificações).

### Views / Screens (src/screens/): Telas divididas por domínios (auth, home, exams, profile, notifications).

### Widgets (src/widgets/): Componentes de interface reutilizáveis (como o CustomAppBar padrão do app).

# 🎨 Diretrizes de UX/UI (Foco 50+)
### O Sanitas foi desenhado levando em consideração as principais necessidades de acessibilidade e usabilidade para o público sênior:

### Legibilidade e Contraste: Uso de fontes com tamanhos generosos por padrão e forte contraste visual (textos escuros sobre fundos claros).

### Áreas de Toque Amplas: Botões e cards projetados com espaçamento e altura superiores a 48px para evitar erros de toque.

### Simplicidade Visual: Redução de carga cognitiva, fluxos diretos, rótulos textuais claros nos botões e ícones intuitivos.

# 📂 Estrutura de Arquivos e Suas Funções
### Abaixo está o detalhamento do papel de cada diretório e arquivo principal no código-fonte (lib/):

lib/
├── main.dart
└── src/
    ├── controllers/
    ├── models/
    ├── screens/
    │   ├── auth/
    │   │   ├── login_screen.dart
    │   │   └── register_screen.dart
    │   ├── exams/
    │   │   └── exams_screen.dart
    │   ├── home/
    │   │   └── home_screen.dart
    │   ├── notifications/
    │   │   └── notifications_screen.dart
    │   ├── profile/
    │   │   └── profile_screen.dart
    │   └── main_wrapper_screen.dart
    └── widgets/
        └── custom_app_bar.dart

# 📄 Detalhamento dos Componentes
## 🚀 lib/main.dart
### Ponto de entrada (entry point) do aplicativo. Configura o MaterialApp, define o tema global com Material 3, tipografia legível e cores de alto contraste, inicializando a rota principal.

## 🎛️ lib/src/screens/main_wrapper_screen.dart
### Gerencia a navegação principal do aplicativo através de uma barra inferior fixa (BottomNavigationBar), permitindo alternar de forma fluida entre as abas Início, Exames e Perfil.

## 🧩 lib/src/widgets/custom_app_bar.dart
### Widget reutilizável de barra superior (AppBar) que exibe a identidade visual do app ("Sanitas" e ícone de saúde), título dinâmico da tela atual e o botão de acesso rápido às notificações.

## 🔐 lib/src/screens/auth/
### Contém as telas de Login e Cadastro com campos de entrada grandes, rótulos claros e botões destacados para facilitar o acesso de novos usuários ou familiares.

## 🏠 lib/src/screens/home/
### Tela inicial (Visão Geral). Possui o botão de destaque "Modo Consulta (Resumo Rápido)" para emergências médicas, exibe a lista dos últimos exames cadastrados e conta com um botão de atalho rápido ao final da lista para adicionar novos exames.

## 📁 lib/src/screens/exams/
### Tela dedicada à listagem completa em formato de linha do tempo (timeline) dos exames do usuário, acompanhada de um botão flutuante para inclusão de novos registros.

## 👤 lib/src/screens/profile/
### Tela de perfil e saúde contendo informações vitais do paciente (como tipo sanguíneo e alergias) e o gerenciamento de familiares ou cuidadores vinculados à conta.

## 🔔 lib/src/screens/notifications/
### Central de avisos e alertas do aplicativo. Permite visualizar pendências, lembretes de exames e consultas, contando com a funcionalidade de marcar todas como lidas em tempo real, refletindo o estado visual instantaneamente na interface sem necessidade de sair da tela.

## 🛠️ Principale Pacotes e Dependências
### Flutter SDK: Framework principal de desenvolvimento multiplataforma (Mobile e Web).

### Material 3: Sistema de design moderno para construção de interfaces limpas e acessíveis.
