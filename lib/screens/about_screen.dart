import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Acerca de"),
      ),

      body: const Padding(

        padding: EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              "GameVault",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 30),

            Text(
              "Aplicación desarrollada en Flutter.",
            ),

            Text(
              "Base de datos: MongoDB Atlas",
            ),

            Text(
              "API externa: RAWG",
            ),

            Text(
              "Infinite Scrolling implementado",
            ),

            SizedBox(height: 30),

            Text(
              "Autor: Diego Montaluisa",
            ),
          ],
        ),
      ),
    );
  }
}