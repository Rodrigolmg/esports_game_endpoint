part of datasource;

abstract class GameStatisticsDataSource {
  Future<Map<String, GameStatisticsEntity>> getGameStatistics(int? gameId);
}

class GameStatisticsDataSourceImpl implements GameStatisticsDataSource {
  
  final DioMethod dio;

  const GameStatisticsDataSourceImpl({
    required this.dio,
  });

  @override
  Future<Map<String, GameStatisticsEntity>> getGameStatistics(int? gameId) async {
    Response response = await dio.getMethod(UrlPath.gameStatisticsPath(gameId));

    if(response.statusCode != null && response.statusCode == 200) {
      if((response.data as Map<String, dynamic>).isEmpty){
        throw ServerException(statusCode: 204);
      }

      return Future.value({
        'awayStatistics': GameStatisticsModel.fromJson(response.data['awayStatistics']),
        'homeStatistics': GameStatisticsModel.fromJson(response.data['homeStatistics'])
      });

    } else {
      throw ServerException(statusCode: response.statusCode);
    }
  }
}