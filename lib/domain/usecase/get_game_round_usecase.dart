part of usecase;

class GetGameRoundUseCase implements UseCase<GameRoundEntity, int?> {

  final GameRoundRepository repository;

  const GetGameRoundUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, GameRoundEntity>> call([int? gameId]) {
    return repository.getGameRounds(gameId);
  }
}