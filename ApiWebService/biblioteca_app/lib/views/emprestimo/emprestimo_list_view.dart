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
  List<Emprestimo> _emprestimos = [];
  List<Emprestimo> _filtroEmprestimos = [];
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
      _emprestimos = await _controller.fetchAll();
      _filtroEmprestimos = _emprestimos;
    } catch (e) {
      // tratar erro
    }
    setState(() => _loading = false);
  }

  void _filtrar() {
    final busca = _buscaField.text.toLowerCase();
    setState(() {
      _filtroEmprestimos = _emprestimos.where((e) {
        return e.usuarioId.toLowerCase().contains(busca) ||
               e.livroId.toLowerCase().contains(busca);
      }).toList();
    });
  }

  void _openForm({Emprestimo? emprestimos}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmprestimoFormView(emprestimo: emprestimos),
      ),
    );
    _load();
  }

  void _delete(Emprestimo emprestimos) async {
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
        await _controller.delete(emprestimos.id);
        _load();
        // mensagem de sucesso
      } catch (e) {
        // tratar erro
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
                      itemCount: _filtroEmprestimos.length,
                      itemBuilder: (context, index) {
                        final emprestimos = _filtroEmprestimos[index];
                        return Card(
                          child: ListTile(
                            title: Text("Usuário ID: ${emprestimos.usuarioId}"),
                            subtitle: Text(
                              "Livro ID: ${emprestimos.livroId}\n"
                              "Data Empréstimo: ${emprestimos.dataEmprestimo}\n"
                              "Data Devolução: ${emprestimos.dataDevolucao}\n"
                              "Devolvido: ${emprestimos.devolvido ? 'Sim' : 'Não'}",
                            ),
                            isThreeLine: true,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => _openForm(emprestimos: emprestimos),
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () => _delete(emprestimos),
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
