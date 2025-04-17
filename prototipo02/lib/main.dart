import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Calculadora IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  String _resultado = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _onCalcular,
          child: const Text('Calcular IMC'),
        ),
      ),
    );
  }
}
