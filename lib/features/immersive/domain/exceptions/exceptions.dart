sealed class CustomException implements Exception {}

class ServerException implements CustomException {}

class LocalStorageReadException implements CustomException {}

class LocalStorageWriteException implements CustomException {}

class NoRemoteDataException implements CustomException {}

class NoLocalDataException implements CustomException {}

class ImageDownloadException implements CustomException {}
