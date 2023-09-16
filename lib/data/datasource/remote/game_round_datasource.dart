part of datasource;

abstract class GameRoundDataSource {
  Future<GameRoundEntity> getGameRounds(int? gameId);
}