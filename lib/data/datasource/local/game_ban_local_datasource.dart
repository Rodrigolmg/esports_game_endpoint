part of datasource;

abstract class GameBanLocalDataSource {
  Future<Map<String, List<GameBanEntity>>> getLastGameBans();
  Future<void> cacheGameBans(Map<String, List<GameBanEntity>> gameBans);
}

class GameBanLocalDataSourceImpl implements GameBanLocalDataSource {

  @override
  Future<void> cacheGameBans(Map<String, List<GameBanEntity>> gameBans) async {
    Box gameBansBox = Hive.box(DataSourceBoxName.gameBansBoxName);

    if(!gameBansBox.isOpen){
      gameBansBox = await Hive.openBox(DataSourceBoxName.gameBansBoxName);
    }

    gameBansBox.add(gameBans);
  }

  @override
  Future<Map<String, List<GameBanEntity>>> getLastGameBans() async {
    Box gameBansBox = Hive.box(DataSourceBoxName.gameBansBoxName);

    if(!gameBansBox.isOpen){
      gameBansBox = await Hive.openBox(DataSourceBoxName.gameBansBoxName);
    }

    int lastBoxIndex = gameBansBox.length - 1;
    Map<String, List<GameBanEntity>> lastGameBans
      = gameBansBox.getAt(lastBoxIndex);
    return lastGameBans;
  }

}