import 'dart:convert';

import 'models/character.dart';
import 'models/episode.dart';
import 'models/locations.dart';
import 'rick_and_morty_api.dart';

abstract class RickAndMortyRepository {
  Future<List<Character>> fetchCharacters(int page);

  Future<Character> fetchPersonage(int id);

  Future<List<Episode>> fetchEpisodesPage(int page);

  // Future<Episode> fetchEpisode(String url);

  Future<List<Locations>> fetchLocationsPage(int page);

  Future<Locations> fetchLocationById(int id);
  Future<Locations> fetchLocationByUrl(String url);
}

class Repository extends RickAndMortyRepository {
  @override
  Future<List<Character>> fetchCharacters(int page) async {
    var result = await RickAndMortyApi().fetchCharacters(page);
    var list = jsonDecode(result)['results']
        .map((e) => Character.fromJson(e))
        .toList();
    return List.from(list);
  }

  @override
  Future<Character> fetchPersonage(int id) async {
    var result = await RickAndMortyApi().fetchPersonage(id);
    return Character.fromJson(jsonDecode(result));
  }

  @override
  Future<List<Episode>> fetchEpisodesPage(int page) async {
    var result = await RickAndMortyApi().fetchEpisodesPage(page);
    var list =
        jsonDecode(result)['results'].map((e) => Episode.fromJson(e)).toList();
    return List.from(list);
  }

  // @override
  // Future<Episode> fetchEpisode(String url) async {
  //   var result = await RickAndMortyApi().fetchData(url);
  //   return Episode.fromJson(jsonDecode(result));
  // }

  @override
  Future<List<Locations>> fetchLocationsPage(int page) async {
    var result = await RickAndMortyApi().fetchLocationsPage(page);
    var list = jsonDecode(result)['results']
        .map((e) => Locations.fromJson(e))
        .toList();
    return List.from(list);
  }

  @override
  Future<Locations> fetchLocationById(int id) async {
    var result = await RickAndMortyApi().fetchLocation(id);
    return Locations.fromJson(jsonDecode(result));
  }

  @override
  Future<Locations> fetchLocationByUrl(String url) async {
    var result = await RickAndMortyApi().fetchData(url);
    return Locations.fromJson(jsonDecode(result));
  }
}
