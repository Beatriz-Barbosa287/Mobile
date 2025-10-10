// Classe para armazenar imagem, data e local
import 'dart:io';

class GridImageItem {
  final File image;
  final String dateTime;
  final String location;

  GridImageItem({
    required this.image,
    required this.dateTime,
    required this.location,
  });
}