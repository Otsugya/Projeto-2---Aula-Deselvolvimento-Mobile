import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BottomNav + TabBar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ModuleTwoPage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.layers),
            label: 'Módulo 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Página Inicial', style: TextStyle(fontSize: 24)),
    );
  }
}

class ModuleTwoPage extends StatelessWidget {
  const ModuleTwoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // número de abas
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Módulo 2"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Aba 1", icon: Icon(Icons.looks_one)),
              Tab(text: "Aba 2", icon: Icon(Icons.looks_two)),
              Tab(text: "Aba 3", icon: Icon(Icons.looks_3)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text("Conteúdo da Aba 1")),
            Center(child: Text("Conteúdo da Aba 2")),
            Center(child: Text("Conteúdo da Aba 3")),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Configurações', style: TextStyle(fontSize: 24)),
    );
  }
}
