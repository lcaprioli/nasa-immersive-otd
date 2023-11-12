import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionCheckService {
  ConnectionCheckService(InternetConnectionChecker internetConnectionChecker)
      : _internetConnectionChecker = internetConnectionChecker;

  final InternetConnectionChecker _internetConnectionChecker;

  Future<bool> get connected async =>
      await _internetConnectionChecker.hasConnection;
}
