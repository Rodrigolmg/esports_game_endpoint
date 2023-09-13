part of repository_contract;

abstract class GameMapImageRepository {
  Future<Either<Failure, Uint8List>> getMapImage(int? mapId);
}