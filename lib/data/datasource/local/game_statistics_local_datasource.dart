part of datasource;

abstract class GameStatisticsLocalDataSource {
  Future<Map<String, GameStatisticsEntity>> getLastGameStatistics();
  Future<void> cacheGameStatistics(Map<String, GameStatisticsEntity> gameStatistics);
}

class GameStatisticsLocalDataSourceImpl implements GameStatisticsLocalDataSource {
  @override
  Future<void> cacheGameStatistics(Map<String, GameStatisticsEntity> gameStatistics) async {
    Box gameStatisticsBox = Hive.box(DataSourceBoxName.gameStatisticsBoxName);

    if(!gameStatisticsBox.isOpen){
      gameStatisticsBox = await Hive.openBox(DataSourceBoxName.gameStatisticsBoxName);
    }

    gameStatisticsBox.add(gameStatistics);
  }

  @override
  Future<Map<String, GameStatisticsEntity>> getLastGameStatistics() async {
    Box gameStatisticsBox = Hive.box(DataSourceBoxName.gameStatisticsBoxName);

    if(!gameStatisticsBox.isOpen){
      gameStatisticsBox = await Hive.openBox(DataSourceBoxName.gameStatisticsBoxName);
    }

    int lastBoxIndex = gameStatisticsBox.length - 1;
    Map<String, GameStatisticsEntity> lastGameStatistics = gameStatisticsBox.getAt(lastBoxIndex);
    return lastGameStatistics;
  }

}