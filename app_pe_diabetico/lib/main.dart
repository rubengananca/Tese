import 'package:app_pe_diabetico/camera.dart';
import 'package:flutter/material.dart';
import 'package:app_pe_diabetico/galery.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
      MaterialApp(
        initialRoute: "/",
        //home: ImagePickerDemo(),
        routes: {
          "/": (context) => ImagePickerDemo(),
          "/galery": (context) => Galery(),
        },
      )
  );
}
