import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/views/registro_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  //atributosss

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  bool _ocultarSenha = true;

  // ignore: unused_element
  void _signIn() async { // do tipo assíncrona porque faz uma requisição para o firebase
    try { //por ser assíncrona usamos o try catch para tratar erros
      await _auth.signInWithEmailAndPassword( //faz o login com email e senha
        email: _emailField.text,
        password: _senhaField.text,
        //verifica se conseguiu fazer o login, ou seja, autenticar o usuário no Firebase 
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar
      (SnackBar(content: Text("Falha ao Fazer Login $e")));
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Padding(padding: EdgeInsetsGeometry.all(16),
      child: Column(
        children: [
          TextField(controller: _emailField, 
          decoration: InputDecoration(labelText: "Email"),
          keyboardType: TextInputType.emailAddress,
          ),
        //colocar olho para visualização da senha
          TextField(controller: _senhaField,
             decoration: InputDecoration(
                labelText: "Senha",
                suffix: IconButton(
                  onPressed: ()=>setState(() {
                    _ocultarSenha = !_ocultarSenha;
                  }), 
                  icon: Icon(_ocultarSenha ? Icons.visibility : Icons.visibility_off))),
                obscureText: _ocultarSenha, // oculta a senha quando digitada
            ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: _signIn, child: Text("Login")),
          TextButton(onPressed: () => Navigator.push(context, 
          MaterialPageRoute(builder: (context)=> RegistroView())), 
          child: Text("Não possui conta? Cadastre-se aqui"))
        ],
      ),),
    );
  }
}