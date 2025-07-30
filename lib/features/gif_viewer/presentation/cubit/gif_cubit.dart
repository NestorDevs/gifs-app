import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphy_gifs_core/giphy_gifs_core.dart';

import 'gif_state.dart';

class GifCubit extends Cubit<GifState> {
  final GetTrendingGifs getTrendingGifs;
  final SearchGifs searchGifs;

  GifCubit({required this.getTrendingGifs, required this.searchGifs})
      : super(GifInitial());

  void fetchTrendingGifs() async {
    try {
      emit(GifLoading());
      final gifs = await getTrendingGifs();
      emit(GifLoaded(gifs));
    } catch (e) {
      emit(const GifError('Failed to fetch trending gifs'));
    }
  }

  void search(String query) async {
    try {
      emit(GifLoading());
      final gifs = await searchGifs(query);
      emit(GifLoaded(gifs));
    } catch (e) {
      emit(const GifError('Failed to search gifs'));
    }
  }
}
