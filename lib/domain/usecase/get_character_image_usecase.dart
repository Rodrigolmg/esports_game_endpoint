part of usecase;

class GetCharacterImageUseCase implements UseCase<Uint8List, int?> {

  final CharacterImageRepository repository;

  const GetCharacterImageUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, Uint8List>> call([int? characterId]) {
    return repository.getCharacterImage(characterId);
  }
}