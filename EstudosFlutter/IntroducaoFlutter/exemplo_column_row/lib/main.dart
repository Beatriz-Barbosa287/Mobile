import "package:flutter/material.dart";

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Exemplo de Colunas e Linhas")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // vertical
          crossAxisAlignment: CrossAxisAlignment.center, //horizontal
          children: [
            Text('Linha 1'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Coluna   1"),
              Text("Coluna   2"),
    
            ],
          ),
          Text("Linha3"),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    color:Colors.pink,
                  )

                ],
              ),
          ],
      ),
      ),
    );
  }
}
