import 'package:flutter/material.dart'; // Importa o pacote material para UI.
import 'perfil_pet_screen.dart'; // Importa a tela do perfil do pet.

void main() => runApp(const PetApp()); // Inicia o app.

class PetApp extends StatelessWidget {
  const PetApp({super.key}); // Construtor.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetApp TUI', // Título do app.
      theme: ThemeData(
        brightness: Brightness.dark, // Tema escuro (TUI geralmente é escuro).
        primarySwatch: Colors.blueGrey, // Cor primária.
        scaffoldBackgroundColor: Colors.black, // Fundo preto.
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black, // AppBar preta.
          foregroundColor: Colors.white, // Texto branco.
          elevation: 0, // Sem sombra na AppBar.
          centerTitle: true, // Centraliza o título.
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true, // Campos preenchidos.
          fillColor: Colors.grey[900], // Fundo escuro para campos.
          labelStyle: const TextStyle(color: Colors.white70), // Label claro.
          border: const OutlineInputBorder(
            // Borda simples e quadrada.
            borderRadius: BorderRadius.zero, // Sem borda arredondada.
            borderSide: BorderSide(color: Colors.grey), // Borda cinza.
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.cyan, width: 2), // Borda focada em ciano.
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.red, width: 2), // Borda de erro.
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: const TextStyle(color: Colors.white), // Texto principal branco.
          bodyMedium: const TextStyle(color: Colors.white70), // Texto secundário mais claro.
          headlineSmall: const TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold), // Títulos de seção.
          titleMedium: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        cardTheme: CardThemeData(
          color: Colors.grey[900], // Cards escuros.
          elevation: 0, // Sem sombra nos cards.
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Cards quadrados.
            side: BorderSide(color: Colors.grey), // Borda nos cards.
          ),
          margin: EdgeInsets.zero, // Sem margem padrão.
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan, // Botão ciano.
            foregroundColor: Colors.black, // Texto preto.
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero), // Botões quadrados.
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.grey), // Borda cinza.
            foregroundColor: Colors.white, // Texto branco.
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero), // Botões quadrados.
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.cyan, // Cursor ciano.
          selectionColor: Colors.cyanAccent, // Seleção de texto ciano.
        ),
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.cyan; // Rádio selecionado ciano.
            }
            return Colors.grey; // Rádio não selecionado cinza.
          }),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.cyan; // Checkbox selecionado ciano.
            }
            return Colors.grey; // Checkbox não selecionado cinza.
          }),
          checkColor: WidgetStateProperty.all(Colors.black), // Ícone de check preto.
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero), // Checkbox quadrado.
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.cyan; // Botão do switch ciano.
            }
            return Colors.grey; // Botão do switch cinza.
          }),
          trackColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.cyan.withOpacity(0.5); // Fundo do switch ciano.
            }
            return Colors.grey.withOpacity(0.5); // Fundo do switch cinza.
          }),
        ),
      ),
      home: const PerfilPetScreen(),
    );
  }
}