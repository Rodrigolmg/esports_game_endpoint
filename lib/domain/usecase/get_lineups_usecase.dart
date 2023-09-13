part of usecase;

class GetLineupsUseCase implements UseCase<Map<String, List<LineUpEntity>>, int?> {

  final LineupRepository repository;

  const GetLineupsUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, Map<String, List<LineUpEntity>>>> call([int? gameId]) {
    return repository.getLineups(gameId);
  }


}