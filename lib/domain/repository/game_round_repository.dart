part of repository_contract;

abstract class GameRoundRepository {
  Future<Either<Failure, GameRoundEntity>> getGameRounds(int? gameId);
}