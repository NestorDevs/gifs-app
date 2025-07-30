import 'package:get_it/get_it.dart';
import 'package:giphy_gifs_core/giphy_gifs_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final sl = GetIt.instance;

void init() {
  // Core
  sl.registerLazySingleton(() => GiphyApiClient(apiKey: dotenv.env['GIPHY_API_KEY']!));
  sl.registerLazySingleton<GifRepository>(
      () => GifRepositoryImpl(apiClient: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetTrendingGifs(sl()));
  sl.registerLazySingleton(() => SearchGifs(sl()));
}