import 'dart:convert';

import 'package:esports_game_endpoint/data/model/model.dart';
import 'package:esports_game_endpoint/domain/entity/entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../fixtures/json_file_name.dart';

void main(){
  GameRoundModel gameRoundModel = GameRoundModel();

  test('Should be a subclass of GameRoundEntity',
      () => expect(gameRoundModel, isA<GameRoundEntity>())
  );

  group('fromJson', () {

    test('Should return a TimeRoundModel from a JSON', () async {
      final Map<String, dynamic> json = jsonDecode(readFixture(gameRoundJson));
      final result = GameRoundModel.fromJson(json);
      expect(result, isA<GameRoundModel>());
    });
  });

}