import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/theme/app_theme.dart';
import 'features/gif_viewer/presentation/cubit/gif_cubit.dart';
import 'features/gif_viewer/presentation/pages/gif_list_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giphy Trending',
      theme: AppTheme.lightTheme,
      home: BlocProvider(
        create: (context) => GifCubit(
          getTrendingGifs: GetIt.instance(),
          searchGifs: GetIt.instance(),
        ),
        child: const GifListPage(),
      ),
    );
  }
}
