import 'package:flutter/material.dart';

enum PetGenero { macho, femea }

class PerfilPetScreen extends StatefulWidget {
  const PerfilPetScreen({super.key});

  @override
  State<PerfilPetScreen> createState() => _PerfilPetScreenState();
}

class _PerfilPetScreenState extends State<PerfilPetScreen> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final racaController = TextEditingController();
  final idadeController = TextEditingController();
  final observacoesController = TextEditingController();

  PetGenero? _generoSelecionado;
  bool _gostaCriancas = false;
  bool _conviveOutrosAnimais = false;
  bool _disponivelParaAdocao = false;

  @override
  void dispose() {
    nomeController.dispose();
    racaController.dispose();
    idadeController.dispose();
    observacoesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Pet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Perfil do Usuário',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Perfil do usuário em desenvolvimento')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cadastro de Perfil do Pet',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Preencha os dados do seu pet!',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome do Pet',
                      prefixIcon: Icon(Icons.pets),
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o nome do pet';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: racaController,
                    decoration: const InputDecoration(
                      labelText: 'Raça',
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a raça do pet';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: idadeController,
                    decoration: const InputDecoration(
                      labelText: 'Idade (em anos)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a idade do pet';
                      }
                      final idade = int.tryParse(value);
                      if (idade == null || idade < 0) {
                        return 'Idade inválida';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: observacoesController,
                    decoration: const InputDecoration(
                      labelText: 'Observações',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gênero',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    RadioListTile<PetGenero>(
                      title: const Text('Macho'),
                      value: PetGenero.macho,
                      groupValue: _generoSelecionado,
                      onChanged: (PetGenero? value) {
                        setState(() {
                          _generoSelecionado = value;
                        });
                      },
                    ),
                    RadioListTile<PetGenero>(
                      title: const Text('Fêmea'),
                      value: PetGenero.femea,
                      groupValue: _generoSelecionado,
                      onChanged: (PetGenero? value) {
                        setState(() {
                          _generoSelecionado = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Preferências',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    CheckboxListTile(
                      title: const Text('Gosta de crianças'),
                      value: _gostaCriancas,
                      onChanged: (bool? valor) {
                        setState(() {
                          _gostaCriancas = valor ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Convive bem com outros animais'),
                      value: _conviveOutrosAnimais,
                      onChanged: (bool? valor) {
                        setState(() {
                          _conviveOutrosAnimais = valor ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SwitchListTile(
                      title: const Text('Disponível para adoção'),
                      value: _disponivelParaAdocao,
                      onChanged: (bool valor) {
                        setState(() {
                          _disponivelParaAdocao = valor;
                        });
                      },
                    ),
                    Text(
                      'Status: ${_disponivelParaAdocao ? 'Disponível' : 'Indisponível'}',
                      style: TextStyle(
                        color: _disponivelParaAdocao ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final nomePet = nomeController.text;
                      final racaPet = racaController.text;
                      final idadePet = int.tryParse(idadeController.text);
                      final observacoesPet = observacoesController.text;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Dados salvos com sucesso!')),
                      );
                    }
                  },
                  child: const Text('Salvar'),
                ),
                OutlinedButton(
                  onPressed: () {
                    nomeController.clear();
                    racaController.clear();
                    idadeController.clear();
                    observacoesController.clear();
                    setState(() {
                      _generoSelecionado = null;
                      _gostaCriancas = false;
                      _conviveOutrosAnimais = false;
                      _disponivelParaAdocao = false;
                    });
                  },
                  child: const Text('Limpar 🔁'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 