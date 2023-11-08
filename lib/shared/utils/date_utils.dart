extension DateUtils on DateTime {
  String toApiFormat() =>
      '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
}
