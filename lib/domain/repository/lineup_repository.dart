part of repository_contract;

abstract class LineupRepository {
  Future<Either<Failure, Map<String, List<LineupEntity>>>>
    getLineups(int? gameId);
}