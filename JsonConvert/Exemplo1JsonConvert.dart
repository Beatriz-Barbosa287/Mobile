
void main() {
  //String no Formato JSON
  String json = '''{
                    "usuario": "João",
                    "login": "joao_user", 
                    "senha": "1234"}''';
  //Convertendo String JSON para Map-> usando json.decode
  Map<String, dynamic> usuario = json.decode(jsonString);
  //acesso ao elementos (atributos) do Json (map)
  print(usuario["ativo"]);

  //Manipular Json usando o Map
  usuario["ativo"] = true;
  //Encode -> função inversa do decode
  var jsonString = json.encode(usuario);
  //mostrar o texto em formato JSON
  print(jsonString);
}
