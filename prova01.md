## Equipe

- Alexandre Junior Garcia dos Santos
- Lucas Gabriel Novak
- Vitor Roberto Batista Schirmer

## 1. Protótipo 1

**Descrição**: 
Implementação da tela para calcular o IMC do usuário.

**Aplicações**: 
Criação de 2 inputs: Peso e metros, botão de calcular e o container com o resultado do calculo.

**Como usar**:
O código completo está disponível em: [prova01/prototipo01/lib/main.dart](prova01/prototipo01/lib/main.dart)

Segue o a explicação do código do protótipo 1.
```dart
// declarações das funções:
Map<String, dynamic> calcImc(double peso, double altura) {
  final double imc = peso / (altura * altura);
  String classificacao;
  if (imc < 16.5) {
    classificacao = 'Muito magro';
  } else if (imc < 18.5) {
    classificacao = 'Magro';
  } else if (imc < 25.0) {
    classificacao = 'Normal';
  } else if (imc < 30.0) {
    classificacao = 'Sobrepeso';
  } else {
    classificacao = 'Obeso';
  }
  return {'valor': imc, 'classificacao': classificacao};
}

void _onCalcular() {
  final double peso = double.tryParse(_pesoController.text.replaceAll(',', '.')) ?? 0;
  final double altura = double.tryParse(_alturaController.text.replaceAll(',', '.')) ?? 0;
  final imcData = calcImc(peso, altura);
  setState(() {
    _resultado = 'IMC: ${imcData['valor'].toStringAsFixed(2)} '
        '(${imcData['classificacao']})';
  });
}

// Agrupa-se em coluna os seguintes componentes:
// 1. TextField: Peso (kg)
// 2. SizedBox: Container vazio para criar espaçamento entre os componentes.
// 3. TextField: Altura (m)
// 4. SizedBox: Container vazio para criar espaçamento entre os componentes.
// 5. Text: texto resultado
Column(
      children: [
        TextField(
          controller: _pesoController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Peso (kg)', border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _alturaController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Altura (m)', border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          _resultado,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
)  

// Insere um botão na barra de navegação inferior.
// Ao clicar no botão, o evento onPressed é disparado executando a função `onCalcular`
bottomNavigationBar: Padding(
  padding: const EdgeInsets.all(16),
  child: ElevatedButton(
    onPressed: _onCalcular,
    child: const Text('CALCULAR IMC'),
  ),
)
```

**Resultado**:

![alt text](assets/image2.png)

## 2. Protótipo 2

**Descrição**: 
Implementação da tela do artista de música.

**Aplicações**: 
Implementação dos componentes de UI: Icon, foto de perfil, texto com o nome do artista, texto com o gênero musical, lista de músicas e botões no footer da página.

**Como usar**:
O código completo está disponível em: [prova01/prototipo02/lib/main.dart](prova01/prototipo01/lib/main.dart)

```dart
// Define a classe PerfilArtistaPage como um StatefulWidget, que permite gerenciar estados dinâmicos.
// StatefulWidgets são usados quando a interface precisa ser atualizada em resposta a interações do usuário ou mudanças de dados.
class PerfilArtistaPage extends StatefulWidget {
  // Construtor constante com uma chave opcional para identificação do widget na árvore de widgets.
  const PerfilArtistaPage({super.key});

  // Método que cria o estado associado a este widget.
  // Retorna uma instância de _PerfilArtistaPageState, onde a lógica e a interface são definidas.
  @override
  State<PerfilArtistaPage> createState() => _PerfilArtistaPageState();
}

// Classe que gerencia o estado da PerfilArtistaPage.
// Aqui são definidas as variáveis de estado, métodos de interação e a construção da interface.
class _PerfilArtistaPageState extends State<PerfilArtistaPage> {
  // Variável booleana que controla o estado do botão de "curtir".
  // Inicialmente falsa, indicando que o artista não está curtido.
  bool curtido = false;

  // Variável booleana que controla o estado do botão de "seguir".
  // Inicialmente falsa, indicando que o usuário não está seguindo o artista.
  bool seguindo = false;

  // Método que alterna o estado de "curtido" (curtir/descurtir).
  // Usa setState para notificar o framework que o estado mudou, reconstruindo a interface.
  void _toggleCurtir() {
    setState(() => curtido = !curtido);
  }

  // Método que alterna o estado de "seguindo" (seguir/deixar de seguir).
  // Similar a _toggleCurtir, usa setState para atualizar a interface.
  void _toggleSeguir() {
    setState(() => seguindo = !seguindo);
  }

  // Método que exibe uma SnackBar (mensagem temporária na parte inferior da tela) ao clicar no botão "Ouvir".
  // A SnackBar mostra a mensagem "🎵 Tocando agora..." para simular o início da reprodução de uma música.
  void _ouvirAgora() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🎵 Tocando agora...')),
    );
  }

  // Método principal que constrói a interface da tela.
  // Retorna um widget Scaffold, que fornece a estrutura básica de uma tela Material Design.
  @override
  Widget build(BuildContext context) {
    // Define uma constante para espaçamento vertical, usada para manter consistência no layout.
    const spacing = SizedBox(height: 16);

    // Retorna um Scaffold, que organiza a tela com uma barra superior, corpo e barra inferior.
    return Scaffold(
      // Define a AppBar (barra superior) com um título centralizado.
      appBar: AppBar(
        // Título da barra, exibindo "Perfil do Artista".
        title: const Text('Perfil do Artista'),
        // Centraliza o título na AppBar.
        centerTitle: true,
        // Define a cor de fundo da AppBar como branca, garantindo um visual limpo.
        backgroundColor: Colors.white,
      ),
      // Define o corpo da tela, que contém todos os elementos visuais principais.
      body: Padding(
        // Aplica um preenchimento (padding) simétrico de 24 pixels horizontalmente e 16 pixels verticalmente.
        // Isso cria margens internas para evitar que o conteúdo fique colado nas bordas da tela.
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        // Usa uma Column para organizar os elementos verticalmente.
        // crossAxisAlignment.start alinha os filhos à esquerda, exceto onde centralização é explicitamente definida.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção superior com um ícone de estrela centralizado.
            const Center(
              child: Icon(
                Icons.star, // Ícone de estrela, possivelmente representando destaque ou favorito.
                size: 48, // Tamanho grande para destaque visual.
                color: Colors.blue, // Cor azul para contraste.
              ),
            ),
            // Texto "Hum" centralizado, possivelmente um placeholder ou nome fictício.
            // Pode ser um erro ou algo a ser substituído por conteúdo real.
            const Center(
              child: Text('Hum'),
            ),
            // Espaçamento vertical usando a constante definida.
            spacing,
            // Avatar circular que representa a imagem do artista.
            Center(
              child: CircleAvatar(
                radius: 60, // Define o tamanho do avatar (diâmetro de 120 pixels).
                backgroundColor: Colors.grey[300], // Cor de fundo caso a imagem não carregue.
                // Imagem do artista carregada de um arquivo local no diretório assets.
                backgroundImage: const AssetImage('assets/imagens/artista.png'),
              ),
            ),
            // Espaçamento vertical para separar o avatar do texto seguinte.
            spacing,
            // Nome do artista em destaque, centralizado.
            Center(
              child: Text(
                'Nome do Artista', // Texto fixo, provavelmente um placeholder.
                // Estilo baseado no tema do aplicativo (headlineSmall), com ajustes.
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold, // Negrito para destaque.
                  color: Colors.black, // Cor preta para legibilidade.
                ),
              ),
            ),
            // Informações sobre o estilo musical do artista, centralizado.
            Center(
              child: Text(
                'Estilo Musical • Pop/Rock', // Texto fixo indicando o gênero musical.
                // Estilo baseado no tema (bodyMedium), com ajustes.
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600], // Cinza claro para menor destaque.
                ),
              ),
            ),
            // Espaçamento maior para separar a seção de informações da seção de músicas.
            const SizedBox(height: 24),
            // Título da seção de músicas, alinhado à esquerda.
            Text(
              'Musicas', // Título da lista de músicas.
              // Estilo baseado no tema (titleLarge), com cor preta.
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
              ),
            ),
            // Espaçamento antes da lista de músicas.
            const SizedBox(height: 12),
            // Lista expansível que ocupa o espaço restante da tela.
            Expanded(
              child: ListView(
                // Remove qualquer padding padrão da ListView para alinhamento consistente.
                padding: EdgeInsets.zero,
                // Lista de widgets filhos, representando as músicas do artista.
                children: const [
                  // Primeiro cartão de música.
                  Card(
                    // Margem vertical para espaçamento entre cartões.
                    margin: EdgeInsets.symmetric(vertical: 8),
                    // Elevação para dar um efeito de sombra, simulando profundidade.
                    elevation: 2,
                    // Cor de fundo branca para o cartão.
                    color: Colors.white,
                    // Borda arredondada para um visual moderno.
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    // Conteúdo do cartão, usando ListTile para layout padrão.
                    child: ListTile(
                      // Ícone de álbum à esquerda.
                      leading: Icon(
                        Icons.album,
                        size: 32, // Tamanho maior para destaque.
                        color: Colors.black, // Cor preta para consistência.
                      ),
                      // Título da música.
                      title: Text('MusicaUm'),
                      // Ano de lançamento como subtítulo.
                      subtitle: Text('2020'),
                    ),
                  ),
                  // Segundo cartão de música, com estrutura idêntica ao primeiro.
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.album,
                        size: 32,
                        color: Colors.black,
                      ),
                      title: Text('MusicaDois'),
                      subtitle: Text('2016'),
                    ),
                  ),
                  // Terceiro cartão de música, com estrutura idêntica.
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.album,
                        size: 32,
                        color: Colors.black,
                      ),
                      title: Text('MusicaTres'),
                      subtitle: Text('2015'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Barra inferior que contém os botões de interação.
      bottomNavigationBar: Padding(
        // Preenchimento de 16 pixels em todas as direções para margens internas.
        padding: const EdgeInsets.all(16),
        // Linha para organizar os botões horizontalmente.
        child: Row(
          // Distribui os botões uniformemente no espaço disponível.
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Botão para curtir/descurtir o artista.
            ElevatedButton.icon(
              // Chama a função _toggleCurtir ao clicar.
              onPressed: _toggleCurtir,
              // Ícone dinâmico: coração preenchido se curtido, vazio se não curtido.
              icon: Icon(
                curtido ? Icons.favorite : Icons.favorite_border,
                color: curtido ? Colors.red : Colors.black, // Vermelho se curtido, preto se não.
              ),
              // Texto do botão, mudando entre "Curtido" e "Curtir".
              label: Text(curtido ? 'Curtido' : 'Curtir'),
              // Estilo personalizado do botão.
              style: ElevatedButton.styleFrom(
                // Borda arredondada para visual moderno.
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                // Preenchimento interno para tamanho confortável.
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                // Fundo branco para consistência com o tema.
                backgroundColor: Colors.white,
                // Cor do texto e ícone (preto, exceto quando curtido).
                foregroundColor: Colors.black,
              ),
            ),
            // Botão para seguir/deixar de seguir o artista.
            ElevatedButton.icon(
              // Chama a função _toggleSeguir ao clicar.
              onPressed: _toggleSeguir,
              // Ícone dinâmico: check se seguindo, ícone de adicionar pessoa se não.
              icon: Icon(
                seguindo ? Icons.check : Icons.person_add_alt_1,
                color: seguindo ? Colors.green : Colors.black, // Verde se seguindo, preto se não.
              ),
              // Texto do botão, mudando entre "Seguindo" e "Seguir".
              label: Text(seguindo ? 'Seguindo' : 'Seguir'),
              // Estilo idêntico ao botão de curtir para consistência visual.
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
            // Botão para ouvir música.
            ElevatedButton.icon(
              // Chama a função _ouvirAgora ao clicar.
              onPressed: _ouvirAgora,
              // Ícone de play, fixo, indicando reprodução.
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.black,
              ),
              // Texto fixo "Ouvir".
              label: const Text('Ouvir'),
              // Estilo idêntico aos outros botões para uniformidade.
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Resultado**:

![alt text](assets/image3.png)
