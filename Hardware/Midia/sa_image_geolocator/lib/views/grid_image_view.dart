//view para inserir o ponto no map
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sa_image_geolocalizador/models/grid_item_model.dart';
import 'package:sa_image_geolocalizador/services/api_service.dart';

/// Widget principal que exibe a tela de captura de imagens e localização
class GridImageView extends StatefulWidget {
  const GridImageView({super.key});

  @override
  State<GridImageView> createState() => _GridImageViewState();
}

/// Estado do widget GridImageView
class _GridImageViewState extends State<GridImageView> {
  // Mensagem exibida na tela (ex: localização)
  String mensagem = "";

  // Armazena a última imagem selecionada/tirada
  File? _image;

  // Controlador do ImagePicker para acessar câmera e galeria
  final _picker = ImagePicker();

  // Lista de imagens selecionadas/tiradas para exibir no GridView
  final List<GridImageItem> _gridImages = [];
  
  /// Método para capturar imagem usando a câmera do dispositivo
  void _getImageFromCamera() async {
    // Abre a câmera e permite tirar uma foto
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    // Verifica se a imagem foi capturada
    if (pickedFile != null) {
      // Obtém localização atual
      Position position = await Geolocator.getCurrentPosition();
      final cidade = await ApiService.getCityByPosition(position);
      String location = "${cidade["name"]}";
      String dateTime = DateTime.now().toString();

      setState(() {
        // Salva a imagem no aplicativo e adiciona à lista
        _image = File(pickedFile.path);
        _gridImages.add(
          GridImageItem(image: _image!, dateTime: dateTime, location: location),
        );
      });
    }
  }

  /// Método para selecionar imagem da galeria do dispositivo
  void _getImageFromGallery() async {
    // Abre a galeria para selecionar uma imagem
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    // Verifica se a imagem foi selecionada
    if (pickedFile != null) {
      // Obtém localização atual
      Position position = await Geolocator.getCurrentPosition();
      final cidade = await ApiService.getCityByPosition(position);
      String location = "${cidade["name"]}";
      String dateTime = DateTime.now().toString();

      setState(() {
        // Salva a imagem no aplicativo e adiciona à lista
        _image = File(pickedFile.path);
        _gridImages.add(
          GridImageItem(image: _image!, dateTime: dateTime, location: location),
        );
      });
    }
  }

  /// Método para obter a localização atual do dispositivo
  Future<String?> _getLocation() async {
    bool serviceEnable;
    LocationPermission permission;

    // Verifica se o serviço de localização está ativo
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return "Serviço de Localização está Desativado";
    }
    // Verifica e solicita permissão de localização
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return "Permissão de Localização Negada";
      }
    }
    // Obtém a posição atual
    Position position = await Geolocator.getCurrentPosition();

    try {
      // Busca a cidade e temperatura usando o serviço de API
      final cidade = await ApiService.getCityByPosition(position);
      return "${cidade["name"]} -- ${cidade["main"]["temp"] - 273}° ";
    } catch (e) {
      // Exibe erro caso ocorra
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
    }
    return null;
  }

  /// Método chamado ao inicializar o estado do widget
  @override
  void initState() {
    super.initState();
    // Chama o método de localização antes de construir a tela
    String result = _getLocation().toString();
    setState(() {
      mensagem = result;
    });
  }

  /// Método que constrói a interface do widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Captura de Imagens")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Exibe a mensagem de localização
            Text(mensagem),
            // Exibe as imagens em um GridView se houver imagens
            _gridImages.isNotEmpty
                ? SizedBox(
                    height: 200,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Número de colunas
                        crossAxisSpacing: 4, // Espaçamento horizontal
                        mainAxisSpacing: 4, // Espaçamento vertical
                      ),
                      itemCount: _gridImages.length, // Quantidade de imagens
                      itemBuilder: (context, index) {
                        final item = _gridImages[index];
                        // Exibe cada imagem da lista
                        return Column(
                          children: [
                            Expanded(child: Image.file(item.image)),
                            Text(item.dateTime, style: TextStyle(fontSize: 10)),
                            Text(item.location, style: TextStyle(fontSize: 10)),
                          ],
                        );
                      },
                    ),
                  )
                : const Text("Nenhuma imagem selecionada"),
            // Botão para obter localização
            ElevatedButton(
              onPressed: () async {
                String? result = await _getLocation();
                setState(() {
                  mensagem = result!;
                });
              },
              child: Text("Obter Localização"),
            ),
            // Linha de botões para tirar foto ou selecionar da galeria
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _getImageFromCamera,
                  child: const Text("Tirar Foto"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _getImageFromGallery,
                  child: const Text("Selecionar da Galeria"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
