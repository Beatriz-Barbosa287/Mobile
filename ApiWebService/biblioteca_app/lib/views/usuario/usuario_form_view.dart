import 'package:biblioteca_app/controllers/usuario_controller.dart';
import 'package:biblioteca_app/models/usuario.dart';
import 'package:biblioteca_app/views/usuario/usuario_list_view.dart';
import 'package:flutter/material.dart';

class UsuarioFormView extends StatefulWidget {
  //atributo
  final Usuario? user;

  const UsuarioFormView({super.key, this.user});

  @override
  State<UsuarioFormView> createState() => _UsuarioFormViewState();
}

class _UsuarioFormViewState extends State<UsuarioFormView> {
  //atributos
  final _formkey = GlobalKey<FormState>(); // validação do formulário
  final _controller = UsuarioController();
  final _nomeField = TextEditingController(); //controla o campo nome
  final _emailField = TextEditingController(); //controla o campo email

  @override
  void initState() {
    super.initState();
    if(widget.user != null){
      _nomeField.text = widget.user!.nome;
      _emailField.text = widget.user!.email;
    }
  }

  //salvar novo usuario
  void _save() async{
    if(_formkey.currentState!.validate()){
      final user = Usuario(
        id: DateTime.now().millisecond.toString(), //criar um ID 
        nome: _nomeField.text.trim(), 
        email: _emailField.text.trim());
      try {
        await _controller.create(user);
        //mensagem de criação com sucesso
      } catch (e) {
        //tratar erro
      }
      Navigator.pop(context);
      Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (context)=> UsuarioListView()));
    }
  }

  //atualizar usuario existente
  void _update() async{
    if(_formkey.currentState!.validate()){
      final user = Usuario(
        id: widget.user?.id!, //pegar id existente
        nome: _nomeField.text.trim(), 
        email: _emailField.text.trim());
      try {
        await _controller.update(user);
        //mensagem de criação com sucesso
      } catch (e) {
        //tratar erro
      }
      Navigator.pop(context);
      Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (context)=> UsuarioListView()));
    }
  }

  //build Tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? "Novo Usuário" : "Editar Usuário"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeField,
                decoration: InputDecoration(labelText: "Nome"),
                validator: (value) => value!.isEmpty ? "Informe o Nome" : null,
              ),
              TextFormField(
                controller: _emailField,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) => value!.isEmpty ? "Informe o Email" : null,
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: widget.user == null ? _save : _update, 
                child: Text(widget.user == null? "Salvar" : "Atualizar"))
            ],
          )),),
    );
  }
}
