import 'package:dartz/dartz.dart';
import 'package:esports_game_endpoint/domain/entity/entity.dart';
import 'package:esports_game_endpoint/domain/repository/repository_contract.dart';
import 'package:esports_game_endpoint/domain/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<LineupRepository>()])
import 'get_lineups_usecase_test.mocks.dart';

void main(){

  late GetLineupsUseCase useCase;
  late MockLineupRepository mockRepository;

  setUp((){
    mockRepository = MockLineupRepository();
    useCase = GetLineupsUseCase(repository: mockRepository);
  });

  const int tGameId = 1;

  Map<String, List<LineupEntity>> lineups = {
    'awayTeamPlayers': [
      LineupEntity(kills: 5),
      LineupEntity(kills: 15),
    ],
    'homeTeamPlayers': [
      LineupEntity(kills: 22),
      LineupEntity(kills: 18),
    ]
  };

  test('Should get Right value', () async {

    when(mockRepository.getLineups(any))
        .thenAnswer((_) async => Right(lineups));

    final result = await useCase(tGameId);

    expect(result, Right(lineups));
    verify(mockRepository.getLineups(tGameId));
    verifyNoMoreInteractions(mockRepository);
  });
}