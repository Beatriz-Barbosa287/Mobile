import 'package:cine_favorite/views/registro_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //atributos
  final FirebaseAuth _auth = FirebaseAuth.instance; //controlador das ações de autenticação do usuário
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();


  //método para fazer o login
  void _signIn() async{
    try {
      await _auth.signInWithEmailAndPassword( //chama o método de autenticação do controller por email e senha
        email: _emailField.text.trim(), 
        password: _senhaField.text);
      //Verifica se  conseguiu autenticação no fireBase (muda oa status do usuário)
      // direciona automaticamente para a tela de tarefas (AuthView)

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao Fazer Login: $e"))
      );
    }
  }

  
  //build da Tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"), titleTextStyle: TextStyle(decorationColor: Color.fromARGB(255, 172, 84, 255), fontSize: 25), centerTitle: true,),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailField,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress, //muda o tipo do teclado para com @ e .com
            ),
            TextField( 
              controller: _senhaField,
              decoration: InputDecoration(
                labelText: "Senha",
                )
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _signIn, 
              child: Text("Login")),
            TextButton( //como se fosse um link para enviar a outra tela 
              onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context)=> RegistroView()) ),
              child: Text("Não tem uma conta? Registre-se Aqui"))
          ],

        ),
        ),
    );
  }
}
    