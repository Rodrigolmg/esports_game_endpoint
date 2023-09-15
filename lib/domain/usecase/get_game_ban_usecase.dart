import 'package:dartz/dartz.dart';
import 'package:esports_game_endpoint/core/core.dart';
import 'package:esports_game_endpoint/domain/entity/entity.dart';
import 'package:esports_game_endpoint/domain/repository/repository_contract.dart';

class GetGameBanUseCase implements UseCase<Map<String, List<GameBanEntity>>, int?> {

  final GameBanRepository repository;

  const GetGameBanUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, Map<String, List<GameBanEntity>>>> call([int? gameId]) {
    return repository.getGameBans(gameId);
  }


}