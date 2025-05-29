import 'package:flutter/material.dart'; // Importa o pacote material para UI.
import 'package:flutter/foundation.dart'; // Importa utilities para debug.

// Enum para o gênero do pet.
enum PetGenero { macho, femea }

class PerfilPetScreen extends StatefulWidget {
  const PerfilPetScreen({super.key}); // Construtor.

  @override
  State<PerfilPetScreen> createState() => _PerfilPetScreenState(); // Cria o estado.
}

class _PerfilPetScreenState extends State<PerfilPetScreen> {
  final _formKey = GlobalKey<FormState>(); // Chave do formulário.

  // Controladores de texto.
  final _nomeController = TextEditingController();
  final _racaController = TextEditingController();
  final _idadeController = TextEditingController();
  final _observacoesController = TextEditingController();

  // Variáveis de estado.
  PetGenero? _genero;
  bool _gostaCriancas = false;
  bool _conviveAnimais = false;
  bool _disponivel = false;
  bool _loading = false;

  @override
  void dispose() {
    // Libera os controladores na saída da tela.
    _nomeController.dispose();
    _racaController.dispose();
    _idadeController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  // Função para salvar dados.
  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate() || _genero == null) {
      _mostrarMensagem(
          _genero == null ? 'Selecione o gênero' : 'Preencha todos os campos obrigatórios', true);
      return;
    }

    setState(() => _loading = true); // Inicia o loading.

    try {
      await Future.delayed(const Duration(seconds: 1)); // Simula delay.

      if (kDebugMode) { // Apenas para debug.
        print('Pet salvo: ${_nomeController.text}, ${_racaController.text}, '
            '${_idadeController.text} anos, ${_genero?.name}, '
            'Crianças: $_gostaCriancas, Animais: $_conviveAnimais, '
            'Disponível: $_disponivel, Obs: ${_observacoesController.text}');
      }
      _mostrarMensagem('Pet salvo com sucesso!', false);
    } catch (e) {
      _mostrarMensagem('Erro ao salvar!', true);
    } finally {
      setState(() => _loading = false); // Finaliza o loading.
    }
  }

  // Função para limpar dados.
  void _limpar() {
    _formKey.currentState?.reset(); // Reseta validações.
    _nomeController.clear();
    _racaController.clear();
    _idadeController.clear();
    _observacoesController.clear();
    setState(() {
      _genero = null;
      _gostaCriancas = false;
      _conviveAnimais = false;
      _disponivel = false;
    });
  }

  // Exibe mensagens na tela.
  void _mostrarMensagem(String msg, bool erro) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(color: Colors.black)), // Texto preto no SnackBar.
        backgroundColor: erro ? Colors.red : Colors.cyan, // Ciano para sucesso.
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero), // SnackBar quadrado.
      ),
    );
  }

  // Widget auxiliar para as seções em Card.
  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16), // Margem entre os cards.
      child: Padding(
        padding: const EdgeInsets.all(16), // Padding interno.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinhamento.
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall), // Título da seção.
            const Divider(color: Colors.grey, height: 24, thickness: 1), // Divisor.
            ...children, // Conteúdo da seção.
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CADASTRO DE PET'), // Título em maiúsculas.
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline), // Ícone de informação.
            onPressed: () => _mostrarMensagem('App de cadastro de pets', false),
          ),
        ],
      ),
      body: Center( // Centraliza o conteúdo.
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600), // Limita a largura para TUI.
          child: Form(
            key: _formKey,
            child: ListView( // Usando ListView para rolagem e preenchimento.
              padding: const EdgeInsets.all(16), // Padding para toda a lista.
              children: [
                _buildSectionCard(
                  title: 'DADOS DO ANIMAL',
                  children: [
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                          labelText: 'NOME DO PET', hintText: 'Ex: Rex'),
                      validator: (v) => v?.isEmpty == true ? 'Campo obrigatório' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _racaController,
                      decoration: const InputDecoration(
                          labelText: 'RAÇA', hintText: 'Ex: Labrador'),
                      validator: (v) => v?.isEmpty == true ? 'Campo obrigatório' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _idadeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'IDADE (ANOS)', hintText: 'Ex: 3'),
                      validator: (v) {
                        if (v?.isEmpty == true) return 'Campo obrigatório';
                        final idade = int.tryParse(v!);
                        return idade == null || idade < 0 ? 'Idade inválida' : null;
                      },
                    ),
                  ],
                ),

                _buildSectionCard(
                  title: 'GÊNERO',
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<PetGenero>(
                            title: const Text('MACHO'),
                            value: PetGenero.macho,
                            groupValue: _genero,
                            onChanged: (v) => setState(() => _genero = v),
                            contentPadding: EdgeInsets.zero, // Padding mínimo.
                            dense: true, // Mais compacto.
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<PetGenero>(
                            title: const Text('FÊMEA'),
                            value: PetGenero.femea,
                            groupValue: _genero,
                            onChanged: (v) => setState(() => _genero = v),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                _buildSectionCard(
                  title: 'CARACTERÍSTICAS',
                  children: [
                    CheckboxListTile(
                      title: const Text('GOSTA DE CRIANÇAS?'),
                      value: _gostaCriancas,
                      onChanged: (v) => setState(() => _gostaCriancas = v ?? false),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                    CheckboxListTile(
                      title: const Text('CONVIVE COM OUTROS ANIMAIS?'),
                      value: _conviveAnimais,
                      onChanged: (v) => setState(() => _conviveAnimais = v ?? false),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                  ],
                ),

                _buildSectionCard(
                  title: 'STATUS DE ADOÇÃO',
                  children: [
                    SwitchListTile(
                      title: const Text('DISPONÍVEL PARA ADOÇÃO?'),
                      value: _disponivel,
                      onChanged: (v) => setState(() => _disponivel = v),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                      child: Text(
                        'STATUS: ${_disponivel ? "DISPONÍVEL" : "INDISPONÍVEL"}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),

                _buildSectionCard(
                  title: 'OBSERVAÇÕES',
                  children: [
                    TextFormField(
                      controller: _observacoesController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'OUTRAS INFORMAÇÕES (OPCIONAL)',
                        alignLabelWithHint: true,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24), // Espaçamento antes dos botões.

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _loading ? null : _salvar,
                        child: _loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.black, strokeWidth: 2))
                            : const Text('SALVAR'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _loading ? null : _limpar,
                        child: const Text('LIMPAR'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}