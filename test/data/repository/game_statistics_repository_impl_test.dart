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
  MockSpec<GameStatisticsDataSource>(),
  MockSpec<GameStatisticsLocalDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'game_statistics_repository_impl_test.mocks.dart';

void main() {

  late GameStatisticsRepositoryImpl repositoryImpl;
  late MockGameStatisticsDataSource mockRemoteDataSource;
  late MockGameStatisticsLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockGameStatisticsDataSource();
    mockLocalDataSource = MockGameStatisticsLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = GameStatisticsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  const int tGameId = 1;

  Map<String, GameStatisticsEntity> gameStatistics = {
    'awayStatistics': GameStatisticsModel(),
    'homeStatistics': GameStatisticsModel(),
  };

  test('Should check if the device is online', () async {
    when(mockNetworkInfo.isConnected)
        .thenAnswer((_) async => true);

    repositoryImpl.getGameStatistics(tGameId);
    verify(mockNetworkInfo.isConnected);

  });

  group('Device is online', () {
    setUp((){
      when(mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
    });

    test('Should return remote data when the remote call is successfull', () async {

      when(mockRemoteDataSource.getGameStatistics(any))
          .thenAnswer((_) async => gameStatistics);

      final result = await repositoryImpl.getGameStatistics(tGameId);

      verify(mockRemoteDataSource.getGameStatistics(tGameId));
      expect(result, equals(Right(gameStatistics)));

    });

    test('Should cache data locally when the remote call is successfull', () async {

      when(mockRemoteDataSource.getGameStatistics(any))
          .thenAnswer((_) async => gameStatistics);

      await repositoryImpl.getGameStatistics(tGameId);

      verify(mockRemoteDataSource.getGameStatistics(tGameId));
      verify(mockLocalDataSource.cacheGameStatistics(gameStatistics));

    });

    test('Should return server failure when remote call is unsuccessfull', () async {

      when(mockRemoteDataSource.getGameStatistics(any))
          .thenThrow(ServerException());

      final result = await repositoryImpl.getGameStatistics(tGameId);

      verify(mockRemoteDataSource.getGameStatistics(tGameId));
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
          when(mockLocalDataSource.getLastGameStatistics())
              .thenAnswer((_) async => gameStatistics);

          final result = await repositoryImpl.getGameStatistics(tGameId);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastGameStatistics());
          expect(result, equals(Right(gameStatistics)));
        });

    test('Should return CacheFailure when there is no cached data',
            () async {
          when(mockLocalDataSource.getLastGameStatistics())
              .thenThrow(CacheException());

          final result = await repositoryImpl.getGameStatistics(tGameId);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastGameStatistics());
          expect(result, equals(Left(CacheFailure())));
        });
  });
}