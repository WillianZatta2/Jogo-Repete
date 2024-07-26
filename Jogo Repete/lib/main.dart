import 'package:flutter/material.dart';
import 'package:data/resposta_estado.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: RespostaEstado(),
        ),
      ),
    );
  }
}