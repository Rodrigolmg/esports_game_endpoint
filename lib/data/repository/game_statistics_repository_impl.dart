part of repository;

class GameStatisticsRepositoryImpl implements GameStatisticsRepository {

  final GameStatisticsDataSource remoteDataSource;
  final GameStatisticsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const GameStatisticsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Map<String, GameStatisticsEntity>>> getGameStatistics(int? gameId) async {
    if(await networkInfo.isConnected){
      try {
        Map<String, GameStatisticsEntity> gameStatistics =
          await remoteDataSource.getGameStatistics(gameId);
        localDataSource.cacheGameStatistics(gameStatistics);

        return Right(gameStatistics);

      } on ServerException catch(sE) {
        return Left(ServerFailure(statusCode: sE.statusCode));
      }
    }else {
      try {
        Map<String, GameStatisticsEntity> lastGameStatistics =
        await localDataSource.getLastGameStatistics();
        return Right(lastGameStatistics);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}