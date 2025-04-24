## Equipe

- Alexandre Junior Garcia dos Santos
- Lucas Gabriel Novak
- Vitor Roberto Batista Schirmer

## 1. Protótipo 1

- Text Field
  - descrição: campo de inserção de dados.
  - aplicaçao: usado para inserir o peso e altura do usuário.
  - como usar:
  ```dart
   // Renderiza o texto, definido o label e váriavel de controle.
   TextField(
          controller: _pesoController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Peso (kg)', border: OutlineInputBorder(),
          ),
  ),
  ```
- Text:
  - descrição: container contendo algum texto.
  - aplicação: usado para mostrar o resultado do cálculo.
  - como usar:
  ```dart
  Text(
    _resultado,
    style: Theme.of(context).textTheme.headlineMedium,
  ),
  ```
- Sized box
  - descrição: container vazio para criar espaçamento entre componentes
  - aplicação: usado para criar espaço vazio entre os TextField.
  - como usar:
  ```dart
  const SizedBox(height: 16),
  ```
- ElevatedButton
  - descrição: renderiza um botão com uma elevação (box-shadow)
  - aplicação: usado para disparar a função de calcular IMC.
  - como usar:
  ```dart
  ElevatedButton(
    onPressed: _onCalcular,
    child: const Text('CALCULAR IMC'),
  ),
  ```
- Padding:
  - descrição: espaçamento interno de um componente
  - aplicação: usado para adicionar um espaçamento interno no componente ElevatedButton, melhorando seu design.
  - como usar:
  ```dart
  Padding(
    padding: const EdgeInsets.all(16),
    child: ElevatedButton(
      onPressed: _onCalcular,
      child: const Text('CALCULAR IMC'),
    ),
  )
  ```

![alt text](assets/image2.png)

## 2. Protótipo 2 
Alguns componentes que foram usando no protótipo 1 também foram utilizados neste protótipo. Para evitar redundância, eles não foram descritos. (TextField, Text, SizedBox, ElevatedButton, Padding)

- Scaffold:
  - descrição: componente fundamental que implementa a estrutura de layout visual básica do Material Design.
  - aplicação: usado para criar a estrutura principal da tela, fornecendo áreas para AppBar, corpo da aplicação e outros elementos.
  - como usar: 

```dart
Scaffold(
  appBar: AppBar(
    title: const Text('Perfil do Artista'),
    centerTitle: true,
    backgroundColor: Colors.white,
  ),
  body: Column(
    children: [
      // Conteúdo da tela
    ],
  ),
)
```

- AppBar:
  - descrição: componente renderizado no topo do aplicativo.
  - aplicação: usado para modificar o texto no topo do aplicativo, inserindo o texto "Perfil de artista"
  - como usar: 

```dart
   // Renderiza o texto, definido o label e váriavel de controle.
   AppBar(
        // Título da barra, exibindo "Perfil do Artista".
        title: const Text('Perfil do Artista'),
        // Centraliza o título na AppBar.
        centerTitle: true,
        // Define a cor de fundo da AppBar como branca, garantindo um visual limpo.
        backgroundColor: Colors.white,
  ),
```

- Center:
  - descrição: alinhamento do texto.
  - aplicação: utilizado para definir o alinhamento central do texto.
  - como usar: 

```dart
   Center(
    child: Text(
      'Estilo Musical • Pop/Rock', 
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Colors.grey[600], // Cinza claro para menor destaque.
      ),
    ),
  ),
```

- Expanded e ListView:
  - descrição: Expanded força um widget filho a preencher o espaço disponível, enquanto ListView cria uma lista rolável de elementos.
  - aplicação: utilizados em conjunto para criar uma lista de músicas rolável que ocupa todo o espaço restante na tela.
  - como usar: 

```dart
    // Lista expansível que ocupa o espaço restante da tela.
    Expanded(
      child: ListView(
        children: [
          // Itens da lista
        ],
      )
    )
```

- Card, ListTitle e RoundedRectangleBorder:
  - descrição: Card é um contêiner com elevação e cantos arredondados; ListTile organiza conteúdo em um layout padronizado; RoundedRectangleBorder define bordas arredondadas para os widgets.
  - aplicação: utilizados para criar cartões de música com informações organizadas, proporcionando uma interface visual atraente e consistente.
  - como usar: 

```dart
    // Primeiro cartão de música.
    Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      // Conteúdo do cartão, usando ListTile para layout padrão.
      child: ListTile(
        leading: Icon(
          Icons.album,
          size: 32, 
          color: Colors.black, 
        ),
        title: Text('MusicaUm'),
        subtitle: Text('2020'),
      ),
    ),
```
  
**Resultado**:

![alt text](assets/image3.png)
