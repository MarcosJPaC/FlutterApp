import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_web_api/cliente/main_page.dart';
import 'package:flutter_web_api/categoria/main_page.dart';
import 'package:flutter_web_api/login_page.dart';

import 'Indice.dart';
class PostHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  HttpOverrides.global = new PostHttpOverrides();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPageLogin(),
    );
  }
}
