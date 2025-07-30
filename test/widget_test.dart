import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gifs_app/features/gif_viewer/presentation/cubit/gif_cubit.dart';
import 'package:gifs_app/features/gif_viewer/presentation/cubit/gif_state.dart';
import 'package:gifs_app/features/gif_viewer/presentation/pages/gif_list_page.dart';

class MockGifCubit extends MockBloc<GifCubit, GifState> implements GifCubit {}

void main() {
  late MockGifCubit mockGifCubit;

  setUp(() {
    mockGifCubit = MockGifCubit();
  });

  testWidgets('GifListPage has a title and a search field', (
    WidgetTester tester,
  ) async {
    whenListen(
      mockGifCubit,
      Stream.fromIterable([GifInitial()]),
      initialState: GifInitial(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<GifCubit>(
          create: (_) => mockGifCubit,
          child: const GifListPage(),
        ),
      ),
    );

    expect(find.text('Giphy Trending'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
