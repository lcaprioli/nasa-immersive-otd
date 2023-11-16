import 'package:equatable/equatable.dart';

class ImmersiveEntity extends Equatable {
  const ImmersiveEntity({
    required this.date,
    required this.explanation,
    required this.title,
    required this.url,
    required this.imageBytes,
  });

  final DateTime date;
  final String explanation;
  final String title;
  final String url;
  final List<int> imageBytes;

  @override
  String toString() {
    return 'ImmersiveEntity{date=$date, explanation=$explanation, title=$title, url=$url, imageBytes=$imageBytes}';
  }

  @override
  List<Object?> get props => [
        date,
        explanation,
        title,
        url,
      ];
}
