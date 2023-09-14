import 'package:dartz/dartz.dart';
import 'package:esports_game_endpoint/domain/entity/entity.dart';
import 'package:esports_game_endpoint/domain/repository/repository_contract.dart';
import 'package:esports_game_endpoint/domain/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<GameStatisticsRepository>()])
import 'get_game_statistics_usecase_test.mocks.dart';

void main() {

  late GetGameStatisticsUseCase useCase;
  late MockGameStatisticsRepository mockRepository;

  setUp(() {
    mockRepository = MockGameStatisticsRepository();
    useCase = GetGameStatisticsUseCase(repository: mockRepository);
  });

  const int tGameId = 1;

  Map<String, GameStatisticsEntity> gameStatistics = {
    'awayStatistics': GameStatisticsEntity(),
    'homeStatistics': GameStatisticsEntity(),
  };

  test('Should get Right value', () async {

    when(mockRepository.getGameStatistics(any))
        .thenAnswer((_) async => Right(gameStatistics));

    final result = await useCase(tGameId);

    expect(result, Right(gameStatistics));
    verify(mockRepository.getGameStatistics(tGameId));
    verifyNoMoreInteractions(mockRepository);
  });

}