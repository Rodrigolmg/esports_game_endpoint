part of repository_contract;

abstract class GameBanRepository {
  Future<Either<Failure, Map<String, List<GameBanEntity>>>> getGameBans(int? gameId);
}