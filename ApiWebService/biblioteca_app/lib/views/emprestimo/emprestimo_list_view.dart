import 'package:flutter/material.dart';
import 'package:biblioteca_app/controllers/emprestimo_controller.dart';
import 'package:biblioteca_app/models/emprestimo.dart';
import 'package:biblioteca_app/views/emprestimo/emprestimo_form_view.dart';

class EmprestimoListView extends StatefulWidget {
  const EmprestimoListView({super.key});

  @override
  State<EmprestimoListView> createState() => _EmprestimoListViewState();
}

class _EmprestimoListViewState extends State<EmprestimoListView> {
  final _controller = EmprestimoController();
  List<Emprestimo> _emprestimo = [];
  List<Emprestimo> _filtroEmprestimo = [];
  final _buscaField = TextEditingController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    setState(() => _loading = true);
    try {
      _emprestimo = await _controller.fetchAll();
      _filtroEmprestimo = _emprestimo;
    } catch (e) {
      // tratar erro
    }
    setState(() => _loading = false);
  }

  void _filtrar() {
    final busca = _buscaField.text.toLowerCase();
    setState(() {
      _filtroEmprestimo = _emprestimo.where((e) {
        return e.usuarioId.toLowerCase().contains(busca) ||
               e.livroId.toLowerCase().contains(busca);
      }).toList();
    });
  }

  void _openForm({Emprestimo? emprestimo}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmprestimoFormView(emprestimo: emprestimo),
      ),
    );
    _load();
  }

  void _delete(Emprestimo emprestimo) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirma Exclusão"),
        content: Text("Deseja excluir este empréstimo?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("Cancelar")),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Excluir")),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _controller.delete(emprestimo.id!);
        _load();
        // mensagem de confirmação
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Empréstimo excluído com sucesso!")),
        );

      } catch (e) {
        // tratar erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao excluir empréstimo.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Empréstimos")),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _buscaField,
                    decoration: InputDecoration(labelText: "Pesquisar por ID de Usuário ou Livro"),
                    onChanged: (value) => _filtrar(),
                  ),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filtroEmprestimo.length,
                      itemBuilder: (context, index) {
                        final emprestimo = _filtroEmprestimo[index];
                        return Card(
                          child: ListTile(
                            title: Text("Usuário ID: ${emprestimo.usuarioId}"),
                            subtitle: Text(
                              "Livro ID: ${emprestimo.livroId}\n"
                              "Data Empréstimo: ${emprestimo.dataEmprestimo}\n"
                              "Data Devolução: ${emprestimo.dataDevolucao}\n"
                              "Devolvido: ${emprestimo.devolvido ? 'Sim' : 'Não'}",
                            ),
                            isThreeLine: true,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => _openForm(emprestimo: emprestimo),
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () => _delete(emprestimo),
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
