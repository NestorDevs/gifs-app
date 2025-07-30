import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/gif_model.dart';

class GiphyApiClient {
  final String apiKey;
  final http.Client client;

  GiphyApiClient({required this.apiKey, http.Client? client})
      : this.client = client ?? http.Client();

  Future<List<GifModel>> getTrendingGifs({int offset = 0, int limit = 25}) async {
    final response = await this.client.get(Uri.parse(
        'https://api.giphy.com/v1/gifs/trending?api_key=$apiKey&offset=$offset&limit=$limit'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['data'] as List)
          .map((item) => GifModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load trending gifs');
    }
  }

  Future<List<GifModel>> searchGifs(String query,
      {int offset = 0, int limit = 25}) async {
    final response = await this.client.get(Uri.parse(
        'https://api.giphy.com/v1/gifs/search?api_key=$apiKey&q=$query&offset=$offset&limit=$limit'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['data'] as List)
          .map((item) => GifModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to search gifs');
    }
  }
}