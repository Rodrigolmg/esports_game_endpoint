part of repository_contract;

abstract class GameStatisticsRepository {
  Future<Either<Failure, Map<String, GameStatisticsEntity>>> getGameStatistics(int? gameId);
}