part of repository;

class GameBanRepositoryImpl implements GameBanRepository {

  final GameBanDataSource remoteDataSource;
  final GameBanLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const GameBanRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Map<String, List<GameBanEntity>>>> getGameBans(int? gameId) async {
    if(await networkInfo.isConnected){
      try {
        Map<String, List<GameBanEntity>> gameBans =
        await remoteDataSource.getGameBans(gameId);
        localDataSource.cacheGameBans(gameBans);

        return Right(gameBans);

      } on ServerException catch(sE) {
        return Left(ServerFailure(statusCode: sE.statusCode));
      }
    } else {
      try {
        Map<String, List<GameBanEntity>> lastGameBans =
        await localDataSource.getLastGameBans();
        return Right(lastGameBans);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}