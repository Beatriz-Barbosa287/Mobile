class Emprestimo{
  //atributos
  final String? id; //pode ser nulo inicialmente -> id será atribuido pelo BD
  final String usuarioId;
  final String livroId;
  final String dataEmprestimo;
  final String dataDevolucao;
  final bool devolvido;
 
  //constructor

  Emprestimo({
    this.id,
    required this.usuarioId, 
    required this.livroId, 
    required this.dataEmprestimo, 
    required this.dataDevolucao, 
    required this.devolvido
    });

  //metodos
  //toJson 
  Map<String, dynamic> toJson() => {
    'id': id,
    'usuario_id': usuarioId,
    'livro_id': livroId,
    'data_emprestimo': dataEmprestimo,
    'data_devolucao': dataDevolucao,
    'devolvido': devolvido,
  };

  //fromMap factory
  factory Emprestimo.fromMap(Map<String, dynamic> json) => Emprestimo(
      id: json["id"].toString(),
      usuarioId: json["usuarioId"].toString(),
      livroId: json["livroId"].toString(),  
      dataEmprestimo: json["dataEmprestimo"].toString(),
      dataDevolucao: json["dataDevolucao"].toString(),
      devolvido: json["devolvido"] as bool
    );
}

