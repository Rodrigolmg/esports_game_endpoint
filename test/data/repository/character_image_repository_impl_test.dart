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
  MockSpec<CharacterImageDataSource>(),
  MockSpec<NetworkInfo>()
])
import 'character_image_repository_impl_test.mocks.dart';

void main(){
  late CharacterImageRepositoryImpl repositoryImpl;
  late MockCharacterImageDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockCharacterImageDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = CharacterImageRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  const int tCharacterId = 1;

  Uint8List bytes = base64Decode('imageUhutJioLSLK');

  test('Should check if the device is online', () async {
    when(mockNetworkInfo.isConnected)
        .thenAnswer((_) async => true);

    repositoryImpl.getCharacterImage(tCharacterId);
    verify(mockNetworkInfo.isConnected);

  });

  group('Device is online', () {
    setUp((){
      when(mockNetworkInfo.isConnected)
          .thenAnswer((_) async => true);
    });

    test('Should return remote data when the remote call is successfull', () async {

      when(mockRemoteDataSource.getCharacterImage(any))
          .thenAnswer((_) async => bytes);

      final result = await repositoryImpl.getCharacterImage(tCharacterId);

      verify(mockRemoteDataSource.getCharacterImage(tCharacterId));
      expect(result, equals(Right(bytes)));

    });

    test('Should return server failure when remote call is unsuccessfull', () async {

      when(mockRemoteDataSource.getCharacterImage(any))
          .thenThrow(ServerException());

      final result = await repositoryImpl.getCharacterImage(tCharacterId);

      verify(mockRemoteDataSource.getCharacterImage(tCharacterId));
      expect(result, equals(const Left(ServerFailure())));
    });
  });
}