import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/views/login_view.dart';
import 'package:todo_list_firebase/views/tarefas_view.dart';
//Tela de atutenticação de Usuário já cadastrado no banco 
class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(//identifica se o usuário está logado ou não
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){//usa os dados do cache para decidir 
        if (snapshot.hasData) {
          return TarefasView();//se tiver dados, retorna a tela de tarefas
        } else {
          //se não tiver dados, retorna a tela de login
          return LoginView();
          
        }
      });
  }
}