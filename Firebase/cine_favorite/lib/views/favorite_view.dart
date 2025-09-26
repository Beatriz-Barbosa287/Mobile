import 'dart:io';

import 'package:cine_favorite/controllers/movie_firestore_controller.dart';
import 'package:cine_favorite/models/movie.dart';
import 'package:cine_favorite/views/search_movie_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final _movieFireStoreController = MovieFirestoreController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filmes Favoritos"),
        actions: [
          IconButton(
            onPressed: FirebaseAuth.instance.signOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: StreamBuilder<List<Movie>>(
        stream: _movieFireStoreController.getFavoriteMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Erro ao Carregar a Lista de Favoritos"),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Nenhum Filme Adicionado Aos Favoritos"),
            );
          }

          final favoriteMovies = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 45,
              childAspectRatio: 0.45,
            ),
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              final movie = favoriteMovies[index];

              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onLongPress: () => _confirmDelete(context, movie),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.vertical(top: Radius.circular(8)),
                              child: Image.file(
                                File(movie.posterPath),
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _confirmDelete(context, movie),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            _buildStarRating(movie),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchMovieView()),
        ),
        child: const Icon(Icons.search),
      ),
    );
  }

  Widget _buildStarRating(Movie movie) {
    return Row(
      children: List.generate(5, (index) {
        final starFilled = index < movie.rating.round();

        return GestureDetector(
          onTap: () async {
            final newRating = index + 1.0;

            await _movieFireStoreController.updateRating(movie.id, newRating);

            setState(() {
              movie.rating = newRating;
            });
          },
          child: Icon(
            starFilled ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 20,
          ),
        );
      }),
    );
  }

  void _confirmDelete(BuildContext context, Movie movie) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Remover Filme"),
        content: Text("Deseja remover '${movie.title}' dos favoritos?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Remover"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      _movieFireStoreController.removeFavoriteMovie(movie.id);
    }
  }
}
