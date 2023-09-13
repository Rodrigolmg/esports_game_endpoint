part of repository_contract;

abstract class LineupRepository {
  Future<Either<Failure, Map<String, List<LineUpEntity>>>>
    getLineups(int? gameId);
}