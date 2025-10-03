import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


void main(){
  runApp(MaterialApp(
    home: LocationScreen(),
  ));
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
  Future<String> _getLocation() async{
    bool serviceEnable;
    LocationPermission permission;

 //Teste se o Serviço está ativo
    serviceEnable = await Geolocator.isLocationServiceEnabled();
  }

  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}