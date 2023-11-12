import 'package:equatable/equatable.dart';

class ImmersiveEntity extends Equatable {
  const ImmersiveEntity({
    required this.date,
    required this.explanation,
    required this.mediaType,
    required this.title,
    required this.url,
    this.copyright,
    this.hdurl,
    this.hdImageBytes,
    this.imageBytes,
  });

  final DateTime date;
  final String explanation;
  final String mediaType;
  final String title;
  final String url;
  final String? copyright;
  final String? hdurl;
  final List<int>? hdImageBytes;
  final List<int>? imageBytes;

  @override
  String toString() {
    return 'ImmersiveEntity{copyright=$copyright, date=$date, explanation=$explanation, hdurl=$hdurl, hdImageBytes=$hdImageBytes, mediaType=$mediaType, title=$title, url=$url, imageBytes=$imageBytes}';
  }

  @override
  List<Object?> get props => [
        date,
        explanation,
        mediaType,
        title,
        url,
        copyright,
        hdurl,
      ];
}
