import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:giphy_gifs_core/src/domain/entities/gif.dart';
import 'package:giphy_gifs_core/src/domain/entities/image_info.dart';
import 'package:giphy_gifs_core/src/domain/repositories/gif_repository.dart';
import 'package:giphy_gifs_core/src/domain/usecases/get_trending_gifs.dart';

import 'get_trending_gifs_test.mocks.dart';

@GenerateMocks([GifRepository])
void main() {
  late GetTrendingGifs usecase;
  late MockGifRepository mockGifRepository;

  setUp(() {
    mockGifRepository = MockGifRepository();
    usecase = GetTrendingGifs(mockGifRepository);
  });

  final tGifs = [
    const GIF(
      id: '1',
      title: 'Test GIF 1',
      originalImage: ImageInfo(url: 'https://example.com/1.gif', width: 100, height: 100),
    )
  ];

  test('should get trending gifs from the repository', () async {
    when(mockGifRepository.getTrendingGifs()).thenAnswer((_) async => tGifs);

    final result = await usecase();

    expect(result, tGifs);
    verify(mockGifRepository.getTrendingGifs());
    verifyNoMoreInteractions(mockGifRepository);
  });
}
