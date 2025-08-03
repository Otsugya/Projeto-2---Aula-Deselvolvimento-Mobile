import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário de Cadastro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        useMaterial3: true,
      ),
      home: const FormularioPage(),
    );
  }
}

class FormularioPage extends StatefulWidget {
  const FormularioPage({super.key});

  @override
  State<FormularioPage> createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  DateTime? _dataNascimento;
  String? _sexoSelecionado;

  String? _validarIdade(DateTime? data) {
    if (data == null) return 'Selecione sua data de nascimento';
    final hoje = DateTime.now();
    final idade =
        hoje.year -
        data.year -
        ((hoje.month < data.month ||
                (hoje.month == data.month && hoje.day < data.day))
            ? 1
            : 0);
    if (idade < 18) return 'É necessário ter mais de 18 anos';
    return null;
  }

  void _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
    }
  }

  Future<void> _selecionarData() async {
    final DateTime? selecionada = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selecionada != null) {
      setState(() {
        _dataNascimento = selecionada;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Formulário de Cadastro',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Nome Completo
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome Completo',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe seu nome completo';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Data de Nascimento
                    GestureDetector(
                      onTap: _selecionarData,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Data de Nascimento',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _dataNascimento == null
                                  ? 'Nenhuma data selecionada'
                                  : '${_dataNascimento!.day}/${_dataNascimento!.month}/${_dataNascimento!.year}',
                            ),
                            const Icon(Icons.edit_calendar),
                          ],
                        ),
                      ),
                    ),
                    if (_validarIdade(_dataNascimento) != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _validarIdade(_dataNascimento)!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),

                    const SizedBox(height: 20),

                    // Sexo
                    DropdownButtonFormField<String>(
                      value: _sexoSelecionado,
                      items: const [
                        DropdownMenuItem(value: 'Homem', child: Text('Homem')),
                        DropdownMenuItem(
                          value: 'Mulher',
                          child: Text('Mulher'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Sexo',
                        prefixIcon: Icon(Icons.person_2),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _sexoSelecionado = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Selecione seu sexo' : null,
                    ),

                    const SizedBox(height: 30),

                    // Botão
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {});
                          if (_validarIdade(_dataNascimento) == null &&
                              _formKey.currentState!.validate()) {
                            _enviarFormulario();
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Cadastrar'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
