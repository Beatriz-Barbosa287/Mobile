//clase de controller de usuario
import 'package:biblioteca_app/models/usuario.dart';
import 'package:biblioteca_app/services/api_service.dart';

class UsuarioController {
  
 //métodos
 //GET DO USUARIO

 Future<List> fectchAll() async {
  //Lista no formato de List<dynamic>
   final list = await ApiService.getList("usuarios?_sort=nome");//ordenar e organizar pelo nome 
  //retornar lista de usuarios convertidos 
  return list.map((item) => Usuario.fromJson(item)).toList(); 
 }
 //Get de um unico usuario
  Future<Usuario> fetchOne(String id) async {
    final usuario = await ApiService.getOne("usuarios", id);
    //retornar usuario convertido
    return Usuario.fromJson(usuario);
  }

  //POST - criar usuario
  //PUT - atualizar usuario
  //DELETE - deletar usuario
  
}