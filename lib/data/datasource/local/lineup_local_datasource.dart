part of datasource;

abstract class LineupLocalDataSource {
  Future<Map<String, List<LineupEntity>>> getLastLineup();
  Future<void> cacheLineups(Map<String, List<LineupEntity>> lineups);
}

class LineupLocalDataSourceImpl implements LineupLocalDataSource {
  @override
  Future<void> cacheLineups(Map<String, List<LineupEntity>> lineups) {
    // TODO: implement cacheLineups
    throw UnimplementedError();
  }

  @override
  Future<Map<String, List<LineupEntity>>> getLastLineup() {
    // TODO: implement getLastLineup
    throw UnimplementedError();
  }

}