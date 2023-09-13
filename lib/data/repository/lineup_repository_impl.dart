part of repository;

class LineupRepositoryImpl implements LineupRepository {

  final LineupDataSource remoteDataSource;
  final LineupLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const LineupRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Map<String, List<LineupEntity>>>> getLineups(int? gameId) async {
    if(await networkInfo.isConnected){
      try {
        Map<String, List<LineupEntity>> lineups =
        await remoteDataSource.getLineups(gameId);
        localDataSource.cacheLineups(lineups);

        return Right(lineups);

      } on ServerException catch(sE) {
        return Left(ServerFailure(statusCode: sE.statusCode));
      }
    } else {
      try {
        Map<String, List<LineupEntity>> lastLineups =
          await localDataSource.getLastLineup();
        return Right(lastLineups);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}