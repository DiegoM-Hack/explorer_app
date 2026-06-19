import 'package:flutter/material.dart';

import '../models/game.dart';

class DetailScreen extends StatelessWidget {

  final Game game;

  const DetailScreen({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(game.nombre),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Image.network(
              game.imagen,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 20),

            Text(
                    game.nombre,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "🎮 Género: ${game.genero}",
                  ),

                  Text(
                    "🖥 Plataforma: ${game.plataforma}",
                  ),

                  Text(
                    "⭐ Rating: ${game.rating}",
                  ),

                  const SizedBox(height: 20),

                  Text(
                    game.nota,
                  ),
          ],
        ),
      ),
    );
  }
}