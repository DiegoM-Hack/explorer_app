import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game_provider.dart';
import 'detail_screen.dart';
import 'form_screen.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {

  Future<void> _confirmDelete(
  BuildContext context,
  String id,
) async {

  final confirm = await showDialog<bool>(

    context: context,

    builder: (context) {

      return AlertDialog(

        title: const Text(
          "Eliminar juego",
        ),

        content: const Text(
          "¿Seguro que deseas eliminar este juego?",
        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(
                context,
                false,
              );
            },

            child: const Text(
              "Cancelar",
            ),
          ),

          ElevatedButton(

            onPressed: () {

              Navigator.pop(
                context,
                true,
              );
            },

            child: const Text(
              "Eliminar",
            ),
          ),
        ],
      );
    },
  );

  if (confirm == true) {

    await context
        .read<GameProvider>()
        .deleteGame(id);

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(
        content: Text(
          "Juego eliminado",
        ),
      ),
    );
  }
}

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<GameProvider>().loadGames();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      floatingActionButton: FloatingActionButton(

  child: const Icon(Icons.add),

  onPressed: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
            const FormScreen(),
      ),
    ).then((_) {

      context
          .read<GameProvider>()
          .loadGames();
    });
  },
),

      appBar: AppBar(
        title: const Text("Mi Colección"),
      ),

      body: Consumer<GameProvider>(
        builder: (context, provider, child) {

          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.games.isEmpty) {
            return const Center(
              child: Text("No hay videojuegos"),
            );
          }

          return ListView.builder(

            itemCount: provider.games.length,

            itemBuilder: (context, index) {

              final game = provider.games[index];

              return Card(

                margin: const EdgeInsets.all(8),

                child: ListTile(

                  leading: Image.network(
                    game.imagen,
                    width: 60,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.videogame_asset),
                  ),

                  title: Text(game.nombre),

                  subtitle: Text(game.genero),

                  onTap: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) => DetailScreen(
                          game: game,
                        ),
                      ),
                    );
                  },

                  trailing: Row(

                    mainAxisSize: MainAxisSize.min,

                    children: [

                      // Editar

                      IconButton(

                        icon: const Icon(Icons.edit),

                        onPressed: () {

                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (_) => FormScreen(
                                game: game,
                              ),
                            ),
                          ).then((_) {

                            context
                                .read<GameProvider>()
                                .loadGames();
                          });
                        },
                      ),

                      // Eliminar

                      IconButton(

                        icon: const Icon(Icons.delete),

                        onPressed: () {

                          _confirmDelete(
                            context,
                            game.id!,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}