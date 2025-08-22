//class de views (tela)
//stateful

import 'package:flutter/material.dart';
import 'package:json_web_service_clima/controllers/clima_controller.dart';
import 'package:json_web_service_clima/models/clima_model.dart';

class ClimaView extends StatefulWidget {
  const ClimaView({super.key});

  @override
  State<ClimaView> createState() => _ClimaViewState();
}

class _ClimaViewState extends State<ClimaView> {
  final TextEditingController _cidadeController = TextEditingController();
  final ClimaController _climaController = ClimaController();
  Clima? _clima; // recebe informações do clima da cidade
  String? _erro; // retorna erro caso cidade nao encontrada

  // método para busca as informações na api
  void buscar() async {
    final cidade = _cidadeController.text.trim();
    final resultado = await _climaController.getClima(cidade);
    setState(() {
      if (resultado != null) {
        _clima = resultado; // atribui o resultado ao clima
        _erro = null; // limpa o erro
        _cidadeController.clear(); // limpa o campo de texto
      } else {
        _clima = null; // limpa o clima
        _erro = "Cidade não encontrada"; // atribui mensagem de erro
      }
    });
  }


  // build da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima App'),
      ),
      body: Padding (padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _cidadeController,
            decoration: InputDecoration(labelText: "Digite uma cidade"),
          ),
          ElevatedButton(onPressed: buscar, child: Text("Buscar Clima")),
          Divider(),
          //condicional 
          if(_clima !=null) ...[
            Text("Cidade: ${_clima!.nome}"),
            Text("Descrição: ${_clima!.descricao}"),  
            Text("Temperatura: ${_clima!.temperatura}°C"),
                      ] else if(_erro != null) ...[
              Text(_erro!)
            ] else ...[
              Text("Procure uma Cidade")
            ]
        ],
      ),
      ),
    );
  }
}
