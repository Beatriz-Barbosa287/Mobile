//classe para modelagem de dados da api

class Clima {
  //atributos
  final String nome; //nome da cidade
  final String descricao; //descrição do clima
  final double temperatura; //temperatura atual

  //constructor
  Clima({
    required this.nome,
    required this.descricao,
    required this.temperatura,
  }); //construtor com atributos obrigatórios

  //fromJson - método para converter dados Json em objeto Clima
  //(constructor direcionado para modelagem)
  factory Clima.fromJson(Map<String, dynamic> json) {
    return Clima(
      nome: json["name"],
      descricao: json["weather"][0]["description"],
      temperatura: json["main"]["temp"],
    );
  }
}
