import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

class ImagePickerDemo extends StatefulWidget {
  const ImagePickerDemo({super.key});

  @override
  State<ImagePickerDemo> createState() => _ImagePickerDemoState();
}

// Estas classes e métodos têm o "_" para garantir que são privadas
// Ou seja, não podem ser acedidos por outros arquivos

class _ImagePickerDemoState extends State<ImagePickerDemo> {

  // O ponto de interrogacao indica que a variavel pode ser nula
  // Util para inicia-la a valor nulo (?). Pode-se usar o "!" para garantir que nao seja nulo
  File? image;
  Map<File,String> capturedImages = {};

  // Representa uma operacao assincrona cujo resultado vai estar disponivel no futuro
  Future<void> _captureImageFromCamera() async {

    // o "final" indica que a variavel so pode ser atribuida uma vez.
    // Após isso torna-se imutavel - importante para que o valor nao seja alterado
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera
    );

    if(pickedFile != null){
      File compressedImage = await _compressImage(File(pickedFile.path));
      setState(() {
        image = compressedImage;
        //capturedImages.add(compressedImage);
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('MMMM dd HH:mm, yyyy').format(now); // atualiza o formato da data
        capturedImages[compressedImage] = formattedDate;
      });

      _saveImageToGallery(compressedImage.path); // guarda na galeria
    }
  }

  Future<File> _compressImage(File image) async {
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path, "${image.path}_compress.jpg",
      quality: 70, // define a qualidade da compressao
    );

    // Ensure that compressedImage is not null before returning
    if (compressedImage != null) {
      return File(compressedImage.path); // Converte XFile (tipo de dado retornado pelo FlutterImageCompress) em File
    } else {
      throw Exception("Image compression failed");
    }
  }

  Future<void> _saveImageToGallery(String imagePath) async {

    final result = await ImageGallerySaverPlus.saveFile(imagePath);
    if (result["isSuccess"]) {
      print("Imaged Saved to gallery");
    } else {
      print("Failed to save image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAEAEA),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Camera",
          style: GoogleFonts.nunito(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: image == null ? // se nao tiver escolhido ainda nenhuma image, ou se ja tiver escolhido mostra a
        Text("No image Selected", style: GoogleFonts.nunito(),) : Image.file(image!),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            backgroundColor: Color(0xFFFFCA9E),
            heroTag: 'galleryButton', // Unique hero tag
            onPressed: () { //_pickImageFromGallery,
              Navigator.pushNamed(
                  context,
                  "/galery",
                  arguments: capturedImages // passa o mapa de imagens como argumento para a página da galeria
              );
            },
            child: Icon(
              Icons.photo_library,
              color: Color(0xFF854400),
            ),
          ),
          SizedBox(width: 10.0),
          FloatingActionButton(
            backgroundColor: Color(0xFFFFCA9E),
            heroTag: 'cameraButton', // Unique hero tag
            onPressed: _captureImageFromCamera,
            child: Icon(
              Icons.camera_alt,
              color: Color(0xFF854400),
            ),
          ),
        ],
      ),
    );
  }
}