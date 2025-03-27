import 'package:flutter/material.dart';

import 'views/tela_boas_vindas_view.dart';
import 'views/tela_cadastro_view.dart';
import 'views/tela_confirmacao_view.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/": (context)=> TelaBoasVindas(),
      "/cadastro":(context)=>TelaCadastro(),
      "/confirmacao":(context)=>TelaConfirmacao()
    },
  ));
}
