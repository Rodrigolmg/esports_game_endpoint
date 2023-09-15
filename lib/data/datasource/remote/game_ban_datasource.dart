part of datasource;

abstract class GameBanDataSource {
  Future<Map<String, List<GameBanEntity>>> getGameBans(int? gameId);
}

class GameBanDataSourceImpl implements GameBanDataSource {

  final DioMethod dio;

  const GameBanDataSourceImpl({
    required this.dio,
  });

  @override
  Future<Map<String, List<GameBanEntity>>> getGameBans(int? gameId) async {
    Response response = await dio.getMethod(UrlPath.gameBansPath(gameId));

    if(response.statusCode != null && response.statusCode == 200) {
      if((response.data as Map<String, dynamic>).isEmpty){
        throw ServerException(statusCode: 204);
      }

      List<GameBanModel> awayTeamBans = [];
      List<GameBanModel> homeTeamBans = [];

      for (var awayBan in response.data['awayTeamBans']) {
        awayTeamBans.add(GameBanModel.fromJson(awayBan));
      }

      for (var homeBan in response.data['homeTeamBans']) {
        homeTeamBans.add(GameBanModel.fromJson(homeBan));
      }

      return Future.value({
        'awayTeamBans': awayTeamBans,
        'homeTeamBans': homeTeamBans
      });

    } else {
      throw ServerException(statusCode: response.statusCode);
    }
  }
}