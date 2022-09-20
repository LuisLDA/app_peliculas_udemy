import 'package:app_peliculas_udemy/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula>? peliculas;
  final Function siguientePagina;

  MovieHorizontal({required this.peliculas,required this.siguientePagina});

  final _pageController = PageController( initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent-200){
        print('Cargar siguientes peliculas');
        siguientePagina();
      }

    });

    return Container(
      height: _screenSize.height * 0.2 ,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas?.length,
        itemBuilder: (context,i){
          return _tarjeta(context, peliculas![i]);
        },
        // children: _tarjetas(context),
      ),
    );
  }

  Widget _tarjeta(BuildContext context,Pelicula pelicula){
    final peliculaTarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              child: FadeInImage(
                placeholder: const AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5.0,),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),

    );

    return GestureDetector(
      child: peliculaTarjeta,
      onTap: (){
        print('ID de la pelicula ${pelicula.backdropPath}');
        Navigator.pushNamed(context, 'detalle',arguments: pelicula);
      },
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas!.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(pelicula.getPosterImg()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 5.0,),
              Text(
                pelicula.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),

      );
    }).toList();
  }
}
