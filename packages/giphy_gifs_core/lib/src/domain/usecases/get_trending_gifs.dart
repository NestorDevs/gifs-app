import '../entities/gif.dart';
import '../repositories/gif_repository.dart';

class GetTrendingGifs {
  final GifRepository repository;

  GetTrendingGifs(this.repository);

  Future<List<GIF>> call({int offset = 0, int limit = 25}) {
    return repository.getTrendingGifs(offset: offset, limit: limit);
  }
}
