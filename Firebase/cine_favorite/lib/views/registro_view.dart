import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView  > {
  //atributos
  final FirebaseAuth _auth = FirebaseAuth.instance; //controlador das ações de autenticação do usuário
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _confirmarSenhaField = TextEditingController();

  //método para registrar novo usuário
  void _cadastrar() async{
    if(_senhaField.text != _confirmarSenhaField.text) return;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailField.text.trim(), 
        password: _senhaField.text);
      // após o registro , usuário já é logado no sistema 
      // AuthView -> tela de favoritos
      Navigator.pop(context); //Fecha a Tela de Registro
    } on FirebaseAuthException catch (e) { //erro especificos do FirebaseAuth
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao Registrar: $e"))
      );
    }
  }

  //build 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro"), titleTextStyle: TextStyle(decorationColor: Color.fromARGB(255, 172, 84, 255), fontSize: 25), centerTitle: true,),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailField,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField( //adicionar o olho de ver senha
              controller: _senhaField,
              decoration: InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            TextField(
              controller: _confirmarSenhaField,
              decoration: InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            SizedBox(height: 20,),
            _senhaField.text != _confirmarSenhaField.text 
            ? Text("As senhas devem ser Iguais", 
              style: TextStyle(color: const Color.fromARGB(255, 54, 0, 179), ), )
            : ElevatedButton(onPressed: _cadastrar, child: Text("Cadastrar")),
            TextButton(onPressed: () => Navigator.pop, child: Text("Voltar"))
          ],
        ),),
    );
  }
}
    