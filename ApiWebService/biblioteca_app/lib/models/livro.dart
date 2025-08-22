class Livro {
  //atributos
  final String? id; //pode ser nulo inicialmente -> id será atribuido pelo BD
  final String titulo;
  final String autor;
  final bool disponivel;

  //constructor
  Livro({this.id, required this.titulo, required this.autor, required this.disponivel});

  //metodos
  //toJson 
  Map<String, dynamic> toJson() => {
    'id': id,
    'titulo': titulo,
    'autor': autor,
    'disponivel': disponivel,
  };

  //fromMap factory
  factory Livro.fromMap(Map<String, dynamic>json ) => Livro(
      id: json["id"].toString(),
      titulo: json["titulo"].toString(),
      autor: json["autor"].toString(),  
      disponivel: json["disponivel"] as bool
    );
}

