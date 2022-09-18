import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class CardSwiper extends StatelessWidget {

  final List<dynamic> peliculas;

  CardSwiper({ required this.peliculas});

@override
Widget build(BuildContext context) {

  final _screnSize = MediaQuery.of(context).size;

  return Container(
    padding: EdgeInsets.only(top: 10.0),

    child: Swiper(
      itemBuilder: (BuildContext context,int index){
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.network("https://via.placeholder.com/350x150",fit: BoxFit.cover,),
        );
      },
      itemCount: peliculas.length,
      itemWidth: _screnSize.width * 0.7,
      itemHeight: _screnSize.height * 0.5,
      layout: SwiperLayout.STACK,
      // pagination: SwiperPagination(),
      // control: SwiperControl(),
    ),
  );
}}
