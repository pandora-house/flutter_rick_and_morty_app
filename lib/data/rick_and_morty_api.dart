import 'package:http/http.dart' as http;

class RickAndMortyApi {
  String url = 'https://rickandmortyapi.com/api/';

  Future<String> fetchCharacters(int page) async {
    final response = await http.get(Uri.parse('$url/character/?page=$page'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<String> fetchPersonage(int id) async {
    final response = await http.get(Uri.parse('$url/character/$id'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load personage');
    }
  }

  Future<String> fetchEpisodesPage(int page) async {
    final response = await http.get(Uri.parse('${url}episode?page=$page'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load episodes');
    }
  }

  Future<String> fetchEpisode(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load episode');
    }
  }

  Future<String> fetchLocationsPage(int page) async {
    final response = await http.get(Uri.parse('${url}location?page=$page'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load locations');
    }
  }

  Future<String> fetchLocation(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load location');
    }
  }
}
