part of datasource;

abstract class CharacterImageDataSource {
  Future<Uint8List> getCharacterImage(int? characterId);
}

class CharacterImageDataSourceImpl implements CharacterImageDataSource {

  final DioMethod dio;

  const CharacterImageDataSourceImpl({
    required this.dio,
  });

  @override
  Future<Uint8List> getCharacterImage(int? characterId) async {
    Response response = await dio.getMethod(UrlPath.characterImagePath(characterId));
    if(response.statusCode != null && response.statusCode == 200){
      if((response.data as String).isEmpty){
        throw ServerException(statusCode: 204);
      }

      Uint8List bytes = ImageHandler.convertBase64(response.data);
      return Future.value(bytes);
    } else {
      throw ServerException(statusCode: response.statusCode);
    }
  }
}