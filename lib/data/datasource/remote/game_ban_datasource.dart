part of datasource;

abstract class GameBanDataSource {
  Future<Map<String, List<GameBanEntity>>> getGameBans(int? gameId);
}