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
  Future<Map<String, List<LineupEntity>>> getLineups(int? gameId) {
    // TODO: implement getLineups
    throw UnimplementedError();
  }
}