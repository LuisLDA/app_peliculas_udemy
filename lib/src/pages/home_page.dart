import 'package:app_peliculas_udemy/src/models/pelicula_model.dart';
import 'package:app_peliculas_udemy/src/providers/peliculas_provider.dart';
import 'package:app_peliculas_udemy/src/search/search_delegate.dart';
import 'package:app_peliculas_udemy/src/widgets/card_swiper_widget.dart';
import 'package:app_peliculas_udemy/src/widgets/movie_horizontal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Peliculas en cines'),
          backgroundColor: Colors.amberAccent,
          actions: [IconButton(onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          }, icon: Icon(Icons.search))],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [_swipedTarjetas(), _footer(context)],
          ),
        ));
  }

  Widget _swipedTarjetas() {

    return FutureBuilder(
        future: peliculasProvider.getEnCines(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(peliculas: snapshot.data);
          } else {
            return Container(
                height: 400.0,
                child: const Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget _footer(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Populares',
                  style: Theme.of(context).textTheme.subtitle1)),
          const SizedBox(height: 5.0),
          StreamBuilder(
              stream: peliculasProvider.popularesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Pelicula>> snapshot) {
                if (snapshot.hasData) {
                  return MovieHorizontal(peliculas: snapshot.data,siguientePagina: peliculasProvider.getPopulares);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}
