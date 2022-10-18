import 'package:app_peliculas_udemy/src/models/pelicula_model.dart';
import 'package:app_peliculas_udemy/src/providers/peliculas_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';

  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Spoderman',
    'Aquamens'
        'CINE',
    'Boys'
  ];

  final peliculasRecientes = ['Spoderman', 'CINE'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Las acciones de nuestro appbar
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.redAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
              children: peliculas!.map((pelicula) {
            return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                });
          }).toList());
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
