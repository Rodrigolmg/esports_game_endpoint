part of usecase;

class GetLineupsUseCase implements UseCase<Map<String, List<LineupEntity>>, int?> {

  final LineupRepository repository;

  const GetLineupsUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, Map<String, List<LineupEntity>>>> call([int? gameId]) {
    return repository.getLineups(gameId);
  }


}