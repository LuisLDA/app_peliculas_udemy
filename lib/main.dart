import 'package:app_peliculas_udemy/src/pages/pelicula_detalle.dart';
import "package:flutter/material.dart";
import 'package:app_peliculas_udemy/src/pages/home_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => HomePage(),
        'detalle': (BuildContext context) => PeliculaDetalle(),
      } ,

    );
  }
}