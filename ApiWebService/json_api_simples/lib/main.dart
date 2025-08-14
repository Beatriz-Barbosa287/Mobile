import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: TarefasPage()));
}

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TarefasPageState();
  }
}

class _TarefasPageState extends State<TarefasPage> {
  //atributos
  //Lista de tarefas<Map>
  List<Map<String, dynamic>> _tarefas = [];
  //controlador para o TextField
  final TextEditingController _tarefaController = TextEditingController();
  // endereço da API
  final String baseUrl = "http://10.109.197.24:3010/tarefas";

  //métodos
  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  void _carregarTarefas() async {
    try {
      //fazer a conexão via HTTP ( biblioteca http - )
      final response = await http.get(
        Uri.parse(baseUrl),
      ); //converter Str -> endereço URL
      if (response.statusCode == 200) {
        List<dynamic> dados = json.decode(
          response.body,
        ); //converti de json -> dart
        setState(() {
          _tarefas = dados
              .map((tarefa) => tarefa as Map<String, dynamic>)
              .toList();
          //_tarefas = dados.cast<Map<String, dynamic>>(); //outra forma de converter-> mais RÁPIDO
          //_tarefas = List<Map<String, dynamic>>.from(dados); //outra forma de converter-> mais DIRETO
        });
      }
    } catch (e) {
      print("Erro ao carregar API: $e");
    }
  }

  void _adicionarTarefa(String titulo) async {
    try {
      //cria um objeto -> tarefa
      final tarefa = {"titulo": titulo, "concluida": false};
      //faz a requisição HTTP para adicionar a tarefa
      //o método POST envia dados para o servidor
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(tarefa), //converte o objeto tarefa para JSON
      );
      if (response.statusCode == 201) {
        //se a tarefa foi criada com sucesso
        setState(() {
        _carregarTarefas(); //atualiza a lista de tarefas
        _tarefaController.clear(); //limpa o campo de texto
        });
      
      }
    } catch (e) {
      print("Erro ao adicionar tarefa: $e");
    }
  }
//remover tarefa 
void _removerTarefa(String id) async {
  try {
    //faz a requisição HTTP para remover a tarefa-> delete (URL + ID)
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      //se a tarefa foi removida com sucesso
      //setState(() {
         _carregarTarefas(); //atualiza a lista de tarefas
      //});
     
    }
  } catch (e) {
    print("Erro ao remover tarefa: $e");
  }
}


//atualizar tarefa 
void _atualizarTarefa(String id, bool concluida) async {
  try {
    //faz a requisição HTTP para remover a tarefa-> patch (URL + ID)
    final tarefaAtualizada = {"concluida": !concluida}; //inverte o estado da tarefa
    final response = await http.patch(Uri.parse('$baseUrl/$id'),
    headers: {"Content-Type": "application/json"},
    body: json.encode(_tarefas), //converte o objeto tarefa para JSON
    );
    if (response.statusCode == 200) {
      //se a tarefa foi atualizada com sucesso
      setState(() {
        _carregarTarefas(); //atualiza a lista de tarefas
      });
     
    }
  } catch (e) {
    print("Erro ao remover tarefa: $e");
  }
}



//build Tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tarefas via API"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tarefaController,
              decoration: InputDecoration(
                labelText: "Nova Tarefa", 
                border: OutlineInputBorder()
              ),
              onSubmitted: _adicionarTarefa,
            ),
            SizedBox(height: 10,),
            Expanded(
              //operador ternário
              child: _tarefas.isEmpty
              ? Center(child: Text("Nenhuma Tarefa Cadastrada"),)
              : ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index){
                  final tarefa = _tarefas[index];
                  return ListTile(
                    //leading para criar um checkbox(atualizar)
                    leading: Checkbox(
                      value: tarefa["concluida"],
                      onChanged: (value) {
                        _atualizarTarefa(tarefa["id"], tarefa["concluida"]);
                      },
                    ),
                    title: Text(tarefa["titulo"]),
                    subtitle: Text(tarefa["concluida"] ? "Concluída" :"Pendente"),
                    trailing: IconButton(
                      onPressed: ()=> _removerTarefa(tarefa["id"]), 
                      icon: Icon(Icons.delete)),
                  );
                })
              )
          ],
        ),
      ),
    );
  }

}