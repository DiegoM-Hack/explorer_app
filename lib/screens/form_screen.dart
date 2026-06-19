import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/game.dart';
import '../providers/game_provider.dart';

class FormScreen extends StatefulWidget {

  final Game? game;

  const FormScreen({
    super.key,
    this.game,
  });

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  final formKey = GlobalKey<FormState>();

  late TextEditingController nombreController;
  late TextEditingController generoController;
  late TextEditingController plataformaController;
  late TextEditingController notaController;
  late TextEditingController imagenController;

  @override
  void initState() {
    super.initState();

    
    nombreController =
        TextEditingController(text: widget.game?.nombre ?? "");

    generoController =
        TextEditingController(text: widget.game?.genero ?? "");

    plataformaController =
        TextEditingController(text: widget.game?.plataforma ?? "");

    notaController =
        TextEditingController(text: widget.game?.nota ?? "");
    
    imagenController =
        TextEditingController(text: widget.game?.imagen ?? "");

    imagenController.addListener(() {
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(
          widget.game == null
              ? "Nuevo Juego"
              : "Editar Juego",
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: SingleChildScrollView(
          child: Form(
          key: formKey,

          child: Column(

            children: [

              TextFormField(
                controller: nombreController,
                decoration:
                    const InputDecoration(labelText: "Nombre"),
              ),

              TextFormField(
                controller: generoController,
                decoration:
                    const InputDecoration(labelText: "Género"),
              ),

              TextFormField(
                controller: plataformaController,
                decoration:
                    const InputDecoration(labelText: "Plataforma"),
              ),

              TextFormField(
                controller: notaController,
                decoration:
                    const InputDecoration(labelText: "Nota"),
              ),

              if (imagenController.text.isNotEmpty)
                  SizedBox(
                    height: 180,
                    child: Image.network(
                      imagenController.text,
                      errorBuilder: (_, __, ___) {
                        return const Center(
                          child: Text("Imagen no válida"),
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 10),

              TextFormField(
                controller: imagenController,
                decoration:
                    const InputDecoration(labelText: "URL Imagen"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(

                onPressed: () async {

                  final game = Game(

                    id: widget.game?.id,

                    nombre: nombreController.text,

                    genero: generoController.text,

                    plataforma: plataformaController.text,

                    imagen: imagenController.text,

                    rating: widget.game?.rating ?? 0,

                    nota: notaController.text,
                  );

                  if (widget.game == null) {

                    await context
                        .read<GameProvider>()
                        .addGame(game);

                  } else {

                    await context
                        .read<GameProvider>()
                        .updateGame(game);
                  }

                  if (!mounted) return;

                  Navigator.pop(context);
                },

                child: const Text(
                  "Guardar",
                ),
              ),
          
            ],
          ),
        ),
      ),
      ),
    );
  }
}