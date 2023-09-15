import 'dart:convert';

import 'package:esports_game_endpoint/data/model/model.dart';
import 'package:esports_game_endpoint/domain/entity/entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../fixtures/json_file_name.dart';

void main() {

  GameBanModel gameBanModel = GameBanModel(
    id: 1
  );

  test('Should be a subclass of LineupEntity',
      () => expect(gameBanModel, isA<GameBanEntity>())
  );

  group('fromJson', () {

    test('Should return a PlayerModel from a JSON', () async {
      final Map<String, dynamic> json = jsonDecode(readFixture(gameBanJson));
      final result = GameBanModel.fromJson(json);
      expect(result, isA<GameBanModel>());
    });
  });
}