// lib/main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/screens/main_wrapper_screen.dart';

void main() {
  runApp(const ProntuarioFamiliarApp());
}

class ProntuarioFamiliarApp extends StatelessWidget {
  const ProntuarioFamiliarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prontuário Familiar',
      debugShowCheckedModeBanner: false,
      // Tema com cores limpas e alto contraste para o público 50+
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          primary: Colors.teal.shade700,
          secondary: Colors.tealAccent.shade700,
        ),
        useMaterial3: true,
        // Usando Google Fonts (Poppins) para toda a aplicação
        textTheme: GoogleFonts.poppinsTextTheme(
          const TextTheme(
            bodyLarge: TextStyle(fontSize: 18.0, color: Colors.black87),
            bodyMedium: TextStyle(fontSize: 16.0, color: Colors.black87),
            titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const MainWrapperScreen(),
    );
  }
}