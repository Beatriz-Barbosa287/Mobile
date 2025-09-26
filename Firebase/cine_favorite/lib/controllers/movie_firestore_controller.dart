import 'dart:io';
import 'package:cine_favorite/models/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MovieFirestoreController {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Stream<List<Movie>> getFavoriteMovies() {
    if (currentUser == null) return Stream.value([]);

    return _db
        .collection("usuarios")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Movie.fromMap(doc.data())).toList());
  }

  Future<void> addFavoriteMovie(Map<String, dynamic> movieData) async {
    if (movieData["poster_path"] == null) return;

    final imageUrl =
        "https://image.tmdb.org/t/p/w500${movieData["poster_path"]}";
    final responseImg = await http.get(Uri.parse(imageUrl));

    final imgDir = await getApplicationDocumentsDirectory();
    final file = File("${imgDir.path}/${movieData["id"]}.jpg");
    await file.writeAsBytes(responseImg.bodyBytes);

    final movie = Movie(
      id: movieData["id"],
      title: movieData["title"],
      posterPath: file.path.toString(),
      rating: 0.0, 
    );

    await _db
        .collection("usuarios")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .doc(movie.id.toString())
        .set(movie.toMap());
  }

  Future<void> removeFavoriteMovie(int movieId) async {
    await _db
        .collection("usuarios")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .doc(movieId.toString())
        .delete();

    final imagemPath = await getApplicationDocumentsDirectory();
    final imagemFile = File("${imagemPath.path}/$movieId.jpg");

    try {
      if (await imagemFile.exists()) {
        await imagemFile.delete();
      }
    } catch (e) {
      print("Erro ao deletar imagem: $e");
    }
  }

  Future<void> updateMovieRating(int movieId, double rating) async {
    await _db
        .collection("usuarios")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .doc(movieId.toString())
        .update({"rating": rating});
  }

  Future<void> updateRating(int movieId, double newRating) async {
    await updateMovieRating(movieId, newRating);
  }
}
