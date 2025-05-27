import 'package:flutter/material.dart';
import 'screens/perfil_pet_screen.dart';

void main() {
  runApp(const PetApp());
}

class PetApp extends StatelessWidget {
  const PetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetApp',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: const PerfilPetScreen(),
    );
  }
} 