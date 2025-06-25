# 🌤️ UTP - App Climático

## 📱 Descrição Geral

**Título:** UTP - App Climático  
**Versão:** 1.0.0
**Apk link**: https://drive.google.com/file/d/1oAulkZVHbO1MHSqNN6VnSuZfUP0txgcJ/view?usp=sharing


### Propósito da Aplicação
O UTP - App Climático é um aplicativo móvel desenvolvido em Flutter que permite aos usuários consultar informações meteorológicas em tempo real e previsões para qualquer cidade do mundo. O aplicativo oferece uma interface moderna e intuitiva com design minimalista inspirado no iOS, proporcionando uma experiência de usuário elegante e funcional.

### Público-Alvo
- **Usuários gerais** que desejam acompanhar o clima diariamente
- **Viajantes** que precisam verificar as condições meteorológicas de diferentes cidades
- **Profissionais** que dependem de informações climáticas para suas atividades
- **Entusiastas de tecnologia** que apreciam aplicativos com design moderno e funcional

### Funcionalidades Principais
- 🔍 **Busca por cidade** com interface intuitiva
- 🌡️ **Temperatura atual** em tempo real
- 📊 **Previsão de 5 dias** com detalhes por período
- 🎨 **Design minimalista** com tema escuro
- 📱 **Interface responsiva** para diferentes tamanhos de tela
- 🌍 **Suporte a múltiplas cidades** globais

---

## 🏗️ Arquitetura e Tecnologias

### Arquitetura Utilizada
O projeto segue a **Clean Architecture** com separação clara de responsabilidades:

```
lib/src/
├── api/                    # Camada de API externa
├── constants/              # Constantes da aplicação
└── features/
    └── weather/
        ├── application/   # Camada de aplicação (Providers)
        ├── data/          # Camada de dados (Repository)
        ├── domain/        # Camada de domínio (Entidades)
        └── presentation/  # Camada de apresentação (UI)
```

### Padrões de Design
- **Repository Pattern** - Para abstração da fonte de dados
- **Provider Pattern** - Para gerenciamento de estado (Riverpod)
- **Dependency Injection** - Para injeção de dependências
- **MVVM** - Model-View-ViewModel com Riverpod

### Componentes e Bibliotecas Principais

#### Estado e Gerenciamento
- **flutter_riverpod** (^2.4.8) - Gerenciamento de estado reativo
- **freezed** (^2.4.5) - Geração de código para data classes
- **json_annotation** (^4.8.1) - Serialização JSON

#### UI e Interface
- **flutter** (SDK) - Framework principal
- **cached_network_image** (^3.4.1) - Cache de imagens de rede
- **cupertino_icons** (^1.0.6) - Ícones do iOS

#### Rede e APIs
- **http** (^1.2.2) - Cliente HTTP para requisições
- **OpenWeatherMap API** - Serviço de dados meteorológicos

#### Utilitários
- **intl** (^0.18.1) - Internacionalização e formatação
- **build_runner** (^2.4.6) - Geração de código
- **mocktail** (^1.0.1) - Mocking para testes

### Tecnologias Empregadas

#### Armazenamento
- **Memória** - Dados temporários via Riverpod
- **Cache de Imagens** - Cache automático de ícones meteorológicos

#### APIs Externas
- **OpenWeatherMap API v2.5**
  - Endpoint: `api.openweathermap.org/data/2.5/`
  - Funcionalidades: Weather e Forecast
  - Unidades: Métricas (Celsius)
  - Autenticação: API Key

#### Recursos do Sistema
- **Status Bar** - Configuração transparente para tema escuro
- **Safe Area** - Adaptação para diferentes dispositivos
- **Responsive Design** - Layout adaptativo

#### Funcionalidades Avançadas
- **Error Handling** - Tratamento robusto de erros de API
- **Loading States** - Indicadores de carregamento
- **Offline Detection** - Detecção de conexão com internet
- **Internationalization** - Suporte a múltiplos idiomas

---

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK >=3.2.0
- Dart SDK >=3.2.0
- API Key do OpenWeatherMap

### Instalação
```bash
# Clone o repositório
git clone [URL_DO_REPOSITORIO]

# Entre no diretório
cd utp_app_climatico

# Instale as dependências
flutter pub get

# Configure a API Key
# Edite lib/src/api/api_keys.dart ou use --dart-define

# Execute o aplicativo
flutter run
```

### Configuração da API Key
1. Obtenha uma API Key gratuita em [OpenWeatherMap](https://openweathermap.org/api)
2. Configure no arquivo `lib/src/api/api_keys.dart`
3. Ou use: `flutter run --dart-define=API_KEY=sua_api_key`

---

## 📊 Estrutura do Projeto

```
lib/
├── main.dart                                    # Ponto de entrada
└── src/
    ├── api/
    │   ├── api.dart                            # Cliente da API
    │   └── api_keys.dart                       # Chaves da API
    ├── constants/
    │   └── app_colors.dart                     # Paleta de cores
    └── features/
        └── weather/
            ├── application/
            │   └── providers.dart              # Providers Riverpod
            ├── data/
            │   ├── api_exception.dart          # Exceções da API
            │   └── weather_repository.dart     # Repositório
            ├── domain/
            │   ├── forecast/                   # Entidades de previsão
            │   ├── weather/                    # Entidades de clima
            │   └── temperature.dart            # Modelo de temperatura
            └── presentation/
                ├── city_search_box.dart        # Campo de busca
                ├── current_weather.dart        # Clima atual
                ├── hourly_weather.dart         # Previsão horária
                ├── weather_icon_image.dart     # Ícones meteorológicos
                └── weather_page.dart           # Página principal
```

---

## 🎨 Design System

### Paleta de Cores (Tema Escuro)
- **Primary**: #FFFFFF (Branco)
- **Secondary**: #8E8E93 (Cinza iOS)
- **Background**: #000000 (Preto)
- **Card Background**: #2C2C2E (Cinza escuro)
- **Accent**: #007AFF (Azul iOS)
- **Error**: #FF453A (Vermelho iOS)

### Tipografia
- **Display Large**: 72px, Weight 300
- **Display Medium**: 48px, Weight 300
- **Headline Medium**: 28px, Weight 400
- **Body Large**: 18px, Weight 400
- **Body Medium**: 16px, Weight 400

### Componentes
- **Border Radius**: 16px (padrão)
- **Padding**: 24px (horizontal), 20px (cards)
- **Spacing**: 8px, 12px, 16px, 20px, 40px, 60px

---

## 🔧 Funcionalidades Técnicas

### Gerenciamento de Estado
```dart
// Providers principais
final cityProvider = StateProvider<String>((ref) => 'Curitiba');
final currentWeatherProvider = FutureProvider.autoDispose<WeatherData>((ref) async {
  final city = ref.watch(cityProvider);
  return await ref.watch(weatherRepositoryProvider).getWeather(city: city);
});
```

### Tratamento de Erros
- **InvalidApiKeyException** - Chave de API inválida
- **CityNotFoundException** - Cidade não encontrada
- **NoInternetConnectionException** - Sem conexão
- **UnknownException** - Erros desconhecidos

### Cache e Performance
- **Cached Network Image** - Cache automático de ícones
- **Auto Dispose** - Limpeza automática de recursos
- **Lazy Loading** - Carregamento sob demanda

---

## 📱 Demonstração

### Funcionalidades para Demonstrar
1. **Busca por cidade** - Digite "London", "Tokyo", "São Paulo"
2. **Exibição do clima atual** - Temperatura, ícone, min/max
3. **Previsão de 5 dias** - Cards com informações detalhadas
4. **Design responsivo** - Rotação de tela
5. **Tratamento de erros** - Teste com cidade inexistente

### Fluxo de Uso
1. Abrir o aplicativo
2. Ver clima atual da cidade padrão (Curitiba)
3. Buscar nova cidade
4. Visualizar previsão semanal
5. Testar diferentes cidades

---

## 🎯 Pontos de Destaque

### Inovação
- **Design minimalista** inspirado no iOS
- **Tema escuro** moderno e elegante
- **Interface intuitiva** com foco na usabilidade

### Qualidade Técnica
- **Clean Architecture** bem estruturada
- **Gerenciamento de estado** eficiente com Riverpod
- **Tratamento robusto de erros**
- **Código limpo** e bem documentado

### Experiência do Usuário
- **Carregamento rápido** com cache inteligente
- **Feedback visual** claro para todas as ações
- **Design consistente** em toda a aplicação
- **Acessibilidade** considerada no design


