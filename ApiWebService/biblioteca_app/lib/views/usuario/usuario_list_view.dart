import 'package:biblioteca_app/controllers/usuario_controller.dart';
import 'package:biblioteca_app/models/usuario.dart';
import 'package:flutter/material.dart';

class UsuarioListView extends StatefulWidget {
  const UsuarioListView({super.key});

  @override
  State<UsuarioListView> createState() => _UsuarioListViewState();
}

class _UsuarioListViewState extends State<UsuarioListView> {
  //atributos
  final _controller = UsuarioController();
  List<Usuario> _usuarios = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    setState(() => _loading = true);
    try {
      _usuarios = await _controller.fetchAll();
    } catch (e) {
      //tratar erro
      
    }
    setState(() => _loading = false);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Padding(padding: EdgeInsets.all(16),
          child: Expanded(child: 
          ListView.builder(
            itemCount: _usuarios.length,
            itemBuilder: (context, index) {
              final user = _usuarios[index];
              return Card(
                child: ListTile(
                  title: Text(user.nome),
                  subtitle: Text(user.email),
                //trailing
              ),
            );
          })),
        )
    );
  }
}