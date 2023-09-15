part of datasource;

abstract class GameBanLocalDataSource {
  Future<Map<String, List<GameBanEntity>>> getLastGameBans();
  Future<void> cacheGameBans(Map<String, List<GameBanEntity>> gameBans);
}