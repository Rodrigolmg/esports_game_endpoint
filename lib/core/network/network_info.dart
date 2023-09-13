part of core;

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {

  final InternetConnectionChecker internetConnectionChecker;

  const NetworkInfoImpl(
    this.internetConnectionChecker,
  );

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;


}