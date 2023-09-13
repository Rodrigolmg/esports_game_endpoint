part of datasource;

abstract class LineupLocalDataSource {
  Future<Map<String, List<LineupEntity>>> getLastLineup();
  Future<void> cacheLineups(Map<String, List<LineupEntity>> lineups);
}

class LineupLocalDataSourceImpl implements LineupLocalDataSource {
  @override
  Future<void> cacheLineups(Map<String, List<LineupEntity>> lineups) async {
    Box lineUpBox = Hive.box(DataSourceBoxName.lineupBoxName);

    if(!lineUpBox.isOpen){
      lineUpBox = await Hive.openBox(DataSourceBoxName.lineupBoxName);
    }

    lineUpBox.add(lineups);
  }

  @override
  Future<Map<String, List<LineupEntity>>> getLastLineup() async {
    Box lineUpBox = Hive.box(DataSourceBoxName.lineupBoxName);

    if(!lineUpBox.isOpen){
      lineUpBox = await Hive.openBox(DataSourceBoxName.lineupBoxName);
    }

    int lastBoxIndex = lineUpBox.length - 1;
    Map<String, List<LineupEntity>> lastLineUp = lineUpBox.getAt(lastBoxIndex);
    return lastLineUp;
  }

}