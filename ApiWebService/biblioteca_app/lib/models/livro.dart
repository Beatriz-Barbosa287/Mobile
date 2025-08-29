class Livro {
  //atributos
  final String? id; //pode ser nulo inicialmente -> id será atribuido pelo BD
  final String titulo;
  final String autor;
  final bool disponivel;

  //constructor
  Livro({this.id, required this.titulo, required this.autor, required this.disponivel});

  //metodos
  //toMap
  Map<String, dynamic> toMap() => {
    'id': id,
    'titulo': titulo,
    'autor': autor,
    'disponivel': disponivel,
  };

  //fromMap factory -- jeito diferente de criar um construtor
  factory Livro.fromMap(Map<String, dynamic>map ) => Livro(
      id: map["id"].toString(),
      titulo: map["titulo"].toString(),
      autor: map["autor"].toString(),  
      disponivel: map["disponivel"] == 1 ? true : false //conversão de int para bool
    );

 
}

