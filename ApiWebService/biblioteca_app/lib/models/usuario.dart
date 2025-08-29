class Usuario {
  //atributos
  final String? id; //pode ser nulo inicialmente -> id será atribuido pelo BD
  final String nome;
  final String email;

  //constructor
  Usuario({this.id, required this.nome, required this.email});

  //metodos
  //toJson 
  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'email': email,
  };

  //fromMap factory
  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
      id: json["id"].toString(),
      nome: json["nome"].toString(),
      email: json["email"].toString()
    );

 
}
