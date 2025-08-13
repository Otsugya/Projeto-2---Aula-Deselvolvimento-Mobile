import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Carrossel de Formulários'),
          backgroundColor: Colors.blue,
        ),
        body: const FormCarousel(),
      ),
    );
  }
}

class FormCarousel extends StatefulWidget {
  const FormCarousel({super.key});

  @override
  State<FormCarousel> createState() => _FormCarouselState();
}

class _FormCarouselState extends State<FormCarousel> {
  final List<Map<String, dynamic>> formsData = List.generate(5, (_) {
    return {'nome': '', 'dataNascimento': null, 'sexo': null};
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: formsData.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 300,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Nome completo
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Nome Completo',
                      ),
                      onChanged: (value) {
                        setState(() {
                          formsData[index]['nome'] = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),

                    // Data de nascimento
                    GestureDetector(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() {
                            formsData[index]['dataNascimento'] = picked;
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Data de Nascimento',
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          formsData[index]['dataNascimento'] != null
                              ? '${formsData[index]['dataNascimento'].day}/${formsData[index]['dataNascimento'].month}/${formsData[index]['dataNascimento'].year}'
                              : 'Selecione uma data',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Sexo
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Sexo',
                        border: OutlineInputBorder(),
                      ),
                      value: formsData[index]['sexo'],
                      items: const [
                        DropdownMenuItem(value: 'Homem', child: Text('Homem')),
                        DropdownMenuItem(
                          value: 'Mulher',
                          child: Text('Mulher'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          formsData[index]['sexo'] = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
