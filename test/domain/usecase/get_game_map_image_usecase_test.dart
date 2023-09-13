import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:esports_game_endpoint/domain/repository/repository_contract.dart';
import 'package:esports_game_endpoint/domain/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<GameMapImageRepository>()])
import 'get_game_map_image_usecase_test.mocks.dart';

void main(){

  late GetGameMapImageUseCase useCase;
  late MockGameMapImageRepository mockRepository;

  setUp(() {
    mockRepository = MockGameMapImageRepository();
    useCase = GetGameMapImageUseCase(repository: mockRepository);
  });

  const int tMapId = 1;

  Uint8List bytes = base64Decode('imageUhutJioLSLK');

  test('Should get Right value', () async {

    when(mockRepository.getMapImage(any))
        .thenAnswer((_) async => Right(bytes));

    final result = await useCase(tMapId);

    expect(result, Right(bytes));
    verify(mockRepository.getMapImage(tMapId));
    verifyNoMoreInteractions(mockRepository);
  });
}