import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Minha Aplicação'),
          backgroundColor: const Color.fromARGB(255, 150, 0, 50),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('Clicou na lupa');
              },
            ),

            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                print('Clicou no sino');
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [Text("Ínicio"), Text("Conteúdo"), Text("Contato")],
          ),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () { 
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ação Realizada')),
              );
            },
            child: Text('Aperte Aqui'),
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Botão Pressionado");
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          ],
        ),
      ),
    );
  }
}
