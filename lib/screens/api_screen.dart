import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/game.dart';
import '../providers/game_provider.dart';
import '../services/rawg_service.dart';
import 'detail_screen.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {

  final RawgService service = RawgService();

  final ScrollController controller = ScrollController();

  final TextEditingController searchController =
    TextEditingController();

  String currentSearch = "";

  List<dynamic> games = [];

  int page = 1;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loadGames();

    controller.addListener(() {

      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 300) {

        loadMoreGames();
      }
    });
  }

  Future<void> searchGames() async {

  page = 1;

  currentSearch = searchController.text;

  setState(() {
    games.clear();
  });

  await loadGames();
}

  Future<void> loadGames() async {

    setState(() {
      isLoading = true;
    });

    try {

      final data = await service.getGames(
      page,
      search: currentSearch,
    );

      setState(() {
        games = data["results"];
      });

    } catch (e) {

      debugPrint("Error RAWG: $e");

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> loadMoreGames() async {

    if (isLoading) return;

    isLoading = true;

    page++;

    try {

      final data = await service.getGames(
      page,
      search: currentSearch,
    );

      setState(() {
        games.addAll(data["results"]);
      });

    } catch (e) {

      debugPrint("Error cargando más juegos: $e");

    } finally {

      isLoading = false;
    }
  }

  @override
  void dispose() {

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Explorador API"),
      ),

      body: Column(

          children: [

            Padding(

              padding: const EdgeInsets.all(8),

              child: Row(

                children: [

                  Expanded(

                    child: TextField(

                      controller: searchController,

                      decoration: const InputDecoration(

                        hintText: "Buscar videojuego",

                        border: OutlineInputBorder(),

                        prefixIcon: Icon(Icons.search),
                      ),

                      onSubmitted: (_) {
                        searchGames();
                      },
                    ),
                  ),

                  const SizedBox(width: 8),

                  ElevatedButton(

                    onPressed: searchGames,

                    child: const Text(
                      "Buscar",
                    ),
                  ),
                ],
              ),
            ),

        Expanded(

            child: isLoading && games.isEmpty

                ? const Center(
                    child: CircularProgressIndicator(),
                  )

                : ListView.builder(

                    controller: controller,

                    itemCount: games.length,

                    itemBuilder: (context, index) {

                      final game = games[index];

                      return Card(

  margin: const EdgeInsets.all(10),

  child: InkWell(

    onTap: () {

      final selectedGame = Game(

        nombre: game["name"] ?? "",

        genero: game["genres"].isNotEmpty
            ? game["genres"][0]["name"]
            : "Sin género",

        plataforma: game["platforms"] != null &&
                game["platforms"].isNotEmpty
            ? game["platforms"][0]["platform"]["name"]
            : "No especificada",

        imagen: game["background_image"] ?? "",

        rating: (game["rating"] ?? 0).toDouble(),

        nota: "Juego obtenido desde RAWG API",
      );

      Navigator.push(

        context,

        MaterialPageRoute(

          builder: (_) => DetailScreen(
            game: selectedGame,
          ),
        ),
      );
    },

    child: Padding(

      padding: const EdgeInsets.all(10),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Image.network(
            game["background_image"] ?? "",
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 10),

          Text(
            game["name"] ?? "",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            "⭐ ${game["rating"]}",
          ),

          const SizedBox(height: 10),

          
          ElevatedButton(
            onPressed: () async {

                                  await context
                                      .read<GameProvider>()
                                      .addGame(

                                    Game(
                                      nombre: game["name"],

                                      genero: game["genres"]
                                              .isNotEmpty
                                          ? game["genres"][0]["name"]
                                          : "Sin género",

                                      plataforma: "",

                                      imagen:
                                          game["background_image"] ?? "",

                                      rating:
                                          game["rating"].toDouble(),

                                      nota: "",
                                    ),
                                  );

                                  if (!mounted) return;

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(

                                    const SnackBar(
                                      content: Text(
                                        "Juego guardado en mi colección",
                                      ),
                                    ),
                                  );
                                },

                                child: const Text(
                                  "Guardar en mi colección",
                                ),
          ),
      
                            ],
                          ),
                        ),
                      ),
                      );
                    },
                  ),
        ),
  
        ],
      ),
    );
  }
}