import 'package:flutter/material.dart';
import 'package:biblioteca_app/controllers/emprestimo_controller.dart';
import 'package:biblioteca_app/models/emprestimo.dart';
import 'package:biblioteca_app/views/emprestimo/emprestimo_list_view.dart';

class EmprestimoFormView extends StatefulWidget {
  final Emprestimo? emprestimo;

  const EmprestimoFormView({super.key, this.emprestimo});

  @override
  State<EmprestimoFormView> createState() => _EmprestimoFormViewState();
}

class _EmprestimoFormViewState extends State<EmprestimoFormView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = EmprestimoController();

  final _usuarioIdField = TextEditingController();
  final _livroIdField = TextEditingController();
  final _dataEmprestimoField = TextEditingController();
  final _dataDevolucaoField = TextEditingController();
  bool _devolvido = false;

  @override
  void initState() {
    super.initState();
    if (widget.emprestimo != null) {
      _usuarioIdField.text = widget.emprestimo!.usuarioId;
      _livroIdField.text = widget.emprestimo!.livroId;
      _dataEmprestimoField.text = widget.emprestimo!.dataEmprestimo;
      _dataDevolucaoField.text = widget.emprestimo!.dataDevolucao;
      _devolvido = widget.emprestimo!.devolvido;
    }
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final emprestimo = Emprestimo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        usuarioId: _usuarioIdField.text.trim(),
        livroId: _livroIdField.text.trim(),
        dataEmprestimo: _dataEmprestimoField.text.trim(),
        dataDevolucao: _dataDevolucaoField.text.trim(),
        devolvido: _devolvido,
      );
      try {
        await _controller.create(emprestimo);
      } catch (e) {
        // tratar erro
      }
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EmprestimoListView()),
      );
    }
  }

  void _update() async {
    if (_formKey.currentState!.validate()) {
      final emprestimo = Emprestimo(
        id: widget.emprestimo!.id,
        usuarioId: _usuarioIdField.text.trim(),
        livroId: _livroIdField.text.trim(),
        dataEmprestimo: _dataEmprestimoField.text.trim(),
        dataDevolucao: _dataDevolucaoField.text.trim(),
        devolvido: _devolvido,
      );
      try {
        await _controller.update(emprestimo);
      } catch (e) {
        // tratar erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao atualizar empréstimo.")),
        );
      }
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EmprestimoListView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.emprestimo == null
            ? 'Novo Empréstimo'
            : 'Editar Empréstimo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _usuarioIdField,
                decoration: InputDecoration(labelText: "ID do Usuário"),
                validator: (value) =>
                    value!.isEmpty ? "Informe o ID do usuário" : null,
              ),
              TextFormField(
                controller: _livroIdField,
                decoration: InputDecoration(labelText: "ID do Livro"),
                validator: (value) =>
                    value!.isEmpty ? "Informe o ID do livro" : null,
              ),
              TextFormField(
                controller: _dataEmprestimoField,
                decoration: InputDecoration(labelText: "Data de Empréstimo"),
                validator: (value) =>
                    value!.isEmpty ? "Informe a data de empréstimo" : null,
              ),
              TextFormField(
                controller: _dataDevolucaoField,
                decoration: InputDecoration(labelText: "Data de Devolução"),
                validator: (value) =>
                    value!.isEmpty ? "Informe a data de devolução" : null,
              ),
              SwitchListTile(
                title: Text("Devolvido"),
                value: _devolvido,
                onChanged: (value) {
                  setState(() {
                    _devolvido = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: widget.emprestimo == null ? _save : _update,
                child: Text(widget.emprestimo == null ? "Salvar" : "Atualizar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}