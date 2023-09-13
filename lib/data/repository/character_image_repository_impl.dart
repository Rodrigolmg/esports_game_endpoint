part of repository;

class CharacterImageRepositoryImpl implements CharacterImageRepository {

  final CharacterImageDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const CharacterImageRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Uint8List>> getCharacterImage(int? characterId) async {
    if(await networkInfo.isConnected){
      try {
        Uint8List bytes = await remoteDataSource.getCharacterImage(characterId);
        return Right(bytes);

      } on ServerException catch (sE) {
        return Left(ServerFailure(statusCode: sE.statusCode));
      }
    } else {
      return const Left(ServerFailure(statusCode: 204));
    }
  }

}