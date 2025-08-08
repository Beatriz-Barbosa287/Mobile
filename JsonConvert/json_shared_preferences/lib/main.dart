import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
void main() {
  runApp(MyApp());
}

//com a page de stateful widget sempre terá 2 clases: 1 para o widget (build) e outra para o estado do widget
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool temaEscuro = false;
  String nomeUsuario = "";

  @override
  void initState() {
    super.initState();
    carregarPreferencias();
  }
}

//função para carregar as preferências do usuário
void carregarPreferencias() async {
  //do tipo assíncrona
  final prefs =
      await SharedPreferences.getInstance(); //conecta com as shared preferences e busca por informações armazenadas
     //recupera as informaçoes do sharedPref e armazena como String (Json)
  String? jsonString = prefs.getString('config');
  if (jsonString != null) {
    //Trasnforma a String Json em um Map -> Uitlizando decode
    Map<String, dynamic> config = json.decode(jsonString);
    setState(() {
      //"pega" as informações de acordo com a chave armazenada
      //e atribui os valores às variáveis do estado
      temaEscuro = config['temaEscuro'] ?? false; //??-> se caso vazio ou nulo, assume o valor padrão
      nomeUsuario = config['nomeUsuario'] ?? ""; //se não tiver nome de usuário, assume vazio
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App de Configurações",
      //operador Ternário
      theme: temaEscuro ? ThemeData.dark() : ThemeData.light(),
      home: ConfigPage()
    );
  }
}
