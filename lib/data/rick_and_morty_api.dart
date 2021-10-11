import 'dart:io';

import 'package:http/http.dart' as http;

import 'errors.dart';

class RickAndMortyApi {
  static const _url = 'https://rickandmortyapi.com/api/';

  Future<String> fetchCharacters(int page) async {
    var response;
    try {
      response = await http.get(Uri.parse('${_url}character/?page=$page'));
    } on SocketException {
      throw NoInternetException();
    } on HttpException {
      throw NoServiceFoundException();
    }

    if (response.statusCode != 200)
      throw StatusException(message: response.statusCode);

    return response.body;
  }

  Future<String> fetchPersonage(int id) async {
    var response;
    try {
      response = await http.get(Uri.parse('${_url}character/$id'));
    } on SocketException {
      throw NoInternetException();
    } on HttpException {
      throw NoServiceFoundException();
    }

    if (response.statusCode != 200)
      throw StatusException(message: response.statusCode);

    return response.body;
  }

  Future<String> fetchEpisodesPage(int page) async {
    var response;
    try {
      response = await http.get(Uri.parse('${_url}episode?page=$page'));
    } on SocketException {
      throw NoInternetException();
    } on HttpException {
      throw NoServiceFoundException();
    }

    if (response.statusCode != 200)
      throw StatusException(message: response.statusCode);

    return response.body;
  }

  Future<String> fetchLocationsPage(int page) async {
    var response;
    try {
      response = await http.get(Uri.parse('${_url}location?page=$page'));
    } on SocketException {
      throw NoInternetException();
    } on HttpException {
      throw NoServiceFoundException();
    }

    if (response.statusCode != 200)
      throw StatusException(message: response.statusCode);

    return response.body;
  }

  Future<String> fetchDataByUrl(String url) async {
    var response;
    try {
      response = await http.get(Uri.parse(url));
    } on SocketException {
      throw NoInternetException();
    } on HttpException {
      throw NoServiceFoundException();
    }

    if (response.statusCode != 200)
      throw StatusException(message: response.statusCode);

    return response.body;
  }

  Future<String> fetchEpisode(int id) async {
    var response;
    try {
      response = await http.get(Uri.parse('${_url}episode/$id'));
    } on SocketException {
      throw NoInternetException();
    } on HttpException {
      throw NoServiceFoundException();
    }

    if (response.statusCode != 200)
      throw StatusException(message: response.statusCode);

    return response.body;
  }

  Future<String> fetchLocation(int id) async {
    var response;
    try {
      response = await http.get(Uri.parse('${_url}location/$id'));
    } on SocketException {
      throw NoInternetException();
    } on HttpException {
      throw NoServiceFoundException();
    }

    if (response.statusCode != 200)
      throw StatusException(message: response.statusCode);

    return response.body;
  }
}
