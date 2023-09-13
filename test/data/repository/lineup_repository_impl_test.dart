import 'package:dartz/dartz.dart';
import 'package:esports_game_endpoint/core/core.dart';
import 'package:esports_game_endpoint/data/datasource/datasource.dart';
import 'package:esports_game_endpoint/data/model/model.dart';
import 'package:esports_game_endpoint/data/repository/repository.dart';
import 'package:esports_game_endpoint/domain/entity/entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<LineupDataSource>(),
  MockSpec<LineupLocalDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'lineup_repository_impl_test.mocks.dart';

void main() {

  late LineupRepositoryImpl repositoryImpl;
  late MockLineupDataSource mockRemoteDataSource;
  late MockLineupLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockLineupDataSource();
    mockLocalDataSource = MockLineupLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = LineupRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  const int tGameId = 1;

  Map<String, List<LineupEntity>> lineups = {
    'awayTeamPlayers': [
      LineupModel(kills: 5),
      LineupModel(kills: 15),
    ],
    'homeTeamPlayers': [
      LineupModel(kills: 22),
      LineupModel(kills: 18),
    ]
  };

  test('Should check if the device is online', () async {
    when(mockNetworkInfo.isConnected)
        .thenAnswer((_) async => true);

    repositoryImpl.getLineups(tGameId);
    verify(mockNetworkInfo.isConnected);

  });

  group('Device is online', () {
    setUp((){
      when(mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
    });

    test('Should return remote data when the remote call is successfull', () async {

      when(mockRemoteDataSource.getLineups(any))
          .thenAnswer((_) async => lineups);

      final result = await repositoryImpl.getLineups(tGameId);

      verify(mockRemoteDataSource.getLineups(tGameId));
      expect(result, equals(Right(lineups)));

    });

    test('Should cache data locally when the remote call is successfull', () async {

      when(mockRemoteDataSource.getLineups(any))
          .thenAnswer((_) async => lineups);

      await repositoryImpl.getLineups(tGameId);

      verify(mockRemoteDataSource.getLineups(tGameId));
      verify(mockLocalDataSource.cacheLineups(lineups));

    });

    test('Should return server failure when remote call is unsuccessfull', () async {

      when(mockRemoteDataSource.getLineups(any))
          .thenThrow(ServerException());

      final result = await repositoryImpl.getLineups(tGameId);

      verify(mockRemoteDataSource.getLineups(tGameId));
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(const Left(ServerFailure())));
    });
  });

  group('Device is offline', () {
    setUp((){
      when(mockNetworkInfo.isConnected)
          .thenAnswer((_) async => false);
    });

    test('Should return last locally cached data when the cached data is present',
            () async {
          when(mockLocalDataSource.getLastLineup())
              .thenAnswer((_) async => lineups);

          final result = await repositoryImpl.getLineups(tGameId);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastLineup());
          expect(result, equals(Right(lineups)));
        });

    test('Should return CacheFailure when there is no cached data',
            () async {
          when(mockLocalDataSource.getLastLineup())
              .thenThrow(CacheException());

          final result = await repositoryImpl.getLineups(tGameId);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastLineup());
          expect(result, equals(Left(CacheFailure())));
        });
  });

}
