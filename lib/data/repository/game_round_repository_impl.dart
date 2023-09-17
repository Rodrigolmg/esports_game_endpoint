part of repository;

class GameRoundRepositoryImpl implements GameRoundRepository {

  final GameRoundDataSource remoteDatasource;
  final GameRoundLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const GameRoundRepositoryImpl({
    required this.remoteDatasource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, GameRoundEntity>> getGameRounds(int? gameId) async {
    await networkInfo.isConnected;
    return Future.value(Right(GameRoundModel()));
  }
}