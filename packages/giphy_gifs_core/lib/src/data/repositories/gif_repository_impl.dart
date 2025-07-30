import '../../domain/entities/gif.dart';
import '../../domain/repositories/gif_repository.dart';
import '../datasources/giphy_api_client.dart';

class GifRepositoryImpl implements GifRepository {
  final GiphyApiClient apiClient;

  GifRepositoryImpl({required this.apiClient});

  @override
  Future<List<GIF>> getTrendingGifs({int offset = 0, int limit = 25}) {
    return apiClient.getTrendingGifs(offset: offset, limit: limit);
  }

  @override
  Future<List<GIF>> searchGifs(String query, {int offset = 0, int limit = 25}) {
    return apiClient.searchGifs(query, offset: offset, limit: limit);
  }
}
