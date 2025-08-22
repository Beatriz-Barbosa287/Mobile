import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_web_service_clima/models/clima_model.dart';

class ClimaController {
  final String _apiKey =
      '90290436d34bb91b4d852afe49197129'; // Chave da API do OpenWeatherMap

  //metodo
  Future<Clima?> getClima(String cidade) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$_apiKey&units=metric&lang=pt_br"); // convereter string em URL

    final res = await http.get(url); //requisição HTTP

    //verificar se deu certo-> status code 200
    if (res.statusCode ==200) {
      final dados = json.decode(res.body); //decodificar o corpo da resposta
      return Clima.fromJson(dados); //retornar objeto Clima
    } else {
      return null; //retornar nulo se der erro
    }
  }
}
