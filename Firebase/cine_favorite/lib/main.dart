import 'package:cine_favorite/views/favorite_view.dart';
import 'package:cine_favorite/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  //garante o carregamento dos widgets
  WidgetsFlutterBinding.ensureInitialized();

  //conectar com o FireBase
  await Firebase.initializeApp();
  
  runApp(
    MaterialApp(
      title: "Cine Favorite",
      theme: ThemeData(
        primarySwatch: Colors.orange,
        brightness: Brightness.dark,
      ),
      home: AuthStream(),
    ),
  );
}

class AuthStream extends StatelessWidget {
  const AuthStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      //?permite usuário NULL
      stream: FirebaseAuth.instance
          .authStateChanges(), //identifica a mudança de status da auth
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //se tiver dados, ou seja, se o usuário estiver logado
          return Favoriteview();
        } else {
          //se não tiver dados, ou seja, se o usuário não estiver logado
          return LoginView();
        }
      },
    );
  }
}
