part of datasource;

abstract class LineupDataSource {
  Future<Map<String, List<LineupEntity>>> getLineups(int? gameId);
}

class LineupDataSourceImpl implements LineupDataSource {

  final DioMethod dio;

  const LineupDataSourceImpl({
    required this.dio,
  });

  @override
  Future<Map<String, List<LineupEntity>>> getLineups(int? gameId) async {
    Response response = await dio.getMethod(UrlPath.lineUpsPath(gameId));

    if(response.statusCode != null && response.statusCode == 200) {
      if((response.data as Map<String, dynamic>).isEmpty){
        throw ServerException(statusCode: 204);
      }

      List<LineupModel> awayTeamPlayers = [];
      List<LineupModel> homeTeamPlayers = [];

      for (var lineupAway in response.data['awayTeamPlayers'] as List<dynamic>) {
        awayTeamPlayers.add(LineupModel.fromJson(lineupAway));
      }

      for (var lineupHome in response.data['homeTeamPlayers'] as List<dynamic>) {
        homeTeamPlayers.add(LineupModel.fromJson(lineupHome));
      }

      return Future.value({
        'awayTeamPlayers': awayTeamPlayers,
        'homeTeamPlayers': homeTeamPlayers
      });

    } else {
      throw ServerException(statusCode: response.statusCode);
    }
  }
}