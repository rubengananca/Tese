import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Galery extends StatelessWidget {
  const Galery({super.key});

  @override
  Widget build(BuildContext context) {

    // Recupera os argumentos enviados pela página camera.dart
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<File,String>; // Interpreta como Map

    return Scaffold(
        backgroundColor: Color(0xFFEAEAEA),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text("Galeria",
            style: GoogleFonts.nunito(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: arguments.isEmpty ?
        // Se a galeria estiver vazia
        const Center(
          child: Text("Nenhuma imagem capturada ainda"),
        )
            : GridView.builder( // se nao estiver vazio mostra a galeria
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // numero de colunas
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: arguments.length,
            itemBuilder: (context, index) {
              final file = arguments.keys.elementAt(index);
              final date = arguments[file]!;

              return Column(
                children: [
                  // Para a imagem ocupar mais espaço da coluna
                  Expanded(
                    child: Image.file(file, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    date,
                    style: GoogleFonts.nunito(fontSize: 12.0),
                  ),
                ],
              );
            }
        )
    );
  }
}
