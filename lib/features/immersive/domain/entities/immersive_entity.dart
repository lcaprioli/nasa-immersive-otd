class ImmersiveEntity {
  ImmersiveEntity({
    required this.copyright,
    required this.date,
    required this.explanation,
    required this.mediaType,
    required this.title,
    required this.url,
    this.hdurl,
    this.hdImageBytes,
    this.imageBytes,
  });

  final String copyright;
  final DateTime date;
  final String explanation;
  final String? hdurl;
  final List<int>? hdImageBytes;
  final String mediaType;
  final String title;
  final String url;
  final List<int>? imageBytes;

  copyWithBytes(
    List<int> downloadedImageBytes,
    List<int> downloadedHdImageBytes,
  ) =>
      ImmersiveEntity(
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

  @override
  String toString() {
    return 'ImmersiveEntity{copyright=$copyright, date=$date, explanation=$explanation, hdurl=$hdurl, hdImageBytes=$hdImageBytes, mediaType=$mediaType, title=$title, url=$url, imageBytes=$imageBytes}';
  }
}
