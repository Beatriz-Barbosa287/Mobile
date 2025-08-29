
import 'package:biblioteca_app/models/emprestimo.dart';
import 'package:biblioteca_app/services/api_service.dart';

class EmprestimoController {
  //métodos
  //GET de todos os emprestimos
  Future<List<Emprestimo>> fetchAll() async {
    //Lista no formato de List<dynamic>
    final list = await ApiService.getList(
      "emprestimos?_sort=dataEmprestimo",
    ); //ordenar e organizar pelo titulo
    //retornar lista de usuarios convertidos
    return list.map((item) => Emprestimo.fromMap(item)).toList();
  }

  //GET -EMPRESTIMO
  Future<Emprestimo> fetchOne(String id) async {
    final emprestimo = await ApiService.getOne("emprestimos", id);
    //retornar usuario convertido
    return Emprestimo.fromMap(emprestimo);
  }

  //POST -EMPRESTIMO
  Future<Emprestimo> create(Emprestimo emprestimo) async {
    final created = await ApiService.post("emprestimos", emprestimo.toJson());
    return Emprestimo.fromMap(created);
  }

  //PUT -EMPRESTIMO
  Future<Emprestimo> update(Emprestimo emprestimo) async{
    final updated = await ApiService.put("emprestimos", emprestimo.toJson(), emprestimo.id!);
    return Emprestimo.fromMap(updated);
  }

  //DELETE -EMPRESTIMO
  Future<void> delete(String id) async {
    await ApiService.delete("emprestimos", id);
  }
}


