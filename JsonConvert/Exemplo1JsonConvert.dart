void main() {
  String json = '''{
                    "usuario": "João",
                    "login": "joao_user", 
                    "senha": "1234"}''';
  Map<String, dynamic> usuario = json.decode(jsonString);

  print(usuario["ativo"]);
}
