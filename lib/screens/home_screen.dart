import 'package:flutter/material.dart';

import 'about_screen.dart';
import 'api_screen.dart';
import 'collection_screen.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("GameVault"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [

            ElevatedButton(

              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CollectionScreen(),
                  ),
                );
              },

              child: const Text(
                "Mi Colección",
              ),
            ),

            ElevatedButton(

              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ApiScreen(),
                  ),
                );
              },

              child: const Text(
                "Explorar Juegos",
              ),
            ),

            ElevatedButton(

              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AboutScreen(),
                  ),
                );
              },

              child: const Text(
                "Acerca de",
              ),
            ),

           

            
          ],
        ),
      ),
    );
  }
}