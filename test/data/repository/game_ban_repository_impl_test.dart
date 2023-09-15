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
  MockSpec<GameBanDataSource>(),
  MockSpec<GameBanLocalDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'game_ban_repository_impl_test.mocks.dart';

void main(){

  late GameBanRepositoryImpl repositoryImpl;
  late MockGameBanDataSource mockRemoteDataSource;
  late MockGameBanLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockGameBanDataSource();
    mockLocalDataSource = MockGameBanLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = GameBanRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  const int tGameId = 1;

  Map<String, List<GameBanEntity>> gameBans = {
    'awayTeamBans': [
      GameBanModel(id: 1),
      GameBanModel(id: 3),
    ],
    'homeTeamBans': [
      GameBanModel(id: 4),
      GameBanModel(id: 6),
    ],
  };

  test('Should check if the device is online', () async {
    when(mockNetworkInfo.isConnected)
        .thenAnswer((_) async => true);

    repositoryImpl.getGameBans(tGameId);
    verify(mockNetworkInfo.isConnected);

  });

  group('Device is online', () {
    setUp((){
      when(mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
    });

    test('Should return remote data when the remote call is successfull', () async {

      when(mockRemoteDataSource.getGameBans(any))
          .thenAnswer((_) async => gameBans);

      final result = await repositoryImpl.getGameBans(tGameId);

      verify(mockRemoteDataSource.getGameBans(tGameId));
      expect(result, equals(Right(gameBans)));

    });

    test('Should cache data locally when the remote call is successfull', () async {

      when(mockRemoteDataSource.getGameBans(any))
          .thenAnswer((_) async => gameBans);

      await repositoryImpl.getGameBans(tGameId);

      verify(mockRemoteDataSource.getGameBans(tGameId));
      verify(mockLocalDataSource.cacheGameBans(gameBans));

    });

    test('Should return server failure when remote call is unsuccessfull', () async {

      when(mockRemoteDataSource.getGameBans(any))
          .thenThrow(ServerException());

      final result = await repositoryImpl.getGameBans(tGameId);

      verify(mockRemoteDataSource.getGameBans(tGameId));
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
          when(mockLocalDataSource.getLastGameBans())
              .thenAnswer((_) async => gameBans);

          final result = await repositoryImpl.getGameBans(tGameId);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastGameBans());
          expect(result, equals(Right(gameBans)));
        });

    test('Should return CacheFailure when there is no cached data',
            () async {
          when(mockLocalDataSource.getLastGameBans())
              .thenThrow(CacheException());

          final result = await repositoryImpl.getGameBans(tGameId);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastGameBans());
          expect(result, equals(Left(CacheFailure())));
        });
  });

}