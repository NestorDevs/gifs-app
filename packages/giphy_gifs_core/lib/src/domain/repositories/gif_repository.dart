import '../entities/gif.dart';

abstract class GifRepository {
  Future<List<GIF>> getTrendingGifs({int offset = 0, int limit = 25});
  Future<List<GIF>> searchGifs(String query, {int offset = 0, int limit = 25});
}
