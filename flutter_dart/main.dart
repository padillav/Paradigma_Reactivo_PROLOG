import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ContadorReactivo()));

class ContadorReactivo extends StatefulWidget {
  const ContadorReactivo({super.key});

  @override
  State<ContadorReactivo> createState() => _ContadorState();
}

class _ContadorState extends State<ContadorReactivo> {
  int valor = 0; // El estado que será observado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi App Reactiva')),
      body: Center(
        child: Text(
          'Contador de clicks: $valor', 
          style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // La magia reactiva: setState redibuja solo lo necesario
        onPressed: () => setState(() => valor++),
        child: const Icon(Icons.add),
      ),
    );
  }
}