import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionCheckService {
  ConnectionCheckService()
      : _instance = InternetConnectionChecker.createInstance();
  final InternetConnectionChecker _instance;
  Future<bool> get connected => _instance.hasConnection;
}
