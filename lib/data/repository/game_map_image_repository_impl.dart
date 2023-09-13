part of repository;

class GameMapImageRepositoryImpl implements GameMapImageRepository {

  final GameMapImageDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const GameMapImageRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Uint8List>> getMapImage(int? mapId) async {
    if(await networkInfo.isConnected){
      try {
        Uint8List bytes = await remoteDataSource.getGameMapImage(mapId);
        return Right(bytes);

      } on ServerException catch (sE) {
        return Left(ServerFailure(statusCode: sE.statusCode));
      }
    } else {
      return const Left(ServerFailure(statusCode: 204));
    }
  }
}