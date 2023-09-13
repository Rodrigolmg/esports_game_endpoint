part of repository_contract;

abstract class CharacterImageRepository {
  Future<Either<Failure, Uint8List>> getCharacterImage(int? characterId);
}