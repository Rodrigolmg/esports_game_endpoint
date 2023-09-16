part of datasource;

abstract class GameRoundLocalDataSource {
  Future<GameRoundEntity> getLastGameRounds();
  Future<void> cacheGameRounds(GameRoundEntity gameRound);
}