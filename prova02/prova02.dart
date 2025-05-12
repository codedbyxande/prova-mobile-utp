import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: CampoMinadoGame()));

class CampoMinadoGame extends StatefulWidget {
  @override
  _CampoMinadoGameState createState() => _CampoMinadoGameState();
}

class _CampoMinadoGameState extends State<CampoMinadoGame> {
  late int tesouro;
  late int bomba;
  late int monstro;
  String mensagem = 'Escolha um número entre 1 e 20.';
  List<String> botoesTexto = List.filled(20, '');
  List<bool> botoesDesabilitados = List.filled(20, false);

  void novoJogo() {
    final random = Random();

    // Sorteio dos três números únicos
    List<int> numeros = [];
    while (numeros.length < 3) {
      int n = random.nextInt(20) + 1;
      if (!numeros.contains(n)) numeros.add(n);
    }

    tesouro = numeros[0];
    bomba = numeros[1];
    monstro = numeros[2];

    setState(() {
      mensagem = 'Escolha um número entre 1 e 20.';
      botoesTexto = List.filled(20, '');
      botoesDesabilitados = List.filled(20, false);
    });
  }

  void verificarNumero(int numero) {
    setState(() {
      if (numero == tesouro) {
        mensagem = '🎉 Parabéns! Você encontrou o tesouro!';
        botoesTexto[numero - 1] = '🏆';
        desabilitarTodos();
      } else if (numero == bomba) {
        mensagem = '💥 Você clicou na bomba! Fim de jogo.';
        botoesTexto[numero - 1] = '💣';
        desabilitarTodos();
      } else if (numero == monstro) {
        mensagem = '👾 Você foi pego pelo monstro!';
        botoesTexto[numero - 1] = '👾';
        desabilitarTodos();
      } else {
        if (numero < tesouro) {
          mensagem = '📈 O tesouro está em um número MAIOR.';
        } else {
          mensagem = '📉 O tesouro está em um número MENOR.';
        }
        botoesTexto[numero - 1] = '❌';
        botoesDesabilitados[numero - 1] = true;
      }
    });
  }

  void desabilitarTodos() {
    for (int i = 0; i < botoesDesabilitados.length; i++) {
      botoesDesabilitados[i] = true;
    }
  }

  @override
  void initState() {
    super.initState();
    novoJogo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Fundo azul
        centerTitle: true, // Centraliza o título
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            'Jogo do Tesouro',
            style: TextStyle(
              color: Colors.white, // Texto branco
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              mensagem,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: List.generate(20, (index) {
                  return ElevatedButton(
                    onPressed:
                        botoesDesabilitados[index]
                            ? null
                            : () => verificarNumero(index + 1),
                    child: Text(
                      botoesTexto[index].isEmpty
                          ? '${index + 1}'
                          : botoesTexto[index],
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: novoJogo,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Fundo azul
                foregroundColor: Colors.white, // Cor do texto
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold, // Texto em negrito
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    4,
                  ), // Menor border radius para deixar mais "quadrado"
                ),
              ),
              child: const Text('Novo Jogo'),
            ),
          ],
        ),
      ),
    );
  }
}