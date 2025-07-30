import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/gif.dart';
import 'image_model.dart';

part 'gif_model.g.dart';

@JsonSerializable()
class GifModel extends GIF {
  @JsonKey(name: 'images', fromJson: _imagesFromJson)
  final ImageModel originalImage;

  const GifModel({
    required String id,
    required String title,
    required this.originalImage,
  }) : super(id: id, title: title, originalImage: originalImage);

  factory GifModel.fromJson(Map<String, dynamic> json) =>
      _$GifModelFromJson(json);

  Map<String, dynamic> toJson() => _$GifModelToJson(this);
}

ImageModel _imagesFromJson(Map<String, dynamic> json) {
  return ImageModel.fromJson(json['original'] as Map<String, dynamic>);
}