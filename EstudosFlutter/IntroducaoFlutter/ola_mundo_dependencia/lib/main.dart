import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() { //Método necessário para rodar a aplicação
  runApp(MyApp());
}

class MyApp extends StatelessWidget { //Classe inicial
  @override
  Widget build(BuildContext context) {
    return MaterialApp( //-Material Base de Desenvolvimento
      home: Scaffold(
        appBar: AppBar(title: Text('Olá Mundo!')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Fluttertoast.showToast(
                msg: "Olá, Mundo!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            },
            child: Text("Mostrar Mensagem"),
          ), //widget->
        ), //widget->
      ),//widget->
    );
  }
}
//WIDGETS= Elementos da Interface Gráfica

