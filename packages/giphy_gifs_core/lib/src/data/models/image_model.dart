import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/image_info.dart';

part 'image_model.g.dart';

@JsonSerializable()
class ImageModel extends ImageInfo {
  ImageModel({
    required String url,
    required String width,
    required String height,
  }) : super(
          url: url,
          width: double.tryParse(width) ?? 0.0,
          height: double.tryParse(height) ?? 0.0,
        );

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}