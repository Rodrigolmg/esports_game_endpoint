part of datasource;

abstract class CharacterImageDataSource {
  Future<Uint8List> getCharacterImage(int? characterId);
}