part of usecase;

class GetGameStatisticsUseCase implements UseCase<Map<String, GameStatisticsEntity>, int?> {
  
  final GameStatisticsRepository repository;

  const GetGameStatisticsUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, Map<String, GameStatisticsEntity>>> call([int? gameId]) {
    return repository.getGameStatistics(gameId);
  }
}