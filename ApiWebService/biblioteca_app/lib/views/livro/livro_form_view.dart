import 'package:flutter/material.dart';
import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro.dart';
import 'package:biblioteca_app/views/livro/livro_list_view.dart';

class LivroFormView extends StatefulWidget {
  final Livro? livro;

  const LivroFormView({super.key, this.livro});

  @override
  State<LivroFormView> createState() => _LivroFormViewState();
}

class _LivroFormViewState extends State<LivroFormView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = LivroController();

  final _tituloField = TextEditingController();
  final _autorField = TextEditingController();
  bool _disponivel = true;

  @override
  void initState() {
    super.initState();
    if (widget.livro != null) {
      _tituloField.text = widget.livro!.titulo;
      _autorField.text = widget.livro!.autor;
      _disponivel = widget.livro!.disponivel;
    }
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final livro = Livro(
        id: null, // Deixe nulo para novo cadastro
        titulo: _tituloField.text.trim(),
        autor: _autorField.text.trim(),
        disponivel: _disponivel,
      );
      try {
        await _controller.create(livro);
        Navigator.pop(
          context,
        ); // Apenas pop, pois ao voltar a lista já recarrega
      } catch (e) {
        // tratar erro
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erro ao cadastrar livro.")));
      }
    }
  }

  void _update() async {
    if (_formKey.currentState!.validate()) {
      final livro = Livro(
        id: widget.livro!.id,
        titulo: _tituloField.text.trim(),
        autor: _autorField.text.trim(),
        disponivel: _disponivel,
      );
      try {
        await _controller.update(livro);
      } catch (e) {
        // tratar erro
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erro ao atualizar livro.")));
      }
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LivroListView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.livro == null ? 'Novo Livro' : 'Editar Livro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloField,
                decoration: InputDecoration(labelText: "Título"),
                validator: (value) =>
                    value!.isEmpty ? "Informe o título" : null,
              ),
              TextFormField(
                controller: _autorField,
                decoration: InputDecoration(labelText: "Autor"),
                validator: (value) => value!.isEmpty ? "Informe o autor" : null,
              ),
              SwitchListTile(
                title: Text("Disponível"),
                value: _disponivel,
                onChanged: (value) {
                  setState(() {
                    _disponivel = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: widget.livro == null ? _save : _update,
                child: Text(widget.livro == null ? "Salvar" : "Atualizar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
