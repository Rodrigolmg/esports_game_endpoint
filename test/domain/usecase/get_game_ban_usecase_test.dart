import 'package:dartz/dartz.dart';
import 'package:esports_game_endpoint/domain/entity/entity.dart';
import 'package:esports_game_endpoint/domain/repository/repository_contract.dart';
import 'package:esports_game_endpoint/domain/usecase/get_game_ban_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<GameBanRepository>()])
import 'get_game_ban_usecase_test.mocks.dart';

void main() {

  late GetGameBanUseCase useCase;
  late MockGameBanRepository mockRepository;

  setUp(() {
    mockRepository = MockGameBanRepository();
    useCase = GetGameBanUseCase(repository: mockRepository);
  });

  const int tGameId = 1;

  Map<String, List<GameBanEntity>> gameBans = {
    'awayTeamBans': [
      GameBanEntity(id: 1),
      GameBanEntity(id: 3),
    ],
    'homeTeamBans': [
      GameBanEntity(id: 4),
      GameBanEntity(id: 6),
    ],
  };

  test('Should get Right value', () async {

    when(mockRepository.getGameBans(any))
        .thenAnswer((_) async => Right(gameBans));

    final result = await useCase(tGameId);

    expect(result, Right(gameBans));
    verify(mockRepository.getGameBans(tGameId));
    verifyNoMoreInteractions(mockRepository);
  });

}