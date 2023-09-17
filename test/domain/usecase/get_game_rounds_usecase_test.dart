import 'package:dartz/dartz.dart';
import 'package:esports_game_endpoint/domain/entity/entity.dart';
import 'package:esports_game_endpoint/domain/repository/repository_contract.dart';
import 'package:esports_game_endpoint/domain/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<GameRoundRepository>()])
import 'get_game_rounds_usecase_test.mocks.dart';

void main(){
  late GetGameRoundUseCase useCase;
  late MockGameRoundRepository mockRepository;

  setUp(() {
    mockRepository = MockGameRoundRepository();
    useCase = GetGameRoundUseCase(repository: mockRepository);
  });

  const int tGameId = 1;
  GameRoundEntity gameRound = GameRoundEntity(
    roundsInAHalf: 5
  );

  test('Should get Right value', () async {

    when(mockRepository.getGameRounds(any))
        .thenAnswer((_) async => Right(gameRound));

    final result = await useCase(tGameId);

    expect(result, Right(gameRound));
    verify(mockRepository.getGameRounds(tGameId));
    verifyNoMoreInteractions(mockRepository);
  });
}