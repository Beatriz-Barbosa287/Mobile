import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; //importa o pacote shared_preferences
void main(){
  runApp(MaterialApp(
    home: NomeUsuario(),
  ));
}

//classe da pagina do usuario
 class NomeUsuario extends StatefulWidget {
  @override
  _NomeUsuarioState createState() => _NomeUsuarioState();
}

class _NomeUsuarioState extends State<NomeUsuario> {
  String _nomeSalvo = ''; //variavel para armazenar o nome do usuario
  final TextEditingController _controller = TextEditingController(); //controlador do campo de texto
  @override
  void initState() {
    super.initState();
    _carregarNomeSalvo(); //carrega o nome do usuario ao iniciar o app
  }
  //metodo para carregar o nome do usuario

  void _carregarNomeSalvo() async {
    // usar o SharedPreferences para carregar o nome de usuario
    SharedPreferences prefs = await SharedPreferences.getInstance(); //instancia do SharedPreferences
    setState(() {
      _nomeSalvo = prefs.getString('nome') ?? ''; //carrega o nome do usuario ou vazio se nao existir
    });
     }
  void _salvarNome() async {
    //usar o sharedpreferences para salvar informações 
    SharedPreferences prefs = await SharedPreferences.getInstance(); //instancia do SharedPreferences
    prefs.setString('nome', _controller.text); //salva o nome do usuario
    _carregarNomeSalvo(); //carrega o nome do usuario
    _controller.clear(); //limpa o campo de texto
  
  }
 
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem Vindo ${_nomeSalvo== ""? "Visitante" : _nomeSalvo}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Digite seu nome'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _salvarNome,
              child: Text("Salvar"),
            ), 
          ],
        ),
      ),
    );
  }
}