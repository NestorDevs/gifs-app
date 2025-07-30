import 'package:equatable/equatable.dart';

import 'image_info.dart';

class GIF extends Equatable {
  final String id;
  final String title;
  final ImageInfo originalImage;

  const GIF({
    required this.id,
    required this.title,
    required this.originalImage,
  });

  @override
  List<Object?> get props => [id, title, originalImage];
}
