import 'dart:convert';

import 'package:nasa_immersive_od/features/immersive/domain/entities/immersive_entity.dart';
import 'package:nasa_immersive_od/shared/utils/date_utils.dart';

class ImmersiveDto extends ImmersiveEntity {
  const ImmersiveDto({
    required super.copyright,
    required super.date,
    required super.explanation,
    required super.mediaType,
    required super.title,
    required super.url,
    super.hdurl,
    super.hdImageBytes,
    super.imageBytes,
  });

  factory ImmersiveDto.fromJson(Map<String, dynamic> json) => ImmersiveDto(
        copyright: json['copyright'],
        date: DateTime.parse(json['date']),
        explanation: json['explanation'],
        hdurl: json['hdurl'],
        mediaType: json['media_type'],
        title: json['title'],
        url: json['url'],
        hdImageBytes: json['hdImageBytes'] != null
            ? base64Decode(json['hdImageBytes'])
            : null,
        imageBytes: json['imageBytes'] != null
            ? base64Decode(json['imageBytes'])
            : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['copyright'] = copyright;
    data['date'] = date.toApiFormat();
    data['explanation'] = explanation;
    data['hdurl'] = hdurl;
    data['media_type'] = mediaType;
    data['title'] = title;
    data['url'] = url;
    if (hdImageBytes != null) {
      data['hdImageBytes'] =
          hdImageBytes != null ? base64Encode(hdImageBytes!) : null;
    }
    if (imageBytes != null) {
      data['imageBytes'] =
          imageBytes != null ? base64Encode(imageBytes!) : null;
    }
    return data;
  }

  copyWithBytes(
    List<int> downloadedImageBytes,
    List<int>? downloadedHdImageBytes,
  ) =>
      ImmersiveDto(
        copyright: copyright,
        date: date,
        explanation: explanation,
        mediaType: mediaType,
        title: title,
        url: url,
        hdurl: hdurl,
        hdImageBytes: downloadedHdImageBytes,
        imageBytes: downloadedImageBytes,
      );
}
