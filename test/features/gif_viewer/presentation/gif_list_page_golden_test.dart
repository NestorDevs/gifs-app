import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gifs_app/features/gif_viewer/presentation/cubit/gif_cubit.dart';
import 'package:gifs_app/features/gif_viewer/presentation/cubit/gif_state.dart';
import 'package:gifs_app/features/gif_viewer/presentation/pages/gif_list_page.dart';
import 'package:giphy_gifs_core/giphy_gifs_core.dart' as core;
import 'package:bloc_test/bloc_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockGifCubit extends MockBloc<GifCubit, GifState> implements GifCubit {}

void main() {
  late MockGifCubit mockGifCubit;

  final tGif = core.GIF(
    id: '1',
    title: 'Test GIF',
    originalImage: core.ImageInfo(
      url: 'https://media.giphy.com/media/3o6Zt481isNVuQI1l6/giphy.gif',
      width: 200,
      height: 150,
    ),
  );

  setUp(() {
    mockGifCubit = MockGifCubit();
  });

  testWidgets('Golden test for GifListPage in loaded state', (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      whenListen(
        mockGifCubit,
        Stream.fromIterable([GifLoaded([tGif])]),
        initialState: GifLoaded([tGif]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<GifCubit>(
            create: (_) => mockGifCubit,
            child: const GifListPage(),
          ),
        ),
      );

      await expectLater(
        find.byType(GifListPage),
        matchesGoldenFile('golden/gif_list_page_loaded.png'),
      );
    });
  });
}
