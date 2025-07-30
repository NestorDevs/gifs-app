import 'package:equatable/equatable.dart';
import 'package:giphy_gifs_core/giphy_gifs_core.dart';

abstract class GifState extends Equatable {
  const GifState();

  @override
  List<Object> get props => [];
}

class GifInitial extends GifState {}

class GifLoading extends GifState {}

class GifLoaded extends GifState {
  final List<GIF> gifs;

  const GifLoaded(this.gifs);

  @override
  List<Object> get props => [gifs];
}

class GifError extends GifState {
  final String message;

  const GifError(this.message);

  @override
  List<Object> get props => [message];
}
