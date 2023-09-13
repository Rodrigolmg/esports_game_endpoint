part of usecase;

class GetGameMapImageUseCase implements UseCase<Uint8List, int?>{

  final GameMapImageRepository repository;

  const GetGameMapImageUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, Uint8List>> call([int? mapId]) {
    return repository.getMapImage(mapId);
  }
}