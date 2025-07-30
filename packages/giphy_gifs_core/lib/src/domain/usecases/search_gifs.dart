import '../entities/gif.dart';
import '../repositories/gif_repository.dart';

class SearchGifs {
  final GifRepository repository;

  SearchGifs(this.repository);

  Future<List<GIF>> call(String query, {int offset = 0, int limit = 25}) {
    return repository.searchGifs(query, offset: offset, limit: limit);
  }
}
