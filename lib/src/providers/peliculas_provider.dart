import 'dart:async';

import 'package:app_peliculas_udemy/src/models/pelicula_model.dart';
import 'package:app_peliculas_udemy/src/models/actores_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeliculasProvider {
  String _apikey = '834750760526aff50a97889f05c80d24';
  String _language = 'es-ES';
  String _url = 'api.themoviedb.org';

  int _popularesPage = 0;

  bool _cargando = false;

  List<Pelicula> _populares = <Pelicula>[];

  final _popularesStream = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStream.sink.add;
  Stream<List<Pelicula>> get popularesStream => _popularesStream.stream;

  void disposeStreams() {
    _popularesStream.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Actor>> _procesarRespuestaCast(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    print("Actores:   " + decodedData['cast'].toString());
    final peliculas = Cast.fromJsonList(decodedData['cast']);
    print("===============================================");
    print(peliculas.actores[0].toString());
    return peliculas.actores;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) {
      return [];
    }

    _cargando = true;

    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);

    popularesSink(_populares);

    _cargando = false;

    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits',
        {'api_key': _apikey, '_language': _language});
    return await _procesarRespuestaCast(url);
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query': query
    });

    return await _procesarRespuesta(url);
  }
}
