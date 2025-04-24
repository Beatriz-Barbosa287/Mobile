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
          title: Text('Perfil do Usuário'),
          backgroundColor: Color.fromARGB(223, 184, 0, 0),
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundColor: Color.fromARGB(255, 70, 13, 13),
                child: Icon(
                  Icons.person,
                  size: 100,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),

              SizedBox(height: 90),
              Text(
                'Beatriz Barbosa',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text(
                'Estudante SESI/SENAI 3T-DEVIN',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 46, 46, 46),
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Limeira- São Paulo, Brasil',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 46, 46, 46),
                ),
              ),
              SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.center, // vertical
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                      color: Color.fromARGB(223, 184, 0, 0),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                      color: Color.fromARGB(223, 184, 0, 0),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                      color: Color.fromARGB(223, 184, 0, 0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 180),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.email, size: 60, color: Colors.red),

                  const Icon(
                    Icons.facebook,
                    size: 60,
                    color: Color.fromARGB(255, 15, 66, 206),
                  ),
                   const Icon(Icons.phone, size: 60, color: Colors.lightGreen),
                  TextButton(
                    onPressed: () {
                    
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(
                        255,
                        128,
                        0,
                        32,
                      ), 
                    ),
                    child: Text(
                      "Entrar em Contato",
                      style: TextStyle(
                        color: Colors.white, 
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
