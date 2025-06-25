# 📋 Documentação Técnica - UTP Weather App

## 🏗️ Arquitetura Utilizada

### Clean Architecture com Riverpod

O projeto segue a **Clean Architecture** com separação clara de responsabilidades em camadas bem definidas, utilizando o **Riverpod** como solução de gerenciamento de estado. A arquitetura implementada é uma variação do padrão **MVVM (Model-View-ViewModel)** com Riverpod.

#### Estrutura de Camadas:

```
lib/src/
├── api/                    # Camada de API externa
├── constants/              # Constantes da aplicação
└── features/
    └── weather/
        ├── application/   # Camada de aplicação (Providers/ViewModel)
        ├── data/          # Camada de dados (Repository)
        ├── domain/        # Camada de domínio (Entidades)
        └── presentation/  # Camada de apresentação (UI/View)
```

#### Padrões de Design Implementados:

1. **Repository Pattern**
   - Abstração da fonte de dados através do `HttpWeatherRepository`
   - Interface única para acesso aos dados meteorológicos
   - Facilita testes e mudanças na implementação

2. **Provider Pattern (Riverpod)**
   - Gerenciamento de estado reativo e declarativo
   - Providers para diferentes tipos de dados:
     - `StateProvider` para estado simples (cidade selecionada)
     - `FutureProvider` para dados assíncronos (clima atual, previsão)
     - `Provider` para dependências (repositório)

3. **Dependency Injection**
   - Injeção de dependências através do Riverpod
   - Configuração centralizada de dependências
   - Facilita testes unitários

4. **Data Classes com Freezed**
   - Entidades imutáveis e type-safe
   - Geração automática de código (JSON serialization, copyWith, etc.)
   - Redução de boilerplate

## 📦 Componentes e Bibliotecas Principais

### Gerenciamento de Estado
- **flutter_riverpod** (^2.4.8)
  - Gerenciamento de estado reativo
  - Providers para diferentes tipos de estado
  - Auto-dispose para limpeza automática de recursos
  - Family providers para parâmetros

### Geração de Código e Serialização
- **freezed** (^2.4.5)
  - Geração de data classes imutáveis
  - Implementação automática de equals, hashCode, toString
  - Suporte a copyWith e pattern matching
- **json_annotation** (^4.8.1)
  - Anotações para serialização JSON
  - Mapeamento de campos da API
- **build_runner** (^2.4.6)
  - Geração de código em tempo de desenvolvimento
  - Compilação de arquivos .freezed.dart e .g.dart

### UI e Interface
- **flutter** (SDK)
  - Framework principal para desenvolvimento mobile
  - Widgets personalizados para interface meteorológica
- **cached_network_image** (^3.4.1)
  - Cache automático de imagens de rede
  - Otimização de performance para ícones meteorológicos
- **cupertino_icons** (^1.0.6)
  - Ícones do design system iOS
  - Consistência visual com tema escuro

### Rede e APIs
- **http** (^1.2.2)
  - Cliente HTTP para requisições REST
  - Tratamento de status codes e erros
  - Configuração de timeouts e headers

### Visualização de Dados
- **fl_chart** (^0.66.2)
  - Gráficos para visualização de dados meteorológicos
  - Charts interativos para temperaturas e previsões

### Internacionalização e Formatação
- **intl** (^0.18.1)
  - Formatação de datas e números
  - Suporte a múltiplos idiomas (pt_BR configurado)
  - Localização de strings

### Testes
- **mocktail** (^1.0.1)
  - Mocking para testes unitários
  - Simulação de respostas da API
  - Testes isolados de componentes

### Qualidade de Código
- **flutter_lints** (^3.0.1)
  - Regras de linting para Flutter
  - Manutenção de padrões de código
  - Detecção de problemas comuns

## 🔧 Tecnologias Empregadas

### Armazenamento

#### Armazenamento em Memória
- **Riverpod State Management**
  - Estado temporário mantido em memória
  - Auto-dispose para limpeza automática
  - Cache inteligente de dados meteorológicos

#### Cache de Imagens
- **Cached Network Image**
  - Cache automático de ícones meteorológicos
  - Otimização de bandwidth
  - Melhoria na performance da UI

### APIs Externas

#### OpenWeatherMap API v2.5
- **Endpoint Base**: `api.openweathermap.org/data/2.5/`
- **Endpoints Utilizados**:
  - `/weather` - Dados meteorológicos atuais
  - `/forecast` - Previsão de 5 dias
- **Parâmetros**:
  - `q`: Nome da cidade
  - `appid`: API Key de autenticação
  - `units`: Métricas (Celsius)
- **Formato de Resposta**: JSON
- **Rate Limiting**: 60 calls/minuto (free tier)

#### Configuração de API
- **Métodos de Configuração**:
  - Variável de ambiente: `--dart-define=API_KEY=sua_chave`
  - Arquivo de configuração: `lib/src/api/api_keys.dart`
- **Segurança**: API keys não versionadas no Git

### Recursos do Sistema

#### Status Bar e UI System
- **Status Bar Transparente**
  - Configuração para tema escuro
  - Ícones claros na status bar
  - Integração visual com o app

#### Safe Area e Responsividade
- **Adaptação a Diferentes Dispositivos**
  - Suporte a diferentes tamanhos de tela
  - Safe area para notches e status bars
  - Layout responsivo

#### Internacionalização
- **Suporte a Múltiplos Idiomas**
  - Configuração para português brasileiro
  - Formatação de datas localizada
  - Preparado para expansão de idiomas

### Funcionalidades Avançadas

#### Tratamento de Erros
- **Hierarquia de Exceções**:
  ```dart
  - InvalidApiKeyException (401)
  - CityNotFoundException (404)
  - NoInternetConnectionException (SocketException)
  - UnknownException (outros erros)
  ```

#### Estados de Carregamento
- **Indicadores Visuais**:
  - Loading states para requisições
  - Error states com mensagens claras
  - Empty states para dados não encontrados

#### Detecção de Conectividade
- **Tratamento Offline**:
  - Detecção de falta de conexão
  - Mensagens informativas ao usuário
  - Graceful degradation

### Configuração de Build

#### Variáveis de Ambiente
- **Dart Define**:
  ```bash
  flutter run --dart-define=API_KEY=sua_api_key
  ```

#### Configuração de Tema
- **Tema Escuro Personalizado**:
  - Cores definidas no `main.dart`
  - Typography system consistente
  - Input decoration themes

#### Configuração de Plataforma
- **Multi-plataforma**:
  - Android, iOS, Web, Desktop
  - Configurações específicas por plataforma
  - Assets e ícones adaptados

### Performance e Otimização

#### Lazy Loading
- **Carregamento Sob Demanda**:
  - Providers auto-dispose
  - Imagens carregadas apenas quando necessárias
  - Dados meteorológicos carregados por cidade

#### Cache Strategy
- **Estratégia de Cache**:
  - Cache de imagens automático
  - Estado mantido durante sessão
  - Limpeza automática de recursos

#### Memory Management
- **Gerenciamento de Memória**:
  - Auto-dispose de providers
  - Limpeza automática de recursos
  - Prevenção de memory leaks

## 🎯 Benefícios da Arquitetura Escolhida

### Manutenibilidade
- Separação clara de responsabilidades
- Código modular e testável
- Fácil adição de novas funcionalidades

### Testabilidade
- Injeção de dependências facilita mocks
- Camadas isoladas permitem testes unitários
- Providers podem ser testados independentemente

### Escalabilidade
- Estrutura preparada para múltiplas features
- Padrões consistentes em todo o projeto
- Fácil integração de novas APIs

### Performance
- Gerenciamento eficiente de estado
- Cache inteligente de recursos
- Carregamento otimizado de dados

Esta documentação técnica demonstra que o projeto UTP Weather App utiliza uma arquitetura moderna, bem estruturada e seguindo as melhores práticas do desenvolvimento Flutter, proporcionando uma base sólida para manutenção e expansão futura. 