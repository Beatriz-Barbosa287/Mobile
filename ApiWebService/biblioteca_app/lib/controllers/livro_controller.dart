import 'package:biblioteca_app/models/livro.dart';
import 'package:biblioteca_app/services/api_service.dart';

class LivroController {
  //métodos
  //get de todos os livros
  Future<List> fectchAll() async {
    //Lista no formato de List<dynamic>
    final list = await ApiService.getList(
      "livro?_sort=titulo",
    ); //ordenar e organizar pelo titulo
    //retornar lista de usuarios convertidos
    return list.map((item) => Livro.fromMap(item)).toList();
  }

  //GET -LIVRO
  Future<Livro> fetchOne(String id) async {
    final livro = await ApiService.getOne("livro", id);
    //retornar usuario convertido
    return Livro.fromMap(livro);
  }

  //POST -LIVRO
  Future<Livro> create(Livro livro) async {
    final created = await ApiService.post("livro", livro.toMap());
    return Livro.fromMap(created);
  }

  //PUT -LIVRO
  Future<Livro> update(Livro livro) async {
    final updated = await ApiService.put("livro", livro.toMap(), livro.id!);
    return Livro.fromMap(updated);
  }

  //DELETE -LIVRO
  Future<void> delete(String id) async {
    await ApiService.delete("livro", id);
  }
}
