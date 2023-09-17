part of datasource;

abstract class GameRoundLocalDataSource {
  Future<GameRoundEntity> getLastGameRounds();
  Future<void> cacheGameRounds(GameRoundEntity gameRound);
}

class GameRoundLocalDataSourceImpl implements GameRoundLocalDataSource {
  @override
  Future<void> cacheGameRounds(GameRoundEntity gameRound) async {
    Box gameRoundsBox = Hive.box(DataSourceBoxName.gameRoundsBoxName);

    if(!gameRoundsBox.isOpen){
      gameRoundsBox = await Hive.openBox(DataSourceBoxName.gameRoundsBoxName);
    }

    gameRoundsBox.add(gameRound);
  }

  @override
  Future<GameRoundEntity> getLastGameRounds() async {
    Box gameRoundsBox = Hive.box(DataSourceBoxName.gameRoundsBoxName);

    if(!gameRoundsBox.isOpen){
      gameRoundsBox = await Hive.openBox(DataSourceBoxName.gameRoundsBoxName);
    }

    int lastBoxIndex = gameRoundsBox.length - 1;
    GameRoundEntity lastGameRounds = gameRoundsBox.getAt(lastBoxIndex);
    return lastGameRounds;
  }

}