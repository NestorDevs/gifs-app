import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:giphy_gifs_core/src/data/datasources/giphy_api_client.dart';
import 'package:giphy_gifs_core/src/data/models/gif_model.dart';
import 'package:giphy_gifs_core/src/data/repositories/gif_repository_impl.dart';
import 'package:giphy_gifs_core/src/data/models/image_model.dart';
import 'package:giphy_gifs_core/src/domain/entities/gif.dart';

import 'gif_repository_impl_test.mocks.dart';

@GenerateMocks([GiphyApiClient])
void main() {
  late GifRepositoryImpl repository;
  late MockGiphyApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockGiphyApiClient();
    repository = GifRepositoryImpl(apiClient: mockApiClient);
  });

  group('getTrendingGifs', () {
    test('should return a list of GIF entities', () async {
      final gifModels = [
        GifModel(
          id: '1',
          title: 'Test GIF 1',
          originalImage: ImageModel(url: 'https://example.com/1.gif', width: '100.0', height: '100.0'),
        )
      ];

      when(mockApiClient.getTrendingGifs()).thenAnswer((_) async => gifModels);

      final result = await repository.getTrendingGifs();

      expect(result, isA<List<GIF>>());
      expect(result.first.id, '1');
    });
  });
}
