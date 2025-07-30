import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:giphy_gifs_core/giphy_gifs_core.dart';
import 'package:gifs_app/features/gif_viewer/presentation/cubit/gif_cubit.dart';
import 'package:gifs_app/features/gif_viewer/presentation/cubit/gif_state.dart';

import 'gif_cubit_test.mocks.dart';

@GenerateMocks([GetTrendingGifs, SearchGifs])
void main() {
  late GifCubit gifCubit;
  late MockGetTrendingGifs mockGetTrendingGifs;
  late MockSearchGifs mockSearchGifs;

  setUp(() {
    mockGetTrendingGifs = MockGetTrendingGifs();
    mockSearchGifs = MockSearchGifs();
    gifCubit = GifCubit(
      getTrendingGifs: mockGetTrendingGifs,
      searchGifs: mockSearchGifs,
    );
  });

  tearDown(() {
    gifCubit.close();
  });

  final tGifs = [
    const GIF(
      id: '1',
      title: 'Test GIF 1',
      originalImage: ImageInfo(url: 'https://example.com/1.gif', width: 100, height: 100),
    )
  ];

  group('GifCubit', () {
    blocTest<GifCubit, GifState>(
      'emits [GifLoading, GifLoaded] when fetchTrendingGifs is successful',
      build: () {
        when(mockGetTrendingGifs()).thenAnswer((_) async => tGifs);
        return gifCubit;
      },
      act: (cubit) => cubit.fetchTrendingGifs(),
      expect: () => [GifLoading(), GifLoaded(tGifs)],
    );

    blocTest<GifCubit, GifState>(
      'emits [GifLoading, GifError] when fetchTrendingGifs fails',
      build: () {
        when(mockGetTrendingGifs()).thenThrow(Exception('error'));
        return gifCubit;
      },
      act: (cubit) => cubit.fetchTrendingGifs(),
      expect: () => [GifLoading(), const GifError('Failed to fetch trending gifs')],
    );

    blocTest<GifCubit, GifState>(
      'emits [GifLoading, GifLoaded] when search is successful',
      build: () {
        when(mockSearchGifs('test')).thenAnswer((_) async => tGifs);
        return gifCubit;
      },
      act: (cubit) => cubit.search('test'),
      expect: () => [GifLoading(), GifLoaded(tGifs)],
    );

    blocTest<GifCubit, GifState>(
      'emits [GifLoading, GifError] when search fails',
      build: () {
        when(mockSearchGifs('test')).thenThrow(Exception('error'));
        return gifCubit;
      },
      act: (cubit) => cubit.search('test'),
      expect: () => [GifLoading(), const GifError('Failed to search gifs')],
    );
  });
}
