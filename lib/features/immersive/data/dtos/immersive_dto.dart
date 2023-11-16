import 'package:nasa_immersive_od/features/immersive/domain/entities/immersive_entity.dart';
import 'package:nasa_immersive_od/shared/utils/date_utils.dart';

class ImmersiveDto extends ImmersiveEntity {
  const ImmersiveDto({
    required super.date,
    required super.explanation,
    required super.title,
    required super.url,
    required super.imageBytes,
  });

  factory ImmersiveDto.fromJson(Map<String, dynamic> json) => ImmersiveDto(
        date: DateTime.parse(json['date']),
        explanation: json['explanation'],
        title: json['title'],
        url: json['url'],
        imageBytes: const [],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date.toApiFormat();
    data['explanation'] = explanation;
    data['title'] = title;
    data['url'] = url;
    return data;
  }

  copyWithBytes(
    List<int> downloadedImageBytes,
  ) =>
      ImmersiveDto(
        date: date,
        explanation: explanation,
        title: title,
        url: url,
        imageBytes: downloadedImageBytes,
      );
}
