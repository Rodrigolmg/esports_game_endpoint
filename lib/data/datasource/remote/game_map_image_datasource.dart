part of datasource;

abstract class GameMapImageDataSource {
  Future<Uint8List> getGameMapImage(int? mapId);
}

class GameMapImageDataSourceImpl implements GameMapImageDataSource {

  final DioMethod dio;

  const GameMapImageDataSourceImpl({
    required this.dio,
  });

  @override
  Future<Uint8List> getGameMapImage(int? mapId) async {
    Response response = await dio.getMethod(UrlPath.lineUpsPath(mapId));
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