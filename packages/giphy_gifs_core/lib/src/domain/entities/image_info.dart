import 'package:equatable/equatable.dart';

class ImageInfo extends Equatable {
  final String url;
  final double width;
  final double height;

  const ImageInfo({
    required this.url,
    required this.width,
    required this.height,
  });

  @override
  List<Object?> get props => [url, width, height];
}
