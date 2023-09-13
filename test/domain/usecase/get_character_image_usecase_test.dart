import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:esports_game_endpoint/domain/repository/repository_contract.dart';
import 'package:esports_game_endpoint/domain/usecase/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<CharacterImageRepository>()])
import 'get_character_image_usecase_test.mocks.dart';

void main(){

  late GetCharacterImageUseCase useCase;
  late MockCharacterImageRepository mockRepository;

  setUp(() {
    mockRepository = MockCharacterImageRepository();
    useCase = GetCharacterImageUseCase(repository: mockRepository);
  });

  const int tCharacterId = 1;

  Uint8List bytes = base64Decode('imageKLojHuyTTrF');

  test('Should get Right value', () async {

    when(mockRepository.getCharacterImage(any))
        .thenAnswer((_) async => Right(bytes));

    final result = await useCase(tCharacterId);

    expect(result, Right(bytes));
    verify(mockRepository.getCharacterImage(tCharacterId));
    verifyNoMoreInteractions(mockRepository);
  });
}