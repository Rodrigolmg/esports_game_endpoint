import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:esports_game_endpoint/core/core.dart';
import 'package:esports_game_endpoint/data/datasource/datasource.dart';
import 'package:esports_game_endpoint/data/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<GameMapImageDataSource>(),
  MockSpec<NetworkInfo>()
])
import 'game_map_image_repository_impl_test.mocks.dart';

void main(){

  late GameMapImageRepositoryImpl repositoryImpl;
  late MockGameMapImageDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockGameMapImageDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = GameMapImageRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  const int tMapId = 1;

  Uint8List bytes = base64Decode('imageUhutJioLSLK');

  test('Should check if the device is online', () async {
    when(mockNetworkInfo.isConnected)
        .thenAnswer((_) async => true);

    repositoryImpl.getMapImage(tMapId);
    verify(mockNetworkInfo.isConnected);

  });

  group('Device is online', () {
    setUp((){
      when(mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
    });

    test('Should return remote data when the remote call is successfull', () async {

      when(mockRemoteDataSource.getGameMapImage(any))
          .thenAnswer((_) async => bytes);

      final result = await repositoryImpl.getMapImage(tMapId);

      verify(mockRemoteDataSource.getGameMapImage(tMapId));
      expect(result, equals(Right(bytes)));

    });

    test('Should return server failure when remote call is unsuccessfull', () async {

      when(mockRemoteDataSource.getGameMapImage(any))
          .thenThrow(ServerException());

      final result = await repositoryImpl.getMapImage(tMapId);

      verify(mockRemoteDataSource.getGameMapImage(tMapId));
      expect(result, equals(const Left(ServerFailure())));
    });
  });
}