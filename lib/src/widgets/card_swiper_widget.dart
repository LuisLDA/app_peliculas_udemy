import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:app_peliculas_udemy/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula>? peliculas;

  CardSwiper({required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screnSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          peliculas![index].uniqueId = '${peliculas![index].id}-tarjeta';
          return Hero(
            tag: peliculas![index].uniqueId.toString(),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'detalle',
                      arguments: peliculas![index]),
                  child: FadeInImage(
                    image: NetworkImage(peliculas![index].getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                  ),
                )),
          );
        },
        itemCount: peliculas!.length,
        itemWidth: _screnSize.width * 0.7,
        itemHeight: _screnSize.height * 0.3,
        layout: SwiperLayout.STACK,
        // pagination: SwiperPagination(),
        // control: SwiperControl(),
      ),
    );
  }
}
