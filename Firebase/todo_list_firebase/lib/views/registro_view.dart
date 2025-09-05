import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/views/login_view.dart';

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  //atributos
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _confirmarSenhaField = TextEditingController();

  void _registrar() async {
    if (_senhaField.text != _confirmarSenhaField.text) return;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailField.text.trim(),
        password: _senhaField.text,
      );
      //após o registro, o usuário já estará logado
      //AuthView -> Joga ele para tela de Tarefas
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao Registrar $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro"),),
      body: Padding(padding: EdgeInsetsGeometry.all(16),
      child: Column(
        children: [
          TextField(controller: _emailField, 
          decoration: InputDecoration(labelText: "Email"),
          keyboardType: TextInputType.emailAddress,
          ),
          TextField(controller: _senhaField,
          decoration: InputDecoration(labelText: "Senha"),
          obscureText: true,//oculta a senha quando digitada
          ),
          TextField(controller: _confirmarSenhaField,
          decoration: InputDecoration(labelText: "Senha"),
          obscureText: true,//oculta a senha quando digitada
          ),
          SizedBox(height: 20,),
            _senhaField.text != _confirmarSenhaField.text 
            ? Text("As senhas devem ser Iguais", 
              style: TextStyle(color: Colors.red, ), )
            : ElevatedButton(onPressed: _registrar, child: Text("Registrar")),
            TextButton(onPressed: () => Navigator.pop, child: Text("Voltar"))
          ],
        ),),
    );
  }
}