part of datasource;

abstract class GameRoundDataSource {
  Future<GameRoundEntity> getGameRounds(int? gameId);
}

class GameRoundDataSourceImpl implements GameRoundDataSource {

  final DioMethod dio;

  const GameRoundDataSourceImpl({
    required this.dio,
  });

  @override
  Future<GameRoundEntity> getGameRounds(int? gameId) async {
    Response response = await dio.getMethod(UrlPath.gameRoundsPath(gameId));

    if(response.statusCode != null && response.statusCode == 200) {
      if((response.data as Map<String, dynamic>).isEmpty){
        throw ServerException(statusCode: 204);
      }

      GameRoundModel gameRound = GameRoundModel.fromJson(response.data);

      return Future.value(gameRound);

    } else {
      throw ServerException(statusCode: response.statusCode);
    }
  }
}