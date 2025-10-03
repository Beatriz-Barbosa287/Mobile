import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MaterialApp(home: LocationScreen()));
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  //atributos
  String mensagem = "";

  //método para Pegar a Localização
  Future<String> _getLocation() async {
    bool serviceEnable;
    LocationPermission permission;

    //Teste se o Serviço está ativo
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error("Serviço de Localização desativado");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Permissão negada");
      }
    }

    //se localização liberada 
    Position position = await Geolocator.getCurrentPosition();
    return "Lat: ${position.latitude} - Long: ${position.longitude}";
  }
  @override 
  void initState() {
    //todo: implement initState
    super.initState();
    //chama o metodo ates de "buildar" a tela 
    setState(() {
      mensagem = _getLocation().toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GPS -> LOCALIZAÇÃO"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mensagem),
            ElevatedButton(onPressed: ()async{
              setState(() {
                mensagem = _getLocation().toString();
              });
            }, child: Text("Pegar a Localização"))          
          ],
        ),
      ),
    );
  }
}
