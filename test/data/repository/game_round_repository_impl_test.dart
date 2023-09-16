import 'package:dartz/dartz.dart';
import 'package:esports_game_endpoint/core/core.dart';
import 'package:esports_game_endpoint/data/datasource/datasource.dart';
import 'package:esports_game_endpoint/data/model/model.dart';
import 'package:esports_game_endpoint/data/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<GameRoundDataSource>(),
  MockSpec<GameRoundLocalDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'game_round_repository_impl_test.mocks.dart';

void main(){

  late MockGameRoundDataSource mockRemoteDataSource;
  late MockGameRoundLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late GameRoundRepositoryImpl repositoryImpl;

  setUp(() {
    mockRemoteDataSource = MockGameRoundDataSource();
    mockLocalDataSource = MockGameRoundLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = GameRoundRepositoryImpl(
      remoteDatasource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  const int tGameId = 1;
  GameRoundModel gameRound = GameRoundModel(
      roundsInAHalf: 5
  );

  test('Should check if the device is online', () async {
    when(mockNetworkInfo.isConnected)
        .thenAnswer((_) async => true);

    repositoryImpl.getGameRounds(tGameId);
    verify(mockNetworkInfo.isConnected);

  });

  group('', () {

  });
}