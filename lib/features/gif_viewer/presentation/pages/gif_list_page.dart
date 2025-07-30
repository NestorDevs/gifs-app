import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../shared/utils/debouncer.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/error_display.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../cubit/gif_cubit.dart';
import '../cubit/gif_state.dart';
import '../widgets/gif_card.dart';
import '../widgets/gif_shimmer_placeholder.dart';

class GifListPage extends StatefulWidget {
  const GifListPage({Key? key}) : super(key: key);

  @override
  _GifListPageState createState() => _GifListPageState();
}

class _GifListPageState extends State<GifListPage> {
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    context.read<GifCubit>().fetchTrendingGifs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Giphy Trending'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                _debouncer.run(() {
                  if (query.isNotEmpty) {
                    context.read<GifCubit>().search(query);
                  } else {
                    context.read<GifCubit>().fetchTrendingGifs();
                  }
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search GIFs',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<GifCubit, GifState>(
              builder: (context, state) {
                if (state is GifLoading) {
                  return MasonryGridView.count(
                    crossAxisCount: 2,
                    itemCount: 10,
                    itemBuilder: (context, index) => const GifShimmerPlaceholder(),
                  );
                } else if (state is GifLoaded) {
                  return MasonryGridView.count(
                    crossAxisCount: 2,
                    itemCount: state.gifs.length,
                    itemBuilder: (context, index) => GifCard(gif: state.gifs[index]),
                  );
                } else if (state is GifError) {
                  return ErrorDisplay(message: state.message);
                } else {
                  return const LoadingIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
